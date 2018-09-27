Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61E82156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61E82156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeI0PYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:24:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54848 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbeI0PYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:24:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CF0E10A4;
        Thu, 27 Sep 2018 09:07:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fred Veldini <fred.veldini@gmail.com>,
        Deshu Wen <dwen@sierrawireless.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 06/88] qmi_wwan: set DTR for modems in forced USB2 mode
Date:   Thu, 27 Sep 2018 11:02:47 +0200
Message-Id: <20180927090301.334673368@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bj�rn Mork" <bjorn@mork.no>

[ Upstream commit 922005c7f50e7f4b2a6dbc182e9c575b4f92396b ]

Recent firmware revisions have added the ability to force
these modems to USB2 mode, hiding their SuperSpeed
capabilities from the host.  The driver has been using the
SuperSpeed capability, as shown by the bcdUSB field of the
device descriptor, to detect the need to enable the DTR
quirk.  This method fails when the modems are forced to
USB2 mode by the modem firmware.

Fix by unconditionally enabling the DTR quirk for the
affected device IDs.

Reported-by: Fred Veldini <fred.veldini@gmail.com>
Reported-by: Deshu Wen <dwen@sierrawireless.com>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Reported-by: Fred Veldini <fred.veldini@gmail.com>
Reported-by: Deshu Wen <dwen@sierrawireless.com>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1206,13 +1206,13 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1199, 0x9061, 8)},	/* Sierra Wireless Modem */
 	{QMI_FIXED_INTF(0x1199, 0x9063, 8)},	/* Sierra Wireless EM7305 */
 	{QMI_FIXED_INTF(0x1199, 0x9063, 10)},	/* Sierra Wireless EM7305 */
-	{QMI_FIXED_INTF(0x1199, 0x9071, 8)},	/* Sierra Wireless MC74xx */
-	{QMI_FIXED_INTF(0x1199, 0x9071, 10)},	/* Sierra Wireless MC74xx */
-	{QMI_FIXED_INTF(0x1199, 0x9079, 8)},	/* Sierra Wireless EM74xx */
-	{QMI_FIXED_INTF(0x1199, 0x9079, 10)},	/* Sierra Wireless EM74xx */
-	{QMI_FIXED_INTF(0x1199, 0x907b, 8)},	/* Sierra Wireless EM74xx */
-	{QMI_FIXED_INTF(0x1199, 0x907b, 10)},	/* Sierra Wireless EM74xx */
-	{QMI_FIXED_INTF(0x1199, 0x9091, 8)},	/* Sierra Wireless EM7565 */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x9071, 8)},	/* Sierra Wireless MC74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x9071, 10)},/* Sierra Wireless MC74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x9079, 8)},	/* Sierra Wireless EM74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x9079, 10)},/* Sierra Wireless EM74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x907b, 8)},	/* Sierra Wireless EM74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x907b, 10)},/* Sierra Wireless EM74xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x9091, 8)},	/* Sierra Wireless EM7565 */
 	{QMI_FIXED_INTF(0x1bbb, 0x011e, 4)},	/* Telekom Speedstick LTE II (Alcatel One Touch L100V LTE) */
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */


