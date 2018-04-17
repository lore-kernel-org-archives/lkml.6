Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDQLfL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:35:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15975 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752087AbeDQLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:35:09 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] drm/stm: ltdc: fix deferred endpoint management
Date: Tue, 17 Apr 2018 13:34:41 +0200
Message-ID: <20180417113441.8214-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a driver related to one of the endpoints is deferred
due to probe dependencies (i2c, spi...) but the other one
is ready, ltdc probe continues and the deferred driver
will never be probed again.

The fix consists in waiting for all deferred endpoints before
continuing the ltdc probe.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index e3121d9e4230..014cef8cef37 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -987,14 +987,13 @@ int ltdc_load(struct drm_device *ddev)
 						  &bridge[i]);
 
 		/*
-		 * If at least one endpoint is ready, continue probing,
-		 * else if at least one endpoint is -EPROBE_DEFER and
-		 * there is no previous ready endpoints, defer probing.
+		 * If at least one endpoint is -EPROBE_DEFER, defer probing,
+		 * else if at least one endpoint is ready, continue probing.
 		 */
-		if (!ret)
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		else if (!ret)
 			endpoint_not_ready = 0;
-		else if (ret == -EPROBE_DEFER && endpoint_not_ready)
-			endpoint_not_ready = -EPROBE_DEFER;
 	}
 
 	if (endpoint_not_ready)
-- 
2.15.1
