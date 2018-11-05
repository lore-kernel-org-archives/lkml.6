Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237EC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D96920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D96920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeKEKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:07:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:9299 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKEKHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:07:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 16:50:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105239613"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 16:50:04 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, "Aaron Lu" <aaron.lu@intel.com>
Subject: Re: [PATCH 1/2] mm: use kvzalloc for swap_info_struct allocation
References: <37b60523-d085-71e9-fef9-80b90bfcef18@virtuozzo.com>
Date:   Mon, 05 Nov 2018 08:50:04 +0800
In-Reply-To: <37b60523-d085-71e9-fef9-80b90bfcef18@virtuozzo.com> (Vasily
        Averin's message of "Mon, 5 Nov 2018 01:13:04 +0300")
Message-ID: <87wopsbb5v.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> writes:

> commit a2468cc9bfdf ("swap: choose swap device according to numa node")
> increased size of swap_info_struct up to 44 Kbytes, now it requires
> 4th order page.

Why swap_info_struct could be so large?  Because MAX_NUMNODES could be
thousands so that 'avail_lists' field could be tens KB?  If so, I think
it's fair to use kvzalloc().  Can you add one line comment?  Because
struct swap_info_struct is quite small in default configuration.

Best Regards,
Huang, Ying

> Switch to kvzmalloc allows to avoid unexpected allocation failures.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/swapfile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 644f746e167a..8688ae65ef58 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2813,7 +2813,7 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	unsigned int type;
>  	int i;
>  
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = kvzalloc(sizeof(*p), GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -2824,7 +2824,7 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= MAX_SWAPFILES) {
>  		spin_unlock(&swap_lock);
> -		kfree(p);
> +		kvfree(p);
>  		return ERR_PTR(-EPERM);
>  	}
>  	if (type >= nr_swapfiles) {
> @@ -2838,7 +2838,7 @@ static struct swap_info_struct *alloc_swap_info(void)
>  		smp_wmb();
>  		nr_swapfiles++;
>  	} else {
> -		kfree(p);
> +		kvfree(p);
>  		p = swap_info[type];
>  		/*
>  		 * Do not memset this entry: a racing procfs swap_next()
