Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA327C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7472089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866918;
	bh=wnX4O+ElyuOy1hyN/XYyEF910kwjU4+bzWmgg3X7BzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uS54THz+3yVdZqSdTtBfS5zDPxfpV9OO5bLjJ74w3iO7MpDPyP37SJUuB3e/om2Aj
	 LBrY4gRyWSKBzxitsbC8YRIElf3fPPsXPtOJbp2Tp1M1ErnfovLiBBBybOUmwwERGw
	 uPs/9Lu7EdXfpOKQgitnP0qbt0+vAva3wlW50qPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfAGNPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730714AbfAGNCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E7E206BB;
        Mon,  7 Jan 2019 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866120;
        bh=wnX4O+ElyuOy1hyN/XYyEF910kwjU4+bzWmgg3X7BzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiwoWDejydC2nVZfQLcC3RLX0DwL5Ahqx53ouTdK5RdODb2Fl1qoTYUJTBB1amLig
         Ul3vz3t6bgpWlH7wkEyNizcdyqTE2gOKtqhKa2zhue0I3eIt/a5WARInxI/e3SQkto
         5DFLN7nKs9B1y95zlzODnDAa1RzRaUUFJaMKRzjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Sjoholm <sebastian.sjoholm@gmail.com>,
        Reinhard Speyerer <rspmn@arcor.de>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 053/101] qmi_wwan: apply SET_DTR quirk to the SIMCOM shared device ID
Date:   Mon,  7 Jan 2019 13:32:41 +0100
Message-Id: <20190107105335.821033866@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Bjørn Mork <bjorn@mork.no>

commit 102cd909635612c0be784a519651954a7924c786 upstream.

SIMCOM are reusing a single device ID for many (all of their?)
different modems, based on different chipsets and firmwares. Newer
Qualcomm chipset generations require setting DTR to wake the QMI
function.  The SIM7600E modem is using such a chipset, making it
fail to work with this driver despite the device ID match.

Fix by unconditionally enabling the SET_DTR quirk for all SIMCOM
modems using this specific device ID.  This is similar to what
we already have done for another case of device IDs recycled over
multiple chipset generations: 14cf4a771b30 ("drivers: net: usb:
qmi_wwan: add QMI_QUIRK_SET_DTR for Telit PID 0x1201")

Initial testing on an older SIM7100 modem shows no immediate side
effects.

Reported-by: Sebastian Sjoholm <sebastian.sjoholm@gmail.com>
Cc: Reinhard Speyerer <rspmn@arcor.de>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/qmi_wwan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1252,7 +1252,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x03f0, 0x4e1d, 8)},	/* HP lt4111 LTE/EV-DO/HSPA+ Gobi 4G Module */
 	{QMI_FIXED_INTF(0x03f0, 0x9d1d, 1)},	/* HP lt4120 Snapdragon X5 LTE */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
-	{QMI_FIXED_INTF(0x1e0e, 0x9001, 5)},	/* SIMCom 7230E */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */


