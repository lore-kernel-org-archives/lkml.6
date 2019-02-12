Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F74C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57D021904
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbfBLU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:27:17 -0500
Received: from anholt.net ([50.246.234.109]:59644 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfBLU1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:27:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 47E0210A2C5C;
        Tue, 12 Feb 2019 12:27:16 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MgP21CFo7hXy; Tue, 12 Feb 2019 12:27:14 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 95D0810A29D8;
        Tue, 12 Feb 2019 12:27:14 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C699E2FE464E; Tue, 12 Feb 2019 12:27:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 3/3] drm/v3d: Make sure the GPU is on when measuring clocks.
Date:   Tue, 12 Feb 2019 12:27:13 -0800
Message-Id: <20190212202713.29205-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212202713.29205-1-eric@anholt.net>
References: <20190212202713.29205-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You'll get garbage measurements if the registers always read back
0xdeadbeef

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index eb2b2d2f8553..a24af2d2f574 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -187,6 +187,11 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 	uint32_t cycles;
 	int core = 0;
 	int measure_ms = 1000;
+	int ret;
+
+	ret = pm_runtime_get_sync(v3d->dev);
+	if (ret < 0)
+		return ret;
 
 	if (v3d->ver >= 40) {
 		V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
@@ -210,6 +215,9 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
 		   cycles / (measure_ms * 1000),
 		   (cycles / (measure_ms * 100)) % 10);
 
+	pm_runtime_mark_last_busy(v3d->dev);
+	pm_runtime_put_autosuspend(v3d->dev);
+
 	return 0;
 }
 
-- 
2.20.1

