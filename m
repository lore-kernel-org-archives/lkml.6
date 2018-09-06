Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF0B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF0B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIFPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:39:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbeIFPjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:39:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65AF040241CA;
        Thu,  6 Sep 2018 11:04:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CCD5100727D;
        Thu,  6 Sep 2018 11:04:18 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:04:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180906110418.GG8248@krava>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <dc18a621-4464-e5a5-ce10-5f7b2f6a9176@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc18a621-4464-e5a5-ce10-5f7b2f6a9176@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 11:04:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 11:04:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:39:25AM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 384d17cd1379..1d57d8387caf 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -332,12 +332,12 @@ int perf_mmap__read_init(struct perf_mmap *map)
>  	return __perf_mmap__read_init(map);
>  }
>  
> -int perf_mmap__push(struct perf_mmap *md, void *to,
> -		    int push(void *to, void *buf, size_t size))
> +int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
> +		    int push(void *to, struct aiocb *cblock, void *data, size_t size))
>  {
>  	u64 head = perf_mmap__read_head(md);
>  	unsigned char *data = md->base + page_size;
> -	unsigned long size;
> +	unsigned long size, size0 = 0;
>  	void *buf;
>  	int rc = 0;
>  
> @@ -345,31 +345,58 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
>  	if (rc < 0)
>  		return (rc == -EAGAIN) ? 0 : -1;
>  
> +	/* md->base data is copied into md->data[idx] buffer to
> +	 * release space in the kernel buffer as fast as possible,

please start the comment with the extra '/*', like:

	/*
	 * md->base data is copied into md->data[idx] buffer to
	 * release space in the kernel buffer as fast as possible,
	...

jirka
