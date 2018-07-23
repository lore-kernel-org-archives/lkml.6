Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5819ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A320880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7A320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbeGWNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbeGWNsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:52 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43EABBB3;
        Mon, 23 Jul 2018 12:47:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 107/107] ubi: fastmap: Erase outdated anchor PEBs during attach
Date:   Mon, 23 Jul 2018 14:42:41 +0200
Message-Id: <20180723122418.865465132@linuxfoundation.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

commit f78e5623f45bab2b726eec29dc5cefbbab2d0b1c upstream.

The fastmap update code might erase the current fastmap anchor PEB
in case it doesn't find any new free PEB. When a power cut happens
in this situation we must not have any outdated fastmap anchor PEB
on the device, because that would be used to attach during next
boot.
The easiest way to make that sure is to erase all outdated fastmap
anchor PEBs synchronously during attach.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Richard Weinberger <richard@nod.at>
Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/wl.c |   77 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 20 deletions(-)

--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1509,6 +1509,46 @@ static void shutdown_work(struct ubi_dev
 }
 
 /**
+ * erase_aeb - erase a PEB given in UBI attach info PEB
+ * @ubi: UBI device description object
+ * @aeb: UBI attach info PEB
+ * @sync: If true, erase synchronously. Otherwise schedule for erasure
+ */
+static int erase_aeb(struct ubi_device *ubi, struct ubi_ainf_peb *aeb, bool sync)
+{
+	struct ubi_wl_entry *e;
+	int err;
+
+	e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	e->pnum = aeb->pnum;
+	e->ec = aeb->ec;
+	ubi->lookuptbl[e->pnum] = e;
+
+	if (sync) {
+		err = sync_erase(ubi, e, false);
+		if (err)
+			goto out_free;
+
+		wl_tree_add(e, &ubi->free);
+		ubi->free_count++;
+	} else {
+		err = schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false);
+		if (err)
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	wl_entry_destroy(ubi, e);
+
+	return err;
+}
+
+/**
  * ubi_wl_init - initialize the WL sub-system using attaching information.
  * @ubi: UBI device description object
  * @ai: attaching information
@@ -1545,17 +1585,9 @@ int ubi_wl_init(struct ubi_device *ubi,
 	list_for_each_entry_safe(aeb, tmp, &ai->erase, u.list) {
 		cond_resched();
 
-		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-		if (!e)
-			goto out_free;
-
-		e->pnum = aeb->pnum;
-		e->ec = aeb->ec;
-		ubi->lookuptbl[e->pnum] = e;
-		if (schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false)) {
-			wl_entry_destroy(ubi, e);
+		err = erase_aeb(ubi, aeb, false);
+		if (err)
 			goto out_free;
-		}
 
 		found_pebs++;
 	}
@@ -1615,6 +1647,8 @@ int ubi_wl_init(struct ubi_device *ubi,
 			ubi_assert(!ubi->lookuptbl[e->pnum]);
 			ubi->lookuptbl[e->pnum] = e;
 		} else {
+			bool sync = false;
+
 			/*
 			 * Usually old Fastmap PEBs are scheduled for erasure
 			 * and we don't have to care about them but if we face
@@ -1624,18 +1658,21 @@ int ubi_wl_init(struct ubi_device *ubi,
 			if (ubi->lookuptbl[aeb->pnum])
 				continue;
 
-			e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
-			if (!e)
-				goto out_free;
+			/*
+			 * The fastmap update code might not find a free PEB for
+			 * writing the fastmap anchor to and then reuses the
+			 * current fastmap anchor PEB. When this PEB gets erased
+			 * and a power cut happens before it is written again we
+			 * must make sure that the fastmap attach code doesn't
+			 * find any outdated fastmap anchors, hence we erase the
+			 * outdated fastmap anchor PEBs synchronously here.
+			 */
+			if (aeb->vol_id == UBI_FM_SB_VOLUME_ID)
+				sync = true;
 
-			e->pnum = aeb->pnum;
-			e->ec = aeb->ec;
-			ubi_assert(!ubi->lookuptbl[e->pnum]);
-			ubi->lookuptbl[e->pnum] = e;
-			if (schedule_erase(ubi, e, aeb->vol_id, aeb->lnum, 0, false)) {
-				wl_entry_destroy(ubi, e);
+			err = erase_aeb(ubi, aeb, sync);
+			if (err)
 				goto out_free;
-			}
 		}
 
 		found_pebs++;


