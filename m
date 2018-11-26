Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5626C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC14E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0JB2C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC14E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeKZVwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 862B520817;
        Mon, 26 Nov 2018 10:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229918;
        bh=9A0oIfs6AtOeWHXNVQkW9zkyjuaXotNwSZpS+bERxAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QW0JB2C5uhARKVaxmzgMnAdErXH9MFc1iz2PGQl0SmjfmR9V00YktTTPebBGeaZog
         W02ylkuJDtKSS57F4gagQsjW/5zIVZ+1YoWbJ51GkXfso13fi95T4y0h9vKKi7QwNy
         SKWVg6YhvY2m5d+DgjMVUSEyfa/6JTNhqLtIvrjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
Subject: [PATCH 4.9 39/46] usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB
Date:   Mon, 26 Nov 2018 11:51:28 +0100
Message-Id: <20181126105049.807145914@linuxfoundation.org>
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

From: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>

commit a77112577667cbda7c6292c52d909636aef31fd9 upstream.

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 LUX RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Dmesg output:
usb 1-6: string descriptor 0 read error: -110
usb 1-6: New USB device found, idVendor=1b1c, idProduct=1b33
usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-6: can't set config #1, error -110

Signed-off-by: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -243,6 +243,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* Corsair K70 LUX RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b33), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 


