Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3618ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5824821569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5824821569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391896AbeIVGKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44079 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391848AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BQ-Br; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000q2-7P; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Valentina Manea" <valentina.manea.m@gmail.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.109038403@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 05/63] usbip: fix error handling in stub_probe()
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit 3ff67445750a84de67faaf52c6e1895cb09f2c56 upstream.

If usb_hub_claim_port() fails, no resources are deallocated and
if stub_add_files() fails, port is not released.

The patch fixes these issues and rearranges error handling code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Valentina Manea <valentina.manea.m@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_dev.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -340,7 +340,6 @@ static int stub_probe(struct usb_device
 {
 	struct stub_device *sdev = NULL;
 	const char *udev_busid = dev_name(&udev->dev);
-	int err = 0;
 	struct bus_id_priv *busid_priv;
 	int rc;
 
@@ -401,23 +400,28 @@ static int stub_probe(struct usb_device
 			(struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to claim port\n");
-		return rc;
+		goto err_port;
 	}
 
-	err = stub_add_files(&udev->dev);
-	if (err) {
+	rc = stub_add_files(&udev->dev);
+	if (rc) {
 		dev_err(&udev->dev, "stub_add_files for %s\n", udev_busid);
-		dev_set_drvdata(&udev->dev, NULL);
-		usb_put_dev(udev);
-		kthread_stop_put(sdev->ud.eh);
-
-		busid_priv->sdev = NULL;
-		stub_device_free(sdev);
-		return err;
+		goto err_files;
 	}
 	busid_priv->status = STUB_BUSID_ALLOC;
 
 	return 0;
+err_files:
+	usb_hub_release_port(udev->parent, udev->portnum,
+			     (struct usb_dev_state *) udev);
+err_port:
+	dev_set_drvdata(&udev->dev, NULL);
+	usb_put_dev(udev);
+	kthread_stop_put(sdev->ud.eh);
+
+	busid_priv->sdev = NULL;
+	stub_device_free(sdev);
+	return rc;
 }
 
 static void shutdown_busid(struct bus_id_priv *busid_priv)

