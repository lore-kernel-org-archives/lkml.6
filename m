Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DFCC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499D020652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499D020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeFUARH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:17:07 -0400
Received: from anholt.net ([50.246.234.109]:49964 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753725AbeFUARG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:17:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A69AC10A1633;
        Wed, 20 Jun 2018 17:17:05 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id FZ4_ViMobNRB; Wed, 20 Jun 2018 17:17:04 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7571310A053A;
        Wed, 20 Jun 2018 17:17:04 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CBFEB2FE2FF0; Wed, 20 Jun 2018 17:17:03 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/v3d: Define the fourcc modifier for the Broadcom UIF format.
Date:   Wed, 20 Jun 2018 17:17:03 -0700
Message-Id: <20180621001703.13522-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used by Mesa, and potentially other drivers in the
future, to describe tiled buffers.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/uapi/drm/drm_fourcc.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 64bf67abff7e..d5e52350a3aa 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -464,6 +464,27 @@ extern "C" {
 #define DRM_FORMAT_MOD_BROADCOM_SAND256 \
 	DRM_FORMAT_MOD_BROADCOM_SAND256_COL_HEIGHT(0)
 
+/* Broadcom UIF format
+ *
+ * This is the common format for the current Broadcom multimedia
+ * blocks, including V3D 3.x and newer, newer video codecs, and
+ * displays.
+ *
+ * The image consists of utiles (64b blocks), UIF blocks (2x2 utiles),
+ * and macroblocks (4x4 UIF blocks).  Those 4x4 UIF block groups are
+ * stored in columns, with padding between the columns to ensure that
+ * moving from one column to the next doesn't hit the same SDRAM page
+ * bank.
+ *
+ * To calculate the padding, it is assumed that each hardware block
+ * and the software driving it knows the platform's SDRAM page size,
+ * number of banks, and XOR address, and that it's identical between
+ * all blocks using the format.  This tiling modifier will use XOR as
+ * necessary to reduce the padding.  If a hardware block can't do XOR,
+ * the assumption is that a no-XOR tiling modifier will be created.
+ */
+#define DRM_FORMAT_MOD_BROADCOM_UIF fourcc_mod_code(BROADCOM, 6)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.17.0

