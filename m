Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F054DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C6E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeIZDC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:02:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:12371 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeIZDC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:02:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77236369"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:53:02 -0700
Subject: [PATCH 1/2] nvdimm: Hold reference on parent while scheduling async
 init
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org
Date:   Tue, 25 Sep 2018 13:53:02 -0700
Message-ID: <20180925205301.6182.58728.stgit@localhost.localdomain>
In-Reply-To: <20180925204801.6182.73167.stgit@localhost.localdomain>
References: <20180925204801.6182.73167.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike asynchronous initialization in the core we have not yet associated
the device with the parent, and as such the device doesn't hold a reference
to the parent.

In order to resolve that we should be holding a reference on the parent
until the asynchronous initialization has completed.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/nvdimm/bus.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 8aae6dcc839f..9148015ed803 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -488,6 +488,8 @@ static void nd_async_device_register(void *d, async_cookie_t cookie)
 		put_device(dev);
 	}
 	put_device(dev);
+	if (dev->parent)
+		put_device(dev->parent);
 }
 
 static void nd_async_device_unregister(void *d, async_cookie_t cookie)
@@ -507,6 +509,8 @@ void __nd_device_register(struct device *dev)
 	if (!dev)
 		return;
 	dev->bus = &nvdimm_bus_type;
+	if (dev->parent)
+		get_device(dev->parent);
 	get_device(dev);
 	async_schedule_domain(nd_async_device_register, dev,
 			&nd_async_domain);

