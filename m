Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E45DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFB2222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfBLVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:37:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:57721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732533AbfBLVha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:37:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 13:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="115696737"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2019 13:37:29 -0800
Subject: [PATCH 2/7] libnvdimm/pmem: Honor force_raw for legacy pmem regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, linux-fsdevel@vger.kernel.org
Date:   Tue, 12 Feb 2019 13:24:51 -0800
Message-ID: <155000669130.348031.13764885263577554365.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For recovery, where non-dax access is needed to a given physical address
range, and testing, allow the 'force_raw' attribute to override the
default establishment of a dev_pagemap.

Otherwise without this capability it is possible to end up with a
namespace that can not be activated due to corrupted info-block, and one
that can not be repaired due to a section collision.

Cc: <stable@vger.kernel.org>
Fixes: 004f1afbe199 ("libnvdimm, pmem: direct map legacy pmem by default")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 4b077555ac70..33a3b23b3db7 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -138,6 +138,7 @@ bool nd_is_uuid_unique(struct device *dev, u8 *uuid)
 bool pmem_should_map_pages(struct device *dev)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	struct nd_namespace_common *ndns = to_ndns(dev);
 	struct nd_namespace_io *nsio;
 
 	if (!IS_ENABLED(CONFIG_ZONE_DEVICE))
@@ -149,6 +150,9 @@ bool pmem_should_map_pages(struct device *dev)
 	if (is_nd_pfn(dev) || is_nd_btt(dev))
 		return false;
 
+	if (ndns->force_raw)
+		return false;
+
 	nsio = to_nd_namespace_io(dev);
 	if (region_intersects(nsio->res.start, resource_size(&nsio->res),
 				IORESOURCE_SYSTEM_RAM,

