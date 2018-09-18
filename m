Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A7F21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKmHWyVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A7F21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeISEao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeISEao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:30:44 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6252133F;
        Tue, 18 Sep 2018 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537311355;
        bh=xjZXOZXtdlVJ4kvy1oZ1maBILdjXkqU9Npp+OB9XKFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKmHWyVJef6gnQv+rzN1PUGH/7krax1hkHRukGG76+VbmuMwRKft8ukn32tjAy+zj
         7LeYCwXrZ2uHBh3RHH5r2oebDbt0EFeQyCeEDDxPjVILJWipwx7khBMbpLi2e/vDoR
         jCDLI6vOUNuVkxhucOqIUtdlqWOZGVyhWqisT2Lk=
Date:   Tue, 18 Sep 2018 15:55:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 09/20] zinc: Poly1305 ARM and ARM64
 implementations
Message-ID: <20180918225552.GA74746@gmail.com>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-10-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918161646.19105-10-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:16:35PM +0200, Jason A. Donenfeld wrote:
> diff --git a/lib/zinc/poly1305/poly1305-arm-glue.h b/lib/zinc/poly1305/poly1305-arm-glue.h
> new file mode 100644
> index 000000000000..dd3fa5a38c62
> --- /dev/null
> +++ b/lib/zinc/poly1305/poly1305-arm-glue.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <asm/hwcap.h>
> +#include <asm/neon.h>
> +
> +asmlinkage void poly1305_init_arm(void *ctx, const u8 key[16]);
> +asmlinkage void poly1305_blocks_arm(void *ctx, const u8 *inp, const size_t len,
> +				    const u32 padbit);
> +asmlinkage void poly1305_emit_arm(void *ctx, u8 mac[16], const u32 nonce[4]);
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&                                     \
> +	(defined(CONFIG_64BIT) || __LINUX_ARM_ARCH__ >= 7)
> +#define ARM_USE_NEON
> +asmlinkage void poly1305_blocks_neon(void *ctx, const u8 *inp, const size_t len,
> +				     const u32 padbit);
> +asmlinkage void poly1305_emit_neon(void *ctx, u8 mac[16], const u32 nonce[4]);
> +#endif
> +
> +static bool poly1305_use_neon __ro_after_init;
> +
> +static void __init poly1305_fpu_init(void)
> +{
> +#if defined(CONFIG_ARM64)
> +	poly1305_use_neon = elf_hwcap & HWCAP_ASIMD;
> +#elif defined(CONFIG_ARM)
> +	poly1305_use_neon = elf_hwcap & HWCAP_NEON;
> +#endif
> +}
> +
> +static inline bool poly1305_init_arch(void *ctx,
> +				      const u8 key[POLY1305_KEY_SIZE])
> +{
> +	poly1305_init_arm(ctx, key);
> +	return true;
> +}
> +
> +static inline bool poly1305_blocks_arch(void *ctx, const u8 *inp,
> +					const size_t len, const u32 padbit,
> +					simd_context_t *simd_context)
> +{
> +#if defined(ARM_USE_NEON)
> +	if (poly1305_use_neon && simd_use(simd_context)) {
> +		poly1305_blocks_neon(ctx, inp, len, padbit);
> +		return true;
> +	}
> +#endif
> +	poly1305_blocks_arm(ctx, inp, len, padbit);
> +	return true;
> +}

This will compute the wrong digest if called with simd_context=HAVE_FULL_SIMD
and then later with simd_context=HAVE_NO_SIMD, since poly1305_blocks_neon()
converts the accumulator from base 32 to base 26, whereas poly1305_blocks_arm()
assumes it is still in base 32.  Is that intentional?  I'm sure this is a rare
case, but my understanding is that the existing crypto API doesn't preclude
calling successive steps in different contexts.  And I'm concerned that it could
be relevant in some cases, e.g. especially if people are importing a hash state
that was exported earlier.  Handling it by silently computing the wrong digest
is not a great idea...

- Eric
