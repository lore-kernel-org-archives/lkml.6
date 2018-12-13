Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5013E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZpOn5i61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5013E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbeLMXOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:14:53 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15458 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLMXOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544742895; x=1576278895;
  h=from:to:cc:subject:date:message-id;
  bh=RTsWalh1XbKdBNzRQGYMWqHt94ahyZseETm1+e2I45A=;
  b=ZpOn5i613aYEEnfPPoqVOgzaWAx5Gc3F9JLfsxByXGF9thcEkBEV2/aX
   I/VHghHGv0Bp7kwnig3RWJK+GmkLGYLGk5j+7a+DHaLOuEsWXPxReObjt
   Fkuue2OWYm5v4/QVhSNJMIchpYAnl2+JS04XRzha3MMm25+/g0ITPj49A
   FxETibxvWy8qqoEvbYz8Wpcuxj6BBSZtNIW709hKq2HxXQOgS0EswfIa8
   5tVb0/8v8+azOkY+fSn/S5TkydzQFuSsB/sZ7Y33VjhhDC4kQwMvBQPQ5
   YOsxq2illStOztNV3AASFcVi38nss7jpLXcl2rnnC1BAl9J/t1ELhXTGi
   w==;
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="194445532"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2018 07:14:54 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Dec 2018 14:57:20 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2018 15:14:53 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/4] Timer code cleanup. 
Date:   Thu, 13 Dec 2018 15:14:25 -0800
Message-Id: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series provides an assorted timer cleanups in RISC-V.

Changes from v1->v2:

1. Updated commit text in 1/4.
2. Added a timebase check for each cpu.
3. Added a warning for invalid hartid 4/4.

Atish Patra (3):
RISC-V: Support per-hart timebase-frequency
RISC-V: Remove per cpu clocksource
RISC-V: Fix non-smp kernel boot on SMP systems

Palmer Dabbelt (1):
dt-bindings: Correct RISC-V's timebase-frequency

Documentation/devicetree/bindings/riscv/cpus.txt |  4 +-
arch/riscv/kernel/time.c                         |  9 +----
drivers/clocksource/riscv_timer.c                | 51 +++++++++++++++++++++---
3 files changed, 49 insertions(+), 15 deletions(-)

--
2.7.4

