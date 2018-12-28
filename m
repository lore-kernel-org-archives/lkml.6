Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BFC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F243420873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D/ik45k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeL1Qo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:44:57 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:54234 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeL1Qo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:44:56 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4444D24E10BE;
        Fri, 28 Dec 2018 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546015496; bh=Tog/g5/fknCUgJEdC2kZb5YmtmjeT94ifEw7Fx+8MpM=;
        h=From:To:Cc:Subject:Date:From;
        b=D/ik45k1QfGL39OpV1TqKHrzRXCDqiZ92MPBxW1xtZGULZMxy9mMZI4br8CNoYtvs
         4ETsbQLdYm8XNeJOT0u7xM5vG/JFE2l71vQ+hy2jRLp/mZjlMoUPKb/kciHyNuYN1D
         2kYslbb41ylOKXznhWfIIikLY7Z01PdqMVnC0uD3B9uWk/BGYBAXrCW4m9Sp93Wrk2
         il2oTvadb5V8j8doP1Y4hHBZvvukTpS3Dth6kTept4CvXeWvfvMSn6s3y44RJEzrX5
         Qyp7HYVuSJh/k7DgYP8DlaAUmJcgDmT5JAfOvrq/hDP+5BYsXlRrGKHLth974L95e/
         ilxZ2XBjbHJmQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id B520639B1;
        Fri, 28 Dec 2018 08:44:53 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: show detaled ActionPoint configuration in mumbojumbo
Date:   Fri, 28 Dec 2018 19:44:44 +0300
Message-Id: <20181228164444.11241-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about ActionPointis number and supported set
of targets (minimum / full).

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/arcregs.h |  8 +++++++
 arch/arc/kernel/setup.c        | 53 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 49bfbd879caa..aa673e27add5 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -216,6 +216,14 @@ struct bcr_fp_arcv2 {
 #endif
 };
 
+struct bcr_actionpoint {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:20, type:4, ver:8;
+#else
+	unsigned int ver:8, type:4, pad:20;
+#endif
+};
+
 #include <soc/arc/timers.h>
 
 struct bcr_bpu_arcompact {
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index b2cae79a25d7..c8d67f9cd40d 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -115,6 +115,47 @@ static void read_decode_ccm_bcr(struct cpuinfo_arc *cpu)
 	}
 }
 
+static bool actionpoints_exists(void)
+{
+	struct bcr_actionpoint bcr;
+
+	READ_BCR(ARC_REG_AP_BCR, bcr);
+	return !!bcr.ver;
+}
+
+static const char *actionpoints_configuration(void)
+{
+	struct bcr_actionpoint bcr;
+
+	READ_BCR(ARC_REG_AP_BCR, bcr);
+	switch (bcr.type) {
+	case 0x0:
+		return "2, full";
+	case 0x1:
+		return "4, full";
+	case 0x2:
+		return "8, full";
+	case 0x4:
+		return "2, minimum";
+	case 0x5:
+		return "4, minimum";
+	case 0x6:
+		return "8, minimum";
+
+	default:
+		return "unknown";
+	}
+}
+
+static int actionpoints_mumbojumbo(char *buf, int len)
+{
+	if (!actionpoints_exists())
+		return 0;
+
+	return scnprintf(buf, len, "ActionPoint (%s set)",
+			 actionpoints_configuration());
+}
+
 static void read_arc_build_cfg_regs(void)
 {
 	struct bcr_timer timer;
@@ -206,8 +247,7 @@ static void read_arc_build_cfg_regs(void)
 		}
 	}
 
-	READ_BCR(ARC_REG_AP_BCR, bcr);
-	cpu->extn.ap = bcr.ver ? 1 : 0;
+	cpu->extn.ap = actionpoints_exists();
 
 	READ_BCR(ARC_REG_SMART_BCR, bcr);
 	cpu->extn.smart = bcr.ver ? 1 : 0;
@@ -332,12 +372,15 @@ static char *arc_extn_mumbojumbo(int cpu_id, char *buf, int len)
 			       IS_AVAIL1(cpu->extn.fpu_sp, "SP "),
 			       IS_AVAIL1(cpu->extn.fpu_dp, "DP "));
 
-	if (cpu->extn.debug)
-		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s%s\n",
-			       IS_AVAIL1(cpu->extn.ap, "ActionPoint "),
+	if (cpu->extn.debug) {
+		n += scnprintf(buf + n, len - n, "DEBUG\t\t: %s%s",
 			       IS_AVAIL1(cpu->extn.smart, "smaRT "),
 			       IS_AVAIL1(cpu->extn.rtt, "RTT "));
 
+		n += actionpoints_mumbojumbo(buf + n, len - n);
+		n += scnprintf(buf + n, len - n, "\n");
+	}
+
 	if (cpu->dccm.sz || cpu->iccm.sz)
 		n += scnprintf(buf + n, len - n, "Extn [CCM]\t: DCCM @ %x, %d KB / ICCM: @ %x, %d KB\n",
 			       cpu->dccm.base_addr, TO_KB(cpu->dccm.sz),
-- 
2.14.5

