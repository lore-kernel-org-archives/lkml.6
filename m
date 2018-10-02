Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57DC64EBB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525E92064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gfW3hq/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525E92064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJCCAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42347 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeJCCAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507710; x=1570043710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IWxrMPP8QxU5skWTKS1CuDJnhG9N0HHk6Ifj0AfIiZA=;
  b=gfW3hq/sRoWl9lV8L1sceRkSyXA4afKbd6n7rriih68Bg+wN5gkUZe3y
   cYav0xaSZppGPAQieA3t6TIchhXvjrxS8ljI9V8owmmpH75N1UcDb2xH3
   7iq1QaU5eKBtI70OETKgIDxLC5z9XmesyU+eYmhVnsBnkG7UWKLr/+q5T
   8Dnwxs+Y5SObmojbHFgnWx8+d5/oCWQe/U0NPI23UXJl6CReCr2uV3sD9
   nw5U6ZC/uylBMf5mizEBY9BdZFstCDvGFlCCW1IBXg6j/nGmXbbjJWpte
   xvuaKJgfzHdq5V0HP5EvOiVGyws//g/NfccGFO6DPyp8RPEU/dIVN9/hy
   A==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="92732899"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:50 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 05/14] RISC-V: Disable preemption before enabling interrupts
Date:   Tue,  2 Oct 2018 12:14:58 -0700
Message-Id: <1538507707-22299-6-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
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

