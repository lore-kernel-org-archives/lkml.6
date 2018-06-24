Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8919C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE82250AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE82250AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFXPqu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:46:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:46:47 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90ACF86D;
        Sun, 24 Jun 2018 15:46:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.17 61/70] media: uvcvideo: Prevent setting unavailable flags
Date:   Sun, 24 Jun 2018 23:22:53 +0800
Message-Id: <20180624142744.272910329@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

commit 0dc68cabdb626e33d02561529e6a4c681b72a784 upstream.

The addition of an extra operation to use the GET_INFO command
overwrites all existing flags from the uvc_ctrls table. This includes
setting all controls as supporting GET_MIN, GET_MAX, GET_RES, and
GET_DEF regardless of whether they do or not.

Move the initialisation of these control capabilities directly to the
uvc_ctrl_fill_xu_info() call where they were originally located in that
use case, and ensure that the new functionality in uvc_ctrl_get_flags()
will only set flags based on their reported capability from the GET_INFO
call.

Fixes: 859086ae3636 ("media: uvcvideo: Apply flags from device to actual properties")

Cc: stable@vger.kernel.org
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Tested-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_ctrl.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1607,14 +1607,12 @@ static int uvc_ctrl_get_flags(struct uvc
 	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
 			     info->selector, data, 1);
 	if (!ret)
-		info->flags = UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_GET_MAX
-			    | UVC_CTRL_FLAG_GET_RES | UVC_CTRL_FLAG_GET_DEF
-			    | (data[0] & UVC_CONTROL_CAP_GET ?
-			       UVC_CTRL_FLAG_GET_CUR : 0)
-			    | (data[0] & UVC_CONTROL_CAP_SET ?
-			       UVC_CTRL_FLAG_SET_CUR : 0)
-			    | (data[0] & UVC_CONTROL_CAP_AUTOUPDATE ?
-			       UVC_CTRL_FLAG_AUTO_UPDATE : 0);
+		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
+				UVC_CTRL_FLAG_GET_CUR : 0)
+			    |  (data[0] & UVC_CONTROL_CAP_SET ?
+				UVC_CTRL_FLAG_SET_CUR : 0)
+			    |  (data[0] & UVC_CONTROL_CAP_AUTOUPDATE ?
+				UVC_CTRL_FLAG_AUTO_UPDATE : 0);
 
 	kfree(data);
 	return ret;
@@ -1689,6 +1687,9 @@ static int uvc_ctrl_fill_xu_info(struct
 
 	info->size = le16_to_cpup((__le16 *)data);
 
+	info->flags = UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_GET_MAX
+		    | UVC_CTRL_FLAG_GET_RES | UVC_CTRL_FLAG_GET_DEF;
+
 	ret = uvc_ctrl_get_flags(dev, ctrl, info);
 	if (ret < 0) {
 		uvc_trace(UVC_TRACE_CONTROL,


