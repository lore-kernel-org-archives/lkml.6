Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149F22064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149F22064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeJBUqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:46:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeJBUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:11 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77239266;
        Tue,  2 Oct 2018 13:29:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 125/228] Input: xen-kbdfront - fix multi-touch XenStore nodes locations
Date:   Tue,  2 Oct 2018 06:23:42 -0700
Message-Id: <20181002132507.886918006@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit ce6f7d087e2b037f47349c1c36ac97678d02e394 ]

kbdif protocol describes multi-touch device parameters as a
part of frontend's XenBus configuration nodes while they
belong to backend's configuration. Fix this by reading the
parameters as defined by the protocol.

Fixes: 49aac8204da5 ("Input: xen-kbdfront - add multi-touch support")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/xen-kbdfront.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -229,7 +229,7 @@ static int xenkbd_probe(struct xenbus_de
 		}
 	}
 
-	touch = xenbus_read_unsigned(dev->nodename,
+	touch = xenbus_read_unsigned(dev->otherend,
 				     XENKBD_FIELD_FEAT_MTOUCH, 0);
 	if (touch) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
@@ -304,13 +304,13 @@ static int xenkbd_probe(struct xenbus_de
 		if (!mtouch)
 			goto error_nomem;
 
-		num_cont = xenbus_read_unsigned(info->xbdev->nodename,
+		num_cont = xenbus_read_unsigned(info->xbdev->otherend,
 						XENKBD_FIELD_MT_NUM_CONTACTS,
 						1);
-		width = xenbus_read_unsigned(info->xbdev->nodename,
+		width = xenbus_read_unsigned(info->xbdev->otherend,
 					     XENKBD_FIELD_MT_WIDTH,
 					     XENFB_WIDTH);
-		height = xenbus_read_unsigned(info->xbdev->nodename,
+		height = xenbus_read_unsigned(info->xbdev->otherend,
 					      XENKBD_FIELD_MT_HEIGHT,
 					      XENFB_HEIGHT);
 


