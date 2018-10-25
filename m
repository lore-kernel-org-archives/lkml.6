Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D7BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C6A2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cViWzvkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C6A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJYWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbeJYWoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:14 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079C320840;
        Thu, 25 Oct 2018 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476679;
        bh=bnh2x8Dql10PSNZKG1iD8t66UzIi4TbzZSRE21F5F2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cViWzvkMi7JGwi+p+x9rWNSnJV8dFmBSGZpFhXbqh9XH1t9q9UBo9revn1VyKs90i
         WUGgcmvHoxaA1sq7B8Ec1dMlOrNIBU+eG4Gv1wFN39q/x8Irs5SGv4TkvFCA9iZWqt
         ov4iYExycna9VdY56DjyVQxq2o0fJN84nR8vBRlc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 17/46] scsi: qla2xxx: Avoid double completion of abort command
Date:   Thu, 25 Oct 2018 10:10:24 -0400
Message-Id: <20181025141053.213330-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

[ Upstream commit 3a9910d7b686546dcc9986e790af17e148f1c888 ]

qla2x00_tmf_sp_done() now deletes the timer that will run
qla2x00_tmf_iocb_timeout(), but doesn't check whether the timer already
expired.  Check the return value from del_timer() to avoid calling
complete() a second time.

Fixes: 4440e46d5db7 ("[SCSI] qla2xxx: Add IOCB Abort command asynchronous ...")
Fixes: 1514839b3664 ("scsi: qla2xxx: Fix NULL pointer crash due to active ...")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1d42d38f5a45..0e19f6bc24ff 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1365,8 +1365,8 @@ qla24xx_abort_sp_done(void *ptr, int res)
 	srb_t *sp = ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
-	del_timer(&sp->u.iocb_cmd.timer);
-	complete(&abt->u.abt.comp);
+	if (del_timer(&sp->u.iocb_cmd.timer))
+		complete(&abt->u.abt.comp);
 }
 
 int
-- 
2.17.1

