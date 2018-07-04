Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688DFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225B824159
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KBawIRbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225B824159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeGDVZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:25:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36201 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGDVZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:25:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so3504180pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=y62pGyN9q4ya652mFs5O3YZQm0O7gODXCp32t35KG0M=;
        b=KBawIRbZK5rVa2AwUGZ487M872/zHnwMAAaE2UamAd7kH6L7cJRmzBx+euhJjQNYJ4
         JswwpEnvb/9s8n5DlssRHqRUCNS0KpSZIXBiMEgRlR6g40fS/cAyuIvpP6KeQM/qdBcT
         XtysUlNTYAFVoR6MDCxg53JGLxeuvD+eYKVTGyrjqMqohoVOgW4oXBMR4gSYb0ufhTBP
         ZaPV8UdzrNF5bqsCn29dOfXCTomzUI1Ru6o8sGHC1oIqCwMZoIIZJSqLz7VMvyrAF7B/
         Xh0Mx6I+3x2KDNbvdDWiIKvyfDVtX3Q5fFOyuVjemLa3vZ0Cf0ioW9kq/t50udHd9YiV
         F3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=y62pGyN9q4ya652mFs5O3YZQm0O7gODXCp32t35KG0M=;
        b=LHGmrMOr+LjKB6E+PqH2msOA55e8GiqUMpQ6j01cDTYAZVXklTqcIyJueZQ59TzJoD
         mRbFhZMJaBsBFU0PfANexuAM/vKenC/qM9854ImHkD8BgKgHu0fxM2Vuf2XuFctpIduA
         a+Mw1gz4dXbT+REK/1OtcWLrVBNdeIeH3OGIW4cavyuamwDJggFUaTkJj+Zf+wB2Q8Ou
         DIXl2DhN3SC37ALAaKGTihev6tE5NY5+biImwlf4EJSVbjGIfgnB4RbV6R5FiISD1SFK
         LDYCgL1xaGTB1f5yoyUsxWcZYuXdPMqUlLVcps5LSq2PbO6LrgnzUhfCWfB+cr2J87Eo
         8l5A==
X-Gm-Message-State: APt69E3oUJyHa/07e9xkrNEpRyJZkzL/Yck4fUEje3iZeuS9cYdbk2sW
        QxHrOG+eHzz+PyG5xFrGTn33aQ==
X-Google-Smtp-Source: AAOMgpfB4Xp0qn7nK2OljmNgGNm82sabhtGZrRiUbGG7w8Plk6Swx62oDNn1fdJ1RVVnobdBpv7Mmg==
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr3205350pgr.157.1530739508386;
        Wed, 04 Jul 2018 14:25:08 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id z25-v6sm6205627pgu.53.2018.07.04.14.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 14:25:07 -0700 (PDT)
Date:   Wed, 04 Jul 2018 14:25:07 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Jul 2018 14:24:55 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixus for 4.18-rc4
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-daf6638a-82c4-40ad-b63c-d3d205b6f556@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.18-rc4

for you to fetch changes up to 9a6a51154f8be90a76f6a8ea8809115c11cec9dd:

  RISC-V: Fix the rv32i kernel build (2018-07-04 14:12:53 -0700)

----------------------------------------------------------------
RISC-V Fixus for 4.18-rc4

This patch set contains a handful of fixes for the RISC-V port:

* A fix to R_RISCV_ADD32/R_RISCV_SUB32 relocations that allows modules
  that use these to load correctly.
* The removal of of_platform_populate(), which is obselete.
* The removal of irq-riscv-intc.h, which is obselete.
* A fix to PTRACE_SETREGSET.
* Fixes that allow the RV32I kernel to build (at least for Zong, I've
  got another patch on the mailing list that's necessary on my setup
  :)).

I've just given these a defconfig build test.

----------------------------------------------------------------
Andreas Schwab (1):
      RISC-V: fix R_RISCV_ADD32/R_RISCV_SUB32 relocations

Jim Wilson (1):
      RISC-V: Fix PTRACE_SETREGSET bug.

Palmer Dabbelt (2):
      RISC-V: Don't include irq-riscv-intc.h
      RISC-V: Fix the rv32i kernel build

Rob Herring (1):
      riscv: remove unnecessary of_platform_populate call

Zong Li (4):
      RISC-V: Add conditional macro for zone of DMA32
      RISC-V: Select GENERIC_UCMPDI2 on RV32I
      RISC-V: Add definiion of extract symbol's index and type for 32-bit
      RISC-V: Change variable type for 32-bit compatible

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/uapi/asm/elf.h |  9 +++++++--
 arch/riscv/kernel/irq.c           |  4 ----
 arch/riscv/kernel/module.c        | 26 +++++++++++++-------------
 arch/riscv/kernel/ptrace.c        |  2 +-
 arch/riscv/kernel/setup.c         |  5 -----
 arch/riscv/mm/init.c              |  2 ++
 7 files changed, 24 insertions(+), 25 deletions(-)
