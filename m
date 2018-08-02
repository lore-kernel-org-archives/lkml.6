Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3249C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4FA208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4n4jory"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4FA208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeHBNln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:41:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeHBNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7mASTYWjWlgnbWE1f5YrO/7yhfBrQ5u+xu1D8oUqScQ=; b=C4n4jory8bnsGxmvXYKPa4wzi
        e9E6rDvIpdyoxs9WNSpJMaEcBBNNOz4cSSA3KVginIBWDuvV0Yn15gRMZKE3B5CeWOtxjwJC618Ll
        Y3p5jW9X6sKSGXBhirGcRjMwEPsV7A6GWaMD1ihGrC4jptavra67AnymSXcje0KUJKGjcjKmuOmNc
        Z9sGRM6HchoczAJUHH/l/Oe5tYAF6RS8vXLjU4U/v2demdiKAVnAZp1BIcC8aV9pd7yuwW7FM6DHZ
        V1FFQstcJEGZWHPveYcWaS6Zvu/saHXkYr8CL4QmK66b7wtvzpajLQr4G96AGi6r1TjwZqFLyJDQn
        /LTTnBkBA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flC80-0005Si-9m; Thu, 02 Aug 2018 11:50:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 09/11] RISC-V: Support per-hart timebase-frequency
Date:   Thu,  2 Aug 2018 13:50:06 +0200
Message-Id: <20180802115008.4031-10-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
References: <20180802115008.4031-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

Follow the updated DT specs and read the timebase-frequency from the
CPU 0 node.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
[hch: updated changelog]
Signed-off-by: Christoph Hellwig <hch@lst.de>
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

