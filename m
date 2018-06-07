Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6jPnNUtIGVtCRwAAmS7hNA
	; Thu, 07 Jun 2018 15:00:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8E68A608B8; Thu,  7 Jun 2018 15:00:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DEC5D601C3;
	Thu,  7 Jun 2018 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEC5D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935812AbeFGPAl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:00:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41349 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932536AbeFGPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:37 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbs-0005hK-Ml; Thu, 07 Jun 2018 15:09:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002pW-G0; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "John Stultz" <john.stultz@linaro.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Android Kernel Team" <kernel-team@android.com>,
        "Michal Nazarewicz" <mina86@mina86.com>,
        "Badhri" <badhri@google.com>,
        "Greg KH" <gregkh@linux-foundation.org>,
        "Dmitry Shmidt" <dimitrysh@google.com>,
        "Amit Pundir" <amit.pundir@linaro.org>,
        "Hemant Kumar" <hemantk@codeaurora.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.31224834@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/410] usb: f_fs: Prevent gadget unbind if it is
 already unbound
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hemant Kumar <hemantk@codeaurora.org>

commit ce5bf9a50daf2d9078b505aca1cea22e88ecb94a upstream.

Upon usb composition switch there is possibility of ep0 file
release happening after gadget driver bind. In case of composition
switch from adb to a non-adb composition gadget will never gets
bound again resulting into failure of usb device enumeration. Fix
this issue by checking FFS_FL_BOUND flag and avoid extra
gadget driver unbind if it is already done as part of composition
switch.

This fixes adb reconnection error reported on Android running
v4.4 and above kernel versions. Verified on Hikey running vanilla
v4.15-rc7 + few out of tree Mali patches.

Reviewed-at: https://android-review.googlesource.com/#/c/582632/

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linux-foundation.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Badhri <badhri@google.com>
Cc: Android Kernel Team <kernel-team@android.com>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
[AmitP: Cherry-picked it from android-4.14 and updated the commit log]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/f_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/f_fs.c
+++ b/drivers/usb/gadget/f_fs.c
@@ -3019,7 +3019,8 @@ static void ffs_closed(struct ffs_data *
 	ci = ffs_obj->opts->func_inst.group.cg_item.ci_parent->ci_parent;
 	ffs_dev_unlock();
 
-	unregister_gadget_item(ci);
+	if (test_bit(FFS_FL_BOUND, &ffs->flags))
+		unregister_gadget_item(ci);
 	return;
 done:
 	ffs_dev_unlock();
