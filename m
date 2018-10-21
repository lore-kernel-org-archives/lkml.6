Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39262ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A43A20652
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A43A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeJVERB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:17:01 -0400
Received: from sauhun.de ([88.99.104.3]:45990 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbeJVEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:30 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id EC7642E35DF;
        Sun, 21 Oct 2018 22:01:01 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 1/1] tty: serial: qcom_geni_serial: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:59 +0200
Message-Id: <20181021200059.2294-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200059.2294-1-wsa+renesas@sang-engineering.com>
References: <20181021200059.2294-1-wsa+renesas@sang-engineering.com>
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

 drivers/tty/serial/qcom_geni_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..4c9dbfe96c1a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -162,8 +162,7 @@ static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 static ssize_t loopback_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 
 	return snprintf(buf, sizeof(u32), "%d\n", port->loopback);
 }
@@ -172,8 +171,7 @@ static ssize_t loopback_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t size)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	u32 loopback;
 
 	if (kstrtoint(buf, 0, &loopback) || loopback > MAX_LOOPBACK_CFG) {
-- 
2.19.0

