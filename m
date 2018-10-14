Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE6C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF14920835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF14920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJNXMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36347 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728221AbeJNXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cg-Ft; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000VU-4v; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Elvinas" <elvinas@veikia.lt>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.703289047@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 256/366] USB: Accept bulk endpoints with 1024-byte
 maxpacket
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

From: Alan Stern <stern@rowland.harvard.edu>

commit fb5ee84ea72c5f1b6cabdd1c9d6e8648995ca7c6 upstream.

Some non-compliant high-speed USB devices have bulk endpoints with a
1024-byte maxpacket size.  Although such endpoints don't work with
xHCI host controllers, they do work with EHCI controllers.  We used to
accept these invalid sizes (with a warning), but we no longer do
because of an unintentional change introduced by commit aed9d65ac327
("USB: validate wMaxPacketValue entries in endpoint descriptors").

This patch restores the old behavior, so that people with these
peculiar devices can use them without patching their kernels by hand.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Elvinas <elvinas@veikia.lt>
Fixes: aed9d65ac327 ("USB: validate wMaxPacketValue entries in endpoint descriptors")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -157,7 +157,9 @@ static const unsigned short full_speed_m
 static const unsigned short high_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 64,
 	[USB_ENDPOINT_XFER_ISOC] = 1024,
-	[USB_ENDPOINT_XFER_BULK] = 512,
+
+	/* Bulk should be 512, but some devices use 1024: we will warn below */
+	[USB_ENDPOINT_XFER_BULK] = 1024,
 	[USB_ENDPOINT_XFER_INT] = 1024,
 };
 static const unsigned short super_speed_maxpacket_maxes[4] = {

