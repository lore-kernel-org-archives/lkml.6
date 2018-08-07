Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCEEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18013217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="R+IT9rao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18013217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbeHGQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:26:37 -0400
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:39256 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388839AbeHGQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1533651126;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=1oesMzKP0x3ZMClTXXKwvhy9WFETe1t4vHe4i+/quXg=;
        b=R+IT9raoxHKAK5FVgDx7I4vlmUcPjfyOL1XI/g23vi+YUVoPmUJB7LQPRYHhAX76
        A750ZCEAd13I6CVFSc5iLA/OGVdqKoVuZ5DOYAopiNtmT3mv5oMtcp/UIjJ31jkuCLD
        ReKqnRUoINydkqVOzqkvV9tl0z9X2huQibL/tWDs=
Date:   Tue, 7 Aug 2018 14:12:06 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dennis Zhou <dennisszhou@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add percpu populated pages count to meminfo
In-Reply-To: <20180807005607.53950-1-dennisszhou@gmail.com>
Message-ID: <0100016514bb069d-a6532c9a-b1ca-4eba-8644-c5b3935e3bd8-000000@email.amazonses.com>
References: <20180807005607.53950-1-dennisszhou@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.08.07-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018, Dennis Zhou wrote:

> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 2fb04846ed11..ddd5249692e9 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -7,6 +7,7 @@
>  #include <linux/mman.h>
>  #include <linux/mmzone.h>
>  #include <linux/proc_fs.h>
> +#include <linux/percpu.h>
>  #include <linux/quicklist.h>
>  #include <linux/seq_file.h>
>  #include <linux/swap.h>
> @@ -121,6 +122,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		   (unsigned long)VMALLOC_TOTAL >> 10);
>  	show_val_kb(m, "VmallocUsed:    ", 0ul);
>  	show_val_kb(m, "VmallocChunk:   ", 0ul);
> +	show_val_kb(m, "PercpuPopulated:", pcpu_nr_populated_pages());

Populated? Can we avoid this for simplicities sake: "Percpu"?

We do not count pages that are not present elsewhere either and those
counters do not have "populated" in them.

>  int pcpu_nr_empty_pop_pages;
>
> +/*
> + * The number of populated pages in use by the allocator, protected by
> + * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
> + * allocated/deallocated, it is allocated/deallocated in all units of a chunk
> + * and increments/decrements this count by 1).
> + */
> +static int pcpu_nr_populated;

pcpu_nr_pages?

