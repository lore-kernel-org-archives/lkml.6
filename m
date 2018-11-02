Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DACBC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BC2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkwsDjSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367BC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeKCD7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeKCD7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:59:34 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0407F2082D;
        Fri,  2 Nov 2018 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184679;
        bh=NrCDT30UhrArbkn8ORZOqGQvfzjijRL/5/7rr4kV25o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkwsDjSHf8QMR2d69QiL3y1eTeL7sB+kiOLbTC+GAARD2UQnA+PbpJOmm4fpu3ZBJ
         lRR06YTEoDlTzoZ7jbbwGBSlA1HOmMgyARn/q33cgcOnygpAM16HPOD0TfvfNQBuTH
         e6zqLXK8K3ly/wmfJwHD6GH7bJxchtd/k2BTn/Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/143] scsi: qla2xxx: Avoid double completion of abort command
Date:   Fri,  2 Nov 2018 19:34:11 +0100
Message-Id: <20181102182902.488263440@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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



