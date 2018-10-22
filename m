Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59896C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228820665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C228820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeJWEim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:13946 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="80737009"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2018 13:18:41 -0700
Subject: [PATCH 4/9] dax/kmem: allow PMEM devices to bind to KMEM driver
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:24 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201324.EBB64302@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, a persistent memory device's mode must be coordinated
with the driver to which it needs to bind.  To change it from the
fsdax to the device-dax driver, you first change the mode of the
device itself.

Instead of adding a new device mode, allow the PMEM mode to also
bind to the KMEM driver.

As I write this, I'm realizing that it might have just been
better to add a new device mode, rather than hijacking the PMEM
eode.  If this is the case, please speak up, NVDIMM folks.  :)

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>

---

 b/drivers/nvdimm/bus.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff -puN drivers/nvdimm/bus.c~dax-kmem-try-again-2018-3-bus-match-override drivers/nvdimm/bus.c
--- a/drivers/nvdimm/bus.c~dax-kmem-try-again-2018-3-bus-match-override	2018-10-22 13:12:22.522930391 -0700
+++ b/drivers/nvdimm/bus.c	2018-10-22 13:12:22.525930391 -0700
@@ -464,11 +464,24 @@ static struct nd_device_driver nd_bus_dr
 static int nvdimm_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct nd_device_driver *nd_drv = to_nd_device_driver(drv);
+	bool match;
 
 	if (is_nvdimm_bus(dev) && nd_drv == &nd_bus_driver)
 		return true;
 
-	return !!test_bit(to_nd_device_type(dev), &nd_drv->type);
+	match = !!test_bit(to_nd_device_type(dev), &nd_drv->type);
+
+	/*
+	 * We allow PMEM devices to be bound to the KMEM driver.
+	 * Force a match if we detect a PMEM device type but
+	 * a KMEM device driver.
+	 */
+	if (!match &&
+	    (to_nd_device_type(dev) == ND_DEVICE_DAX_PMEM) &&
+	    (nd_drv->type == ND_DRIVER_DAX_KMEM))
+		match = true;
+
+	return match;
 }
 
 static ASYNC_DOMAIN_EXCLUSIVE(nd_async_domain);
_
