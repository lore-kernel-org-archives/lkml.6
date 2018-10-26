Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A164C20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A164C20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJZVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:02:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727491AbeJZVC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:02:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69A37E6B1F381;
        Fri, 26 Oct 2018 20:25:59 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 26 Oct 2018
 20:25:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <johan@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] USB: serial: mos7840: remove set but not used variables 'st, data1, iflag'
Date:   Fri, 26 Oct 2018 20:25:49 +0800
Message-ID: <20181026122549.19036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/usb/serial/mos7840.c: In function 'mos7840_interrupt_callback':
drivers/usb/serial/mos7840.c:604:14: warning:
 variable 'st' set but not used [-Wunused-but-set-variable]

drivers/usb/serial/mos7840.c: In function 'mos7840_write':
drivers/usb/serial/mos7840.c:1303:17: warning:
 variable 'data1' set but not used [-Wunused-but-set-variable]

drivers/usb/serial/mos7840.c:1700:11: warning:
 variable 'iflag' set but not used [-Wunused-but-set-variable]

They are never used since introduction in
commit 3f5429746d91 ("USB: Moschip 7840 USB-Serial Driver")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/serial/mos7840.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 88828b4..bfbf75b 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -601,7 +601,7 @@ static void mos7840_interrupt_callback(struct urb *urb)
 	struct usb_serial *serial;
 	__u16 Data;
 	unsigned char *data;
-	__u8 sp[5], st;
+	__u8 sp[5];
 	int i, rv = 0;
 	__u16 wval, wreg = 0;
 	int status = urb->status;
@@ -644,7 +644,6 @@ static void mos7840_interrupt_callback(struct urb *urb)
 	sp[1] = (__u8) data[1];
 	sp[2] = (__u8) data[2];
 	sp[3] = (__u8) data[3];
-	st = (__u8) data[4];
 
 	for (i = 0; i < serial->num_ports; i++) {
 		mos7840_port = mos7840_get_port_private(serial->port[i]);
@@ -1300,7 +1299,6 @@ static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
 	struct urb *urb;
 	/* __u16 Data; */
 	const unsigned char *current_position = data;
-	unsigned char *data1;
 
 	if (mos7840_port_paranoia_check(port, __func__))
 		return -1;
@@ -1361,7 +1359,6 @@ static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
 			mos7840_bulk_out_data_callback, mos7840_port);
 	}
 
-	data1 = urb->transfer_buffer;
 	dev_dbg(&port->dev, "bulkout endpoint is %d\n", port->bulk_out_endpointAddress);
 
 	if (mos7840_port->has_led)
@@ -1697,7 +1694,6 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 {
 	int baud;
 	unsigned cflag;
-	unsigned iflag;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
@@ -1729,7 +1725,6 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 	lParity = LCR_PAR_NONE;
 
 	cflag = tty->termios.c_cflag;
-	iflag = tty->termios.c_iflag;
 
 	/* Change the number of bits */
 	switch (cflag & CSIZE) {
-- 
2.7.0


