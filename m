Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEFDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C81421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DSAakXyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeLRP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:57:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40366 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbeLRP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:57:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 160EB8EE1CB;
        Tue, 18 Dec 2018 07:57:17 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gO0KCh5yvTuT; Tue, 18 Dec 2018 07:57:16 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 71BA78EE0BF;
        Tue, 18 Dec 2018 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545148636;
        bh=RElkuV5q2XQbBRbgoR/jnZxF0DOckAuLlxs6UqnXUco=;
        h=Subject:From:To:Cc:Date:From;
        b=DSAakXySZYOl1Pq9lMtMSJ/kasy6TS+6eBbdJohuXra6Id/rz/PCYgMGQXDa91ZCz
         r2y4bbFj6yNLuiAly+UYdC4eiTmLlOdnK/SZjDfn27eCk/rn5SXkxzJMZywugvJYsn
         1jNzsw6rM2+UVY7dULZz0wLRDHPGbQX0Z1QvEalU=
Message-ID: <1545148634.2837.6.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 4.20-rc7
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Dec 2018 07:57:14 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes: The t10-pi one is a regression from the 4.19 release, the
qla2xxx one is a 4.20 merge window regression and the bnx2fc is a very
old bug.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dan Carpenter (1):
      scsi: bnx2fc: Fix NULL dereference in error handling

Himanshu Madhani (1):
      Revert "scsi: qla2xxx: Fix NVMe Target discovery"

Martin K. Petersen (1):
      scsi: t10-pi: Return correct ref tag when queue has no integrity profile

And the diffstat:

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 2 +-
 drivers/scsi/qla2xxx/qla_os.c     | 4 ++--
 include/linux/t10-pi.h            | 9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index cd160f2ec75d..bcd30e2374f1 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2364,7 +2364,7 @@ static int _bnx2fc_create(struct net_device *netdev,
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
 		rc = -ENOMEM;
-		goto ifput_err;
+		goto netdev_err;
 	}
 
 	if (is_vlan_dev(netdev)) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b658b9a5eb1e..d0ecc729a90a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4886,10 +4886,10 @@ void qla24xx_create_new_sess(struct scsi_qla_host *vha, struct qla_work_evt *e)
 			fcport->d_id = e->u.new_sess.id;
 			fcport->flags |= FCF_FABRIC_DEVICE;
 			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
-			if (e->u.new_sess.fc4_type & FS_FC4TYPE_FCP)
+			if (e->u.new_sess.fc4_type == FS_FC4TYPE_FCP)
 				fcport->fc4_type = FC4_TYPE_FCP_SCSI;
 
-			if (e->u.new_sess.fc4_type & FS_FC4TYPE_NVME) {
+			if (e->u.new_sess.fc4_type == FS_FC4TYPE_NVME) {
 				fcport->fc4_type = FC4_TYPE_OTHER;
 				fcport->fc4f_nvme = FC4_TYPE_NVME;
 			}
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index b9626aa7e90c..3e2a80cc7b56 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -39,12 +39,13 @@ struct t10_pi_tuple {
 
 static inline u32 t10_pi_ref_tag(struct request *rq)
 {
+	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-	return blk_rq_pos(rq) >>
-		(rq->q->integrity.interval_exp - 9) & 0xffffffff;
-#else
-	return -1U;
+	if (rq->q->integrity.interval_exp)
+		shift = rq->q->integrity.interval_exp;
 #endif
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
 }
 
 extern const struct blk_integrity_profile t10_pi_type1_crc;
