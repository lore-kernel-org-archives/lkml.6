Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F4C7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443F320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443F320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJNXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36914 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbeJNXXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cf-3V; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000EV-OD; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
        "Bin Liu" <b-liu@ti.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.364892287@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 073/366] usb: musb: gadget: misplaced out of bounds check
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/musb/musb_gadget_ep0.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}

