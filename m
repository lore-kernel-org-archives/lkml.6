Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61BC2064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61BC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeHWLgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:36:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHWLgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E08DBB6;
        Thu, 23 Aug 2018 08:07:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 022/130] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Thu, 23 Aug 2018 09:52:18 +0200
Message-Id: <20180823074928.761955883@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 93efbd39870474cc536b9caf4a6efeb03b0bc56f ]

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/xen-scsifront.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -676,10 +676,17 @@ static int scsifront_dev_reset_handler(s
 static int scsifront_sdev_configure(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateConnected);
+		if (err) {
+			xenbus_dev_error(info->dev, err,
+				"%s: writing dev_state_path", __func__);
+			return err;
+		}
+	}
 
 	return 0;
 }
@@ -687,10 +694,15 @@ static int scsifront_sdev_configure(stru
 static void scsifront_sdev_destroy(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing dev_state_path", __func__);
+	}
 }
 
 static struct scsi_host_template scsifront_sht = {
@@ -1025,9 +1037,12 @@ static void scsifront_do_lun_hotplug(str
 
 			if (scsi_add_device(info->host, chn, tgt, lun)) {
 				dev_err(&dev->dev, "scsi_add_device\n");
-				xenbus_printf(XBT_NIL, dev->nodename,
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateClosed);
+				if (err)
+					xenbus_dev_error(dev, err,
+						"%s: writing dev_state_path", __func__);
 			}
 			break;
 		case VSCSIFRONT_OP_DEL_LUN:
@@ -1041,10 +1056,14 @@ static void scsifront_do_lun_hotplug(str
 			}
 			break;
 		case VSCSIFRONT_OP_READD_LUN:
-			if (device_state == XenbusStateConnected)
-				xenbus_printf(XBT_NIL, dev->nodename,
+			if (device_state == XenbusStateConnected) {
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateConnected);
+				if (err)
+					xenbus_dev_error(dev, err,
+						"%s: writing dev_state_path", __func__);
+			}
 			break;
 		default:
 			break;


