Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE37C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863A5269EA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863A5269EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeF0GUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:20:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57590 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeF0GUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:20:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2E2B42073C; Wed, 27 Jun 2018 08:20:37 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF0F4206ED;
        Wed, 27 Jun 2018 08:20:36 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ethan Tuttle <ethan@ethantuttle.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] ARM: mvebu: declare asm symbols as character arrays in pmsu.c
References: <20180620043109.1190-1-ethan@ethantuttle.com>
Date:   Wed, 27 Jun 2018 08:20:37 +0200
In-Reply-To: <20180620043109.1190-1-ethan@ethantuttle.com> (Ethan Tuttle's
        message of "Tue, 19 Jun 2018 21:31:08 -0700")
Message-ID: <87wouk92dm.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,
 
 On mar., juin 19 2018, Ethan Tuttle <ethan@ethantuttle.com> wrote:

> With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
> detect buffer overflows.  If src or dest is declared as a char, attempts to
> copy more than byte will result in a fortify_panic().
>
> Address this problem in mvebu_setup_boot_addr_wa() by declaring
> mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
> a couple addressof operators to avoid "arithmetic on pointer to an
> incomplete type" compiler error.
>
> See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
> not single characters") for a similar fix.
>
> Fixes "detected buffer overflow in memcpy" error during init on some mvebu
> systems (armada-370-xp, armada-375):
>
> (fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
> (mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
> (mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
> (do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
> (kernel_init_freeable) from (kernel_init+0x8/0x114)
> (kernel_init) from (ret_from_fork+0x14/0x2c)
>
> Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
> Tested-by: Ethan Tuttle <ethan@ethantuttle.com>

Out of curiosity on which platform did you test it?

Applied on mvebu/arm

Thanks,

Gregory



> ---
>  arch/arm/mach-mvebu/pmsu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 27a78c80e5b1..73d5d72dfc3e 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>  		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
>  }
>  
> -extern unsigned char mvebu_boot_wa_start;
> -extern unsigned char mvebu_boot_wa_end;
> +extern unsigned char mvebu_boot_wa_start[];
> +extern unsigned char mvebu_boot_wa_end[];
>  
>  /*
>   * This function sets up the boot address workaround needed for SMP
> @@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
>  			     phys_addr_t resume_addr_reg)
>  {
>  	void __iomem *sram_virt_base;
> -	u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
> +	u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
>  
>  	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
>  	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
