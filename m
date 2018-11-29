Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9901320989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oTqTKDli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9901320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK3Kfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:35:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50484 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543534107; x=1575070107;
  h=from:to:cc:subject:date:message-id;
  bh=L7Qnx+G1U15UoezilU3DKAcIr1VLVm+CQnW9+MoRsKs=;
  b=oTqTKDli1HZWr14a4gdRslqdsLY6gE2Ccnt1xO+D/28GAfOsRmca6iyt
   iW489Auj48ALeMXXiRvtQFKPpGHgPG8Gs0jXj/7j40LrbV+oIpfhHtxJi
   ilBPav86jOr3c8FjNNb0mCEzzhnegSt9DE96nDZmbA8HMrWvcoZqqeaHA
   CLtx1lIvFlTcNEp7h0MAu+DQ5tJubWSSaubo9LyEX9tA1kN+/F6Ir1pud
   PT/+8/4VDTqWaQVi67gcY9VzVdtssFExDUwsEtL3VCZegkzfdIUvktv7P
   ceIl9P2uomkoqPwDCGTDWMYXFTWO1z97yMXR9BybLjrWaS4Szo+F2pzHm
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; 
   d="scan'208";a="96644301"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 07:28:26 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 15:11:23 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 15:28:26 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFT PATCH v1 0/4] Unify CPU topology across ARM64 & RISC-V
Date:   Thu, 29 Nov 2018 15:28:16 -0800
Message-Id: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu-map DT entry in ARM64 can describe the CPU topology in
much better way compared to other existing approaches. RISC-V can
easily adopt this binding to represent it's own CPU topology.
Thus, both cpu-map DT binding and topology parsing code can be
moved to a common location so that RISC-V or any other
architecture can leverage that.

The relevant discussion regarding unifying cpu topology can be
found in [1].

arch_topology seems to be a perfect place to move the common
code. I have not introduced any functional changes in the moved
code. The only downside in this approach is that the capacity
code will be executed for RISC-V as well. But, it will exit
immediately after not able to find the appropriate DT node. If
the overhead is considered too much, we can always compile out
capacity related functions under a different config for the
architectures that do not support them.

The patches have been tested for RISC-V and compile tested for
ARM64 & x86.

The socket change[2] is also now part of this series.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

QEMU changes for RISC-V topology are available at

https://github.com/atishp04/riscv-qemu/tree/cpu_topo

Apologies for the previous patch series with incorrect title and
was sent only to kernel mailing list due to a bug in my config.
Please ignore that.

Atish Patra (3):
dt-binding: cpu-topology: Move cpu-map to a common binding.
cpu-topology: Move cpu topology code to common code.
RISC-V: Parse cpu topology during boot.

Sudeep Holla (1):
Documentation: DT: arm: add support for sockets defining package
boundaries

.../{arm/topology.txt => cpu/cpu-topology.txt}     | 133 +++++++--
arch/arm64/include/asm/topology.h                  |  22 --
arch/arm64/kernel/topology.c                       | 303 +--------------------
arch/riscv/Kconfig                                 |   1 +
arch/riscv/kernel/smpboot.c                        |   3 +
drivers/base/arch_topology.c                       | 294 ++++++++++++++++++++
include/linux/arch_topology.h                      |  26 ++
include/linux/topology.h                           |   1 +
8 files changed, 435 insertions(+), 348 deletions(-)
rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)

--
2.7.4

