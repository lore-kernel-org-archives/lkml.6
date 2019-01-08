Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6596C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728A0206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PaElqrju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAHJi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:38:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8886 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfAHJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546940328; x=1578476328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hIYjBsfhX3gB/IHDl4/QkkHLXfbPQQMg3EaMmAjjBhc=;
  b=PaElqrjuHBVa7s4moEuTG76Oqw9AJZ8WAoiRHh+7HxFwDelAz1BmcgK3
   viY2IW6zJZlRhQ30c+FpaMbaepJi/e1DMx6NMQ971FEwBcqQLzK41KdLF
   7SOM5XZ4XJ+2PUzJdnxm/OnXmUaA5+ImYVC6nhqGOgMqC7ptXXfMHDBVn
   qgLAjtSdCdeY26owfNbfJNOK6guUrtFQ6tplMu6qSmBt2n6FHLq+/A40q
   WoK8tfo6gMqQuYBzJiRzsCvnZiiZYoPXshB64/TEJRwpvgTkuaH1UCbuf
   KCSpqAbf0UoKspY8PkFHDK4ktluCtNaMwajhBx9Kc3GJs2PULDvz9e8dS
   A==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="99458416"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 17:38:48 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 08 Jan 2019 01:18:53 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 01:38:48 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 8/8] RISC-V: Assign hwcap only according to current cpu.
Date:   Tue,  8 Jan 2019 01:38:38 -0800
Message-Id: <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we set hwcap based on first valid cpu from
DT. This may not be correct always as that CPU might not
be current booting cpu.

Set hwcap based on the current cpu instead of first
valid CPU from DT.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpufeature.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a6e369ed..ed6122ff 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -43,12 +43,15 @@ void riscv_fill_hwcap(void)
 	elf_hwcap = 0;
 
 	/*
-	 * We don't support running Linux on hertergenous ISA systems.  For
-	 * now, we just check the ISA of the first "okay" processor.
+	 * We don't support running Linux on hertergenous ISA systems.
+	 * But first "okay" processor might not be the boot cpu.
+	 * Check the ISA of boot cpu.
 	 */
-	while ((node = of_find_node_by_type(node, "cpu")))
-		if (riscv_of_processor_hartid(node) >= 0)
+	while ((node = of_find_node_by_type(node, "cpu"))) {
+		if (riscv_of_processor_hartid(node) == boot_cpu_hartid)
 			break;
+	}
+
 	if (!node) {
 		pr_warning("Unable to find \"cpu\" devicetree entry");
 		return;
-- 
2.7.4

