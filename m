Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA7BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10628206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025316;
	bh=UEido4J2OYf+cF5ssjFQS1aOIAj3PxadB0E0g+1aDdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2msecJKacDDf28NJPyTSg0zypW/6QrwsnFnUF5RHMtdJJSXyn2/OU5nXyLcGdbGNb
	 M+0CK+llKiv8SHMvYICf39RYz6svaWI5tkrnOKZkj1vJUkz2q78/niC5o9AAf5iEMi
	 Q76vb8sk8lbZhoKCAPDG1rnx2KuaCo40x00nb/5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbfBMCfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387900AbfBMCfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766EA222C7;
        Wed, 13 Feb 2019 02:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025309;
        bh=UEido4J2OYf+cF5ssjFQS1aOIAj3PxadB0E0g+1aDdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KaBTbXGUaR7ozWtWxusHjHgX9AslzCE6WgqdCz8Oib/ySPUTsBKlLOonSW2LC9FR6
         +7OLstUJYe5nuL4qVmHq2cP8C7OA7d+Zv4Ku2pNv/o5U6spk36PLoedxue090I6AX2
         KQn6aY4A1PJNZIgTA1pfR7Gb/3RD98sgfzuAo2DM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 060/105] scsi: ufs: Fix system suspend status
Date:   Tue, 12 Feb 2019 21:32:51 -0500
Message-Id: <20190213023336.19019-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index 1cb35ab8a4ec..2772ff4357fc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7924,6 +7924,8 @@ out:
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

