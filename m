Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E99ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB2F2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB2F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeJVEQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:16:05 -0400
Received: from sauhun.de ([88.99.104.3]:45826 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbeJVEQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:04 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id B20D92E35DF;
        Sun, 21 Oct 2018 22:00:35 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/5] pinctrl: intel: pinctrl-cherryview: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:28 +0200
Message-Id: <20181021200032.1833-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/pinctrl/intel/pinctrl-cherryview.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 9b0f4b9ef482..f685abef68c3 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1744,8 +1744,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int chv_pinctrl_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct chv_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct chv_pinctrl *pctrl = dev_get_drvdata(dev);
 	unsigned long flags;
 	int i;
 
@@ -1778,8 +1777,7 @@ static int chv_pinctrl_suspend_noirq(struct device *dev)
 
 static int chv_pinctrl_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct chv_pinctrl *pctrl = platform_get_drvdata(pdev);
+	struct chv_pinctrl *pctrl = dev_get_drvdata(dev);
 	unsigned long flags;
 	int i;
 
-- 
2.19.0

