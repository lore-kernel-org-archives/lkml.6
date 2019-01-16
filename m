Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED55C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4926120657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbfAPQd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:29 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42732 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbfAPQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E488418561;
        Wed, 16 Jan 2019 17:33:02 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5oOJYsWxFf35; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 368D418558;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B251A081;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1794F1A06D;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 0902F2FB1;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 073D580B47; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 6/8] vop: Fix handling of >32 feature bits
Date:   Wed, 16 Jan 2019 17:32:51 +0100
Message-Id: <20190116163253.23780-7-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed, for example, for VIRTIO_F_IOMMU_PLATFORM.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 26b23f2cf94c..dd49169ef53d 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -117,7 +117,7 @@ _vop_total_desc_size(struct mic_device_desc __iomem *desc)
 static u64 vop_get_features(struct virtio_device *vdev)
 {
 	unsigned int i, bits;
-	u32 features = 0;
+	u64 features = 0;
 	struct mic_device_desc __iomem *desc = to_vopvdev(vdev)->desc;
 	u8 __iomem *in_features = _vop_vq_features(desc);
 	int feature_len = ioread8(&desc->feature_len);
@@ -125,7 +125,7 @@ static u64 vop_get_features(struct virtio_device *vdev)
 	bits = min_t(unsigned, feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++)
 		if (ioread8(&in_features[i / 8]) & (BIT(i % 8)))
-			features |= BIT(i);
+			features |= BIT_ULL(i);
 
 	return features;
 }
-- 
2.20.0

