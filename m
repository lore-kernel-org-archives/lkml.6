Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D17D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D17D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGYACP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:02:15 -0400
Received: from anholt.net ([50.246.234.109]:38394 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388506AbeGYACP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:02:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E3DD310A1504;
        Tue, 24 Jul 2018 15:53:32 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dVFsXJvRF3NE; Tue, 24 Jul 2018 15:53:31 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 75B7A10A053F;
        Tue, 24 Jul 2018 15:53:31 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D57562FE4641; Tue, 24 Jul 2018 15:53:30 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/v3d: Add a little debugfs entry for measuring the core clock.
Date:   Tue, 24 Jul 2018 15:53:30 -0700
Message-Id: <20180724225330.1288-1-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds just enough performance counter support to measure the
clock.  We don't have linux kernel drivers for the clock driving the
HW, and this was useful for determining that the V3D HW is running on
a slow clock, not that the driver was slow.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 35 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_regs.h    | 30 ++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 4db62c545748..d48008adb085 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -176,9 +176,44 @@ static int v3d_debugfs_bo_stats(struct seq_file *m, void *unused)
 	return 0;
 }
 
+static int v3d_measure_clock(struct seq_file *m, void *unused)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct v3d_dev *v3d = to_v3d_dev(dev);
+	uint32_t cycles;
+	int core = 0;
+	int measure_ms = 1000;
+
+	if (v3d->ver >= 40) {
+		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
+			       V3D_SET_FIELD(V3D_PCTR_CYCLE_COUNT,
+					     V3D_PCTR_S0));
+		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_CLR, 1);
+		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_EN, 1);
+	} else {
+		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_PCTRS0,
+			       V3D_PCTR_CYCLE_COUNT);
+		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_CLR, 1);
+		V3D_CORE_WRITE(core, V3D_V3_PCTR_0_EN,
+			       V3D_V3_PCTR_0_EN_ENABLE |
+			       1);
+	}
+	msleep(measure_ms);
+	cycles = V3D_CORE_READ(core, V3D_PCTR_0_PCTR0);
+
+	seq_printf(m, "cycles: %d (%d.%d Mhz)\n",
+		   cycles,
+		   cycles / (measure_ms * 1000),
+		   (cycles / (measure_ms * 100)) % 10);
+
+	return 0;
+}
+
 static const struct drm_info_list v3d_debugfs_list[] = {
 	{"v3d_ident", v3d_v3d_debugfs_ident, 0},
 	{"v3d_regs", v3d_v3d_debugfs_regs, 0},
+	{"measure_clock", v3d_measure_clock, 0},
 	{"bo_stats", v3d_debugfs_bo_stats, 0},
 };
 
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 854046565989..c3a5e4e44f73 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -267,6 +267,36 @@
 # define V3D_PTB_BXCF_RWORDERDISA                      BIT(1)
 # define V3D_PTB_BXCF_CLIPDISA                         BIT(0)
 
+#define V3D_V3_PCTR_0_EN                               0x00674
+#define V3D_V3_PCTR_0_EN_ENABLE                        BIT(31)
+#define V3D_V4_PCTR_0_EN                               0x00650
+/* When a bit is set, resets the counter to 0. */
+#define V3D_V3_PCTR_0_CLR                              0x00670
+#define V3D_V4_PCTR_0_CLR                              0x00654
+#define V3D_PCTR_0_OVERFLOW                            0x00658
+
+#define V3D_V3_PCTR_0_PCTRS0                           0x00684
+#define V3D_V3_PCTR_0_PCTRS15                          0x00660
+#define V3D_V3_PCTR_0_PCTRSX(x)                        (V3D_V3_PCTR_0_PCTRS0 + \
+							4 * (x))
+/* Each src reg muxes four counters each. */
+#define V3D_V4_PCTR_0_SRC_0_3                          0x00660
+#define V3D_V4_PCTR_0_SRC_28_31                        0x0067c
+# define V3D_PCTR_S0_MASK                              V3D_MASK(6, 0)
+# define V3D_PCTR_S0_SHIFT                             0
+# define V3D_PCTR_S1_MASK                              V3D_MASK(14, 8)
+# define V3D_PCTR_S1_SHIFT                             8
+# define V3D_PCTR_S2_MASK                              V3D_MASK(22, 16)
+# define V3D_PCTR_S2_SHIFT                             16
+# define V3D_PCTR_S3_MASK                              V3D_MASK(30, 24)
+# define V3D_PCTR_S3_SHIFT                             24
+# define V3D_PCTR_CYCLE_COUNT                          32
+
+/* Output values of the counters. */
+#define V3D_PCTR_0_PCTR0                               0x00680
+#define V3D_PCTR_0_PCTR31                              0x006fc
+#define V3D_PCTR_0_PCTRX(x)                            (V3D_PCTR_0_PCTR0 + \
+							4 * (x))
 #define V3D_GMP_STATUS                                 0x00800
 # define V3D_GMP_STATUS_GMPRST                         BIT(31)
 # define V3D_GMP_STATUS_WR_COUNT_MASK                  V3D_MASK(30, 24)
-- 
2.18.0

