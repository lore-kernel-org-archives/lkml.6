Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD1C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA720835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJNXPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36280 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728174AbeJNXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cJ-BQ; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000VP-3G; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "=?UTF-8?q?Bj=C3=B8rn=20Mork?=" <bjorn@mork.no>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.135469311@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 255/366] qmi_wwan: do not steal interfaces from class
 drivers
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bjørn Mork <bjorn@mork.no>

commit 5697db4a696c41601a1d15c1922150b4dbf5726c upstream.

The USB_DEVICE_INTERFACE_NUMBER matching macro assumes that
the { vendorid, productid, interfacenumber } set uniquely
identifies one specific function.  This has proven to fail
for some configurable devices. One example is the Quectel
EM06/EP06 where the same interface number can be either
QMI or MBIM, without the device ID changing either.

Fix by requiring the vendor-specific class for interface number
based matching.  Functions of other classes can and should use
class based matching instead.

Fixes: 03304bcb5ec4 ("net: qmi_wwan: use fixed interface number matching")
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/usb/qmi_wwan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -899,6 +899,18 @@ static int qmi_wwan_probe(struct usb_int
 		id->driver_info = (unsigned long)&qmi_wwan_info;
 	}
 
+	/* There are devices where the same interface number can be
+	 * configured as different functions. We should only bind to
+	 * vendor specific functions when matching on interface number
+	 */
+	if (id->match_flags & USB_DEVICE_ID_MATCH_INT_NUMBER &&
+	    desc->bInterfaceClass != USB_CLASS_VENDOR_SPEC) {
+		dev_dbg(&intf->dev,
+			"Rejecting interface number match for class %02x\n",
+			desc->bInterfaceClass);
+		return -ENODEV;
+	}
+
 	/* Quectel EC20 quirk where we've QMI on interface 4 instead of 0 */
 	if (quectel_ec20_detected(intf) && desc->bInterfaceNumber == 0) {
 		dev_dbg(&intf->dev, "Quectel EC20 quirk, skipping interface 0\n");

