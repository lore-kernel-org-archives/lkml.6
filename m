Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C201CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEBB217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aAX2iIEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfBYWt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:49:29 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57826 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfBYWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:49:29 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id F06B710C0B59;
        Mon, 25 Feb 2019 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551134968; bh=Ywg8nLaGmctilSeykxnzR5kWTebK6szo03fUYdQ3eLY=;
        h=From:To:CC:Subject:Date:From;
        b=aAX2iIEvPtbuqWIJ0WuApkoVxZ1yd3xdXVtXJFaxkp7l12ebXwZ+X5t9nVQMR95qZ
         2ZoYXP256B24AOpD7xsl++jBM8scPYfQ9QcDEPtgUOcop3y9OKPdjkR8k1s6MGj7iR
         U5AC1Db5mS0SsN1/2uUIxnyxPVnJ+3DMK3hEypDorqF4948Me6kVheyFJlNKWy0Qgj
         /DtK2CZS5kCaAfecdeW4Kpbgjvt6AaFKsRPsHppRAn93Rv0WPVr2SNPRyoaGjMQlWR
         DLkfg3KAf1qXMaPp0SECL1f+WAGtnCGmIf85lHABJs08qO6OARgXV7LC/et5o640Aa
         RtPqU0wwBrANQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C18D3A0091;
        Mon, 25 Feb 2019 22:49:28 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 25 Feb 2019 14:49:28 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Feb 2019 04:19:32 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Feb 2019 04:19:31 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <alexey.brodkin@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH 1/2] ARCv2: boot log: refurbish HS core/release identification
Date:   Mon, 25 Feb 2019 14:49:08 -0800
Message-ID: <1551134949-23676-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HS core names and releases were currently identified base don the
IDENTIFY.ARCVER field. With the future HS core4 release, this will not
be sufficient as same ARCVER 0x54 could be a HS38 or HS48.

So rewrite the code to use the new BCR to identify the cores properly.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/arcregs.h |   2 +-
 arch/arc/kernel/setup.c        | 130 +++++++++++++++++++++++------------------
 2 files changed, 75 insertions(+), 57 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 0c13317af1d6..36e5d124f5ae 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -313,7 +313,7 @@ struct cpuinfo_arc {
 	struct cpuinfo_arc_bpu bpu;
 	struct bcr_identity core;
 	struct bcr_isa_arcv2 isa;
-	const char *details, *name;
+	const char *release, *name;
 	unsigned int vec_base;
 	struct cpuinfo_arc_ccm iccm, dccm;
 	struct {
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index ec2fd231ecd9..6bd466892915 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -45,29 +45,24 @@ struct task_struct *_current_task[NR_CPUS];	/* For stack switching */
 
 struct cpuinfo_arc cpuinfo_arc700[NR_CPUS];
 
-static const struct id_to_str arc_cpu_rel[] = {
+static const struct id_to_str arc_legacy_rel[] = {
+	/* ID.ARCVER,	Release */
 #ifdef CONFIG_ISA_ARCOMPACT
-	{ 0x34, "R4.10"},
-	{ 0x35, "R4.11"},
+	{ 0x34, 	"R4.10"},
+	{ 0x35, 	"R4.11"},
 #else
-	{ 0x51, "R2.0" },
-	{ 0x52, "R2.1" },
-	{ 0x53, "R3.0" },
-	{ 0x54, "R3.10a" },
+	{ 0x51, 	"R2.0" },
+	{ 0x52, 	"R2.1" },
+	{ 0x53,		"R3.0" },
 #endif
-	{ 0x00, NULL   }
+	{ 0x00,		NULL   }
 };
 
-static const struct id_to_str arc_cpu_nm[] = {
-#ifdef CONFIG_ISA_ARCOMPACT
-	{ 0x20, "ARC 600"   },
-	{ 0x30, "ARC 770"   },  /* 750 identified seperately */
-#else
-	{ 0x40, "ARC EM"  },
-	{ 0x50, "ARC HS38"  },
-	{ 0x54, "ARC HS48"  },
-#endif
-	{ 0x00, "Unknown"   }
+static const struct id_to_str arc_cpu_rel[] = {
+	/* UARCH.MAJOR,	Release */
+	{  0,		"R3.10a"},
+	{  1,		"R3.50a"},
+	{  0xFF,	NULL   }
 };
 
 static void read_decode_ccm_bcr(struct cpuinfo_arc *cpu)
@@ -117,31 +112,72 @@ static void read_decode_ccm_bcr(struct cpuinfo_arc *cpu)
 	}
 }
 
+static void decode_arc_core(struct cpuinfo_arc *cpu)
+{
+	struct bcr_uarch_build_arcv2 uarch;
+	const struct id_to_str *tbl;
+
+	/*
+	 * Up until (including) the first core4 release (0x54) things were
+	 * simple: AUX IDENTITY.ARCVER was sufficient to identify arc family
+	 * and release: 0x50 to 0x53 was HS38, 0x54 was HS48 (dual issue)
+	 */
+
+	if (cpu->core.family < 0x54) { /* includes arc700 */
+
+		for (tbl = &arc_legacy_rel[0]; tbl->id != 0; tbl++) {
+			if (cpu->core.family == tbl->id) {
+				cpu->release = tbl->str;
+				break;
+			}
+		}
+
+		if (is_isa_arcompact())
+			cpu->name = "ARC700";
+		else if (tbl->str)
+			cpu->name = "HS38";
+		else
+			cpu->name = cpu->release = "Unknown";
+
+		return;
+	}
+
+	/*
+	 * However the subsequent HS release (same 0x54) allow HS38 or HS48
+	 * configurations and encode this info in a different BCR.
+	 * The BCR was introduced in 0x54 so can't be read unconditionally.
+	 */
+
+	READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
+
+	if (uarch.prod == 4) {
+		cpu->name = "HS48";
+		cpu->extn.dual = 1;
+
+	} else {
+		cpu->name = "HS38";
+	}
+
+	for (tbl = &arc_cpu_rel[0]; tbl->id != 0xFF; tbl++) {
+		if (uarch.maj == tbl->id) {
+			cpu->release = tbl->str;
+			break;
+		}
+	}
+}
+
 static void read_arc_build_cfg_regs(void)
 {
 	struct bcr_timer timer;
 	struct bcr_generic bcr;
 	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
-	const struct id_to_str *tbl;
 	struct bcr_isa_arcv2 isa;
 	struct bcr_actionpoint ap;
 
 	FIX_PTR(cpu);
 
 	READ_BCR(AUX_IDENTITY, cpu->core);
-
-	for (tbl = &arc_cpu_rel[0]; tbl->id != 0; tbl++) {
-		if (cpu->core.family == tbl->id) {
-			cpu->details = tbl->str;
-			break;
-		}
-	}
-
-	for (tbl = &arc_cpu_nm[0]; tbl->id != 0; tbl++) {
-		if ((cpu->core.family & 0xF4) == tbl->id)
-			break;
-	}
-	cpu->name = tbl->str;
+	decode_arc_core(cpu);
 
 	READ_BCR(ARC_REG_TIMERS_BCR, timer);
 	cpu->extn.timer0 = timer.t0;
@@ -199,30 +235,12 @@ static void read_arc_build_cfg_regs(void)
 		cpu->bpu.num_pred = 2048 << bpu.pte;
 		cpu->bpu.ret_stk = 4 << bpu.rse;
 
-		if (cpu->core.family >= 0x54) {
-
-			struct bcr_uarch_build_arcv2 uarch;
-
-			/*
-			 * The first 0x54 core (uarch maj:min 0:1 or 0:2) was
-			 * dual issue only (HS4x). But next uarch rev (1:0)
-			 * allows it be configured for single issue (HS3x)
-			 * Ensure we fiddle with dual issue only on HS4x
-			 */
-			READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
+		/* if dual issue hardware, is it enabled ? */
+		if (cpu->extn.dual) {
+			unsigned int exec_ctrl;
 
-			if (uarch.prod == 4) {
-				unsigned int exec_ctrl;
-
-				/* dual issue hardware always present */
-				cpu->extn.dual = 1;
-
-				READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
-
-				/* dual issue hardware enabled ? */
-				cpu->extn.dual_enb = !(exec_ctrl & 1);
-
-			}
+			READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
+			cpu->extn.dual_enb = !(exec_ctrl & 1);
 		}
 	}
 
@@ -273,7 +291,7 @@ static char *arc_cpu_mumbojumbo(int cpu_id, char *buf, int len)
 		       core->family, core->cpu_id, core->chip_id);
 
 	n += scnprintf(buf + n, len - n, "processor [%d]\t: %s %s (%s ISA) %s%s%s\n",
-		       cpu_id, cpu->name, cpu->details,
+		       cpu_id, cpu->name, cpu->release,
 		       is_isa_arcompact() ? "ARCompact" : "ARCv2",
 		       IS_AVAIL1(cpu->isa.be, "[Big-Endian]"),
 		       IS_AVAIL3(cpu->extn.dual, cpu->extn.dual_enb, " Dual-Issue "));
-- 
2.7.4

