Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4966F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4966F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeKLGSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:18:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50598 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730489AbeKLFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:23 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsi-0000oO-Cg; Sun, 11 Nov 2018 19:58:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001r3-2I; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Shuah Khan" <shuahkh@osg.samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.57826657@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 335/366] usbip: stub_rx: fix static checker warning
 on unnecessary checks
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 10c90120930628e8b959bf58d4a0aaef3ae5d945 upstream.

Fix the following static checker warnings:

The patch c6688ef9f297: "usbip: fix stub_rx: harden CMD_SUBMIT path
to handle malicious input" from Dec 7, 2017, leads to the following
static checker warning:

    drivers/usb/usbip/stub_rx.c:346 get_pipe()
    warn: impossible condition
'(pdu->u.cmd_submit.transfer_buffer_length > ((~0 >> 1))) =>
(s32min-s32max > s32max)'
    drivers/usb/usbip/stub_rx.c:486 stub_recv_cmd_submit()
    warn: always true condition
'(pdu->u.cmd_submit.transfer_buffer_length <= ((~0 >> 1))) =>
(s32min-s32max <= s32max)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -353,14 +353,6 @@ static int get_pipe(struct stub_device *
 
 	epd = &ep->desc;
 
-	/* validate transfer_buffer_length */
-	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
-		dev_err(&sdev->udev->dev,
-			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
-			pdu->u.cmd_submit.transfer_buffer_length);
-		return -1;
-	}
-
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -494,8 +486,7 @@ static void stub_recv_cmd_submit(struct
 	}
 
 	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
-	    pdu->u.cmd_submit.transfer_buffer_length <= INT_MAX) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
 		priv->urb->transfer_buffer =
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);

