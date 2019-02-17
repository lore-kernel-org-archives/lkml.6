Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5002147C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="RdTgcbvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBQR7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:59:18 -0500
Received: from erza.pados.hu ([176.9.136.194]:49730 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBQR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=MIME-Version:Date:Subject:To:From:From:Subject:To:
        Content-Type; bh=rIjhwHMBppHfj0QRTpoUxM4Fk8pH4xuVPrjiqbtsbts=; b=RdTgcbvEDg1a
        it7BbYCP/Bfnf399DI8nFdk/yp/dxqdQ5XsJ0riagWvUOhL3WccTZNJwcJliE5WKdeL2erBFsTx1Z
        YTryZGdR1nTMrj2Srqfc23rSr66qwal2wM70ADvMR/spQ1KKasSyDEaEgOw3AlRoJoc8w0UwdzrbQ
        IC8d3hERFn5KzcQRyVN4Dbeh4Ms3+8hQuGkVnTdkSSlCUqcmp2E3gXXK5GDjSGM8OWIDiNbfsMo1C
        h6JJodFPJp6OOaGxAs9Y9MHzbO8+H+5Nu3L9A5LJ+fZl7Ob0s5gZO4xYL0V3xRX08FEU8QE8TVMdc
        L82pQUACEEN+SDAJaVk2jA==;
Received: from 84-236-59-32.pool.digikabel.hu ([84.236.59.32] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1gvQif-0007Ax-QW; Sun, 17 Feb 2019 18:59:14 +0100
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
Date:   Sun, 17 Feb 2019 18:59:01 +0100
Message-Id: <20190217175901.3986-1-pados@pados.hu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Current GPIO code in cp210x fails to take USB autosuspend
   into account, making it practically impossible to use GPIOs with autosuspend
    enabled without user configuration. Fix this like for ftdi_sio in [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 TVD_RCVD_IP            Message was received from an IP address
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was
                             blocked.  See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current GPIO code in cp210x fails to take USB autosuspend into account,
making it practically impossible to use GPIOs with autosuspend enabled
without user configuration. Fix this like for ftdi_sio in a previous patch.
Tested on a CP2102N.

Signed-off-by: Karoly Pados <pados@pados.hu>
---
Changelog:
- v2: Restrict new autopm calls to GPIO paths.
      Always check result of usb_autopm_get.
      Rebased to current usb_serial upstream.

 drivers/usb/serial/cp210x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fac7a4547523..f7aaecad6e21 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1370,8 +1370,13 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	if (priv->partnum == CP210X_PARTNUM_CP2105)
 		req_type = REQTYPE_INTERFACE_TO_HOST;
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		return result;
+
 	result = cp210x_read_vendor_block(serial, req_type,
 					  CP210X_READ_LATCH, &buf, sizeof(buf));
+	usb_autopm_put_interface(serial->interface);
 	if (result < 0)
 		return result;
 
@@ -1392,6 +1397,10 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 
 	buf.mask = BIT(gpio);
 
+	result = usb_autopm_get_interface(serial->interface);
+	if (result)
+		goto out;
+
 	if (priv->partnum == CP210X_PARTNUM_CP2105) {
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
@@ -1399,7 +1408,6 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 						   sizeof(buf));
 	} else {
 		u16 wIndex = buf.state << 8 | buf.mask;
-
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
 					 CP210X_VENDOR_SPECIFIC,
@@ -1409,6 +1417,9 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 					 NULL, 0, USB_CTRL_SET_TIMEOUT);
 	}
 
+	usb_autopm_put_interface(serial->interface);
+
+out:
 	if (result < 0) {
 		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
 				result);
-- 
2.20.1

