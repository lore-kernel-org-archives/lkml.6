Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0FC00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706BC2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706BC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJIJeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:34:24 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:58596 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbeJIJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:34:24 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w992Lha0032580;
        Tue, 9 Oct 2018 10:21:43 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 9 Oct 2018
 10:19:01 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH v8 0/5] riscv: Add support to no-FPU systems
Date:   Tue, 9 Oct 2018 10:18:29 +0800
Message-ID: <1539051514-3658-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w992Lha0032580
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

Changes in v8:
 - Fix a build fail introduced in v7.

Changes in v7:
 - Remove "fd" attribute from KBUILD_CFLAGS.

Changes in v6 (PATCH 0005 only):
 - Make the flag checking neater.

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

 arch/riscv/Kconfig                 |   9 ++++
 arch/riscv/Makefile                |  19 +++----
 arch/riscv/include/asm/switch_to.h |  12 ++++-
 arch/riscv/kernel/Makefile         |   1 +
 arch/riscv/kernel/cpufeature.c     |   8 +++
 arch/riscv/kernel/entry.S          |  87 ------------------------------
 arch/riscv/kernel/fpu.S            | 106 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c        |   6 ++-
 arch/riscv/kernel/signal.c         |  75 ++++++++++++++++----------
 9 files changed, 196 insertions(+), 127 deletions(-)
 create mode 100644 arch/riscv/kernel/fpu.S

-- 
2.7.4

