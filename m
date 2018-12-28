Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807902148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999398;
	bh=1f4TOD46ZC+XZHtum0pESaG4xV/cYdNK/uQN0E7QJRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+Q9W4A5uVDkigwxUR6xbaxP5S3Oc44LtyF/9Qov509wk9bpQS/jKyQfL9vUTsv0Y
	 VfpWvF5VKDRFeTobAUdDNnzTq346sPq0GDA5D+jfRMT9Skgd/WwVf9XuYxjhG75MS7
	 TCTOjP051dym3hM5J1UAhMlVtoVQ5OUAys2h7YwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbeL1MQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732693AbeL1MQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E8A2087F;
        Fri, 28 Dec 2018 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999391;
        bh=1f4TOD46ZC+XZHtum0pESaG4xV/cYdNK/uQN0E7QJRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdBh1eO33MTEYM1Yhsa7TRn1+lm1TF2A5zCRqMYPLwk/8C6l894wm+XcLWPYwPXva
         qrv8Tp5zSDpdYp/SGYEDim32ek5SfE/UILCZoRxx5zaWnLa4u5JlP5CQwNq8hx+ES0
         SKCBbTUxc/iEzBgb8gI7kBgWfJVDvycXKB1Hn01g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/36] spi: imx: add a device specific prepare_message callback
Date:   Fri, 28 Dec 2018 12:52:47 +0100
Message-Id: <20181228113128.540899623@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

This is just preparatory work which allows to move some initialisation
that currently is done in the per transfer hook .config to an earlier
point in time in the next few patches. There is no change in behaviour
introduced by this patch.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
[ukleinek: backport to v4.14.x]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d51ca243a028..3fdb0652429b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -72,6 +72,7 @@ struct spi_imx_data;
 
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
+	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
 	int (*config)(struct spi_device *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
@@ -439,6 +440,12 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
+				      struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx51_ecspi_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -599,6 +606,12 @@ static void mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx31_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx31_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -695,6 +708,12 @@ static void mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx21_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx21_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -764,6 +783,12 @@ static void mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx1_prepare_message(struct spi_imx_data *spi_imx,
+			       struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx1_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -798,6 +823,7 @@ static void mx1_reset(struct spi_imx_data *spi_imx)
 
 static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.intctrl = mx1_intctrl,
+	.prepare_message = mx1_prepare_message,
 	.config = mx1_config,
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
@@ -810,6 +836,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -823,6 +850,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	/* i.mx27 cspi shares the functions with i.mx21 one */
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -835,6 +863,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -848,6 +877,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	/* i.mx35 and later cspi shares the functions with i.mx31 one */
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -860,6 +890,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
@@ -872,6 +903,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
@@ -1310,7 +1342,13 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 		return ret;
 	}
 
-	return 0;
+	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
+	if (ret) {
+		clk_disable(spi_imx->clk_ipg);
+		clk_disable(spi_imx->clk_per);
+	}
+
+	return ret;
 }
 
 static int
-- 
2.19.1



