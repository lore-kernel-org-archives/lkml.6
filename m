Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906DAC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8D20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJOWzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:55:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:21971 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeJOWzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:55:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 08:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="100389805"
Received: from jhli-desk1.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.154])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2018 08:09:32 -0700
Subject: [driver-core PATCH v4 5/6] driver core: Attach devices on CPU local
 to device node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com
Date:   Mon, 15 Oct 2018 08:09:32 -0700
Message-ID: <20181015150932.29520.2252.stgit@localhost.localdomain>
In-Reply-To: <20181015150305.29520.86363.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes it so that we call the asynchronous probe routines on a
CPU local to the device node. By doing this we should be able to improve
our initialization time significantly as we can avoid having to access the
device from a remote node which may introduce higher latency.

For example, in the case of initializing memory for NVDIMM this can have a
singifcant impact as initialing 3TB on remote node can take up to 39
seconds while initialing it on a local node only takes 23 seconds. It is
situations like this where we will see the biggest improvement.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c33f893ec9d8..65cfdd2b00ed 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -827,7 +827,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async_schedule(__device_attach_async_helper, dev);
+			async_schedule_dev(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
 		}
@@ -984,7 +984,7 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver) {
 			get_device(dev);
 			dev_set_drvdata(dev, drv);
-			async_schedule(__driver_attach_async_helper, dev);
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		}
 		device_unlock(dev);
 		return 0;

