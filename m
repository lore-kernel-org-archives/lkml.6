Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E559821582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E559821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbeKOAoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:44:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:37242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeKOAoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:44:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8A68B0ED;
        Wed, 14 Nov 2018 14:40:53 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: Fix racy link clearance
Date:   Wed, 14 Nov 2018 15:40:50 +0100
Message-Id: <20181114144050.12630-1-tiwai@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ap->sff_pio_task_link gets cleared in a racy way in
ata_sff_flush_pio_task().  This may lead to BUG_ON() check in the
work, and screw up the whole system.

Along with it, replace BUG_ON() with WARN_ON() and let the work quit
gracefully.  It's no end of the world, after all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/ata/libata-sff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c5ea0fc635e5..28ef46ef656d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1271,9 +1271,8 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 	 */
 	spin_lock_irq(ap->lock);
 	ap->hsm_task_state = HSM_ST_IDLE;
-	spin_unlock_irq(ap->lock);
-
 	ap->sff_pio_task_link = NULL;
+	spin_unlock_irq(ap->lock);
 
 	if (ata_msg_ctl(ap))
 		ata_port_dbg(ap, "%s: EXIT\n", __func__);
@@ -1283,14 +1282,17 @@ static void ata_sff_pio_task(struct work_struct *work)
 {
 	struct ata_port *ap =
 		container_of(work, struct ata_port, sff_pio_task.work);
-	struct ata_link *link = ap->sff_pio_task_link;
+	struct ata_link *link;
 	struct ata_queued_cmd *qc;
 	u8 status;
 	int poll_next;
 
 	spin_lock_irq(ap->lock);
 
-	BUG_ON(ap->sff_pio_task_link == NULL);
+	link = ap->sff_pio_task_link;
+	if (WARN_ON(!link))
+		goto out_unlock;
+
 	/* qc can be NULL if timeout occurred */
 	qc = ata_qc_from_tag(ap, link->active_tag);
 	if (!qc) {
-- 
2.19.1

