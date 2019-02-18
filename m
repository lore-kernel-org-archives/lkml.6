Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5577C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B517C21905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500094;
	bh=y2Bc2MGaDDM2Jqc0GsCtrDj8Fb98l2QAlrqtMTiTuAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1TAGS+qriUdTgbkIgKHMl3cBWyiyGiRVb5xxUQ+943gieQqySaBaONPMA1wWIe3i
	 WIrgZMBVHsYcS8SjTvxTulMqYMMStK6NIAhyZDyHFUffwr2quTUHxggQUHdOIb+P07
	 ahdsjekH78Y343Qxhmh3nx8gzkeLZK4QeyzArx2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbfBRO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388997AbfBROBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DF62070D;
        Mon, 18 Feb 2019 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498469;
        bh=y2Bc2MGaDDM2Jqc0GsCtrDj8Fb98l2QAlrqtMTiTuAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9Oewy9+mOMatp9jWwWJVA351VkQhhixLfeCr00CPVUcf9+aQKoXjw98m9KazCpEF
         KjTQMVP5WkB1FZqNBU3st+kiR6ZeI9tI49vJioG2ffwqlYE3gOGthl98sFw+ZvrgRZ
         uW2R0Fvot/uCwR/w0lzHKKtD1RJvU1TripeuX1lQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 004/143] scsi: lpfc: Correct LCB RJT handling
Date:   Mon, 18 Feb 2019 14:42:12 +0100
Message-Id: <20190218133529.292754223@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b114d9009d386276bfc3352289fc235781ae3353 ]

When LCB's are rejected, if beaconing was already in progress, the
Reason Code Explanation was not being set. Should have been set to
command in progress.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index fd8fe1202dbe..398c9a0a5ade 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5105,6 +5105,9 @@ error:
 	stat = (struct ls_rjt *)(pcmd + sizeof(uint32_t));
 	stat->un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
 
+	if (shdr_add_status == ADD_STATUS_OPERATION_ALREADY_ACTIVE)
+		stat->un.b.lsRjtRsnCodeExp = LSEXP_CMD_IN_PROGRESS;
+
 	elsiocb->iocb_cmpl = lpfc_cmpl_els_rsp;
 	phba->fc_stat.elsXmitLSRJT++;
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
-- 
2.19.1



