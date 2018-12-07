Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42151C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49A20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE49A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLGCmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:42:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbeLGCmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:42:37 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 56F728CE3A4AF;
        Fri,  7 Dec 2018 10:42:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 7 Dec 2018 10:42:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] USB: serial: mos7840: remove set but not used variables 'number, serial'
Date:   Fri, 7 Dec 2018 02:50:42 +0000
Message-ID: <1544151042-120303-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/usb/serial/mos7840.c: In function 'mos7840_send_cmd_write_baud_rate':
drivers/usb/serial/mos7840.c:1584:16: warning:
 variable 'number' set but not used [-Wunused-but-set-variable]

drivers/usb/serial/mos7840.c: In function 'mos7840_change_port_settings':
drivers/usb/serial/mos7840.c:1695:21: warning:
 variable 'serial' set but not used [-Wunused-but-set-variable]

'number' never used since introduction in commit 3f5429746d91 ("USB: Moschip
7840 USB-Serial Driver")

'serial' not used since commit 5833041f1b13 ("USB: serial: remove unnecessary
reinitialisations of urb->dev")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/serial/mos7840.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 6ff6d67..a698d46 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1581,7 +1581,6 @@ static int mos7840_send_cmd_write_baud_rate(struct moschip_port *mos7840_port,
 	int divisor = 0;
 	int status;
 	__u16 Data;
-	unsigned char number;
 	__u16 clk_sel_val;
 	struct usb_serial_port *port;
 
@@ -1595,8 +1594,6 @@ static int mos7840_send_cmd_write_baud_rate(struct moschip_port *mos7840_port,
 	if (mos7840_serial_paranoia_check(port->serial, __func__))
 		return -1;
 
-	number = mos7840_port->port->port_number;
-
 	dev_dbg(&port->dev, "%s - baud = %d\n", __func__, baudRate);
 	/* reset clk_uart_sel in spregOffset */
 	if (baudRate > 115200) {
@@ -1692,7 +1689,6 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 	int status;
 	__u16 Data;
 	struct usb_serial_port *port;
-	struct usb_serial *serial;
 
 	if (mos7840_port == NULL)
 		return;
@@ -1705,8 +1701,6 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 	if (mos7840_serial_paranoia_check(port->serial, __func__))
 		return;
 
-	serial = port->serial;
-
 	if (!mos7840_port->open) {
 		dev_dbg(&port->dev, "%s - port not opened\n", __func__);
 		return;



