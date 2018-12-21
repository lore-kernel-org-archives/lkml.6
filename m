Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D280C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E94218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbeLUHSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:18:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeLUHSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:18:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7A00A7E1;
        Fri, 21 Dec 2018 07:18:30 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADBD64AC;
        Fri, 21 Dec 2018 07:18:26 +0000 (UTC)
Date:   Fri, 21 Dec 2018 15:18:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20181221071823.GA2526@MiWiFi-R3L-srv>
References: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544760446-506-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 21 Dec 2018 07:18:30 +0000 (UTC)
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

This is a bug fix and urged by our customer.

I personally think crashkernel=xx@ is a generic synctax, the current
code making it search only under 896 MB seems not so reasonable.

Ack this patch.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

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
> +
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 
