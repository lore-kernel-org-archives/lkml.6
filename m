Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C414FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87747208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87747208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJAVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:51:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46401 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:51:48 -0400
Received: by mail-qk1-f195.google.com with SMTP id q12-v6so8272489qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XcgePceFCL49hyxQEpsBicUuZ9s87jVul+pdMU9fhk=;
        b=syPsSiBXztbeJIwuGqkVeNixfvT+V6AFzGSwRp55AYwTyb6Ad1L4scJhXjomcUt1QZ
         a8oNfvalk34d8ExCB/eeGNjmnDhdNJpvskjm2q5sllQJR+nIlQfE1IfrCTDRopQOjqO2
         Z5pnqQA0FD1YDCMG7cun6G4LVpWBi//YGB0uyRM5/Zez2WLcgIa1mJ5A4bu+/TMSnwbM
         fhnFJs3uvQfufN0T5O2L7TEgjvXEPTV9OdGOhyhNnJlKprX97zD95hVMtYMda2hDDZw+
         QkkMuY0EP+I6oi6kKfnHD9mK6saXDIZMjh8q7fJ7W2ob56cnbGFH9yNZdh9wB8A+DwaR
         7r9A==
X-Gm-Message-State: ABuFfoicuILaFuauA8Vcpruh+pVayhqtzBtW9vbamO5pc9dvfwsUY2EN
        TUasRoePPKmWTEm1+qoJWHALhJtJ4Gwr43eKDsOEeBzz
X-Google-Smtp-Source: ACcGV63ViPZrKkHin89rvTxVFjycOFPdfM/5zrVHYbh84UZT5j6kPpCiBCeliNMVXgNGU78xQd7RWjexBM/2w10n65o=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr8669211qkd.173.1538406812055;
 Mon, 01 Oct 2018 08:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com>
In-Reply-To: <20180930024904.14240-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 17:13:15 +0200
Message-ID: <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 4:49 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Per the discussion about half-way down in [1], the kernel doesn't
> actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
> hardware that benefits from ARMv3 code generation. Such a consideration,
> then, only applies to the compiler but not to the assembler. This commit
> passes -march=armv4 to the assembler in those cases, so that code
> written for ARMv4 will continue to compile and run fine, without needing
> module-specific asflags-y overrides.
>
> [1] https://lore.kernel.org/lkml/CAKv+Gu9FoFQymp2-=rUeh14CkUKON389OCE7stYCOFwKZpaCrg@mail.gmail.com/
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> I don't have too much familiarity with hardware this old, nor access to
> testing systems, so please do carefully evaluate the assertions above
> before merging this, since I'm not sure I have a full understanding of
> the Linux ARMv3 situation.

I took a look at the original build problem. It seems that the issue
here that your assembler implementation contains multiplication
instructions that are part of ARMv3M and higher but not ARMv3.

Since RPC/sa110 supports those instructions, should we maybe
just build the kernel with -march-armv3 instead?

Russell, does this make sense, or is there a reason we're not
already doing the below?

       Arnd

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c05ab53425a..445ae57ee3a1 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -81,7 +81,7 @@ endif
 arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 -march=armv5te
 arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 $(call
cc-option,-march=armv4,-march=armv4t)
-arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
+arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m

 # Evaluate arch cc-option calls now
 arch-y := $(arch-y)
