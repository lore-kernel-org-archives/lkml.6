Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7ECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B375220840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eG2dsFtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B375220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeKIL2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:28:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29613 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeKIL2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1541728211; x=1573264211;
  h=from:to:cc:subject:date:message-id;
  bh=VF4xDTCd1cf9MNbFtsKdQRmCcMT129PQWO/5Qc0m0p0=;
  b=eG2dsFtzQb245LzBDSGS/1qlO0crxTf2RaVBcRKcm/UmLzpAuorDWgDQ
   Cj9FdBEzZfOlLnjG0/3t+z+HXq/4KSItnG4tGo08jCq4RbcaeInZ8daft
   Cnagu/HmyYUhX9L69bt0GgjaybEuGpiKRpg1licxu3yvqzWbTB1WBdSO6
   YdpnBrWeNc6N3VY7VGK/eztcDdo87axG0M/WOFKzYWDZ+hN64x5HzKHmp
   r7HTln17sU5AaxvDo1gRsNXcKVB588n/iMyMSK68TmxQjqChYK9slkGJX
   pkGeVjsm+Z4jiYbmLf73Xo8KHzlYjyt5rdbszbZlT6v5Wursn+T+ilx4J
   A==;
X-IronPort-AV: E=Sophos;i="5.54,481,1534780800"; 
   d="scan'208";a="98624911"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2018 09:50:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Nov 2018 17:33:44 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Nov 2018 17:50:10 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        Damien.LeMoal@wdc.com, atish.patra@wdc.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org, sudeep.holla@arm.com, palmer@sifive.com,
        devicetree@vger.kernel.org, juri.lelli@arm.com, mick@ics.forth.gr,
        jeremy.linton@arm.com
Subject: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V 
Date:   Thu,  8 Nov 2018 17:50:06 -0800
Message-Id: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
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
to code. The only downside in this approach is that the capacity
code will be executed for RISC-V as well. But, it will exit
immediately after not able to find the appropriate DT node. If
the overhead is considered too much, we can always compile out
capacity related functions under a different config for the
architectures that do not support them.

The patches have been tested for RISC-V and compile tested for
ARM64.

The socket changes[2] can be merged on top of this series or vice
versa.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

Atish Patra (3):
  dt-binding: cpu-topology: Move cpu-map to a common binding.
  cpu-topology: Move cpu topology code to common code.
  RISC-V: Parse cpu topology during boot.

 Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
 .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
 arch/arm64/include/asm/topology.h                  |  23 +-
 arch/arm64/kernel/topology.c                       | 305 +-----------
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/kernel/smpboot.c                        |   6 +-
 drivers/base/arch_topology.c                       | 303 ++++++++++++
 include/linux/arch_topology.h                      |  23 +
 include/linux/topology.h                           |   1 +
 9 files changed, 864 insertions(+), 799 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
 create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt

-- 
2.7.4

