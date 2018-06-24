Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A9C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B225100
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1B225100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeFXPwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:52:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934000AbeFXPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:52:27 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5310C2C;
        Sun, 24 Jun 2018 15:52:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH 4.9 35/39] w1: mxc_w1: Enable clock before calling clk_get_rate() on it
Date:   Sun, 24 Jun 2018 23:24:22 +0800
Message-Id: <20180624152355.955768000@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Potyra <Stefan.Potyra@elektrobit.com>

commit 955bc61328dc0a297fb3baccd84e9d3aee501ed8 upstream.

According to the API, you may only call clk_get_rate() after actually
enabling it.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: a5fd9139f74c ("w1: add 1-wire master driver for i.MX27 / i.MX31")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/w1/masters/mxc_w1.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -113,6 +113,10 @@ static int mxc_w1_probe(struct platform_
 	if (IS_ERR(mdev->clk))
 		return PTR_ERR(mdev->clk);
 
+	err = clk_prepare_enable(mdev->clk);
+	if (err)
+		return err;
+
 	clkrate = clk_get_rate(mdev->clk);
 	if (clkrate < 10000000)
 		dev_warn(&pdev->dev,
@@ -126,12 +130,10 @@ static int mxc_w1_probe(struct platform_
 
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
 
 	/* Software reset 1-Wire module */
 	writeb(MXC_W1_RESET_RST, mdev->regs + MXC_W1_RESET);
@@ -147,8 +149,12 @@ static int mxc_w1_probe(struct platform_
 
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
 


