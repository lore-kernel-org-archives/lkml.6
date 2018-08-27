Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC3208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CC3208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeH0MUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:20:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbeH0MUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FBF84021FC6;
        Mon, 27 Aug 2018 08:34:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id D2C1D2166B41;
        Mon, 27 Aug 2018 08:34:57 +0000 (UTC)
Date:   Mon, 27 Aug 2018 10:34:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180827083457.GE24695@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 08:34:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 08:34:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e71d46cb01cc..c8b921c88a5d 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -292,11 +292,11 @@ int perf_mmap__read_init(struct perf_mmap *map)
>  }
>  
>  int perf_mmap__push(struct perf_mmap *md, void *to,
> -		    int push(void *to, void *buf, size_t size))
> +		    int push(void *to, void *buf, size_t size, off_t), off_t *off)
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	unsigned char *data = md->base + page_size;
> -	unsigned long size;
> +	unsigned long size, size0 = 0;
>  	void *buf;
>  	int rc = 0;
>  
> @@ -308,23 +308,22 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  
>  	if ((md->start & md->mask) + size != (md->end & md->mask)) {
>  		buf = &data[md->start & md->mask];
> -		size = md->mask + 1 - (md->start & md->mask);
> -		md->start += size;
> -
> -		if (push(to, buf, size) < 0) {
> -			rc = -1;
> -			goto out;
> -		}
> +		size0 = md->mask + 1 - (md->start & md->mask);
> +		md->start += size0;
> +		memcpy(md->data, buf, size0);
>  	}
>  
>  	buf = &data[md->start & md->mask];
>  	size = md->end - md->start;
>  	md->start += size;
> +	memcpy(md->data + size0, buf, size);

this will need more comments.. and explanation why we copy the data
over to another buffer.. it's interesting, it's still faster 

jirka
