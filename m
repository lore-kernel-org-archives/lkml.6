Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEACC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82359208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82359208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeHWLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47036 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeHWLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8A74C83;
        Thu, 23 Aug 2018 08:22:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 088/217] NFC: pn533: Fix wrong GFP flag usage
Date:   Thu, 23 Aug 2018 09:53:21 +0200
Message-Id: <20180823075509.482604108@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ecc443c03fb14abfb8a6af5e3b2d43b5257e60f2 ]

pn533_recv_response() is an urb completion handler, so it must use
GFP_ATOMIC. pn533_usb_send_frame() OTOH runs from a regular sleeping
context, so the pn533_submit_urb_for_response() there (and only there)
can use the regular GFP_KERNEL flags.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514134
Fixes: 9815c7cf22da ("NFC: pn533: Separate physical layer from ...")
Cc: Michael Thalmeier <michael.thalmeier@hale.at>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/pn533/usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -74,7 +74,7 @@ static void pn533_recv_response(struct u
 	struct sk_buff *skb = NULL;
 
 	if (!urb->status) {
-		skb = alloc_skb(urb->actual_length, GFP_KERNEL);
+		skb = alloc_skb(urb->actual_length, GFP_ATOMIC);
 		if (!skb) {
 			nfc_err(&phy->udev->dev, "failed to alloc memory\n");
 		} else {
@@ -186,7 +186,7 @@ static int pn533_usb_send_frame(struct p
 
 	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {
 		/* request for response for sent packet directly */
-		rc = pn533_submit_urb_for_response(phy, GFP_ATOMIC);
+		rc = pn533_submit_urb_for_response(phy, GFP_KERNEL);
 		if (rc)
 			goto error;
 	} else if (dev->protocol_type == PN533_PROTO_REQ_ACK_RESP) {


