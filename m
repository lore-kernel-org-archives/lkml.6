Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65EC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18120841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA18120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJLFkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:40:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:34957 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeJLFkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:40:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 15:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="80764031"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.157])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 15:09:38 -0700
Subject: [driver-core PATCH v3 4/5] driver core: Attach devices on CPU local
 to device node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com
Date:   Thu, 11 Oct 2018 15:09:38 -0700
Message-ID: <20181011220938.1408.87333.stgit@localhost.localdomain>
In-Reply-To: <20181011220134.1408.63391.stgit@localhost.localdomain>
References: <20181011220134.1408.63391.stgit@localhost.localdomain>
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
index 5ba366c1cb83..81472dc44a70 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -826,7 +826,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async_schedule(__device_attach_async_helper, dev);
+			async_schedule_dev(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
 		}
@@ -927,7 +927,7 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver) {
 			get_device(dev);
 			dev_set_drvdata(dev, drv);
-			async_schedule(__driver_attach_async_helper, dev);
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		}
 		device_unlock(dev);
 		return 0;

