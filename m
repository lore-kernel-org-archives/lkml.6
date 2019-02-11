Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783B222AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897495;
	bh=dNiDnC+hVwkSoR5L0WN+7qRoop5NKGV5DSGbDcPBwjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=llHhesTjZxOfzd30cmJZWNhSN8MhDSKvCF9TYB4lEECty6pkFvWexgiMG439G3A0J
	 hxaQRky/xq+LThKO6clptINGM1VskNrFHuPOs+YQtef9cRv2Kdw6y9A15o8TInk7Bo
	 8IUv7JhD9dhA6qq0ctYwj9fPDzggdxpHQTD2j1G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbfBKPEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbfBKPEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3547222AD;
        Mon, 11 Feb 2019 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897490;
        bh=dNiDnC+hVwkSoR5L0WN+7qRoop5NKGV5DSGbDcPBwjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGDJOHmYdQZpUOwU0oHOCDHggFsQuzwlEgKSiVZJOEPMrJBVwXYrKzzD4j5Arl9qC
         XwW015Ik7Wd6aoZpADtGU4pnVCZ90cH2ZCiQMo4oxfY+luU5XQJpzA2a8K5nEQJWbx
         DDFWByzimBeEiVJiQ9MHHqMwvz5QTtLckgqseXeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 006/137] scsi: lpfc: Correct LCB RJT handling
Date:   Mon, 11 Feb 2019 15:18:07 +0100
Message-Id: <20190211141812.538784457@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index fc7addaf24da..4905455bbfc7 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5396,6 +5396,9 @@ error:
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



