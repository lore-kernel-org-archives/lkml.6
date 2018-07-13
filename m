Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E518D208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E518D208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeGMJnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:43:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59264 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbeGMJnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:43:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fduOi-0004Rn-CQ; Fri, 13 Jul 2018 09:29:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: ehci-sched: remove redundant pointer dev
Date:   Fri, 13 Jul 2018 10:29:56 +0100
Message-Id: <20180713092956.13247-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dev is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'dev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/ehci-sched.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 1d87295682b8..da7b00a6110b 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1835,7 +1835,6 @@ static bool itd_complete(struct ehci_hcd *ehci, struct ehci_itd *itd)
 	unsigned				uframe;
 	int					urb_index = -1;
 	struct ehci_iso_stream			*stream = itd->stream;
-	struct usb_device			*dev;
 	bool					retval = false;
 
 	/* for each uframe with a packet */
@@ -1886,7 +1885,6 @@ static bool itd_complete(struct ehci_hcd *ehci, struct ehci_itd *itd)
 	 */
 
 	/* give urb back to the driver; completion often (re)submits */
-	dev = urb->dev;
 	ehci_urb_done(ehci, urb, 0);
 	retval = true;
 	urb = NULL;
@@ -2230,7 +2228,6 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 	u32					t;
 	int					urb_index;
 	struct ehci_iso_stream			*stream = sitd->stream;
-	struct usb_device			*dev;
 	bool					retval = false;
 
 	urb_index = sitd->index;
@@ -2268,7 +2265,6 @@ static bool sitd_complete(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
 	 */
 
 	/* give urb back to the driver; completion often (re)submits */
-	dev = urb->dev;
 	ehci_urb_done(ehci, urb, 0);
 	retval = true;
 	urb = NULL;
-- 
2.17.1

