Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3423C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4BC21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866199;
	bh=TVDN2ykqWGbFWIl08st6vrWQDk/46mPtASMS9yGhdtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4PsglqRmbZu1hdxivx7LiXEhMSI/1rFSvKK+zY9tSps/fmpBHdWLTCWN5CpA8MtH
	 eml99XugBSaw4Ur0ukSjIuLSHpDiYC6lm19G2yZwojKbBOiksqArTBCe1RnTwbj5z0
	 yKKdz4vHhLoYDnM3tfFwCR3JDhh8SYfpKM/pxf9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfAGNDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730522AbfAGNDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD54F206BB;
        Mon,  7 Jan 2019 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866195;
        bh=TVDN2ykqWGbFWIl08st6vrWQDk/46mPtASMS9yGhdtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11Yt7YlYOO9Vu/LBYLQLUVRUy7b2vcvZjpckexs3qQjRbO9Us62l2kpsMne/P0RC6
         fVnM0rS085T+wP6jKoA/EFPL5Mq3GKYPwg3/vCQgHvtPNqlr+8ezFadUytEuOB5MUG
         Dqxj+YOHU6huk82GUUHJY3QoLFjTz2gYzdA9LbQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>,
        Johan Hovold <johan@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 076/101] cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.
Date:   Mon,  7 Jan 2019 13:33:04 +0100
Message-Id: <20190107105337.131531897@linuxfoundation.org>
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
@@ -593,6 +593,13 @@ static int acm_tty_install(struct tty_dr
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
@@ -1685,6 +1692,9 @@ static const struct usb_device_id acm_id
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
@@ -140,3 +140,4 @@ struct acm {
 #define QUIRK_CONTROL_LINE_STATE	BIT(6)
 #define CLEAR_HALT_CONDITIONS		BIT(7)
 #define SEND_ZERO_PACKET		BIT(8)
+#define DISABLE_ECHO			BIT(9)


