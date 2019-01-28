Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC00C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D9420880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690643;
	bh=ZbMytEUdLH9aGQ71UHhqBRVS72KYdBykgOF2tIcVg50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kjaN3GK0cmXI1l9OrRXI8iLfPosT0u4RY+UH9yUYqWDHN+Xge0P7SxaMLVrBdBPOc
	 weVlsu0i2UcrcmZr2q59VdKlPIxb7qYSmsZIDfnEzKd7M9k/stykaaA2FXucPsszV+
	 mvy4gljsuY4zaUgOJqq1ukDWLYRDdV19oZb38Smg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfA1Pul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbfA1Puj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA4021741;
        Mon, 28 Jan 2019 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690639;
        bh=ZbMytEUdLH9aGQ71UHhqBRVS72KYdBykgOF2tIcVg50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k080CkaSBfZAVZtoJ3HMwSTYKJkwbZJTIXUzUKRpuJ7doBkmO6iVwl/I+DNzl2RvG
         bzLi58YKPMVyIz1R20hyRsn6SvH+rLP1FtWGCCzwhvozMKvVyuO2ekpoxbcuiw5VTd
         ouvipqgV2NtD+6A600Hlmzo4fTFBG6ZV59uRwxAU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 149/304] watchdog: renesas_wdt: don't set divider while watchdog is running
Date:   Mon, 28 Jan 2019 10:41:06 -0500
Message-Id: <20190128154341.47195-149-sashal@kernel.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit e990e12741877e9bfac402ca468f4007a75f6e2a ]

The datasheet says we must stop the timer before changing the clock
divider. This can happen when the restart handler is called while the
watchdog is running.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/renesas_wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 0d74c3e48979..55c9eb6c6e51 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -74,12 +74,17 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+	u8 val;
 
 	pm_runtime_get_sync(wdev->parent);
 
-	rwdt_write(priv, 0, RWTCSRB);
-	rwdt_write(priv, priv->cks, RWTCSRA);
+	/* Stop the timer before we modify any register */
+	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
+	rwdt_write(priv, val, RWTCSRA);
+
 	rwdt_init_timeout(wdev);
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	rwdt_write(priv, 0, RWTCSRB);
 
 	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
 		cpu_relax();
-- 
2.19.1

