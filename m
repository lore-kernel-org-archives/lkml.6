Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB02ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30402146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30402146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeIREjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:39:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeIREjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:39:32 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B62BC49;
        Mon, 17 Sep 2018 23:10:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 063/158] scsi: lpfc: Fix driver crash when re-registering NVME rports.
Date:   Tue, 18 Sep 2018 00:41:33 +0200
Message-Id: <20180917211714.147270343@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 93a3922da428ec0752e8b2ab00c42dadbbf805a9 ]

During remote port loss fault testing, the driver crashed with the
following trace:

general protection fault: 0000 [#1] SMP
RIP: ... lpfc_nvme_register_port+0x250/0x480 [lpfc]
Call Trace:
 lpfc_nlp_state_cleanup+0x1b3/0x7a0 [lpfc]
 lpfc_nlp_set_state+0xa6/0x1d0 [lpfc]
 lpfc_cmpl_prli_prli_issue+0x213/0x440
 lpfc_disc_state_machine+0x7e/0x1e0 [lpfc]
 lpfc_cmpl_els_prli+0x18a/0x200 [lpfc]
 lpfc_sli_sp_handle_rspiocb+0x3b5/0x6f0 [lpfc]
 lpfc_sli_handle_slow_ring_event_s4+0x161/0x240 [lpfc]
 lpfc_work_done+0x948/0x14c0 [lpfc]
 lpfc_do_work+0x16f/0x180 [lpfc]
 kthread+0xc9/0xe0
 ret_from_fork+0x55/0x80

After registering a new remoteport, the driver is pulling an ndlp pointer
from the lpfc rport associated with the private area of a newly registered
remoteport. The private area is uninitialized, so it's garbage.

Correct by pulling the the lpfc rport pointer from the entering ndlp point,
then ndlp value from at rport. Note the entering ndlp may be replacing by
the rport->ndlp due to an address change swap.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2687,7 +2687,7 @@ lpfc_nvme_register_port(struct lpfc_vpor
 	struct lpfc_nvme_rport *oldrport;
 	struct nvme_fc_remote_port *remote_port;
 	struct nvme_fc_port_info rpinfo;
-	struct lpfc_nodelist *prev_ndlp;
+	struct lpfc_nodelist *prev_ndlp = NULL;
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NVME_DISC,
 			 "6006 Register NVME PORT. DID x%06x nlptype x%x\n",
@@ -2736,23 +2736,29 @@ lpfc_nvme_register_port(struct lpfc_vpor
 		spin_unlock_irq(&vport->phba->hbalock);
 		rport = remote_port->private;
 		if (oldrport) {
+			/* New remoteport record does not guarantee valid
+			 * host private memory area.
+			 */
+			prev_ndlp = oldrport->ndlp;
 			if (oldrport == remote_port->private) {
-				/* Same remoteport.  Just reuse. */
+				/* Same remoteport - ndlp should match.
+				 * Just reuse.
+				 */
 				lpfc_printf_vlog(ndlp->vport, KERN_INFO,
 						 LOG_NVME_DISC,
 						 "6014 Rebinding lport to "
 						 "remoteport %p wwpn 0x%llx, "
-						 "Data: x%x x%x %p x%x x%06x\n",
+						 "Data: x%x x%x %p %p x%x x%06x\n",
 						 remote_port,
 						 remote_port->port_name,
 						 remote_port->port_id,
 						 remote_port->port_role,
+						 prev_ndlp,
 						 ndlp,
 						 ndlp->nlp_type,
 						 ndlp->nlp_DID);
 				return 0;
 			}
-			prev_ndlp = rport->ndlp;
 
 			/* Sever the ndlp<->rport association
 			 * before dropping the ndlp ref from
@@ -2786,13 +2792,13 @@ lpfc_nvme_register_port(struct lpfc_vpor
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_NVME_DISC | LOG_NODE,
 				 "6022 Binding new rport to "
-				 "lport %p Remoteport %p  WWNN 0x%llx, "
+				 "lport %p Remoteport %p rport %p WWNN 0x%llx, "
 				 "Rport WWPN 0x%llx DID "
-				 "x%06x Role x%x, ndlp %p\n",
-				 lport, remote_port,
+				 "x%06x Role x%x, ndlp %p prev_ndlp %p\n",
+				 lport, remote_port, rport,
 				 rpinfo.node_name, rpinfo.port_name,
 				 rpinfo.port_id, rpinfo.port_role,
-				 ndlp);
+				 ndlp, prev_ndlp);
 	} else {
 		lpfc_printf_vlog(vport, KERN_ERR,
 				 LOG_NVME_DISC | LOG_NODE,


