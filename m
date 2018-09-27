Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66422152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="FXt/sOk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66422152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeI0XO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:14:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeI0XO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:14:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id t22-v6so2738158lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iM8c0ufFnsdAl7ba5T+Z3WN7gLhoLrTNvpjR0bH4AwM=;
        b=FXt/sOk2SbP1AvGPLTOWaXNJ9cR+513RIm7Dt6AcPZDnSx93A93v2fVw4FcXXPxVfX
         9HG6FnPSdxRX5sQTijVTqJwwQasX91r8h+UrrC0CPVoN2fSqnGO66AbKofmeTdJVlq4z
         3cdCTwbDa45Ywz6Ggkp5862BNoSfRP4rVaozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iM8c0ufFnsdAl7ba5T+Z3WN7gLhoLrTNvpjR0bH4AwM=;
        b=I0DpS6Q+dxudC0PoppaCv0JrH9375xLHs1AprHoiCPd/o0fdo+Ak8ZQ8BUqDHITfnb
         945iLa6dgLN4y0caDd49sM+6mqz21YriPktPrQ0eLPC3iI03vaURmRHiRhZ8hf9BjLHC
         upoAo/+ve3jL845erjLAjECD2H4fZbC30ckg4f0igsEEkeqiHF7UqwROXrIG92Ndl96m
         mOu4HkZUBUxwp0GD/EkrfURGuGVYquZj9pZpWji/KyL8MwFQjfjdA7rW0w2YiPy+355J
         z5JMFzowf+iWMB4Df+u367BLtCJGq+gR3/Ua/tjHOpAg1oJ/0PrrTWPwxv6PTG8sWmB9
         zRsg==
X-Gm-Message-State: ABuFfohmgUrxcmSVKaZJeBPYgysXJNfB3090Y6Y7RUVr/+qy8fg9FQ57
        1yK8QJzkBa7qx/sUmSSXWpx1Pg==
X-Google-Smtp-Source: ACcGV60IVvJ1LmrupkgPSKGUTSqjIw+n1U2CyKX7tDFZzcRbrqnbFz86YNwU9RqIoJEQ9c/o4zxHOg==
X-Received: by 2002:a19:635b:: with SMTP id x88-v6mr789639lfb.85.1538067316929;
        Thu, 27 Sep 2018 09:55:16 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id n3-v6sm533529lfi.96.2018.09.27.09.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:55:16 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] add generic builtin command line
Date:   Thu, 27 Sep 2018 19:55:08 +0300
Message-Id: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were series of patches [1] for 4.3.0-rc3, that allowed
architectures to use a generic builtin command line. I have rebased
these patches on kernel 4.19.0-rc4.

Things, modified in comparison with original patches:                            
* There was some bug for mips, in the case when CONFIG_CMDLINE_PREPEND
and CONFIG_CMDLINE_APPEND are empty and CMDLINE_OVERRIDE is not set,
command line from bootloader was ignored, so I fixed it, modifying
patch "add generic builtin command line".

* Implemented new patch to resolve conflict with new kernel, which
modify EFI stub code. Unfortunately, I don't have capability to test
this modification on real arm board with EFI.

* Removed new realisation of mips builtin command line, which was
created after 4.3.0-rc3.

* Kernel 4.3.0-rc3 with original patches could not be compiled for
powerpc due to prom_init.c checking by prom_init_check.sh. So I added
strlcat (which is used by cmdline_add_builtin macro) to
prom_init_check.sh whitelist.

Patches have been tested in QEMU for x86, arm (little-endian), arm64
(little-endian), mips (little-endian, 32-bit) and powerpc
(big-endian, 64-bit), everything works perfectly. Also it was tested
on linux-next (next-20180924 tag) for all listed above architectures.

[1] : https://lore.kernel.org/patchwork/patch/604992/

Daniel Walker (7):
  add generic builtin command line
  drivers: of: ifdef out cmdline section
  x86: convert to generic builtin command line
  arm: convert to generic builtin command line
  arm64: convert to generic builtin command line
  mips: convert to generic builtin command line
  powerpc: convert to generic builtin command line

Maksym Kokhan (1):
  efi: modify EFI stub code for arm/arm64

 arch/arm/Kconfig                        | 38 +-----------------
 arch/arm/kernel/atags_parse.c           | 14 ++-----
 arch/arm/kernel/devtree.c               |  2 +
 arch/arm64/Kconfig                      | 17 +-------
 arch/arm64/kernel/setup.c               |  3 ++
 arch/mips/Kconfig                       | 24 +----------
 arch/mips/Kconfig.debug                 | 47 ----------------------
 arch/mips/kernel/setup.c                | 41 ++-----------------
 arch/powerpc/Kconfig                    | 23 +----------
 arch/powerpc/kernel/prom.c              |  4 ++
 arch/powerpc/kernel/prom_init.c         |  8 ++--
 arch/powerpc/kernel/prom_init_check.sh  |  2 +-
 arch/x86/Kconfig                        | 44 +--------------------
 arch/x86/kernel/setup.c                 | 19 ++-------
 drivers/firmware/efi/libstub/arm-stub.c | 10 ++---
 drivers/of/fdt.c                        |  2 +-
 include/linux/cmdline.h                 | 70 +++++++++++++++++++++++++++++++++
 init/Kconfig                            | 68 ++++++++++++++++++++++++++++++++
 18 files changed, 173 insertions(+), 263 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.7.4

