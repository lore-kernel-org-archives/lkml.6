Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E12BC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F46214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y8ObDh3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F46214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406493AbeKTD2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405461AbeKTD2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA95D214D9;
        Mon, 19 Nov 2018 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647055;
        bh=6rhgKeQAd/eGpdgi19mL22FJ/S/xrb9WX3YVtKzYMvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8ObDh3HRiH2UwD9YR/Dx+6Q1qLLGV82/UV0qSsLtu52F8IkPmZDPhPUvdPuJ287y
         aAP816iyVD35JvQKtnpwwsZnA2EXSleCpYNThwwvF0zmTtemV3Ujq9IfEFvIKd5B02
         44tFznEdGhdJGNX+0VwYm6ifPsMVUGD7j0uurJPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 26/90] scsi: lpfc: Correct soft lockup when running mds diagnostics
Date:   Mon, 19 Nov 2018 17:29:08 +0100
Message-Id: <20181119162625.162444940@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3441,6 +3441,7 @@ lpfc_sli_handle_slow_ring_event_s4(struc
 	struct hbq_dmabuf *dmabuf;
 	struct lpfc_cq_event *cq_event;
 	unsigned long iflag;
+	int count = 0;
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	phba->hba_flag &= ~HBA_SP_QUEUE_EVT;
@@ -3462,16 +3463,22 @@ lpfc_sli_handle_slow_ring_event_s4(struc
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
 


