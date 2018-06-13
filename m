Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A506EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCC2208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCC2208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936008AbeFMVZE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:25:04 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45446 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935926AbeFMVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 1993418198DC8;
        Wed, 13 Jun 2018 23:24:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/14] ubi: uapi: Add mode selector to attach request
Date:   Wed, 13 Jun 2018 23:23:42 +0200
Message-Id: <20180613212344.11608-13-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows userspace, ubiattach, to force a full scan.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/uapi/mtd/ubi-user.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/mtd/ubi-user.h b/include/uapi/mtd/ubi-user.h
index 5b04a494d139..cc0e54cfa7f9 100644
--- a/include/uapi/mtd/ubi-user.h
+++ b/include/uapi/mtd/ubi-user.h
@@ -235,12 +235,19 @@ enum {
 	UBI_VOL_PROP_DIRECT_WRITE = 1,
 };
 
+enum {
+	UBI_ATTACH_MODE_AUTO = 0x0,
+	UBI_ATTACH_MODE_SCAN = 0x1,
+	UBI_ATTACH_MODE_MAX = UBI_ATTACH_MODE_SCAN,
+};
+
 /**
  * struct ubi_attach_req - attach MTD device request.
  * @ubi_num: UBI device number to create
  * @mtd_num: MTD device number to attach
  * @vid_hdr_offset: VID header offset (use defaults if %0)
  * @max_beb_per1024: maximum expected number of bad PEB per 1024 PEBs
+ * @attach_mode: selects the attach mode
  * @padding: reserved for future, not used, has to be zeroed
  *
  * This data structure is used to specify MTD device UBI has to attach and the
@@ -276,13 +283,18 @@ enum {
  * eraseblocks for new bad eraseblocks, but attempts to use available
  * eraseblocks (if any). The accepted range is 0-768. If 0 is given, the
  * default kernel value of %CONFIG_MTD_UBI_BEB_LIMIT will be used.
+ *
+ * @attach_mode is %UBI_ATTACH_MODE_AUTO by default, and let's the UBI
+ * implementation decide how to attach. If %UBI_ATTACH_MODE_SCAN is selected
+ * a full scan is forced.
  */
 struct ubi_attach_req {
 	__s32 ubi_num;
 	__s32 mtd_num;
 	__s32 vid_hdr_offset;
 	__s16 max_beb_per1024;
-	__s8 padding[10];
+	__s8 attach_mode;
+	__s8 padding[9];
 };
 
 /**
-- 
2.13.6

