Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5357A2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5357A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933604AbeGIPky (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:40:54 -0400
Received: from gateway36.websitewelcome.com ([192.185.187.5]:20752 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932628AbeGIPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:40:51 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 5CE2C400CB899
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 09:41:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cYHTf2A8JbXuJcYHTfBXHS; Mon, 09 Jul 2018 10:40:51 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=45610 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fcYHS-0010mx-7d; Mon, 09 Jul 2018 10:40:50 -0500
Date:   Mon, 9 Jul 2018 10:40:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: usb: hso: use swap macro in hso_kick_transmit
Message-ID: <20180709154048.GA32345@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fcYHS-0010mx-7d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:45610
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the swap macro and remove unnecessary variable *temp*.
This makes the code easier to read and maintain. Also, slightly
refactor some code due to the removal of *temp*.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/usb/hso.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index de305ea..78d128e 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1732,7 +1732,6 @@ static int hso_serial_ioctl(struct tty_struct *tty,
 /* starts a transmit */
 static void hso_kick_transmit(struct hso_serial *serial)
 {
-	u8 *temp;
 	unsigned long flags;
 	int res;
 
@@ -1748,14 +1747,11 @@ static void hso_kick_transmit(struct hso_serial *serial)
 		goto out;
 
 	/* Switch pointers around to avoid memcpy */
-	temp = serial->tx_buffer;
-	serial->tx_buffer = serial->tx_data;
-	serial->tx_data = temp;
+	swap(serial->tx_buffer, serial->tx_data);
 	serial->tx_data_count = serial->tx_buffer_count;
 	serial->tx_buffer_count = 0;
 
-	/* If temp is set, it means we switched buffers */
-	if (temp && serial->write_data) {
+	if (serial->write_data) {
 		res = serial->write_data(serial);
 		if (res >= 0)
 			serial->tx_urb_used = 1;
-- 
2.7.4

