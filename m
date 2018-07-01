Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C20C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8A254F6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8A254F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032042AbeGAQmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:42:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031569AbeGAQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C829AA6;
        Sun,  1 Jul 2018 16:42:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 134/220] scsi: qla2xxx: Delete session for nport id change
Date:   Sun,  1 Jul 2018 18:22:38 +0200
Message-Id: <20180701160913.915354761@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 1d317b21231bb2b81a6e0f94f708b8619ec8775b upstream.

This patch fixes regression introduced by commit a4239945b8ad ("scsi:
qla2xxx: Add switch command to simplify fabric discovery") by scheduling
session deletion when Nport ID changes.

[mkp: clarified commit]

Fixes: a4239945b8ad ("scsi: qla2xxx: Add switch command to simplify fabric discovery")
Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3915,7 +3915,6 @@ void qla24xx_async_gnnft_done(scsi_qla_h
 			if (memcmp(rp->port_name, fcport->port_name, WWN_SIZE))
 				continue;
 			fcport->scan_state = QLA_FCPORT_FOUND;
-			fcport->d_id.b24 = rp->id.b24;
 			found = true;
 			/*
 			 * If device was not a fabric device before.
@@ -3923,7 +3922,10 @@ void qla24xx_async_gnnft_done(scsi_qla_h
 			if ((fcport->flags & FCF_FABRIC_DEVICE) == 0) {
 				qla2x00_clear_loop_id(fcport);
 				fcport->flags |= FCF_FABRIC_DEVICE;
+			} else if (fcport->d_id.b24 != rp->id.b24) {
+				qlt_schedule_sess_for_deletion(fcport);
 			}
+			fcport->d_id.b24 = rp->id.b24;
 			break;
 		}
 


