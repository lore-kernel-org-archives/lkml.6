Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD2721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeIXR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:58:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbeIXR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:58:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F3D21075;
        Mon, 24 Sep 2018 11:56:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 4.4 44/70] usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()
Date:   Mon, 24 Sep 2018 13:52:43 +0200
Message-Id: <20180924113104.900101278@linuxfoundation.org>
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

commit 6e22e3af7bb3a7b9dc53cb4687659f6e63fca427 upstream.

wdm_in_callback() is a completion handler function for the USB driver.
So it should not sleep. But it calls service_outstanding_interrupt(),
which calls usb_submit_urb() with GFP_KERNEL.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-wdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -453,7 +453,7 @@ static int clear_wdm_read_flag(struct wd
 
 	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
-	rv = usb_submit_urb(desc->response, GFP_KERNEL);
+	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
 	spin_lock_irq(&desc->iuspin);
 	if (rv) {
 		dev_err(&desc->intf->dev,


