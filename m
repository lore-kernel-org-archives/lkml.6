Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50780C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A072064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A072064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbeJBUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbeJBUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:43 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2E8DB4B;
        Tue,  2 Oct 2018 13:36:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 48/94] EDAC, i7core: Fix memleaks and use-after-free on probe and remove
Date:   Tue,  2 Oct 2018 06:25:02 -0700
Message-Id: <20181002132503.813245029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6c974d4dfafe5e9ee754f2a6fba0eb1864f1649e ]

Make sure to free and deregister the addrmatch and chancounts devices
allocated during probe in all error paths. Also fix use-after-free in a
probe error path and in the remove success path where the devices were
being put before before deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make Documentation/kobject.txt happy")
Link: http://lkml.kernel.org/r/20180612124335.6420-2-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/i7core_edac.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,15 +1177,14 @@ static int i7core_create_sysfs_devices(s
 
 	rc = device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
 
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev = kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return -ENOMEM;
+			rc = -ENOMEM;
+			goto err_del_addrmatch;
 		}
 
 		pvt->chancounts_dev->type = &all_channel_counts_type;
@@ -1199,9 +1198,18 @@ static int i7core_create_sysfs_devices(s
 
 		rc = device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
 
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1211,11 +1219,11 @@ static void i7core_delete_sysfs_devices(
 	edac_dbg(1, "\n");
 
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
 
 /****************************************************************************


