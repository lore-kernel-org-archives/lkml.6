Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937240AbeE1O73 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034079AbeE1KZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:25:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 263/268] scsi: lpfc: Fix frequency of Release WQE CQEs
Date: Mon, 28 May 2018 12:03:57 +0200
Message-Id: <20180528100232.712860896@linuxfoundation.org>
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

[ Upstream commit 04673e38f56b30cd39b1fa0f386137d818b17781 ]

The driver controls when the hardware sends completions that communicate
consumption of elements from the WQ. This is done by setting a WQEC bit
on a WQE.

The current driver sets it on every Nth WQE posting. However, the driver
isn't clearing the bit if the WQE is reused. Thus, if the queue depth
isn't evenly divisible by N, with enough time, it can be set on every
element, creating a lot of overhead and risking CQ full conditions.

Correct by clearing the bit when not setting it on an Nth element.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -115,6 +115,8 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, u
 	/* set consumption flag every once in a while */
 	if (!((q->host_index + 1) % q->entry_repost))
 		bf_set(wqe_wqec, &wqe->generic.wqe_com, 1);
+	else
+		bf_set(wqe_wqec, &wqe->generic.wqe_com, 0);
 	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
 		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
 	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
