Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A805920989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yR6aj+ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A805920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeKZV7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZV7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC3520672;
        Mon, 26 Nov 2018 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230362;
        bh=9cZ7MMMvudXd3+I4SNGAEsjP0YKa5FiguHeHTk+x1x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yR6aj+evBsoQEFoD5bFQ6avWQs2f6ktunCoS5A61ELW32UuD1scTR/qSw79V7CT4W
         +J4JCSbWoc00p7Pdf9DgTd2EeLsOw00sGm/8suXxJs/bj+6jmcs6inM9GFF670m/LF
         3J2+Fb+40RwwRU4vg2z8X9Pei18Ak0UP6RaluRmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
Subject: [PATCH 4.19 106/118] usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB
Date:   Mon, 26 Nov 2018 11:51:40 +0100
Message-Id: <20181126105105.953904015@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -397,6 +397,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* Corsair K70 LUX RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b33), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 


