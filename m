Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038AC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214F20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzGhYsFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBBJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41321 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBBJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id a20so7453966edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VAF/GjUy6YKlyxVPg6hOLHx2TgtZJ9pLi131Tzx0U9Y=;
        b=IzGhYsFdBo8ilxxhYPKF8f2vvvHWBW6MkNlAa7RmrQ0Jr0o9dj3Ig89/wR2QC4L5Ty
         cZG2eTgSGNBsQsCzSQ4zYu+PAQFDLFtVqEiIEzhSbFGaVbwJk35KCwXFzw3veEjV920Z
         TcS4uQrcIEu1jQ+H09yGiLUubChgcmzOKIpsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VAF/GjUy6YKlyxVPg6hOLHx2TgtZJ9pLi131Tzx0U9Y=;
        b=GmFoaP40tXeJvpmNTlOqbLTrb+btOPnurRp5eQ/uRZUNUHEIQlRHlHNOv/PY8UQvDH
         SM4+glgWEs4Rec5ddXSv2KUAC6i1F9D+Oao2utu6D/DWbakjVBtCk/wpcN+OQX7bct2V
         jHerLvcp33rIDxVLsk3qYAgWpKMTSrZep/o8UgKt21nfwjs05J0QEyI1sUlTSVcDVRHN
         ccso664k7sVtuuyKtAn7U+dHAYnyAWcHMHwKyYX4wRCRGbSyUI1U5Ml3Qc0nY69FT2t+
         8iCTBvk+iVLzVufjuUud3pLKfwLtpRg8N7WSml4t73kkNaSF6QhzhYtMHuJjpSeKo0O/
         Voqw==
X-Gm-Message-State: AJcUukfw4r9FGaYgABSuvFsMrXjkvQl5BgujS64krj+C86bo2NZfMZfZ
        k/iiCNKjiZB1bMFFgcSuiUvUpA==
X-Google-Smtp-Source: ALg8bN4KuXYUOZZHumncy0ZkNRqnS0DkwS2F8kcUQKgajFKbXs6OlyjqLmQ5IzC7ZTJCWiabpocGaw==
X-Received: by 2002:a50:d94a:: with SMTP id u10mr41883512edj.214.1549100486982;
        Sat, 02 Feb 2019 01:41:26 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:25 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [GIT PULL 00/10] EFI changes for v5.1
Date:   Sat,  2 Feb 2019 10:41:09 +0100
Message-Id: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to 44f5ab0e212a9fff7c518803f7fc77b692b2afcd:

  acpi: bgrt: parse BGRT to obtain BMP address before it gets clobbered (2019-02-02 10:35:35 +0100)

----------------------------------------------------------------
EFI changes for v5.1:
- Use 32 bit alignment for efi_guid_t
- Allow the call to SetVirtualAddressMap() to be omitted
- Implement earlycon=efifb based on existing earlyprintk code
- Move BGRT table handling to earlier in the boot so we don't overwrite it
- Various minor fixes and code cleanups from Sai, Ingo and Ard

----------------------------------------------------------------
Ard Biesheuvel (7):
      efi: memattr: don't bail on zero VA if it equals the region's PA
      efi: use 32-bit alignment for efi_guid_t
      efi: replace GPL license boilerplate with SPDX headers
      efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
      x86: make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
      efi: x86: convert x86 EFI earlyprintk into generic earlycon implementation
      acpi: bgrt: parse BGRT to obtain BMP address before it gets clobbered

Ingo Molnar (1):
      efi/fdt: More cleanups

Sai Praneeth Prakhya (2):
      x86/efi: Mark can_free_region() as an __init function
      x86/efi: Return error status if mapping EFI regions fail

 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 arch/Kconfig                                    |   3 +
 arch/arm64/kernel/acpi.c                        |   2 -
 arch/x86/Kconfig                                |   5 +-
 arch/x86/Kconfig.debug                          |  10 -
 arch/x86/include/asm/efi.h                      |   7 +-
 arch/x86/kernel/acpi/boot.c                     |   2 -
 arch/x86/kernel/early_printk.c                  |   4 -
 arch/x86/mm/ioremap.c                           |   4 +-
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/early_printk.c            | 240 ------------------------
 arch/x86/platform/efi/efi.c                     |  21 ++-
 arch/x86/platform/efi/efi_32.c                  |   6 +-
 arch/x86/platform/efi/efi_64.c                  |  39 ++--
 arch/x86/platform/efi/quirks.c                  |   2 +-
 drivers/acpi/bgrt.c                             |   6 -
 drivers/firmware/efi/Kconfig                    |   6 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/apple-properties.c         |  13 +-
 drivers/firmware/efi/arm-init.c                 |   6 +-
 drivers/firmware/efi/arm-runtime.c              |   6 +-
 drivers/firmware/efi/capsule-loader.c           |   4 +-
 drivers/firmware/efi/capsule.c                  |   4 +-
 drivers/firmware/efi/cper-arm.c                 |  14 +-
 drivers/firmware/efi/cper.c                     |  14 +-
 drivers/firmware/efi/dev-path-parser.c          |   9 +-
 drivers/firmware/efi/earlycon.c                 | 206 ++++++++++++++++++++
 drivers/firmware/efi/efi-bgrt.c                 |  89 +++++++--
 drivers/firmware/efi/efi-pstore.c               |   2 +
 drivers/firmware/efi/efi.c                      |  13 ++
 drivers/firmware/efi/efibc.c                    |  10 +-
 drivers/firmware/efi/efivars.c                  |  58 +-----
 drivers/firmware/efi/esrt.c                     |   1 +
 drivers/firmware/efi/fake_mem.c                 |  16 +-
 drivers/firmware/efi/libstub/Makefile           |   4 +-
 drivers/firmware/efi/libstub/arm-stub.c         |   5 +
 drivers/firmware/efi/libstub/arm32-stub.c       |   6 +-
 drivers/firmware/efi/libstub/arm64-stub.c       |   6 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c  |  15 +-
 drivers/firmware/efi/libstub/efistub.h          |  12 ++
 drivers/firmware/efi/libstub/fdt.c              | 115 ++++++------
 drivers/firmware/efi/libstub/gop.c              |   4 +-
 drivers/firmware/efi/libstub/random.c           |   6 +-
 drivers/firmware/efi/libstub/secureboot.c       |   4 +-
 drivers/firmware/efi/libstub/tpm.c              |   4 +-
 drivers/firmware/efi/memattr.c                  |   7 +-
 drivers/firmware/efi/runtime-map.c              |   3 +-
 drivers/firmware/efi/test/efi_test.c            |   1 +
 drivers/firmware/efi/test/efi_test.h            |   2 +-
 drivers/firmware/efi/tpm.c                      |   5 +-
 drivers/firmware/efi/vars.c                     |  15 +-
 include/linux/efi-bgrt.h                        |   4 +-
 include/linux/efi.h                             |  15 +-
 53 files changed, 494 insertions(+), 571 deletions(-)
 delete mode 100644 arch/x86/platform/efi/early_printk.c
 create mode 100644 drivers/firmware/efi/earlycon.c
