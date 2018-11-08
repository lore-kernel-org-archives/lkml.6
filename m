Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4DA20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkuI+xKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4DA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeKIHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeKIHfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89F620989;
        Thu,  8 Nov 2018 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714306;
        bh=9ngANrJUTdD0BaMutpikQJJGxSVsG0NyHPZwsE4V2Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkuI+xKblbhgGjgBw30t9vlNNkaq7Bh4N4ubuTZ1+ok3RLSvsBMCaqaV6szWOcaky
         Cq3N19VrDZAdOUMReZIw6R4GXb3Y51hLVMZbjD02dkhSv9JoF/KbBLgw0b4Dv3lvc+
         rdgOQzeX0jsni0n7GF1N4qyxIhn5qy4OBfoOWXIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3.18 143/144] USB: fix the usbfs flag sanitization for control transfers
Date:   Thu,  8 Nov 2018 13:51:54 -0800
Message-Id: <20181108215108.570758390@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 665c365a77fbfeabe52694aedf3446d5f2f1ce42 upstream.

Commit 7a68d9fb8510 ("USB: usbdevfs: sanitize flags more") checks the
transfer flags for URBs submitted from userspace via usbfs.  However,
the check for whether the USBDEVFS_URB_SHORT_NOT_OK flag should be
allowed for a control transfer was added in the wrong place, before
the code has properly determined the direction of the control
transfer.  (Control transfers are special because for them, the
direction is set by the bRequestType byte of the Setup packet rather
than direction bit of the endpoint address.)

This patch moves code which sets up the allow_short flag for control
transfers down after is_in has been set to the correct value.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com
Fixes: 7a68d9fb8510 ("USB: usbdevfs: sanitize flags more")
CC: Oliver Neukum <oneukum@suse.com>
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/devio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1326,8 +1326,6 @@ static int proc_do_submiturb(struct usb_
 	u = 0;
 	switch(uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
-		if (is_in)
-			allow_short = true;
 		if (!usb_endpoint_xfer_control(&ep->desc))
 			return -EINVAL;
 		/* min 8 byte setup packet */
@@ -1357,6 +1355,8 @@ static int proc_do_submiturb(struct usb_
 			is_in = 0;
 			uurb->endpoint &= ~USB_DIR_IN;
 		}
+		if (is_in)
+			allow_short = true;
 		snoop(&ps->dev->dev, "control urb: bRequestType=%02x "
 			"bRequest=%02x wValue=%04x "
 			"wIndex=%04x wLength=%04x\n",


