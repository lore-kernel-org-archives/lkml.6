Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96309C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CDF2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CDF2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeKLGAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:00:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52468 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730968AbeKLGAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:47 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000oN-P3; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Pu-SA; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Evgeniy Polyakov" <zbr@ioremap.net>,
        "Stefan Potyra" <Stefan.Potyra@elektrobit.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.978285934@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 048/366] w1: mxc_w1: Enable clock before calling
 clk_get_rate() on it
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>

commit 955bc61328dc0a297fb3baccd84e9d3aee501ed8 upstream.

According to the API, you may only call clk_get_rate() after actually
enabling it.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: a5fd9139f74c ("w1: add 1-wire master driver for i.MX27 / i.MX31")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/w1/masters/mxc_w1.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -111,6 +111,10 @@ static int mxc_w1_probe(struct platform_
 	if (IS_ERR(mdev->clk))
 		return PTR_ERR(mdev->clk);
 
+	err = clk_prepare_enable(mdev->clk);
+	if (err)
+		return err;
+
 	clkrate = clk_get_rate(mdev->clk);
 	if (clkrate < 10000000)
 		dev_warn(&pdev->dev,
@@ -124,12 +128,10 @@ static int mxc_w1_probe(struct platform_
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mdev->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mdev->regs))
-		return PTR_ERR(mdev->regs);
-
-	err = clk_prepare_enable(mdev->clk);
-	if (err)
-		return err;
+	if (IS_ERR(mdev->regs)) {
+		err = PTR_ERR(mdev->regs);
+		goto out_disable_clk;
+	}
 
 	writeb(clkdiv - 1, mdev->regs + MXC_W1_TIME_DIVIDER);
 
@@ -141,8 +143,12 @@ static int mxc_w1_probe(struct platform_
 
 	err = w1_add_master_device(&mdev->bus_master);
 	if (err)
-		clk_disable_unprepare(mdev->clk);
+		goto out_disable_clk;
+
+	return 0;
 
+out_disable_clk:
+	clk_disable_unprepare(mdev->clk);
 	return err;
 }
 

