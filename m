Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5020881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697885;
	bh=ApqE3Olbw2PmGMrvDPb65vjQNm9rWZjkdUPQvCga/CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1F4Bk27RGHwlg7bSCZ0vTXncTdE/dcdET1jZz3SoYTlm7petBX8lOM4qyqBHbzXfp
	 rEqsFitzhKu/hMW0MlICP7fDp9801AIejMJgeQASmk4sRvKT2dEUuN6ZOg/Zn5WMxh
	 GibVdrrdjC4DURQ0Yx/C9mDinpIGKX6lfHeq7clo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfA1RvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfA1PoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3ACA214DA;
        Mon, 28 Jan 2019 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690255;
        bh=ApqE3Olbw2PmGMrvDPb65vjQNm9rWZjkdUPQvCga/CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYVY6JGXItj4F2vfEx9k+A2uriI5U7Fak7eBxpE+YhB7zEMxJZUAKpDfSBL+Rnt9W
         zwK/7+lMjFTEa5DUgBRI4zRmHsjJgNv78ANqJ+dSFkv7cUvYDnGzIPnRn+Ci5G5lGu
         Ctfh9xwkvnNMBrhtWpCqV2uy9olhBZhWyhPd6q8U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 019/304] scsi: lpfc: Correct LCB RJT handling
Date:   Mon, 28 Jan 2019 10:38:56 -0500
Message-Id: <20190128154341.47195-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

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
index f1c1faa74b46..96e2f542734a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5701,6 +5701,9 @@ error:
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

