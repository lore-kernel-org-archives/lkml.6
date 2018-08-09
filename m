Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C3C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31621B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F31621B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeHIIuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:50:21 -0400
Received: from exmail.andestech.com ([59.124.169.137]:55665 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:50:20 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w796PsgH087824;
        Thu, 9 Aug 2018 14:25:54 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 9 Aug 2018
 14:26:49 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Darius Rad <darius@bluespec.com>
CC:     <greentime@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <nickhu@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH v5 0/5] riscv: Add support to no-FPU systems
Date:   Thu, 9 Aug 2018 14:26:38 +0800
Message-ID: <1533796003-680-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w796PsgH087824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an option, CONFIG_FPU, to enable/disable floating-
point procedures.

Kernel's new behavior will be as follows:

* with CONFIG_FPU=y
  All FPU codes are reserved.  If no FPU is found during booting, a
  global flag will be set, and those functions will be bypassed with
  condition check to that flag.

* with CONFIG_FPU=n
  No floating-point instructions in kernel and all related settings
  are excluded.

Changes in v5:
 - Invert the polarity of checking flag from no_fpu to has_fpu.

Changes in v4:
 - Append a new patch to detect existence of FPU and followups.
 - Add SPDX header to newly created fpu.S.
 - Fix a build error, sorry for that.
 - Fix wording, style, etc.

Changes in v3:
 - Refactor the whole patch into independent ones.

Changes in v2:
 - Various code cleanups and style fixes.

Alan Kao (5):
  Extract FPU context operations from entry.S
  Refactor FPU code in signal setup/return procedures
  Cleanup ISA string setting
  Allow to disable FPU support
  Auto-detect whether a FPU exists

 arch/riscv/Kconfig                 |   9 +++
 arch/riscv/Makefile                |  19 +++---
 arch/riscv/include/asm/hwcap.h     |   1 +
 arch/riscv/include/asm/switch_to.h |  13 +++-
 arch/riscv/kernel/Makefile         |   1 +
 arch/riscv/kernel/cpufeature.c     |   8 +++
 arch/riscv/kernel/entry.S          |  87 -----------------------
 arch/riscv/kernel/fpu.S            | 106 +++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c        |   6 +-
 arch/riscv/kernel/signal.c         |  75 ++++++++++++--------
 10 files changed, 198 insertions(+), 127 deletions(-)
 create mode 100644 arch/riscv/kernel/fpu.S

-- 
2.18.0

