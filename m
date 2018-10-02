Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F6C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9F2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB9F2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbeJBUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733264AbeJBUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:05 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F6709D9;
        Tue,  2 Oct 2018 13:36:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 69/94] USB: usbdevfs: restore warning for nonsensical flags
Date:   Tue,  2 Oct 2018 06:25:23 -0700
Message-Id: <20181002132505.301820420@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 81e0403b26d94360abd1f6a57311337973bc82cd upstream.

If we filter flags before they reach the core we need to generate our
own warnings.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 0cb54a3e47cb ("USB: debugging code shouldn't alter control flow")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/devio.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1714,6 +1714,11 @@ static int proc_do_submiturb(struct usb_
 		u |= URB_NO_INTERRUPT;
 	as->urb->transfer_flags = u;
 
+	if (!allow_short && uurb->flags & USBDEVFS_URB_SHORT_NOT_OK)
+		dev_warn(&ps->dev->dev, "Requested nonsensical USBDEVFS_URB_SHORT_NOT_OK.\n");
+	if (!allow_zero && uurb->flags & USBDEVFS_URB_ZERO_PACKET)
+		dev_warn(&ps->dev->dev, "Requested nonsensical USBDEVFS_URB_ZERO_PACKET.\n");
+
 	as->urb->transfer_buffer_length = uurb->buffer_length;
 	as->urb->setup_packet = (unsigned char *)dr;
 	dr = NULL;


