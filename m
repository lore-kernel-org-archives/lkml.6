Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8323D2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYPTel+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8323D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeHVWRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:17:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35193 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:17:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so2230034ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TGgrTXLN0aVfgN898DKInV0UG15EsTQu/qBRFYzHYZg=;
        b=fYPTel+bgBIQbW3BjJOEU3rnfCG7RRf6w0jZDmcTZ6FHPOxStZ+fH45UhfkKOasFog
         yXOgXNFaV++ACmE6EKrZA+PST1b/HKUJ32+E4JEh7p+tYO24JWkdOIZdfX9fxyGExMOi
         T7R7lwEkpiSJR0qSVIVyTDNoC71hxGMU5NtPb+6xaDvTtRQjm6yOr3CtEjh44tZyIjtC
         YIL5rRElboLC+Z5Cma2Xf+gPb4b6QBzLW29Tv1f1rt6FnahIbG/ToZY6A0ro6I62pPqC
         mVu7WezDZFwWDMh7v6t3mZL3H+IEOpIp4Ji66YARviDNPpmWqEuiz3UmJ0303hA9P38I
         FY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TGgrTXLN0aVfgN898DKInV0UG15EsTQu/qBRFYzHYZg=;
        b=s9W8WWdbSUlIt45BKA4IcaiwgaFpgp/dd+FwUG73CzpRhD2wvEck4MRLiUe/furIxe
         ZaAxivNkWvOnOM2ucyB8lqh+Fnvh+wZ2h/tEkzeRq/eDcdR6E6E9jVk3ptqyJVs7Qs+E
         zPVQVh1t2Om885WZ7Ok6of9dt/1p2hePPwBh5D2EnZK38NHGDblCeIP4WUQ7sz1eikEN
         n43tX/v1hQhNlrPRI7y8mMPhGA6XQXmeESb/Ibb5v/U+CfslWwAW6XTZOlFAcCdWTRpR
         dMoEs+Z7inBghSUxNu59xiQOYpZnPKRl04t8CfevsRugTpNQwe2djJmN14B/HlM8XEXu
         DrNw==
X-Gm-Message-State: APzg51DXXCKNSD0gCat0Aef7fPJCkfa+tvoCu8/iUe1/gESSPddn4NYb
        TIrjCD02pxMDS+IKOZJUtI8=
X-Google-Smtp-Source: ANB0VdbIlSEyfgzJAYvwqaVkaDgOqLV2vHY59XZA945QoZTMMvzKA1iGBPtJR1SafzWuJ5ZSeFKqrA==
X-Received: by 2002:a2e:9d0c:: with SMTP id t12-v6mr132950lji.75.1534963862312;
        Wed, 22 Aug 2018 11:51:02 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id r4-v6sm70840ljd.70.2018.08.22.11.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 11:51:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/14] Xtensa updates for 4.19
Date:   Wed, 22 Aug 2018 11:50:34 -0700
Message-Id: <20180822185034.30167-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the folowing batch of updates for the Xtensa architecture
for 4.19.

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20180820

for you to fetch changes up to 35d231db53a60b76e218a56da30ad071d4717b56:

  Merge branch 'xtensa-dma-fixes' (early part) into xtensa-fixes (2018-08-20 13:24:24 -0700)

----------------------------------------------------------------
Xtensa improvements for v4.19:

- switch xtensa arch to the generic noncoherent direct mapping operations;
- add support for DMA_ATTR_NO_KERNEL_MAPPING attribute;
- clean up users of platform/hardware.h in generic Xtensa code;
- fix assembly cache maintenance code for long cache lines;
- rework noMMU cache attributes initialization;
- add big-endian HiFi2 test_kc705_be CPU variant.

----------------------------------------------------------------
Christoph Hellwig (1):
      xtensa: use generic dma_noncoherent_ops

Max Filippov (14):
      xtensa: support DMA_ATTR_NO_KERNEL_MAPPING attribute
      xtensa: platform-specific handling of coherent memory
      xtensa: limit offsets in __loop_cache_{all,page}
      xtensa: increase ranges in ___invalidate_{i,d}cache_all
      xtensa: rework noMMU cache attributes initialization
      xtensa: drop unused {CONFIG,PLATFORM}_DEFAULT_MEM_SIZE
      xtensa: rework {CONFIG,PLATFORM}_DEFAULT_MEM_START
      xtensa: move PLATFORM_NR_IRQS to Kconfig
      xtensa: drop unneeded platform/hardware.h headers
      xtensa: drop variant IRQ support
      xtensa: make bootparam parsing optional
      xtensa: clean up boot-elf/bootstrap.S
      xtensa: add test_kc705_be variant
      Merge branch 'xtensa-dma-fixes' (early part) into xtensa-fixes

 arch/xtensa/Kconfig                                |  60 ++-
 arch/xtensa/boot/boot-elf/bootstrap.S              |  19 +-
 arch/xtensa/configs/nommu_kc705_defconfig          |   2 +-
 arch/xtensa/include/asm/Kbuild                     |   1 +
 arch/xtensa/include/asm/cacheasm.h                 |  69 ++-
 arch/xtensa/include/asm/dma-mapping.h              |  26 -
 arch/xtensa/include/asm/initialize_mmu.h           |  42 +-
 arch/xtensa/include/asm/irq.h                      |  21 +-
 arch/xtensa/include/asm/kmem_layout.h              |   6 -
 arch/xtensa/include/asm/page.h                     |   5 +-
 arch/xtensa/include/asm/pgtable.h                  |   8 +
 arch/xtensa/include/asm/platform.h                 |  27 +
 arch/xtensa/include/asm/processor.h                |   1 -
 arch/xtensa/include/asm/vectors.h                  |   1 -
 arch/xtensa/kernel/head.S                          |   2 +
 arch/xtensa/kernel/irq.c                           |   1 -
 arch/xtensa/kernel/pci-dma.c                       | 193 +++----
 arch/xtensa/kernel/setup.c                         |  10 +-
 arch/xtensa/kernel/vmlinux.lds.S                   |   2 +-
 .../platforms/iss/include/platform/hardware.h      |  29 --
 .../platforms/xt2000/include/platform/hardware.h   |  11 -
 .../platforms/xtfpga/include/platform/hardware.h   |   9 -
 .../variants/test_kc705_be/include/variant/core.h  | 575 +++++++++++++++++++++
 .../test_kc705_be/include/variant/tie-asm.h        | 308 +++++++++++
 .../variants/test_kc705_be/include/variant/tie.h   | 182 +++++++
 drivers/irqchip/irq-xtensa-mx.c                    |   2 -
 drivers/irqchip/irq-xtensa-pic.c                   |   2 -
 27 files changed, 1300 insertions(+), 314 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/dma-mapping.h
 delete mode 100644 arch/xtensa/platforms/iss/include/platform/hardware.h
 create mode 100644 arch/xtensa/variants/test_kc705_be/include/variant/core.h
 create mode 100644 arch/xtensa/variants/test_kc705_be/include/variant/tie-asm.h
 create mode 100644 arch/xtensa/variants/test_kc705_be/include/variant/tie.h

Thanks.
-- Max
