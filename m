Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D915BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E2A21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLZBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:47:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLZBrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:47:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC1F53C2CCC;
        Wed, 26 Dec 2018 01:47:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1515D781;
        Wed, 26 Dec 2018 01:47:06 +0000 (UTC)
Date:   Wed, 26 Dec 2018 09:47:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20181226014701.GD11472@dhcp-128-65.nay.redhat.com>
References: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 26 Dec 2018 01:47:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 at 12:07pm, Pingfan Liu wrote:
> Customer reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammer looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> 
> This patch simplifies the method suggested in the mail [1]. It just goes
> bottom-up to find a candidate region for crashkernel. The bottom-up may be
> better compatible with the old reservation style, i.e. still want to get
> memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> 
> There is one trivial thing about the compatibility with old kexec-tools:
> if the reserved region is above 896M, then old tool will fail to load
> bzImage. But without this patch, the old tool also fail since there is no
> memory below 896M can be reserved for crashkernel.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: kexec@lists.infradead.org
> 
> ---
> v1->v2:
>   improve commit log
>  arch/x86/kernel/setup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d494b9b..60f12c4 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
>  
>  	/* 0 means: find the address automatically */
>  	if (crash_base <= 0) {
> +		if (!memblock_bottom_up())
> +			memblock_set_bottom_up(true);
>  		/*
>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
>  		 * as old kexec-tools loads bzImage below that, unless
>  		 * "crashkernel=size[KMG],high" is specified.
>  		 */
>  		crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						    high ? CRASH_ADDR_HIGH_MAX
> -							 : CRASH_ADDR_LOW_MAX,
> -						    crash_size, CRASH_ALIGN);
> +			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> +		if (!memblock_bottom_up())
> +			memblock_set_bottom_up(false);

The previous memblock_set_bottom_up(true) set it as true, so
"!memblock_bottom_up()" is impossible, not sure what is the point of
this condition check.

Do you want to restore the original memblock direction? If so a variable
to save the old direction is needed.  But is this really necessary?
Do you know any side effects of setting the bottom up as true?

> +
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
