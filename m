Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD5C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991E42081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991E42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKEKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:14:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:54451 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbeKEKOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:14:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 16:57:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="105240671"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2018 16:57:06 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, "Aaron Lu" <aaron.lu@intel.com>
Subject: Re: [PATCH 2/2] mm: avoid unnecessary swap_info_struct allocation
References: <a24bf353-8715-2bee-d0fa-96ca06c5b69f@virtuozzo.com>
Date:   Mon, 05 Nov 2018 08:57:05 +0800
In-Reply-To: <a24bf353-8715-2bee-d0fa-96ca06c5b69f@virtuozzo.com> (Vasily
        Averin's message of "Mon, 5 Nov 2018 01:13:12 +0300")
Message-ID: <87sh0gbau6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> writes:

> Currently newly allocated swap_info_struct can be quickly freed.
> This patch avoid uneccessary high-order page allocation and helps
> to decrease the memory pressure.

I think swapon/swapoff are rare operations, so it will not increase the
memory pressure much.  

Best Regards,
Huang, Ying

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/swapfile.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8688ae65ef58..53ec2f0cdf26 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2809,14 +2809,17 @@ late_initcall(max_swapfiles_check);
>  
>  static struct swap_info_struct *alloc_swap_info(void)
>  {
> -	struct swap_info_struct *p;
> +	struct swap_info_struct *p = NULL;
>  	unsigned int type;
>  	int i;
> +	bool force_alloc = false;
>  
> -	p = kvzalloc(sizeof(*p), GFP_KERNEL);
> -	if (!p)
> -		return ERR_PTR(-ENOMEM);
> -
> +retry:
> +	if (force_alloc) {
> +		p = kvzalloc(sizeof(*p), GFP_KERNEL);
> +		if (!p)
> +			return ERR_PTR(-ENOMEM);
> +	}
>  	spin_lock(&swap_lock);
>  	for (type = 0; type < nr_swapfiles; type++) {
>  		if (!(swap_info[type]->flags & SWP_USED))
> @@ -2828,6 +2831,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>  		return ERR_PTR(-EPERM);
>  	}
>  	if (type >= nr_swapfiles) {
> +		if (!force_alloc) {
> +			force_alloc = true;
> +			spin_unlock(&swap_lock);
> +			goto retry;
> +		}
>  		p->type = type;
>  		swap_info[type] = p;
>  		/*
