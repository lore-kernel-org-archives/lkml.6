Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237C620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e3XwWCyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfBVTlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:41:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9380 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550864504; x=1582400504;
  h=from:to:cc:subject:date:message-id;
  bh=wb0dw4T5YMS0q07wWKgtgtrcUdnKjfeD2XfS99Hk2IU=;
  b=e3XwWCyIA4JWcB2ooNn2wx7De/sSq10Zh9WVOwbr2RALHqLl1xonUsnI
   aoctuXpLXuP3rj46ifzCWxmZwbvLDMo9sCtyrgjCXNOac6jwKn60nlEsn
   5Pa5r48Vi1bTWPZN18Ecgiav8m9aOQUvKigcAaAS6+ImV4MlBdPuRSOSd
   I36YhWq3ABIJjLnwKhNXvg1Inp+Kdk+JPWmiO1wtQKGXLQhnfJyY+tSPP
   7ehFYz//9sgKm8btjAFoThT5gY48zxWcTRLtUZdbUf1OpiV9AqC4exo/v
   6/bExBdc3kBOlke4Om0YYT9neqokVItwu9fJdsi4JUIuLZg8SXvBBso10
   A==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544457600"; 
   d="scan'208";a="103727132"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2019 03:41:44 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 22 Feb 2019 11:22:03 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2019 11:41:44 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v6 PATCH 0/6] Various SMP related fixes
Date:   Fri, 22 Feb 2019 11:41:34 -0800
Message-Id: <1550864500-13652-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing upstream kernel doesn't boot for non-smp configuration.
This patch series address various issues with non-smp configurations.

The patch series is based on 5.0-rc7 + Johan's below mentioned patch
series. Tested on both QEMU and HiFive Unleashed board using both
OpenSBI & BBL.

https://lore.kernel.org/lkml/20190118140308.9599-1-johan@kernel.org/   

Changes from v5->v6
1. Dropped driver patches as they have been accepted via drivers tree.

Changes from v4->v5
1. Continue processing other harts even if isa string is incorrect for
   a single hart during HWCAP processing.

Changes from v3->v4
1. Fixed commit text length issues.
2. Updated hwcap patch to use common capabilities of all harts.
3. Rebased on Johan's patch series.

Changes from v2->v3

1. Fixed spurious white space.
2. Added lockdep for smpboot completion variable.
2. Added a sanity check for hwcap.

Changes from v1->v2

1. Move the cpuid to hartid map to smp.c from setup.c
2. Split 3rd patch into several small patches based on
   logical grouping.
3. Added a new patch that fixes an issue in hwcap query.
4. Changed the title of the patch series.

Atish Patra (6):
RISC-V: Do not wait indefinitely in __cpu_up
RISC-V: Move cpuid to hartid mapping to SMP.
RISC-V: Remove NR_CPUs check during hartid search from DT
RISC-V: Allow hartid-to-cpuid function to fail.
RISC-V: Compare cpuid with NR_CPUS before mapping.
RISC-V: Assign hwcap as per comman capabilities.

arch/riscv/include/asm/smp.h   | 18 +++++++++++++-----
arch/riscv/kernel/cpu.c        |  4 ----
arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
arch/riscv/kernel/setup.c      |  9 ---------
arch/riscv/kernel/smp.c        | 10 +++++++++-
arch/riscv/kernel/smpboot.c    | 20 +++++++++++++++++---
6 files changed, 61 insertions(+), 41 deletions(-)

--
2.7.4

