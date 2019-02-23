Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7FA20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="X8yo46L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBWDIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:08:04 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53322 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbfBWDID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:08:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2C6F88EE26A;
        Fri, 22 Feb 2019 19:08:03 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iwiyt8w56Rec; Fri, 22 Feb 2019 19:08:02 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 908658EE105;
        Fri, 22 Feb 2019 19:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550891282;
        bh=DL8000E9l7RP/8GUKh1li5Qj9DPlkbD5yj3LVRYKkPI=;
        h=Subject:From:To:Cc:Date:From;
        b=X8yo46L+63VayzQXXSx1P+U5UNfcFzgbxIdRpDkIxbgJQAqopC3WvJPe8CN/c4yLz
         b4hnw7O2eRC7kobqHfvgQMAb4ljvM2gstBxgtH7CsFA/MwylywpD1+ZE7M9tGWMlEI
         DrS3XhScMwPhqZMfUFbK/a2h/+RvetRYOVtb/jgQ=
Message-ID: <1550891280.3577.36.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.0-rc7
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Feb 2019 19:08:00 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four small fixes: three in drivers and one in the core.  The core fix
is also minor in scope since the bug it fixes is only known to affect
systems using SCSI reservations.  Of the driver bugs, the libsas one is
 the most major because it can lead to multiple disks on the same
expander not being exposed.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Martin Wilck (1):
      scsi: core: reset host byte in DID_NEXUS_FAILURE case

Masato Suzuki (1):
      scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation

And the diffstat:

 drivers/scsi/libiscsi.c            | 6 ++++++
 drivers/scsi/libsas/sas_expander.c | 2 ++
 drivers/scsi/scsi_lib.c            | 1 +
 drivers/scsi/sd_zbc.c              | 8 +++++---
 4 files changed, 14 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index b8d325ce8754..120fc520f27a 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1459,7 +1459,13 @@ static int iscsi_xmit_task(struct iscsi_conn *conn)
 	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx))
 		return -ENODATA;
 
+	spin_lock_bh(&conn->session->back_lock);
+	if (conn->task == NULL) {
+		spin_unlock_bh(&conn->session->back_lock);
+		return -ENODATA;
+	}
 	__iscsi_get_task(task);
+	spin_unlock_bh(&conn->session->back_lock);
 	spin_unlock_bh(&conn->session->frwd_lock);
 	rc = conn->session->tt->xmit_task(task);
 	spin_lock_bh(&conn->session->frwd_lock);
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 17eb4185f29d..f21c93bbb35c 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -828,6 +828,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 		rphy = sas_end_device_alloc(phy->port);
 		if (!rphy)
 			goto out_free;
+		rphy->identify.phy_identifier = phy_id;
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
@@ -854,6 +855,7 @@ static struct domain_device *sas_ex_discover_end_dev(
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
+		rphy->identify.phy_identifier = phy_id;
 		sas_fill_in_rphy(child, rphy);
 
 		list_add_tail(&child->disco_list_node, &parent->port->disco_list);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6d65ac584eba..f8d51c3d5582 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -655,6 +655,7 @@ static blk_status_t scsi_result_to_blk_status(struct scsi_cmnd *cmd, int result)
 		set_host_byte(cmd, DID_OK);
 		return BLK_STS_TARGET;
 	case DID_NEXUS_FAILURE:
+		set_host_byte(cmd, DID_OK);
 		return BLK_STS_NEXUS;
 	case DID_ALLOC_FAILURE:
 		set_host_byte(cmd, DID_OK);
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index fff86940388b..a340af797a85 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -142,10 +142,12 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		return -EOPNOTSUPP;
 
 	/*
-	 * Get a reply buffer for the number of requested zones plus a header.
-	 * For ATA, buffers must be aligned to 512B.
+	 * Get a reply buffer for the number of requested zones plus a header,
+	 * without exceeding the device maximum command size. For ATA disks,
+	 * buffers must be aligned to 512B.
 	 */
-	buflen = roundup((nrz + 1) * 64, 512);
+	buflen = min(queue_max_hw_sectors(disk->queue) << 9,
+		     roundup((nrz + 1) * 64, 512));
 	buf = kmalloc(buflen, gfp_mask);
 	if (!buf)
 		return -ENOMEM;
