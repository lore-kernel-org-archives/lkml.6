Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A60CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BD021741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694837;
	bh=56sDkTOANPa2jze6owne038gvfwm3VUHezJPck7T1xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nK9/wRdMmIH4Mycmo1AAbTxT2N0Gxa2WqYwmUmdkhm2BLLioMRisyrndIQpsn4Bwd
	 +vPsvkvrkLkEihKFZvPLJFwgbFtI+Ol6D2MPi9L7F+pkAhibyC1iPnG/K5nWjCiIP7
	 Ffo5bDZJs5YIawsr8k0V3FlmWd1apW3JwGgimnZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfA1RAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733053AbfA1QPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BE72148E;
        Mon, 28 Jan 2019 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692134;
        bh=56sDkTOANPa2jze6owne038gvfwm3VUHezJPck7T1xU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgZg8T4YWgtAlnVXqARMzDoTqJ3pAmGWbYq1vArtDlLqw2IdZgF4bCVNKKhBg8reU
         f29w4+iwkDUbNhHmVLgV1cxPFLEtIQ9/54kl35nN+EvqcOtXutFXIqMcSXPrGS+2Qb
         VbCbUjuFK0et6zB3nDjgcFjbuWQKk6ABZcgXO5wI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 082/170] watchdog: renesas_wdt: don't set divider while watchdog is running
Date:   Mon, 28 Jan 2019 11:10:32 -0500
Message-Id: <20190128161200.55107-82-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index 831ef83f6de1..c4a17d72d025 100644
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

