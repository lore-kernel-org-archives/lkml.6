Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9CA2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBTVD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:03:59 -0500
Received: from anholt.net ([50.246.234.109]:51864 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfBTVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D3AB210A2D1A;
        Wed, 20 Feb 2019 13:03:57 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ZQ9ZlQHux-l3; Wed, 20 Feb 2019 13:03:56 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2A71510A2D25;
        Wed, 20 Feb 2019 13:03:46 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id AE2FB2FE4652; Wed, 20 Feb 2019 13:03:43 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 7/7] drm/vc4: Make sure that the v3d ident debugfs has vc4's power on.
Date:   Wed, 20 Feb 2019 13:03:43 -0800
Message-Id: <20190220210343.28157-7-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, you sometimes decode the ident fields based on 0xdeadbeef
register reads.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 7820b8eaaa98..36e6c7086ecf 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -108,18 +108,23 @@ static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	uint32_t ident1 = V3D_READ(V3D_IDENT1);
-	uint32_t nslc = VC4_GET_FIELD(ident1, V3D_IDENT1_NSLC);
-	uint32_t tups = VC4_GET_FIELD(ident1, V3D_IDENT1_TUPS);
-	uint32_t qups = VC4_GET_FIELD(ident1, V3D_IDENT1_QUPS);
-
-	seq_printf(m, "Revision:   %d\n",
-		   VC4_GET_FIELD(ident1, V3D_IDENT1_REV));
-	seq_printf(m, "Slices:     %d\n", nslc);
-	seq_printf(m, "TMUs:       %d\n", nslc * tups);
-	seq_printf(m, "QPUs:       %d\n", nslc * qups);
-	seq_printf(m, "Semaphores: %d\n",
-		   VC4_GET_FIELD(ident1, V3D_IDENT1_NSEM));
+	int ret = vc4_v3d_pm_get(vc4);
+
+	if (ret == 0) {
+		uint32_t ident1 = V3D_READ(V3D_IDENT1);
+		uint32_t nslc = VC4_GET_FIELD(ident1, V3D_IDENT1_NSLC);
+		uint32_t tups = VC4_GET_FIELD(ident1, V3D_IDENT1_TUPS);
+		uint32_t qups = VC4_GET_FIELD(ident1, V3D_IDENT1_QUPS);
+
+		seq_printf(m, "Revision:   %d\n",
+			   VC4_GET_FIELD(ident1, V3D_IDENT1_REV));
+		seq_printf(m, "Slices:     %d\n", nslc);
+		seq_printf(m, "TMUs:       %d\n", nslc * tups);
+		seq_printf(m, "QPUs:       %d\n", nslc * qups);
+		seq_printf(m, "Semaphores: %d\n",
+			   VC4_GET_FIELD(ident1, V3D_IDENT1_NSEM));
+		vc4_v3d_pm_put(vc4);
+	}
 
 	return 0;
 }
-- 
2.20.1

