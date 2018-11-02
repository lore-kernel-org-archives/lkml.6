Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE61BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099120848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="toq5ReTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B099120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbeKCEEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:23 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A986D2084C;
        Fri,  2 Nov 2018 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184967;
        bh=VNukPUy2UYfDPi/R7Cux1ejfEmRb3EhkXwAyUpYkFYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toq5ReTv3Y3oX2RF2NPbuPDSO4Bg25XydFAbw6RBDq/xuWE/IFQzSrYK5D3J6PX8B
         U84ovDCCTPKO7ye3BQ/K9A+2ZxaL65uXzTxfwwqbbuFr3GjYfPlIIoQUf7TpMydUFc
         K4U44qFKbBoEIc0uoSyhuGFOpA8J23yl+uLgC54M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 110/143] media: uvcvideo: Fix driver reference counting
Date:   Fri,  2 Nov 2018 19:34:55 +0100
Message-Id: <20181102182906.624871582@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit f9ffcb0a21e1fa8e64d09ed613d884e054ae8191 upstream

kref_init initializes the reference count to 1, not 0. This additional
reference is never released since the conversion to reference counters.
As a result, uvc_delete is not called anymore when UVC cameras are
disconnected.
Fix this by adding an additional kref_put in uvc_disconnect and in the
probe error path. This also allows to remove the temporary additional
reference in uvc_unregister_video.

Fixes: 9d15cd958c17 ("media: uvcvideo: Convert from using an atomic variable to a reference count")

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6d22b22cb35b..064d88299adc 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1865,13 +1865,6 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
-	/* Unregistering all video devices might result in uvc_delete() being
-	 * called from inside the loop if there's no open file handle. To avoid
-	 * that, increment the refcount before iterating over the streams and
-	 * decrement it when done.
-	 */
-	kref_get(&dev->ref);
-
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (!video_is_registered(&stream->vdev))
 			continue;
@@ -1880,8 +1873,6 @@ static void uvc_unregister_video(struct uvc_device *dev)
 
 		uvc_debugfs_cleanup_stream(stream);
 	}
-
-	kref_put(&dev->ref, uvc_delete);
 }
 
 static int uvc_register_video(struct uvc_device *dev,
@@ -2129,6 +2120,7 @@ static int uvc_probe(struct usb_interface *intf,
 
 error:
 	uvc_unregister_video(dev);
+	kref_put(&dev->ref, uvc_delete);
 	return -ENODEV;
 }
 
@@ -2146,6 +2138,7 @@ static void uvc_disconnect(struct usb_interface *intf)
 		return;
 
 	uvc_unregister_video(dev);
+	kref_put(&dev->ref, uvc_delete);
 }
 
 static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
-- 
2.17.1



