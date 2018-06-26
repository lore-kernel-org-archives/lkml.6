Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E30BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AD82650A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AD82650A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964847AbeF0ALQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:11:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:45130 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932283AbeF0ALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:11:14 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qc022979;
        Tue, 26 Jun 2018 18:26:41 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/14] fsi: master-gpio: Add support for link_config
Date:   Wed, 27 Jun 2018 09:25:56 +1000
Message-Id: <20180626232605.13420-6-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To configure the send and echo delays

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 836587701ceb..48e0e65b2982 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -64,6 +64,8 @@ struct fsi_master_gpio {
 	bool			external_mode;
 	bool			no_delays;
 	uint32_t		last_addr;
+	uint8_t			t_send_delay;
+	uint8_t			t_echo_delay;
 };
 
 #define CREATE_TRACE_POINTS
@@ -338,7 +340,7 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 static void echo_delay(struct fsi_master_gpio *master)
 {
 	set_sda_output(master, 1);
-	clock_toggle(master, FSI_ECHO_DELAY_CLOCKS);
+	clock_toggle(master, master->t_echo_delay);
 }
 
 static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
@@ -540,7 +542,7 @@ static int poll_for_response(struct fsi_master_gpio *master,
 	 * from receive of response back to send of data.
 	 */
 	local_irq_save(flags);
-	clock_zeros(master, FSI_SEND_DELAY_CLOCKS);
+	clock_zeros(master, master->t_send_delay);
 	local_irq_restore(flags);
 
 	return rc;
@@ -728,6 +730,22 @@ static int fsi_master_gpio_link_enable(struct fsi_master *_master, int link)
 	return rc;
 }
 
+static int fsi_master_gpio_link_config(struct fsi_master *_master, int link,
+				       u8 t_send_delay, u8 t_echo_delay)
+{
+	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
+
+	if (link != 0)
+		return -ENODEV;
+
+	mutex_lock(&master->cmd_lock);
+	master->t_send_delay = t_send_delay;
+	master->t_echo_delay = t_echo_delay;
+	mutex_unlock(&master->cmd_lock);
+
+	return 0;
+}
+
 static ssize_t external_mode_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -832,6 +850,10 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	 */
 	master->no_delays = device_property_present(&pdev->dev, "no-gpio-delays");
 
+	/* Default FSI command delays */
+	master->t_send_delay = FSI_SEND_DELAY_CLOCKS;
+	master->t_echo_delay = FSI_ECHO_DELAY_CLOCKS;
+
 	master->master.n_links = 1;
 	master->master.flags = FSI_MASTER_FLAG_SWCLOCK;
 	master->master.read = fsi_master_gpio_read;
@@ -839,6 +861,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->master.term = fsi_master_gpio_term;
 	master->master.send_break = fsi_master_gpio_break;
 	master->master.link_enable = fsi_master_gpio_link_enable;
+	master->master.link_config = fsi_master_gpio_link_config;
 	platform_set_drvdata(pdev, master);
 	mutex_init(&master->cmd_lock);
 
-- 
2.17.1

