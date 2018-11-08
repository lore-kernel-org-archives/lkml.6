Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F23820892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLjfaxG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F23820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbeKIHnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeKIHnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:12 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34D2208A3;
        Thu,  8 Nov 2018 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714742;
        bh=1nm3usq3S/PyZFZg9GujIMUp2XSkLuXV930aPBU7M0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLjfaxG+aAvMtMYAEU1v3+vYlWJg93jQDT7TQ/U3UaE6HFBgI1vMoOMaTyLoKCVj+
         TpR4wk9heEjbTwQAcYARnkKkRKwm0pCx9FMAszKOTmFNue9UhurSyIGPOoOjsei5ns
         Ryap+VwDdmQpZQO/o4Zuz03+2dvYnkT0+3oBxP1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 099/171] scsi: qla2xxx: Avoid double completion of abort command
Date:   Thu,  8 Nov 2018 13:51:09 -0800
Message-Id: <20181108215134.649265099@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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



