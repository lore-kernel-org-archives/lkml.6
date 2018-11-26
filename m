Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF49E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUMqA6ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF49E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeKZVwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070A32089F;
        Mon, 26 Nov 2018 10:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229914;
        bh=y9Wo10FlwwELj3mTtmjZjrpmPemFWIQgwbQb2WakB1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUMqA6iahy5BL/PZVOy0evZo4+T8TKfTTvhVhP9x2q3R6VATtdWrJ5JKBYFwk6Hkb
         ki7mBl8+xisUdxjVJ73XxHGk/ucHUVrHYzGnQ3wKvl411yDVDWdvtdayMW/wjwVA5m
         r5bD1up6wuK6UbUGw4yNX9fxbAbjB2dbPQClhTq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.9 38/46] USB: quirks: Add no-lpm quirk for Raydium touchscreens
Date:   Mon, 26 Nov 2018 11:51:27 +0100
Message-Id: <20181126105049.687639322@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit deefd24228a172d1b27d4a9adbfd2cdacd60ae64 upstream.

Raydium USB touchscreen fails to set config if LPM is enabled:
[    2.030658] usb 1-8: New USB device found, idVendor=2386, idProduct=3119
[    2.030659] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.030660] usb 1-8: Product: Raydium Touch System
[    2.030661] usb 1-8: Manufacturer: Raydium Corporation
[    7.132209] usb 1-8: can't set config #1, error -110

Same behavior can be observed on 2386:3114.

Raydium claims the touchscreen supports LPM under Windows, so I used
Microsoft USB Test Tools (MUTT) [1] to check its LPM status. MUTT shows
that the LPM doesn't work under Windows, either. So let's just disable LPM
for Raydium touchscreens.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/usbcon/usb-test-tools

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -263,6 +263,11 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* Raydium Touchscreen */
+	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
+
+	{ USB_DEVICE(0x2386, 0x3119), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 


