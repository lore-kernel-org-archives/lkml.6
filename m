Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56742C46473
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDEB21A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRQkPH5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDEB21A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeHLQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 12:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbeHLQkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 12:40:53 -0400
Received: from localhost.localdomain (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A20921A05;
        Sun, 12 Aug 2018 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534082564;
        bh=ynntHqTITRSrvXp4Z1a2UTgjlXGsTsgZ5MDcgXcKdyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRQkPH5HSsr8A/KA3IdRInBS9DEUvwD0SCyXyWpM2oEcESWYZGcewCz6PAc+MgIE6
         ADsaMAKssRDMxVO9rP4xtEvRyRnSKGxKr/W90ORiK3UK12BeDxv69I+DtH81mEXu4n
         90uKDnOhvyHZ9qKeJMdjcMIJ4dTu3bZUHJv2JImg=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/8] staging: erofs: rearrange vle clustertype definitions
Date:   Sun, 12 Aug 2018 22:01:47 +0800
Message-Id: <20180812140150.13397-6-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180812140150.13397-1-chao@kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch moves vle clustertype definitions to erofs_fs.h
since they are part of on-disk format.

It also adds compile time check for Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/erofs_fs.h  | 11 +++++++++++
 drivers/staging/erofs/unzip_vle.c |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 2f8e2bf70941..d4bffa2852b3 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -202,6 +202,14 @@ struct erofs_extent_header {
  *        di_u.delta[1] = distance to its corresponding tail cluster
  *                (di_advise could be 0, 1 or 2)
  */
+enum {
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
+	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+};
+
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
@@ -260,6 +268,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_extent_header) != 16);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
+
+	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
+		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
 }
 
 #endif
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 5032b3b05de1..f597f079d579 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1416,14 +1416,6 @@ const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 #define __vle_cluster_type(advise) __vle_cluster_advise(advise, \
 	Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT, Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS)
 
-enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
-	Z_EROFS_VLE_CLUSTER_TYPE_MAX
-};
-
 #define vle_cluster_type(di)	\
 	__vle_cluster_type((di)->di_advise)
 
-- 
2.18.0

