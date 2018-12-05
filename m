Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C32205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C32205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeLER0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:26:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:37841 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbeLERZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="116247750"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2018 09:25:18 -0800
Subject: [driver-core PATCH v8 1/9] driver core: Move async_synchronize_full
 call
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 05 Dec 2018 09:25:18 -0800
Message-ID: <154403071891.11544.9860064260259005955.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the async_synchronize_full call out of __device_release_driver and
into driver_detach.

The idea behind this is that the async_synchronize_full call will only
guarantee that any existing async operations are flushed. This doesn't do
anything to guarantee that a hotplug event that may occur while we are
doing the release of the driver will not be asynchronously scheduled.

By moving this into the driver_detach path we can avoid potential deadlocks
as we aren't holding the device lock at this point and we should not have
the driver we want to flush loaded so the flush will take care of any
asynchronous events the driver we are detaching might have scheduled.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 689ac9dc6d81..88713f182086 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -931,9 +931,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
-			async_synchronize_full();
-
 		while (device_links_busy(dev)) {
 			device_unlock(dev);
 			if (parent)
@@ -1039,6 +1036,9 @@ void driver_detach(struct device_driver *drv)
 	struct device_private *dev_prv;
 	struct device *dev;
 
+	if (driver_allows_async_probing(drv))
+		async_synchronize_full();
+
 	for (;;) {
 		spin_lock(&drv->p->klist_devices.k_lock);
 		if (list_empty(&drv->p->klist_devices.k_list)) {

