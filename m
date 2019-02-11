Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA082229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897067;
	bh=94Bzif+YofnvqvpvdZJ0SzyDrJ5/IO/ilMOUOm/w2MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZBfoWCoDFTHikZUWz14lxz/ajSb4b1ldTeVyMrA98p0ftJEb3MHF4hmco1oOukpME
	 MIMIMuX+mpkTHEBuczLv5XCv+l16MSdmSePE7Jyp5deSO1K/QyTC8h79AfIfDn8dp9
	 q9gntgt4ugs5scK4fzGvEnYQLk2vb9WY0fF5XlWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfBKO5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfBKO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56949222A1;
        Mon, 11 Feb 2019 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897062;
        bh=94Bzif+YofnvqvpvdZJ0SzyDrJ5/IO/ilMOUOm/w2MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avVesrD145iTDY9y13wtwEUZUW3kV88JPmEoxVhjvBJel+T9VtFWd3cN6tW+oqJZk
         AT7shmS0OU6TxNcxxQyS67aj8UOtulShpxe5oORK1DfbYGeCMToZ/NJuhe/VSkEQF6
         KozcdDfNS2NAXlHryuGbLDImtglnEr2XDG4BMFZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/205] watchdog: renesas_wdt: dont set divider while watchdog is running
Date:   Mon, 11 Feb 2019 15:17:56 +0100
Message-Id: <20190211141833.802533062@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



