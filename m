Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCC421900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="N1SQinY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfBOTRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:17:15 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51358 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfBOTRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D65C98EE235;
        Fri, 15 Feb 2019 11:17:13 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tr1HqR5hTIJi; Fri, 15 Feb 2019 11:17:13 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4BB708EE10C;
        Fri, 15 Feb 2019 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550258233;
        bh=ZcQo684pyd8jOtiDQZLm9UhOtL4FAORSIvKrJR1kZ3A=;
        h=Subject:From:To:Cc:Date:From;
        b=N1SQinY5xadTWYJLZ8Thkmhl8NjxqOwhbrI+jGAyBkHNDvoEJj5gsXTuyiubmTAEW
         55YNGi3gdL2XzFGEuaRwJxqfyr7EVAFSEJQpwZKh8vRGQJAGYi3rK6o3xYfkDGpVH5
         tJ2G6L/UN8jaKtCbsJMlXwPD76h6yjtfGAvVFKGw=
Message-ID: <1550258231.3406.15.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.0-rc
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Feb 2019 11:17:11 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fairly small fixes: the qla one is a panic inducing use after free
and the entropy fix may seem minor but it has had huge userspace impact
thanks to an unrelated change in openssl that causes sshd to refuse
logins until it has enough entropy for the session keys, which causes
tens of minutes delay before the affected systems allow logins after
reboot.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bill Kuzeja (1):
      scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd

James Bottomley (1):
      scsi: sd: fix entropy gathering for most rotational disks

And the diffstat:

 drivers/scsi/qla2xxx/qla_init.c |  4 ++--
 drivers/scsi/sd.c               | 12 +++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 364bb52ed2a6..109587e62983 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1785,13 +1785,13 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 
 		/* Issue Marker IOCB */
 		qla2x00_marker(vha, vha->hw->req_q_map[0],
-		    vha->hw->rsp_q_map[0], sp->fcport->loop_id, lun,
+		    vha->hw->rsp_q_map[0], fcport->loop_id, lun,
 		    flags == TCF_LUN_RESET ? MK_SYNC_ID_LUN : MK_SYNC_ID);
 	}
 
 done_free_sp:
 	sp->free(sp);
-	sp->fcport->flags &= ~FCF_ASYNC_SENT;
+	fcport->flags &= ~FCF_ASYNC_SENT;
 done:
 	return rval;
 }
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b2da8a00ec33..5464d467e23e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2951,9 +2951,6 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 	if (rot == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
-	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
-		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
@@ -3090,6 +3087,15 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	if (sdkp->media_present) {
 		sd_read_capacity(sdkp, buffer);
 
+		/*
+		 * set the default to rotational.  All non-rotational devices
+		 * support the block characteristics VPD page, which will
+		 * cause this to be updated correctly and any device which
+		 * doesn't support it should be treated as rotational.
+		 */
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
+
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
