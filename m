Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC08208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVoZhfrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC08208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeK3BTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeK3BTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD45205C9;
        Thu, 29 Nov 2018 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500812;
        bh=jM9tG0yqz747N0irbiQfOSyZVTF3MYXugyN7z3rm3js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVoZhfrlcNvAuWV+zzOY52jDboKLSHPaR3BCub7AYVaqbT4OPRDswx+CPxg2rmwsh
         gtGfEIzweAVNwt1/pOwzm+WwV2Y2PNqFvOmijOlMxKixryekNhqEF2+W3tRiz+sfKA
         E3mojpsnz2u69WjyTAEE8IEJyU37fUBSfvghyib8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3.18 01/83] usb: core: Fix hub port connection events lost
Date:   Thu, 29 Nov 2018 15:11:19 +0100
Message-Id: <20181129140138.094785400@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2765,7 +2765,9 @@ static int hub_port_reset(struct usb_hub
 					USB_PORT_FEAT_C_BH_PORT_RESET);
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_PORT_LINK_STATE);
-			usb_clear_port_feature(hub->hdev, port1,
+
+			if (udev)
+				usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
 
 			/*


