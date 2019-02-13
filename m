Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC61C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239221934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026356;
	bh=PPd7w0aOaEqXrRHZG3X/CYT+qZv3NDX6g6GVL8uiH08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2j/ucZEXI9eas3f+MEk+r8ojqyNpIz+M9P64mukAVlORYs49EMdEe2qfydd/agLiA
	 q6IfRddAAIsaA/OorG5KoYOwWrHzqx1poAAY/UfZzrA3CkB83QV7XIo8/bMEZ/mRpb
	 WXNg+LKQHMA9G4NqwQt8Bw1MIYDePZJsuKHobwlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbfBMCwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388535AbfBMCi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB62222C2;
        Wed, 13 Feb 2019 02:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025509;
        bh=PPd7w0aOaEqXrRHZG3X/CYT+qZv3NDX6g6GVL8uiH08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCkbrjZC/tL/wdp1144ThCrLq/4Y+3PErlk5++8C3EIRR0biToYrS1Qqh2NPV7ozF
         mf/DdMSqTVzB0WnG7hSWYYBn4/Njup8fBjHYI4JZ77ggpbfamA/Gn0blJAPio1R16S
         tVoT4lbPcYHuEImsCdgGjezqNHeDbsS2GSZblPns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 52/83] scsi: ufs: Fix system suspend status
Date:   Tue, 12 Feb 2019 21:36:30 -0500
Message-Id: <20190213023701.20286-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit ce9e7bce43526626f7cffe2e657953997870197e ]

hba->is_sys_suspended is set after successful system suspend but
not clear after successful system resume.

According to current behavior, hba->is_sys_suspended will not be set if
host is runtime-suspended but not system-suspended. Thus we shall aligh the
same policy: clear this flag even if host remains runtime-suspended after
ufshcd_system_resume is successfully returned.

Simply fix this flag to correct host status logs.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 12ddb5928a73..6e80dfe4fa97 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7768,6 +7768,8 @@ int ufshcd_system_resume(struct ufs_hba *hba)
 	trace_ufshcd_system_resume(dev_name(hba->dev), ret,
 		ktime_to_us(ktime_sub(ktime_get(), start)),
 		hba->curr_dev_pwr_mode, hba->uic_link_state);
+	if (!ret)
+		hba->is_sys_suspended = false;
 	return ret;
 }
 EXPORT_SYMBOL(ufshcd_system_resume);
-- 
2.19.1

