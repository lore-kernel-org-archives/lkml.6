Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB81C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5005223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqcEHHbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5005223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403756AbeKLIWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390677AbeKLIWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A246621582;
        Sun, 11 Nov 2018 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975559;
        bh=1erSnG0ArysKG85B7X8OlLYTO5vShg6oH5af2ZZki9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqcEHHbQc733o9ePnCs4J4iTATjdvIxvQRp6smzGXjTkeyShWCgUwTa4oyV69S30Q
         8iwWdt25SditIvQswmASITdxM+v6al+Y9Bf8D1RpvNEi+sN6HjUPdAD2Z30UbyaFV6
         zuy7HrmM6qSZTbSxLI+3K0s7vYZfmtzPG3vkijJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 101/222] scsi: lpfc: Correct soft lockup when running mds diagnostics
Date:   Sun, 11 Nov 2018 14:23:18 -0800
Message-Id: <20181111221656.965098029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3585,6 +3585,7 @@ lpfc_sli_handle_slow_ring_event_s4(struc
 	struct hbq_dmabuf *dmabuf;
 	struct lpfc_cq_event *cq_event;
 	unsigned long iflag;
+	int count = 0;
 
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	phba->hba_flag &= ~HBA_SP_QUEUE_EVT;
@@ -3606,16 +3607,22 @@ lpfc_sli_handle_slow_ring_event_s4(struc
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
 


