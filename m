Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55E21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B55E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbeIXSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:00:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbeIXSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:00:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB9DED64;
        Mon, 24 Sep 2018 11:58:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 4.4 38/70] usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()
Date:   Mon, 24 Sep 2018 13:52:37 +0200
Message-Id: <20180924113103.860378395@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/u132-hcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2565,7 +2565,7 @@ static int u132_get_frame(struct usb_hcd
 	} else {
 		int frame = 0;
 		dev_err(&u132->platform_dev->dev, "TODO: u132_get_frame\n");
-		msleep(100);
+		mdelay(100);
 		return frame;
 	}
 }


