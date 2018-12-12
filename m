Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791BC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49E72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeLLJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:01:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLLJBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:01:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C50230841DE;
        Wed, 12 Dec 2018 09:01:50 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C67D319C7D;
        Wed, 12 Dec 2018 09:01:46 +0000 (UTC)
Date:   Wed, 12 Dec 2018 17:01:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/kdump: directly find a candidate region when
 crashkernel=X
Message-ID: <20181212090144.GQ17340@MiWiFi-R3L-srv>
References: <1544602756-17449-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544602756-17449-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Dec 2018 09:01:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

Thanks for fixing this.

On 12/12/18 at 04:19pm, Pingfan Liu wrote:
> I encounter a case where crashkernel=384M, and kaslr is enabled. During the
> test, sometimes, the system may fail to reserve region for crash kernel,
> although there is much free space above 896MB. It is caused by the

I remember this bug was reported by our customer. They specify
crashkernel=384MB on a high end server with many pcie devices. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found.

If want to make it succeed, customer can change kernel option to
"crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammer looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

> truncation of the candidate region by kaslr kernel. It raises confusion to
> the end user that sometimes crashkernel=X works while sometimes fails.
> Since on x86, kaslr is a default option, and this corner case is
> unavoidable.
> This patch simplifies the method suggested in the mail [1]. It just goes
> bottom-up to find a candidate region for crashkernel.
> There is one trivial thing about the compatibility with old kexec-tools:
> if the reserved region is above 896M, then old tool will fail to load
> bzImage. But without this patch, the old tool also fail since there is no
> memory below 896M can be reserved for crashkernel.

Meanwhile, we set bottom-up to try to reserve crashkernel because we
still want to get memory region from 896 MB firstly, then [896 MB, 4G],
finally above 4G. This gives us a chance to be compatible with the old
reservation style, and this is what we have been doing in redhat
distros. We may only search [128MB, 4G] only if people mind, just leave
above 4G reservation to ',high' explicitly. 

Thanks
Baoquan
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
Here maybe change it like below. Just personal opinion, not a big deal,
not strongly suggested. 
		bool bottom_up;

		bottom_up = memblock_bottom_up();
		memblock_set_bottom_up(true);

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
		memblock_set_bottom_up(bottom_up);
> +
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 
