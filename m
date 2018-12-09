Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC147C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884752081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884752081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeLIWJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37476 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbeLIWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:47 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002im-7C; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Vk-HH; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.148942297@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 208/328] usb: host: u132-hcd: Fix a sleep-in-atomic-context
 bug in u132_get_frame()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit 6d4f268fa132742fe96dad22307c68d237356d88 upstream.

i_usX2Y_subs_startup in usbusx2yaudio.c is a completion handler function
for the USB driver. So it should not sleep, but it is can sleep
according to the function call paths (from bottom to top) in Linux-4.16.

[FUNC] msleep
drivers/usb/host/u132-hcd.c, 2558:
	msleep in u132_get_frame
drivers/usb/core/hcd.c, 2231:
	[FUNC_PTR]u132_get_frame in usb_hcd_get_frame_number
drivers/usb/core/usb.c, 822:
	usb_hcd_get_frame_number in usb_get_current_frame_number
sound/usb/usx2y/usbusx2yaudio.c, 303:
	usb_get_current_frame_number in i_usX2Y_urb_complete
sound/usb/usx2y/usbusx2yaudio.c, 366:
	i_usX2Y_urb_complete in i_usX2Y_subs_startup

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, msleep() is replaced with mdelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/u132-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2569,7 +2569,7 @@ static int u132_get_frame(struct usb_hcd
 	} else {
 		int frame = 0;
 		dev_err(&u132->platform_dev->dev, "TODO: u132_get_frame\n");
-		msleep(100);
+		mdelay(100);
 		return frame;
 	}
 }

