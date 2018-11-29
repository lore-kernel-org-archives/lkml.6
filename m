Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641CAC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DE520673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P71jGYZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DE520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeK3KQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43698 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK3KQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543532958; x=1575068958;
  h=from:to:subject:date:message-id;
  bh=T4sACbZQqUFgfK2xqCQnFGi9r01TmuB0hzck2X/Um78=;
  b=P71jGYZHDSkS9RKhPeJCi6gZKYDH/pQW1LCC0d9P44sQxU/MHQrG13o0
   wliVD6ihUBb/19xOHgxyyJK4W6fsGsEdhgdLYbuIigDd4iuDMJnDsS08H
   NkQQfHYYwqtdEmLVAEeG1B0JCVdrmoHYP0H6Gy9hOpFkioEpYM/zbz2LZ
   ck8Orjc/yzva/TmLYOYRBOmSJZycKTm831z71D62HUQ7C/fqMSlkAh/ED
   gPAWRLjv5VOI65Yv8Rzo9x6LkcClV4OYH/uOZLuQt5IylgTM1YXywvLIg
   /itw6U/2PiEroQZVfo8xPDZ0pvcr0iM9nhmUOPH23Hzdhi2nU+7xzczpg
   A==;
X-IronPort-AV: E=Sophos;i="5.56,296,1539619200"; 
   d="scan'208";a="97183853"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 07:09:18 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 14:52:14 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 15:09:18 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [RFT PATCH 0/4] Unify CPU topology across ARM64 & RISC-V
Date:   Thu, 29 Nov 2018 15:09:13 -0800
Message-Id: <1543532957-22661-1-git-send-email-atish.patra@wdc.com>
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

