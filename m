Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D2DC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19F2206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19F2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJCMFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:05:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeJCMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:05:16 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g7ZYJ-00027N-A9; Wed, 03 Oct 2018 05:18:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] usb: core: Check portchange C_PORT_RESET after resetting
Date:   Wed,  3 Oct 2018 13:18:22 +0800
Message-Id: <20181003051822.4011-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on USB2.0 Spec Section 11.24.2.7.2.5:

  "This bit is set when the port transitions from the Resetting state (or,
  if present, the Speed_eval state) to the Enabled state."

Also Section 11.24.2.13:

  "Setting the reset feature PORT_RESET causes the hub to signal reset on
  that port. When the reset signaling is complete, the hub sets the
  C_PORT_RESET status change and immediately enables the port."

So let's also check C_PORT_RESET for reset completion.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7801bb30bdba..d96058372280 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2721,7 +2721,8 @@ static int hub_port_wait_reset(struct usb_hub *hub, int port1,
 		 * so also wait for the connection to be re-established.
 		 */
 		if (!(portstatus & USB_PORT_STAT_RESET) &&
-		    (portstatus & USB_PORT_STAT_CONNECTION))
+		    (portstatus & USB_PORT_STAT_CONNECTION) &&
+		    (portchange & USB_PORT_STAT_C_RESET))
 			break;
 
 		/* switch to the long delay after two short delay failures */
-- 
2.17.1

