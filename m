Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A7620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KNKTjC8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A7620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKBIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:09:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34533 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeKBIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541113469; x=1572649469;
  h=from:to:cc:subject:date:message-id;
  bh=u58J7OBrDe40sG+JE5QsBGfXlwVdiMnwpU4kzKzSGGo=;
  b=KNKTjC8rIZUeJWiEBuYArLWlJZoiGZ31EQdtfrMyfklNg1hrBBdb1A7w
   RjEO8OnMRONJ+DkrCpd6edMovEhPzTbRTo4YoG1oH2n5S3U2SgAgGTMgJ
   T51ioXLPCvHEyCCzOl4P/s1s9LCRylGYDbFCoH30Y1j7HEuuEbiqOMnXC
   uxaIxoIBytinCAomyT0t3PjreUVit9JQMi0MvdChFBHPeZw5hI19+r4Jx
   zTPqGJWh3x3CYXy4FDkB0BkS61nDLYtdQTlDQapChwynozJa/oOCewpbO
   Bitfyb1azGpsJ3CCmOljtXm9ZcG38KxMQWvXbIZlCPztYBv5QamTMRpBC
   g==;
X-IronPort-AV: E=Sophos;i="5.54,454,1534780800"; 
   d="scan'208";a="197776149"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2018 07:04:28 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Nov 2018 15:48:30 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Nov 2018 16:04:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     palmer@sifive.com, anup@brainfault.org, hch@infradead.org,
        Damien.LeMoal@wdc.com, tglx@linutronix.de, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alankao@andestech.com,
        zong@andestech.com
Subject: [RFC 0/2] Add RISC-V cpu topology
Date:   Thu,  1 Nov 2018 16:04:26 -0700
Message-Id: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the cpu topology for RISC-V. It contains
both the DT binding and actual source code. It has been tested on
QEMU & Unleashed board. 

The idea is based on cpu-map in ARM with changes related to how
we define SMT systems. The reason for adopting a similar approach
to ARM as I feel it provides a very clear way of defining the
topology compared to parsing cache nodes to figure out which cpus
share the same package or core.  I am open to any other idea to
implement cpu-topology as well.

Atish Patra (2):
  dt-bindings: topology: Add RISC-V cpu topology.
  RISC-V: Introduce cpu topology.

 .../devicetree/bindings/riscv/topology.txt         | 154 ++++++++++++++++
 arch/riscv/include/asm/topology.h                  |  28 +++
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/smpboot.c                        |   5 +-
 arch/riscv/kernel/topology.c                       | 194 +++++++++++++++++++++
 5 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
 create mode 100644 arch/riscv/include/asm/topology.h
 create mode 100644 arch/riscv/kernel/topology.c

-- 
2.7.4

