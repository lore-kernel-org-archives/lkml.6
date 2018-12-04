Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05A12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0WQOsd3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05A12087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeLDLGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeLDLGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2452087F;
        Tue,  4 Dec 2018 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921609;
        bh=vgsa1aB3LA0hNvLf9nx9KnSoknRziqtYByWDXwdJlug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WQOsd3AMCIeSyB8DX0NaWbd61qNIWR72kDs0eLTnPVwil/cXh5sZBIvRx39twkeh
         qaH5LyB9T7QBajP1At/FsvYmvvaf21i7DczUi26tfo/pdVhr4U2AwOim73nYG4maYv
         9RkjfpKSPQe7k/LW78q3duAez0rpc4t2m1/m47qY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Wolsieffer <benwolsieffer@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 4.14 136/146] staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION
Date:   Tue,  4 Dec 2018 11:50:22 +0100
Message-Id: <20181204103732.299096107@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Wolsieffer <benwolsieffer@gmail.com>

commit 5a96b2d38dc054c0bbcbcd585b116566cbd877fe upstream.

The compatibility ioctl wrapper for VCHIQ_IOC_AWAIT_COMPLETION assumes that
the native ioctl always uses a message buffer and decrements msgbufcount.
Certain message types do not use a message buffer and in this case
msgbufcount is not decremented, and completion->header for the message is
NULL. Because the wrapper unconditionally decrements msgbufcount, the
calling process may assume that a message buffer has been used even when
it has not.

This results in a memory leak in the userspace code that interfaces with
this driver. When msgbufcount is decremented, the userspace code assumes
that the buffer can be freed though the reference in completion->header,
which cannot happen when the reference is NULL.

This patch causes the wrapper to only decrement msgbufcount when the
native ioctl decrements it. Note that we cannot simply copy the native
ioctl's value of msgbufcount, because the wrapper only retrieves messages
from the native ioctl one at a time, while userspace may request multiple
messages.

See https://github.com/raspberrypi/linux/pull/2703 for more discussion of
this patch.

Fixes: 5569a1260933 ("staging: vchiq_arm: Add compatibility wrappers for ioctls")
Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1461,6 +1461,7 @@ vchiq_compat_ioctl_await_completion(stru
 	struct vchiq_await_completion32 args32;
 	struct vchiq_completion_data32 completion32;
 	unsigned int *msgbufcount32;
+	unsigned int msgbufcount_native;
 	compat_uptr_t msgbuf32;
 	void *msgbuf;
 	void **msgbufptr;
@@ -1572,7 +1573,11 @@ vchiq_compat_ioctl_await_completion(stru
 			 sizeof(completion32)))
 		return -EFAULT;
 
-	args32.msgbufcount--;
+	if (get_user(msgbufcount_native, &args->msgbufcount))
+		return -EFAULT;
+
+	if (!msgbufcount_native)
+		args32.msgbufcount--;
 
 	msgbufcount32 =
 		&((struct vchiq_await_completion32 __user *)arg)->msgbufcount;


