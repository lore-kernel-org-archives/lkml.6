Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD78C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41DE21902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497629;
	bh=a20BMaYnBzA722S3qoNqAccbMv+ymb/Nr+mq1EVPl3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hLjDylWVhxVlslvqnbw6tGOSaIVuCvokdUewqQxtN4unctQBFHo22Y0B1TNQ/JxLp
	 4KII+PHWaBnaqqzpX1rktjiNSpzS3OIL5WXDyWn50lXG+FozLFVILgPU1YIzNq+HsM
	 5y8RETwLIWxHe2gs+kkK5SMtbZ3nNLXW2+aC8OUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfBRNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbfBRNrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569A3218FC;
        Mon, 18 Feb 2019 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497620;
        bh=a20BMaYnBzA722S3qoNqAccbMv+ymb/Nr+mq1EVPl3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6n2KZXZIb5ZnBNGLpd8hhQsTKefhHaGNhLWO9jUFOSiFQEQ97qi0NESyjxAGUCXs
         fcT6L8ZqPPukZhRO58lSVa01zp5Cs9eKkAlzY6P2yesf7W9KD922BKupvupgYIe5bf
         u+2afnM3vCeYsTa4sPeh3LkdSRk5rv/z8d7a9aXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 49/92] gpio: mxc: move gpio noirq suspend/resume to syscore phase
Date:   Mon, 18 Feb 2019 14:42:52 +0100
Message-Id: <20190218133459.291135962@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 1a5287a3dbc34cd0c02c8f64c9131bd23cdfe2bb upstream.

During noirq suspend/resume phase, GPIO irq could arrive
and its registers like IMR will be changed by irq handle
process, to make the GPIO registers exactly when it is
powered ON after resume, move the GPIO noirq suspend/resume
callback to syscore suspend/resume phase, local irq is
disabled at this phase so GPIO registers are atomic.

Fixes: c19fdaeea0aa ("gpio: mxc: add power management support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Hundebøll <martin@geanix.com>
Cc: <stable@vger.kernel.org> # 4.19.x+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mxc.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 995cf0b9e0b1..2d1dfa1e0745 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 #include <linux/gpio/driver.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -550,33 +551,38 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_port *port)
 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
 }
 
-static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+static int mxc_gpio_syscore_suspend(void)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+	struct mxc_gpio_port *port;
 
-	mxc_gpio_save_regs(port);
-	clk_disable_unprepare(port->clk);
+	/* walk through all ports */
+	list_for_each_entry(port, &mxc_gpio_ports, node) {
+		mxc_gpio_save_regs(port);
+		clk_disable_unprepare(port->clk);
+	}
 
 	return 0;
 }
 
-static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+static void mxc_gpio_syscore_resume(void)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+	struct mxc_gpio_port *port;
 	int ret;
 
-	ret = clk_prepare_enable(port->clk);
-	if (ret)
-		return ret;
-	mxc_gpio_restore_regs(port);
-
-	return 0;
+	/* walk through all ports */
+	list_for_each_entry(port, &mxc_gpio_ports, node) {
+		ret = clk_prepare_enable(port->clk);
+		if (ret) {
+			pr_err("mxc: failed to enable gpio clock %d\n", ret);
+			return;
+		}
+		mxc_gpio_restore_regs(port);
+	}
 }
 
-static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
+static struct syscore_ops mxc_gpio_syscore_ops = {
+	.suspend = mxc_gpio_syscore_suspend,
+	.resume = mxc_gpio_syscore_resume,
 };
 
 static struct platform_driver mxc_gpio_driver = {
@@ -584,7 +590,6 @@ static struct platform_driver mxc_gpio_driver = {
 		.name	= "gpio-mxc",
 		.of_match_table = mxc_gpio_dt_ids,
 		.suppress_bind_attrs = true,
-		.pm = &mxc_gpio_dev_pm_ops,
 	},
 	.probe		= mxc_gpio_probe,
 	.id_table	= mxc_gpio_devtype,
@@ -592,6 +597,8 @@ static struct platform_driver mxc_gpio_driver = {
 
 static int __init gpio_mxc_init(void)
 {
+	register_syscore_ops(&mxc_gpio_syscore_ops);
+
 	return platform_driver_register(&mxc_gpio_driver);
 }
 subsys_initcall(gpio_mxc_init);
-- 
2.19.1



