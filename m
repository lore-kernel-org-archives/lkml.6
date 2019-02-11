Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17095C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC14421B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896244;
	bh=4L7FZxUk4M21BUVZI9liPj5y+tMMswWYkv+1fd89mu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifZ5D9Enels/IvRNITCj/XTh0PmrE6JKXpmDc1xbe/0XaFjCNoFmouj/RnC67s5LW
	 VRlH7U2sxBXz4chXTy9tSI3Gm9liK1IK6C99jPi9LDKnFe3ps452knwKBBNWh9aNSX
	 QfXhZNpr/4og123CTd/ibeduGj5vsD0alQCNnQg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfBKOoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbfBKOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6D3222A1;
        Mon, 11 Feb 2019 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896238;
        bh=4L7FZxUk4M21BUVZI9liPj5y+tMMswWYkv+1fd89mu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gp99GmKkemgkcjhZ8qcU6jdLKtjBrdu5ME2YO4Vie6pIN+a+x7wmZdO394qQ4wiB5
         JQ2dbVa7fDQU2mveJZ1sId00scuf954grZpM17gxnh8q9RLTKQRbTnpGTsPknnP6ho
         UmkEOiv0kQCTTBY+9vrEoHlSrbaeOKibaAmOtU3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/313] watchdog: renesas_wdt: dont set divider while watchdog is running
Date:   Mon, 11 Feb 2019 15:16:37 +0100
Message-Id: <20190211141901.657007697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 88d81feba4e6..d01efd342dc0 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -77,12 +77,17 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
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



