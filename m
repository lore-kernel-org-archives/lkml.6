Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C0A2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeH1MoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:44:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbeH1MoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61A2F402332F;
        Tue, 28 Aug 2018 08:53:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AF7410EE6D1;
        Tue, 28 Aug 2018 08:53:43 +0000 (UTC)
Date:   Tue, 28 Aug 2018 10:53:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180828085343.GF23727@krava>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 08:53:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 08:53:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:

SNIP

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
>  
> -	if (push(to, buf, size) < 0) {
> -		rc = -1;
> +	rc = push(to, md, size0 + size, *off) < 0 ? -1 : 1;
> +	if (rc == -1)
>  		goto out;
> -	}
> +
> +	perf_mmap__get(md);
> +	*off += size0 + size;

this get is for the perf_mmap pointer storage in the mmap_aio array right?

I see it's released in record__mmap_read_sync, which might also return
without releasing it.. this needs to be fixed and explained in here,
why we take the reference in the first place

thanks,
jirka
