Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2792083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2792083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeIHCKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:10:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIHCKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:10:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0421F23;
        Fri,  7 Sep 2018 21:27:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.14 39/89] extcon: Release locking when sending the notification of connector state
Date:   Fri,  7 Sep 2018 23:09:33 +0200
Message-Id: <20180907210857.056083719@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
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

From: Chanwoo Choi <cw00.choi@samsung.com>

commit 8a9dbb779fe882325b9a0238494a7afaff2eb444 upstream.

Previously, extcon used the spinlock before calling the notifier_call_chain
to prevent the scheduled out of task and to prevent the notification delay.
When spinlock is locked for sending the notification, deadlock issue
occured on the side of extcon consumer device. To fix this issue,
extcon consumer device should always use the work. it is always not
reasonable to use work.

To fix this issue on extcon consumer device, release locking when sending
the notification of connector state.

Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to support the notification")
Cc: stable@vger.kernel.org
Cc: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/extcon/extcon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev,
 		return index;
 
 	spin_lock_irqsave(&edev->lock, flags);
-
 	state = !!(edev->state & BIT(index));
+	spin_unlock_irqrestore(&edev->lock, flags);
 
 	/*
 	 * Call functions in a raw notifier chain for the specific one
@@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev,
 	 */
 	raw_notifier_call_chain(&edev->nh_all, state, edev);
 
+	spin_lock_irqsave(&edev->lock, flags);
 	/* This could be in interrupt handler */
 	prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
 	if (!prop_buf) {


