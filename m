Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC418C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACA0207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BgQt3mbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBUWwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:52:32 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:58290 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:52:31 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 0713010C0EAD;
        Thu, 21 Feb 2019 14:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550789551; bh=eqx6vFmvQZf7X4R7gultMJpwZ7hX2Vm0zJkFCdtbPF0=;
        h=From:To:CC:Subject:Date:From;
        b=BgQt3mbIqacOrZ1mKq73CvwaLWctN17Vuie20eaf3S1863BmJ3h6XOObCh3jKYGJs
         VWVOpdwgZCTtGkHRj1CnflKZLzdxP/RwjG/hk1eRH6o+MdUpYXxhRv//mUoWLMcuy4
         bf1UwCSGgVZ0Kuhr3VKiwf1QLlASpdkuH0Yw1HfcSj0wwqWPB5uQq7n+E8w+rvU50C
         PwVKzk6VCPWv8JRzw56PJw1L0QEkTeHh98zVz20AlTPioplZfRa8uY2AY+jisi6dlp
         MSLUNK0uN/Va4vFpuKuL0O2K0eW842ZB6VJHO6eIl7zfZvf3mtX2E4CPkl6ushxtzN
         V4+QZIgtT1Nzw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C9C12A005D;
        Thu, 21 Feb 2019 22:52:29 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 21 Feb 2019 14:52:29 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 22 Feb 2019 04:22:33 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 22 Feb 2019 04:22:32 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <alexey.brodkin@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH] ARCv2: don't assume core 0x54 has dual issue
Date:   Thu, 21 Feb 2019 14:52:18 -0800
Message-ID: <1550789538-20786-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 0x54 core were dual issue only (HS4x). Newer releases allow
hardware to be configured as single issue (HS3x) or dual issue.

Prevent accessing a HS4x only aux register in HS3x, which otherwise
leads to illegal instruction exceptions

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/arcregs.h |  8 ++++++++
 arch/arc/kernel/setup.c        | 26 +++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index f1b86cef0905..a27eafdc8260 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -151,6 +151,14 @@ struct bcr_isa_arcv2 {
 #endif
 };
 
+struct bcr_uarch_build_arcv2 {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	unsigned int pad:8, prod:8, maj:8, min:8;
+#else
+	unsigned int min:8, maj:8, prod:8, pad:8;
+#endif
+};
+
 struct bcr_mpy {
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	unsigned int pad:8, x1616:8, dsp:4, cycles:2, type:2, ver:8;
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 93d4d6639873..7b2340996cf8 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -199,13 +199,29 @@ static void read_arc_build_cfg_regs(void)
 		cpu->bpu.ret_stk = 4 << bpu.rse;
 
 		if (cpu->core.family >= 0x54) {
-			unsigned int exec_ctrl;
 
-			READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
-			cpu->extn.dual_enb = !(exec_ctrl & 1);
+			struct bcr_uarch_build_arcv2 uarch;
 
-			/* dual issue always present for this core */
-			cpu->extn.dual = 1;
+			/*
+			 * The first 0x54 core (uarch maj:min 0:1 or 0:2) was
+			 * dual issue only (HS4x). But next uarch rev (1:0)
+			 * allows it be configured for single issue (HS3x)
+			 * Ensure we fiddle with dual issue only on HS4x
+			 */
+			READ_BCR(ARC_REG_MICRO_ARCH_BCR, uarch);
+
+			if (uarch.prod == 4) {
+				unsigned int exec_ctrl;
+
+				/* dual issue hardware always present */
+				cpu->extn.dual = 1;
+
+				READ_BCR(AUX_EXEC_CTRL, exec_ctrl);
+
+				/* dual issue hardware enabled ? */
+				cpu->extn.dual_enb = !(exec_ctrl & 1);
+
+			}
 		}
 	}
 
-- 
2.7.4

