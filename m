Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B3C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC912089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HIf4o9S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC912089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKKJHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:07:32 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55612 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeKKJHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 04:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjVFlkSgk0BDTgQVRpr/2/qyl7ykVo0DO2kAtXSunjo=; b=HIf4o9S0jhybQUpDBlhogfd2Pn
        NZtHe/0Sk2p+xwG6WvabrRAX1RVQf9GDRtxEjdA4yd/z33BQtOulYqZz8yqUby80/wW5vGZ8ESfGZ
        aQivKC4uSw5OCpx22oklzpddC1UkCBu4P0KD1dOHxxJAe9zndI2YrIrOLc0DuxsLiCWs=;
Received: from p200300ccfbcefb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbce:fb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLcYZ-0002U6-Ia; Sun, 11 Nov 2018 00:20:47 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLcYZ-0004rX-23; Sun, 11 Nov 2018 00:20:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
Date:   Sun, 11 Nov 2018 00:20:34 +0100
Message-Id: <20181110232034.17277-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first try to be able to use h4 devices specified in
the devicetree, so you do not need to call hciattach and
it can be automatically probed.

Of course, proper devicetree bindings documentation is
missing. And also you would extend that by regulator/
enable gpio settings.

But before proceeding further it should be checked if the
general way of doing things is right.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/bluetooth/hci_h4.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fb97a3bf069b..8df0611d976c 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -39,6 +39,8 @@
 #include <linux/string.h>
 #include <linux/signal.h>
 #include <linux/ioctl.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
 #include <linux/skbuff.h>
 #include <asm/unaligned.h>
 
@@ -47,6 +49,11 @@
 
 #include "hci_uart.h"
 
+struct h4_device {
+	struct hci_uart hu;
+	bool flow;
+};
+
 struct h4_struct {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
@@ -146,9 +153,76 @@ static struct sk_buff *h4_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&h4->txq);
 }
 
+#if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
+static int h4_setup(struct hci_uart *hu)
+{
+	struct h4_device *h4dev;
+	struct serdev_device *serdev = hu->serdev;
+
+	if (!serdev)
+		return 0;
+
+	h4dev = serdev_device_get_drvdata(serdev);
+
+	serdev_device_set_flow_control(serdev, h4dev->flow);
+
+	return 0;
+}
+
+static const struct hci_uart_proto h4p;
+
+static int hci_h4_probe(struct serdev_device *serdev)
+{
+	struct hci_uart *hu;
+	struct h4_device *h4dev;
+	u32 speed = 3000000;
+
+	h4dev = devm_kzalloc(&serdev->dev, sizeof(struct h4_device),
+			     GFP_KERNEL);
+	if (!h4dev)
+		return -ENOMEM;
+	hu = &h4dev->hu;
+
+	serdev_device_set_drvdata(serdev, h4dev);
+	hu->serdev = serdev;
+
+	h4dev->flow = of_property_read_bool(serdev->dev.of_node, "flow");
+
+	of_property_read_u32(serdev->dev.of_node, "speed", &speed);
+	hci_uart_set_speeds(hu, speed, speed);
+
+	return hci_uart_register_device(hu, &h4p);
+}
+
+static void hci_h4_remove(struct serdev_device *serdev)
+{
+	struct h4_device *h4dev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&h4dev->hu);
+}
+
+static const struct of_device_id hci_h4_of_match[] = {
+	{ .compatible = "wi2wi,w2cbw003-bluetooth"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hci_h4_of_match);
+
+static struct serdev_device_driver hci_h4_drv = {
+	.driver		= {
+		.name	= "hci-h4",
+		.of_match_table = of_match_ptr(hci_h4_of_match),
+	},
+	.probe = hci_h4_probe,
+	.remove = hci_h4_remove
+};
+#else
+#define h4_setup NULL
+#endif
+
 static const struct hci_uart_proto h4p = {
 	.id		= HCI_UART_H4,
 	.name		= "H4",
+	.setup		= h4_setup,
 	.open		= h4_open,
 	.close		= h4_close,
 	.recv		= h4_recv,
@@ -159,11 +233,15 @@ static const struct hci_uart_proto h4p = {
 
 int __init h4_init(void)
 {
+	serdev_device_driver_register(&hci_h4_drv);
+
 	return hci_uart_register_proto(&h4p);
 }
 
 int __exit h4_deinit(void)
 {
+	serdev_device_driver_unregister(&hci_h4_drv);
+
 	return hci_uart_unregister_proto(&h4p);
 }
 
-- 
2.11.0

