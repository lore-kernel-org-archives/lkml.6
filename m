Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698BEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F172208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F172208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeIXSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:19:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeIXSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:19:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DE99109F;
        Mon, 24 Sep 2018 12:17:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.14 087/173] mei: bus: need to unlink client before freeing
Date:   Mon, 24 Sep 2018 13:52:01 +0200
Message-Id: <20180924113122.460108726@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Tomas Winkler <tomas.winkler@intel.com>

commit 34f1166afd67f9f48a08c52f36180048908506a4 upstream.

In case a client fails to connect in mei_cldev_enable(), the
caller won't call the mei_cldev_disable leaving the client
in a linked stated. Upon driver unload the client structure
will be freed in  mei_cl_bus_dev_release(), leaving a stale pointer
on a fail_list.  This will eventually end up in crash
during power down flow in mei_cl_set_disonnected().

RIP:  mei_cl_set_disconnected+0x5/0x260[mei]
Call trace:
mei_cl_all_disconnect+0x22/0x30
mei_reset+0x194/0x250
__synchronize_hardirq+0x43/0x50
_cond_resched+0x15/0x30
mei_me_intr_clear+0x20/0x100
mei_stop+0x76/0xb0
mei_me_shutdown+0x3f/0x80
pci_device_shutdown+0x34/0x60
kernel_restart+0x0e/0x30

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200455
Fixes: 'c110cdb17148 ("mei: bus: make a client pointer always available")'
Cc: <stable@vger.kernel.org> 4.10+
Tested-by: Georg Müller <georgmueller@gmx.net>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/bus.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -465,17 +465,15 @@ int mei_cldev_enable(struct mei_cl_devic
 
 	cl = cldev->cl;
 
+	mutex_lock(&bus->device_lock);
 	if (cl->state == MEI_FILE_UNINITIALIZED) {
-		mutex_lock(&bus->device_lock);
 		ret = mei_cl_link(cl);
-		mutex_unlock(&bus->device_lock);
 		if (ret)
-			return ret;
+			goto out;
 		/* update pointers */
 		cl->cldev = cldev;
 	}
 
-	mutex_lock(&bus->device_lock);
 	if (mei_cl_is_connected(cl)) {
 		ret = 0;
 		goto out;
@@ -841,12 +839,13 @@ static void mei_cl_bus_dev_release(struc
 
 	mei_me_cl_put(cldev->me_cl);
 	mei_dev_bus_put(cldev->bus);
+	mei_cl_unlink(cldev->cl);
 	kfree(cldev->cl);
 	kfree(cldev);
 }
 
 static const struct device_type mei_cl_device_type = {
-	.release	= mei_cl_bus_dev_release,
+	.release = mei_cl_bus_dev_release,
 };
 
 /**


