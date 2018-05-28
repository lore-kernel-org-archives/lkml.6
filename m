Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937046AbeE1O7Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034062AbeE1KZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:25:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 262/268] scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
Date: Mon, 28 May 2018 12:03:56 +0200
Message-Id: <20180528100232.539006557@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 161df4f09987ae2e9f0f97f0b38eee298b4a39ff ]

During link bounce testing in a point-to-point topology, the host may
enter a soft lockup on the lpfc_worker thread:

    Call Trace:
     lpfc_work_done+0x1f3/0x1390 [lpfc]
     lpfc_do_work+0x16f/0x180 [lpfc]
     kthread+0xc7/0xe0
     ret_from_fork+0x3f/0x70

The driver was simultaneously setting a combination of flags that caused
lpfc_do_work()to effectively spin between slow path work and new event
data, causing the lockup.

Ensure in the typical wq completions, that new event data flags are set
if the slow path flag is running. The slow path will eventually
reschedule the wq handling.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -691,8 +691,9 @@ lpfc_work_done(struct lpfc_hba *phba)
 	    (phba->hba_flag & HBA_SP_QUEUE_EVT)) {
 		if (pring->flag & LPFC_STOP_IOCB_EVENT) {
 			pring->flag |= LPFC_DEFERRED_RING_EVENT;
-			/* Set the lpfc data pending flag */
-			set_bit(LPFC_DATA_READY, &phba->data_flags);
+			/* Preserve legacy behavior. */
+			if (!(phba->hba_flag & HBA_SP_QUEUE_EVT))
+				set_bit(LPFC_DATA_READY, &phba->data_flags);
 		} else {
 			if (phba->link_state >= LPFC_LINK_UP) {
 				pring->flag &= ~LPFC_DEFERRED_RING_EVENT;
