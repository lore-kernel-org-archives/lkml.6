Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C691C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BEA2561A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BEA2561A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031295AbeGAR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:26:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031434AbeGAQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B68E8AA6;
        Sun,  1 Jul 2018 16:37:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH 4.17 024/220] usb: do not reset if a low-speed or full-speed device timed out
Date:   Sun,  1 Jul 2018 18:20:48 +0200
Message-Id: <20180701160909.361263127@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>

commit 6e01827ed93947895680fbdad68c072a0f4e2450 upstream.

Some low-speed and full-speed devices (for example, bluetooth)
do not have time to initialize. For them, ETIMEDOUT is a valid error.
We need to give them another try. Otherwise, they will
never be initialized correctly and in dmesg will be messages
"Bluetooth: hci0 command 0x1002 tx timeout" or similars.

Fixes: 264904ccc33c ("usb: retry reset if a device times out")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4551,7 +4551,9 @@ hub_port_init(struct usb_hub *hub, struc
 				 * reset. But only on the first attempt,
 				 * lest we get into a time out/reset loop
 				 */
-				if (r == 0  || (r == -ETIMEDOUT && retries == 0))
+				if (r == 0 || (r == -ETIMEDOUT &&
+						retries == 0 &&
+						udev->speed > USB_SPEED_FULL))
 					break;
 			}
 			udev->descriptor.bMaxPacketSize0 =


