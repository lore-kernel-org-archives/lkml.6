Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00160C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A3D20665
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 10:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A3D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbeJ0Skh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 14:40:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728434AbeJ0Skg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 14:40:36 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC87C2307E4AD;
        Sat, 27 Oct 2018 18:00:04 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 27 Oct 2018 17:59:52 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tsai <lucas_tsai@richtek.com>,
        shufan_lee <shufan_lee@richtek.com>,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH 08/10] usb: typec: Add support for usb role switch in rt1711h driver
Date:   Sat, 27 Oct 2018 17:58:18 +0800
Message-ID: <20181027095820.40056-9-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181027095820.40056-1-chenyu56@huawei.com>
References: <20181027095820.40056-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add struct device_connection to rt1711h driver to support
find "usb-role-switch" in tcpm_register_port.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lucas Tsai <lucas_tsai@richtek.com>
Cc: shufan_lee <shufan_lee@richtek.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 017389021b96..5f8b952612fe 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -39,6 +39,7 @@ struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct device_connection dev_conn;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -237,6 +238,7 @@ static int rt1711h_probe(struct i2c_client *client,
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const char *dev_conn_end;
 
 	ret = rt1711h_check_revision(client);
 	if (ret < 0) {
@@ -254,6 +256,7 @@ static int rt1711h_probe(struct i2c_client *client,
 		return PTR_ERR(chip->data.regmap);
 
 	chip->dev = &client->dev;
+	dev_set_name(chip->dev, "rt1711h");
 	i2c_set_clientdata(client, chip);
 
 	ret = rt1711h_sw_reset(chip);
@@ -264,6 +267,15 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	ret = device_property_read_string(chip->dev, "dev-conn-end",
+			&dev_conn_end);
+	if (!ret) {
+		chip->dev_conn.endpoint[0] = "rt1711h";
+		chip->dev_conn.endpoint[1] = dev_conn_end;
+		chip->dev_conn.id = "usb-role-switch";
+		device_connection_add(&chip->dev_conn);
+	}
+
 	chip->data.init = rt1711h_init;
 	chip->data.set_vconn = rt1711h_set_vconn;
 	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
@@ -279,6 +291,9 @@ static int rt1711h_remove(struct i2c_client *client)
 	struct rt1711h_chip *chip = i2c_get_clientdata(client);
 
 	tcpci_unregister_port(chip->tcpci);
+	if (chip->dev_conn.id)
+		device_connection_remove(&chip->dev_conn);
+
 	return 0;
 }
 
-- 
2.15.0-rc2

