Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DCD2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DCD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbeHAUMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:12:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404310AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB43DF70;
        Wed,  1 Aug 2018 16:56:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 043/336] watchdog: da9063: Fix updating timeout value
Date:   Wed,  1 Aug 2018 18:46:18 +0200
Message-Id: <20180801165030.733632075@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 44ee54aabfdb3b35866ed909bde3ab01e9679385 ]

The DA9063 watchdog has only one register field to store the timeout value
and to enable the watchdog. The watchdog gets enabled if the value is
not zero. There is no issue if the watchdog is already running but it
leads into problems if the watchdog is disabled.

If the watchdog is disabled and only the timeout value should be prepared
the watchdog gets enabled too. Add a check to get the current watchdog
state and update the watchdog timeout value on hw-side only if the
watchdog is already active.

Fixes: 5e9c16e37608 ("watchdog: Add DA9063 PMIC watchdog driver.")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/watchdog/da9063_wdt.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -99,10 +99,23 @@ static int da9063_wdt_set_timeout(struct
 {
 	struct da9063 *da9063 = watchdog_get_drvdata(wdd);
 	unsigned int selector;
-	int ret;
+	int ret = 0;
 
 	selector = da9063_wdt_timeout_to_sel(timeout);
-	ret = _da9063_wdt_set_timeout(da9063, selector);
+
+	/*
+	 * There are two cases when a set_timeout() will be called:
+	 * 1. The watchdog is off and someone wants to set the timeout for the
+	 *    further use.
+	 * 2. The watchdog is already running and a new timeout value should be
+	 *    set.
+	 *
+	 * The watchdog can't store a timeout value not equal zero without
+	 * enabling the watchdog, so the timeout must be buffered by the driver.
+	 */
+	if (watchdog_active(wdd))
+		ret = _da9063_wdt_set_timeout(da9063, selector);
+
 	if (ret)
 		dev_err(da9063->dev, "Failed to set watchdog timeout (err = %d)\n",
 			ret);


