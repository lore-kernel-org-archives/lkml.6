Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A702C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F75021855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfAXN7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:59:40 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:51430 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbfAXN7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:59:39 -0500
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 08:59:39 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 9032015AC5; Thu, 24 Jan 2019 13:52:13 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: cp210x: support all gpios on CP2102N QFN28 package
Date:   Thu, 24 Jan 2019 13:48:39 +0000
Message-Id: <20190124134839.13316-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QFN28 package version of the CP2102N has three additional gpio pins.
Add support for these.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/serial/cp210x.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c0777a374a88..336a3c0f9f2c 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1574,12 +1574,6 @@ static int cp2102n_gpioconf_init(struct usb_serial *serial)
 	if (config_version != 0x01)
 		return -ENOTSUPP;
 
-	/*
-	 * We only support 4 GPIOs even on the QFN28 package, because
-	 * config locations of GPIOs 4-6 determined using reverse
-	 * engineering revealed conflicting offsets with other
-	 * documented functions. So we'll just play it safe for now.
-	 */
 	priv->gc.ngpio = 4;
 
 	/*
@@ -1594,6 +1588,19 @@ static int cp2102n_gpioconf_init(struct usb_serial *serial)
 	/* 0 indicates GPIO mode, 1 is alternate function */
 	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0f;
 
+	if (priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) {
+		/*
+		 * For the QFN28 package, GPIO4-6 are controlled by
+		 * the low three bits of the mode/latch fields.
+		 * Contrary to the document linked above, the bits for
+		 * the SUSPEND pins are elsewhere.  No alternate
+		 * function is available for these pins.
+		 */
+		priv->gc.ngpio = 7;
+		gpio_latch |= (gpio_rst_latch & 7) << 4;
+		priv->gpio_pushpull |= (gpio_pushpull & 7) << 4;
+	}
+
 	/*
 	 * The CP2102N does not strictly has input and output pin modes,
 	 * it only knows open-drain and push-pull modes which is set at
-- 
2.20.1

