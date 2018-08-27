Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F49C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A662208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A662208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeH0XbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:31:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:5779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeH0XbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 12:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="83833392"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga004.fm.intel.com with ESMTP; 27 Aug 2018 12:43:05 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc for 4.9 2/2] mei: bus: need to unlink client before freeing
Date:   Mon, 27 Aug 2018 22:40:16 +0300
Message-Id: <20180827194016.1287-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180827194016.1287-1-tomas.winkler@intel.com>
References: <20180827194016.1287-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/misc/mei/bus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 13c6c9a2248a..fc3872fe7b25 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -521,17 +521,15 @@ int mei_cldev_enable(struct mei_cl_device *cldev)
 
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
@@ -875,12 +873,13 @@ static void mei_cl_bus_dev_release(struct device *dev)
 
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
-- 
2.14.4

