Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50DECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F9920866
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT+THpJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F9920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeKAIM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbeKAIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8819E20866;
        Wed, 31 Oct 2018 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027546;
        bh=OiOY1w8FlPG7S0RyhAlrAwzjDCi6i2Cm+o3e9g8jJNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BT+THpJxRyFuwkpYTIvIJ1g3fIe+qBXg134PJYe4sDwAyxJXcykNLeXmztwIcuvVQ
         zfsXeCB60sfU3k70wIpWVdD5PvwqA1UHIGD8AaCvAlo6z7i5mNeCEdDzILnzboN082
         5XCAMSZu5cAJA6RBf2SFObNQ7kyXATgMyZenc44A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 20/22] scsi: lpfc: Correct soft lockup when running mds diagnostics
Date:   Wed, 31 Oct 2018 19:12:04 -0400
Message-Id: <20181031231206.29509-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 0ef01a2d95fd62bb4f536e7ce4d5e8e74b97a244 ]

When running an mds diagnostic that passes frames with the switch, soft
lockups are detected. The driver is in a CQE processing loop and has
sufficient amount of traffic that it never exits the ring processing routine,
thus the "lockup".

Cap the number of elements in the work processing routine to 64 elements. This
ensures that the cpu will be given up and the handler reschedule to process
additional items.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index cdade5828a5d..fcae6f66a5a6 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3441,6 +3441,7 @@ lpfc_sli_handle_slow_ring_event_s4(struct lpfc_hba *phba,
 	struct hbq_dmabuf *dmabuf;
 	struct lpfc_cq_event *cq_event;
 	unsigned long iflag;
+	int count = 0;
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	phba->hba_flag &= ~HBA_SP_QUEUE_EVT;
@@ -3462,16 +3463,22 @@ lpfc_sli_handle_slow_ring_event_s4(struct lpfc_hba *phba,
 			if (irspiocbq)
 				lpfc_sli_sp_handle_rspiocb(phba, pring,
 							   irspiocbq);
+			count++;
 			break;
 		case CQE_CODE_RECEIVE:
 		case CQE_CODE_RECEIVE_V1:
 			dmabuf = container_of(cq_event, struct hbq_dmabuf,
 					      cq_event);
 			lpfc_sli4_handle_received_buffer(phba, dmabuf);
+			count++;
 			break;
 		default:
 			break;
 		}
+
+		/* Limit the number of events to 64 to avoid soft lockups */
+		if (count == 64)
+			break;
 	}
 }
 
-- 
2.17.1

