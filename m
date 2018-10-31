Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A786ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAF22081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAF22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeJaTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:33:54 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:20861 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727980AbeJaTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:33:53 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9VAaVRO095819;
        Wed, 31 Oct 2018 18:36:31 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 31 Oct 2018
 18:35:35 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>
CC:     <arnd@arndb.de>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <greentime@andestech.com>,
        <alankao@andestech.com>, <vincentc@andestech.com>,
        <zong@andestech.com>, <deanbo422@gmail.com>
Subject: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Date:   Wed, 31 Oct 2018 18:35:28 +0800
Message-ID: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9VAaVRO095819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  RISC-V permits each vendor to develop respective extension ISA based
on RISC-V standard ISA. This means that these vendor-specific features
may be compatible to their compiler and CPU. Therefore, each vendor may
be considered a sub-architecture of RISC-V. Currently, vendors do not
have the appropriate examples to add these specific features to the
kernel. In this RFC set, we propose an infrastructure that vendor can
easily hook their specific features into kernel. The first commit is
the main body of this infrastructure. In the second commit, we provide
a solution that allows dma_map_ops() to work without cache coherent
agent support. Cache coherent agent is unsupported for low-end CPUs in
the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
need this solution to overcome the limitation of cache coherent agent
support. Hence, it also can be used as an example for the first commit.

  I am glad to discuss any ideas, so if you have any idea, please give
me some feedback.

Vincent Chen (2):
  RISC-V: An infrastructure to add vendor-specific code.
  RISC-V: make dma_map_ops work without cache coherent agent

 arch/riscv/Kconfig                              |   49 +++++
 arch/riscv/Makefile                             |    6 +
 arch/riscv/include/asm/sbi.h                    |    6 +
 arch/riscv/include/asm/vendor-hook.h            |   13 ++
 arch/riscv/kernel/cpufeature.c                  |    5 +
 arch/riscv/kernel/setup.c                       |    6 +-
 arch/riscv/vendor-nds/Kconfig                   |   29 +++
 arch/riscv/vendor-nds/Makefile                  |    1 +
 arch/riscv/vendor-nds/cache.c                   |   83 ++++++++
 arch/riscv/vendor-nds/include/asm/csr.h         |   32 +++
 arch/riscv/vendor-nds/include/asm/dma-mapping.h |   24 +++
 arch/riscv/vendor-nds/include/asm/proc.h        |   17 ++
 arch/riscv/vendor-nds/include/asm/sbi.h         |   17 ++
 arch/riscv/vendor-nds/include/asm/vendor-hook.h |    8 +
 arch/riscv/vendor-nds/noncoherent_dma.c         |  254 +++++++++++++++++++++++
 arch/riscv/vendor-nds/setup.c                   |   16 ++
 16 files changed, 565 insertions(+), 1 deletions(-)
 create mode 100644 arch/riscv/include/asm/vendor-hook.h
 create mode 100644 arch/riscv/vendor-nds/Kconfig
 create mode 100644 arch/riscv/vendor-nds/Makefile
 create mode 100644 arch/riscv/vendor-nds/cache.c
 create mode 100644 arch/riscv/vendor-nds/include/asm/csr.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/dma-mapping.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/proc.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/sbi.h
 create mode 100644 arch/riscv/vendor-nds/include/asm/vendor-hook.h
 create mode 100644 arch/riscv/vendor-nds/noncoherent_dma.c
 create mode 100644 arch/riscv/vendor-nds/setup.c

