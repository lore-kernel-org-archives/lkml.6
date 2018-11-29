Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A22146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="udHnXzWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522A22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbeK3BaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbeK3BaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9AB21104;
        Thu, 29 Nov 2018 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501477;
        bh=n9DJN1Oty99bkT1IuSc7bNCie40ugdXeimF7j/GmC84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udHnXzWF0wm3n9nj4oTgwkS7HR493FssMrioy7EZXJQMp9DL+X3O07bpXlZGOX47q
         FHRVdT2GIAXpwgPtbK50LCSgyOXTUROPzjvdOysS8+ng5yP7x8N+LwrDqo2tt8XnoG
         M9l3qLQNelY0BAdxTBsdcu5zun7BlAOG6i/oQy2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 006/100] usb: core: Fix hub port connection events lost
Date:   Thu, 29 Nov 2018 15:11:36 +0100
Message-Id: <20181129140059.440780027@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit 22454b79e6de05fa61a2a72d00d2eed798abbb75 upstream.

This will clear the USB_PORT_FEAT_C_CONNECTION bit in case of a hub port reset
only if a device is was attached to the hub port before resetting the hub port.

Using a Lenovo T480s attached to the ultra dock it was not possible to detect
some usb-c devices at the dock usb-c ports because the hub_port_reset code
will clear the USB_PORT_FEAT_C_CONNECTION bit after the actual hub port reset.
Using this device combo the USB_PORT_FEAT_C_CONNECTION bit was set between the
actual hub port reset and the clear of the USB_PORT_FEAT_C_CONNECTION bit.
This ends up with clearing the USB_PORT_FEAT_C_CONNECTION bit after the
new device was attached such that it was not detected.

This patch will not clear the USB_PORT_FEAT_C_CONNECTION bit if there is
currently no device attached to the port before the hub port reset.
This will avoid clearing the connection bit for new attached devices.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub
 					USB_PORT_FEAT_C_BH_PORT_RESET);
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_PORT_LINK_STATE);
-			usb_clear_port_feature(hub->hdev, port1,
+
+			if (udev)
+				usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
 
 			/*


