Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFCF20894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFCF20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbeG0LXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:23:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:23:17 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 939E8CBA;
        Fri, 27 Jul 2018 10:02:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Zhang <zhangjerry@google.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 37/48] usb: gadget: f_fs: Only return delayed status when len is 0
Date:   Fri, 27 Jul 2018 12:00:22 +0200
Message-Id: <20180727095922.344103799@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
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

From: Jerry Zhang <zhangjerry@google.com>

commit 4d644abf25698362bd33d17c9ddc8f7122c30f17 upstream.

Commit 1b9ba000 ("Allow function drivers to pause control
transfers") states that USB_GADGET_DELAYED_STATUS is only
supported if data phase is 0 bytes.

It seems that when the length is not 0 bytes, there is no
need to explicitly delay the data stage since the transfer
is not completed until the user responds. However, when the
length is 0, there is no data stage and the transfer is
finished once setup() returns, hence there is a need to
explicitly delay completion.

This manifests as the following bugs:

Prior to 946ef68ad4e4 ('Let setup() return
USB_GADGET_DELAYED_STATUS'), when setup is 0 bytes, ffs
would require user to queue a 0 byte request in order to
clear setup state. However, that 0 byte request was actually
not needed and would hang and cause errors in other setup
requests.

After the above commit, 0 byte setups work since the gadget
now accepts empty queues to ep0 to clear the delay, but all
other setups hang.

Fixes: 946ef68ad4e4 ("Let setup() return USB_GADGET_DELAYED_STATUS")
Signed-off-by: Jerry Zhang <zhangjerry@google.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3243,7 +3243,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return USB_GADGET_DELAYED_STATUS;
+	return creq->wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,


