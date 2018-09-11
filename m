Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC0AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9420645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lXGFGTQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E9420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeILBHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:07:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52883 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeILBGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696343; x=1568232343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IWxrMPP8QxU5skWTKS1CuDJnhG9N0HHk6Ifj0AfIiZA=;
  b=lXGFGTQNcrUyopoBMBVrkxbmpNrkx/0kKgI/U6U+ahUdrQ11uYSr7zDd
   wrUI77XzfEPJ6id+OwGfQMbCZmqQhqlhHltvOFjKcgl7le2ORrV60Rr+U
   IQUUstCBTGNsan9X4/k5EMkx7OveGgol2QbFPT/Mr1NwcSy7/PfZuPBDv
   mFJfdzISDm6dODJHRz3PITV6QBEteZ+I8pxdYCK2KPbiuVPFOSW3OF/fU
   6RdRbaYmJX6BsqlnQPGmfRme6b3f5L77OMNAi+n+0dM4TH3POUfHLXeX4
   3U3AkOTrgaECV+F8RruhkgyTnKntS2MzHQGDfC/HXEY1jNo4+OQ/qrSeG
   g==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728829"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:41 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:16 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:42 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 05/12] RISC-V: Disable preemption before enabling interrupts
Date:   Tue, 11 Sep 2018 13:05:32 -0700
Message-Id: <1536696339-15204-6-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, irq is enabled before preemption disabling happens.
If the scheduler fired right here and cpu is scheduled then it
may blow up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
[Atish: Commit text and code comment formatting update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/smpboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 712e9ca8..670749ec 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -111,7 +111,11 @@ asmlinkage void __init smp_callin(void)
 	 * a local TLB flush right now just in case.
 	 */
 	local_flush_tlb_all();
-	local_irq_enable();
+	/*
+	 * Disable preemption before enabling interrupts, so we don't try to
+	 * schedule a CPU that hasn't actually started yet.
+	 */
 	preempt_disable();
+	local_irq_enable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
-- 
2.7.4

