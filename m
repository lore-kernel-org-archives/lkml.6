Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C29C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356E620673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4vZBDFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356E620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeGZPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:55:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EFVeN7WbbZw6vRuuORh8CD4rJRx53TVZwG89sQVyxzI=; b=G4vZBDFyRYzkFeLX0XMg0TizK
        kQb6XA033UAXdKLYg41W0QcBuXDQW5Ro+2wgxJ7ogAs8JSsKbJWI0WZ1TPkmCeyJKp7xYoLIvUHcT
        Ahfjj04OSGNJ/+oD060YR+u8YGRaHKlOyEiuHIqaiOVRC47Oo1eNX4fIVJXWJpZHlCekSEI9uMTfp
        2rrzrl7oyeQurV2eowJsUCmZodpVLUjFznxniipMaApcZ1RjgPPIBQO2xz0bATXp1+vIQme0qfZzh
        teozTrBidR69e3JYi30reTgXUqZwWvGB57k90PaXWwOWr/VDaCBfVjpfy1HPkuUDSd+RMvpRhTd00
        g19m/1afg==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOl-0005oI-Dx; Thu, 26 Jul 2018 14:37:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 6/9] RISC-V: Support per-hart timebase-frequency
Date:   Thu, 26 Jul 2018 16:37:20 +0200
Message-Id: <20180726143723.16585-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726143723.16585-1-hch@lst.de>
References: <20180726143723.16585-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

This isn't actually how I want to do it, I just needed something right
now.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/kernel/time.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 0df9b2cbd645..1bb01dc2d0f1 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -24,17 +24,24 @@ void __init init_clockevent(void)
 	csr_set(sie, SIE_STIE);
 }
 
-void __init time_init(void)
+static long __init timebase_frequency(void)
 {
 	struct device_node *cpu;
 	u32 prop;
 
 	cpu = of_find_node_by_path("/cpus");
-	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
-		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
-	riscv_timebase = prop;
+	if (cpu && !of_property_read_u32(cpu, "timebase-frequency", &prop))
+		return prop;
+	cpu = of_find_node_by_path("/cpus/cpu@0");
+	if (cpu && !of_property_read_u32(cpu, "timebase-frequency", &prop))
+		return prop;
 
-	lpj_fine = riscv_timebase / HZ;
+	panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
+}
 
+void __init time_init(void)
+{
+	riscv_timebase = timebase_frequency();
+	lpj_fine = riscv_timebase / HZ;
 	init_clockevent();
 }
-- 
2.18.0

