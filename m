Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1929820685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbeGWNsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbeGWNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:23 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 379FBBDB;
        Mon, 23 Jul 2018 12:47:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 102/107] ubi: Introduce vol_ignored()
Date:   Mon, 23 Jul 2018 14:42:36 +0200
Message-Id: <20180723122418.624558482@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 243a4f8126fcf7facb04b324dbb7c85d10b11ce9 upstream.

This makes the logic more easy to follow.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/attach.c |   24 ++++++++++++++++++------
 drivers/mtd/ubi/ubi.h    |   15 +++++++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -803,6 +803,20 @@ out_unlock:
 	return err;
 }
 
+static bool vol_ignored(int vol_id)
+{
+	switch (vol_id) {
+		case UBI_LAYOUT_VOLUME_ID:
+		return true;
+	}
+
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	return ubi_is_fm_vol(vol_id);
+#else
+	return false;
+#endif
+}
+
 /**
  * scan_peb - scan and process UBI headers of a PEB.
  * @ubi: UBI device description object
@@ -995,17 +1009,15 @@ static int scan_peb(struct ubi_device *u
 		*vid = vol_id;
 	if (sqnum)
 		*sqnum = be64_to_cpu(vidh->sqnum);
-	if (vol_id > UBI_MAX_VOLUMES && vol_id != UBI_LAYOUT_VOLUME_ID) {
+	if (vol_id > UBI_MAX_VOLUMES && !vol_ignored(vol_id)) {
 		int lnum = be32_to_cpu(vidh->lnum);
 
 		/* Unsupported internal volume */
 		switch (vidh->compat) {
 		case UBI_COMPAT_DELETE:
-			if (vol_id != UBI_FM_SB_VOLUME_ID
-			    && vol_id != UBI_FM_DATA_VOLUME_ID) {
-				ubi_msg(ubi, "\"delete\" compatible internal volume %d:%d found, will remove it",
-					vol_id, lnum);
-			}
+			ubi_msg(ubi, "\"delete\" compatible internal volume %d:%d found, will remove it",
+				vol_id, lnum);
+
 			err = add_to_list(ai, pnum, vol_id, lnum,
 					  ec, 1, &ai->erase);
 			if (err)
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -1101,4 +1101,19 @@ static inline int idx2vol_id(const struc
 		return idx;
 }
 
+/**
+ * ubi_is_fm_vol - check whether a volume ID is a Fastmap volume.
+ * @vol_id: volume ID
+ */
+static inline bool ubi_is_fm_vol(int vol_id)
+{
+	switch (vol_id) {
+		case UBI_FM_SB_VOLUME_ID:
+		case UBI_FM_DATA_VOLUME_ID:
+		return true;
+	}
+
+	return false;
+}
+
 #endif /* !__UBI_UBI_H__ */


