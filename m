Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACBBC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605C82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026060;
	bh=U6S6ZDPTARCTs2QDGyvCo8psu6nP0VMVVAv3khpgn3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msEHhUYs7YZU6F/WOvMZXef3ZPbOdGVS06r7onsy4eQuLYx49EcyEL3HWpWpCeHYe
	 694fQsqyJ1LaTEJx2+ALQPvthDkb0eOQSa46gVnBjPQYjS+5F2sX07I81cWic+V2uw
	 w1IuPmTd1FS9HVzcMPQbyu5tF11cSCaee29pcc3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfBMCri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388991AbfBMCk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFF3222C7;
        Wed, 13 Feb 2019 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025626;
        bh=U6S6ZDPTARCTs2QDGyvCo8psu6nP0VMVVAv3khpgn3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzzJ7L/m+CnYT1v/wbLRiTdZMW08VIwm3wfHfJRgFzitTXTzN+hPvPd9aHAqbKrA7
         abcP2EALzoB9OsyZu8acSnjobRKQLlwNl/V7oUdWqrbjPLF8z2kEdjYofshIphxp7y
         4hmClwEqzlGsbCbaRZjClr1Uz0O7NedhQfNT/OX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/34] scsi: ufs: Fix system suspend status
Date:   Tue, 12 Feb 2019 21:39:42 -0500
Message-Id: <20190213023952.21311-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
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
index 21c81c1feac5..66540491839e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7520,6 +7520,8 @@ int ufshcd_system_resume(struct ufs_hba *hba)
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

