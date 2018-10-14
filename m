Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C322C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF7520876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF7520876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJNXPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36303 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbeJNXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004co-Fm; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000Uv-P1; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.983011955@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 249/366] USB: serial: visor: handle potential invalid
 device configuration
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 4842ed5bfcb9daf6660537d70503c18d38dbdbb8 upstream.

If we get an invalid device configuration from a palm 3 type device, we
might incorrectly parse things, and we have the potential to crash in
"interesting" ways.

Fix this up by verifying the size of the configuration passed to us by
the device, and only if it is correct, will we handle it.

Note that this also fixes an information leak of slab data.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ johan: add comment about the info leak ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/visor.c | 69 +++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -338,47 +338,48 @@ static int palm_os_3_probe(struct usb_se
 		goto exit;
 	}
 
-	if (retval == sizeof(*connection_info)) {
-			connection_info = (struct visor_connection_info *)
-							transfer_buffer;
-
-		num_ports = le16_to_cpu(connection_info->num_ports);
-		for (i = 0; i < num_ports; ++i) {
-			switch (
-			   connection_info->connections[i].port_function_id) {
-			case VISOR_FUNCTION_GENERIC:
-				string = "Generic";
-				break;
-			case VISOR_FUNCTION_DEBUGGER:
-				string = "Debugger";
-				break;
-			case VISOR_FUNCTION_HOTSYNC:
-				string = "HotSync";
-				break;
-			case VISOR_FUNCTION_CONSOLE:
-				string = "Console";
-				break;
-			case VISOR_FUNCTION_REMOTE_FILE_SYS:
-				string = "Remote File System";
-				break;
-			default:
-				string = "unknown";
-				break;
-			}
-			dev_info(dev, "%s: port %d, is for %s use\n",
-				serial->type->description,
-				connection_info->connections[i].port, string);
-		}
+	if (retval != sizeof(*connection_info)) {
+		dev_err(dev, "Invalid connection information received from device\n");
+		retval = -ENODEV;
+		goto exit;
 	}
-	/*
-	* Handle devices that report invalid stuff here.
-	*/
+
+	connection_info = (struct visor_connection_info *)transfer_buffer;
+
+	num_ports = le16_to_cpu(connection_info->num_ports);
+
+	/* Handle devices that report invalid stuff here. */
 	if (num_ports == 0 || num_ports > 2) {
 		dev_warn(dev, "%s: No valid connect info available\n",
 			serial->type->description);
 		num_ports = 2;
 	}
 
+	for (i = 0; i < num_ports; ++i) {
+		switch (connection_info->connections[i].port_function_id) {
+		case VISOR_FUNCTION_GENERIC:
+			string = "Generic";
+			break;
+		case VISOR_FUNCTION_DEBUGGER:
+			string = "Debugger";
+			break;
+		case VISOR_FUNCTION_HOTSYNC:
+			string = "HotSync";
+			break;
+		case VISOR_FUNCTION_CONSOLE:
+			string = "Console";
+			break;
+		case VISOR_FUNCTION_REMOTE_FILE_SYS:
+			string = "Remote File System";
+			break;
+		default:
+			string = "unknown";
+			break;
+		}
+		dev_info(dev, "%s: port %d, is for %s use\n",
+			serial->type->description,
+			connection_info->connections[i].port, string);
+	}
 	dev_info(dev, "%s: Number of ports: %d\n", serial->type->description,
 		num_ports);
 

