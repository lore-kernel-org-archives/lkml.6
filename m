Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DE4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F5E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216474;
	bh=+8bnEF3Qj6Vv9Ay0hcuuYFkwcWYH/2+Xe7fvK/GTWtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQRJcTXgtnU5fQVGvig5RkCbLKB7DAaHzJtk242+n+g989hoDTWhKWbNwJ62+Hq2E
	 EsJ54+ymQsfuKyGS1A2cX/bKn5rhlHdj1W3tfeuyUfHh0it4dlVvNliA3Z1k/cd3Q6
	 ztD5VlZ7jPcaex8FOml20fofP1rjYYJTgwqqLoeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfAKOUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfAKOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:20:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6E62177B;
        Fri, 11 Jan 2019 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216401;
        bh=+8bnEF3Qj6Vv9Ay0hcuuYFkwcWYH/2+Xe7fvK/GTWtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1DACgPxvKaHKBXTSGFAEphdJ1yF5rdbMNPK2m8W9g/2RUxkSCc7j7R+Pt9wRa7sE
         urGmN2OOlmeMSGuksO68jLEJ0YeTWmZvuiM+OGPw3eP0gBSPv10zLkMoqY78NWtwOh
         geeNDDE7kiX2FqYLY7bGtRNbpgv3KgB7nowCkIy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>,
        Johan Hovold <johan@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.4 49/88] cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.
Date:   Fri, 11 Jan 2019 15:08:18 +0100
Message-Id: <20190111131053.347555508@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit eafb27fa5283599ce6c5492ea18cf636a28222bb upstream.

Mediatek Preloader is a proprietary embedded boot loader for loading
Little Kernel and Linux into device DRAM.

This boot loader also handle firmware update. Mediatek Preloader will be
enumerated as a virtual COM port when the device is connected to Windows
or Linux OS via CDC-ACM class driver. When the USB enumeration has been
done, Mediatek Preloader will send out handshake command "READY" to PC
actively instead of waiting command from the download tool.

Since Linux 4.12, the commit "tty: reset termios state on device
registration" (93857edd9829e144acb6c7e72d593f6e01aead66) causes Mediatek
Preloader receiving some abnoraml command like "READYXX" as it sent.
This will be recognized as an incorrect response. The behavior change
also causes the download handshake fail. This change only affects
subsequent connects if the reconnected device happens to get the same minor
number.

By disabling the ECHO termios flag could avoid this problem. However, it
cannot be done by user space configuration when download tool open
/dev/ttyACM0. This is because the device running Mediatek Preloader will
send handshake command "READY" immediately once the CDC-ACM driver is
ready.

This patch wants to fix above problem by introducing "DISABLE_ECHO"
property in driver_info. When Mediatek Preloader is connected, the
CDC-ACM driver could disable ECHO flag in termios to avoid the problem.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |   10 ++++++++++
 drivers/usb/class/cdc-acm.h |    1 +
 2 files changed, 11 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -507,6 +507,13 @@ static int acm_tty_install(struct tty_dr
 	if (retval)
 		goto error_init_termios;
 
+	/*
+	 * Suppress initial echoing for some devices which might send data
+	 * immediately after acm driver has been installed.
+	 */
+	if (acm->quirks & DISABLE_ECHO)
+		tty->termios.c_lflag &= ~ECHO;
+
 	tty->driver_data = acm;
 
 	return 0;
@@ -1677,6 +1684,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x0e8d, 0x0003), /* FIREFLY, MediaTek Inc; andrey.arapov@gmail.com */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0e8d, 0x2000), /* MediaTek Inc Preloader */
+	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x0e8d, 0x3329), /* MediaTek Inc GPS */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -134,3 +134,4 @@ struct acm {
 #define QUIRK_CONTROL_LINE_STATE	BIT(6)
 #define CLEAR_HALT_CONDITIONS		BIT(7)
 #define SEND_ZERO_PACKET		BIT(8)
+#define DISABLE_ECHO			BIT(9)


