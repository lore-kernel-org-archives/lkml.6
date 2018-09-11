Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB6520645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rhSq6ZZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB6520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeILBGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52883 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeILBGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696342; x=1568232342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OuyFWfTkug3rB9AJbq2Ei8qu9NGd/jDUUCC71bRCdX0=;
  b=rhSq6ZZKx5EV2glD2S/JuLflu+lvcF1az9Cg3AALVCxrPxVwVQqQIMBf
   Y3E2zl9XQ4n7voExJw9YIQ1cnzZUTuCBJcpLCVOkFWOOpLktetAVrVi+5
   Q+tJGnZVDGK7MaMDtGlJ4eFulecM7ZcaDXSA+1mU9A3cp6Rm9EVSVnptJ
   oxBt5TJ39VhRmQH6lT37ZFW8AI9gV8C8q6EZ8U5Eh+tpyzAFC9IUGgMez
   F4pHUabYFCkGVwh+DwkVu8HFR1DFmPR4MFPck53pD5b0pp+cWQ6c+zPxk
   rFSqQD84YwWMaIOCuCErRES0JCVJ4p7slL4L4RpP6nnJRo0fgOWGLdVuF
   g==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728824"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:41 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:15 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 03/12] RISC-V: Filter ISA and MMU values in cpuinfo
Date:   Tue, 11 Sep 2018 13:05:30 -0700
Message-Id: <1536696339-15204-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

We shouldn't be directly passing device tree values to userspace, both
because there could be mistakes in device trees and because the kernel
doesn't support arbitrary ISAs.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
[Atish: checkpatch fix and code comment formatting update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/cpu.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ca6c81e5..1c0bf662 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -58,6 +58,63 @@ int riscv_of_processor_hart(struct device_node *node)
 
 #ifdef CONFIG_PROC_FS
 
+static void print_isa(struct seq_file *f, const char *orig_isa)
+{
+	static const char *ext = "mafdc";
+	const char *isa = orig_isa;
+	const char *e;
+
+	/*
+	 * Linux doesn't support rv32e or rv128i, and we only support booting
+	 * kernels on harts with the same ISA that the kernel is compiled for.
+	 */
+#if defined(CONFIG_32BIT)
+	if (strncmp(isa, "rv32i", 5) != 0)
+		return;
+#elif defined(CONFIG_64BIT)
+	if (strncmp(isa, "rv64i", 5) != 0)
+		return;
+#endif
+
+	/* Print the base ISA, as we already know it's legal. */
+	seq_puts(f, "isa\t: ");
+	seq_write(f, isa, 5);
+	isa += 5;
+
+	/*
+	 * Check the rest of the ISA string for valid extensions, printing those
+	 * we find.  RISC-V ISA strings define an order, so we only print the
+	 * extension bits when they're in order.
+	 */
+	for (e = ext; *e != '\0'; ++e) {
+		if (isa[0] == e[0]) {
+			seq_write(f, isa, 1);
+			isa++;
+		}
+	}
+
+	/*
+	 * If we were given an unsupported ISA in the device tree then print
+	 * a bit of info describing what went wrong.
+	 */
+	if (isa[0] != '\0')
+		pr_info("unsupported ISA \"%s\" in device tree", orig_isa);
+}
+
+static void print_mmu(struct seq_file *f, const char *mmu_type)
+{
+#if defined(CONFIG_32BIT)
+	if (strcmp(mmu_type, "riscv,sv32") != 0)
+		return;
+#elif defined(CONFIG_64BIT)
+	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
+	    strcmp(mmu_type, "riscv,sv48") != 0)
+		return;
+#endif
+
+	seq_printf(f, "mmu\t: %s\n", mmu_type+6);
+}
+
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
@@ -83,13 +140,10 @@ static int c_show(struct seq_file *m, void *v)
 	const char *compat, *isa, *mmu;
 
 	seq_printf(m, "hart\t: %lu\n", hart_id);
-	if (!of_property_read_string(node, "riscv,isa", &isa)
-	    && isa[0] == 'r'
-	    && isa[1] == 'v')
-		seq_printf(m, "isa\t: %s\n", isa);
-	if (!of_property_read_string(node, "mmu-type", &mmu)
-	    && !strncmp(mmu, "riscv,", 6))
-		seq_printf(m, "mmu\t: %s\n", mmu+6);
+	if (!of_property_read_string(node, "riscv,isa", &isa))
+		print_isa(m, isa);
+	if (!of_property_read_string(node, "mmu-type", &mmu))
+		print_mmu(m, mmu);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t: %s\n", compat);
-- 
2.7.4

