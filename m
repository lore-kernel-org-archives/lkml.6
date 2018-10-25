Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1293120870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="syj5u5fZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeJYWtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJYWtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:04 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB5B2086D;
        Thu, 25 Oct 2018 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476967;
        bh=1baPjp4sv4CBi6+f0mKX9Cgnd40ZrU2MbTTm2jPuoOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=syj5u5fZHrxUdCPLV7oT6rSpaC3DoHmxKkovbq/hsSSZkqsn7HLT2+LkRtY56Afgc
         lA0wgTXjwr4eLTtLT50MK5itaG7rsWScyBhFdAGToiQYBDFM6rDTER0ATi7Dkov0y6
         H2e8fj9T73+tlfHBFIhmisOnDfDp7EeURToxzxg0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 70/98] scsi: qla2xxx: Avoid double completion of abort command
Date:   Thu, 25 Oct 2018 10:13:55 -0400
Message-Id: <20181025141423.213774-70-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
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
index 5f66b6da65f2..b6d9e3104b89 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -368,8 +368,8 @@ qla24xx_abort_sp_done(void *data, void *ptr, int res)
 	srb_t *sp = (srb_t *)ptr;
 	struct srb_iocb *abt = &sp->u.iocb_cmd;
 
-	del_timer(&sp->u.iocb_cmd.timer);
-	complete(&abt->u.abt.comp);
+	if (del_timer(&sp->u.iocb_cmd.timer))
+		complete(&abt->u.abt.comp);
 }
 
 static int
-- 
2.17.1

