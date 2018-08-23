Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD333C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4520851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE4520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbeHWMK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732644AbeHWMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:56 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD1877F6;
        Thu, 23 Aug 2018 08:42:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 062/324] xen/scsiback: add error handling for xenbus_printf
Date:   Thu, 23 Aug 2018 09:52:08 +0200
Message-Id: <20180823074958.992432008@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7c63ca24c878e0051c91904b72174029320ef4bd ]

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/xen-scsiback.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1012,6 +1012,7 @@ static void scsiback_do_add_lun(struct v
 {
 	struct v2p_entry *entry;
 	unsigned long flags;
+	int err;
 
 	if (try) {
 		spin_lock_irqsave(&info->v2p_lock, flags);
@@ -1027,8 +1028,11 @@ static void scsiback_do_add_lun(struct v
 			scsiback_del_translation_entry(info, vir);
 		}
 	} else if (!try) {
-		xenbus_printf(XBT_NIL, info->dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, info->dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 	}
 }
 
@@ -1067,8 +1071,11 @@ static void scsiback_do_1lun_hotplug(str
 	snprintf(str, sizeof(str), "vscsi-devs/%s/p-dev", ent);
 	val = xenbus_read(XBT_NIL, dev->nodename, str, NULL);
 	if (IS_ERR(val)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 	strlcpy(phy, val, VSCSI_NAMELEN);
@@ -1079,8 +1086,11 @@ static void scsiback_do_1lun_hotplug(str
 	err = xenbus_scanf(XBT_NIL, dev->nodename, str, "%u:%u:%u:%u",
 			   &vir.hst, &vir.chn, &vir.tgt, &vir.lun);
 	if (XENBUS_EXIST_ERR(err)) {
-		xenbus_printf(XBT_NIL, dev->nodename, state,
+		err = xenbus_printf(XBT_NIL, dev->nodename, state,
 			      "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing %s", __func__, state);
 		return;
 	}
 


