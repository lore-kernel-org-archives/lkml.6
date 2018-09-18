Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F1AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F049B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F049B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeIRSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:43:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:13543 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeIRSni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:43:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 06:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="87121871"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2018 06:11:04 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [GIT PULL 2/3] intel_th: Fix resource handling for ACPI glue layer
Date:   Tue, 18 Sep 2018 16:10:48 +0300
Message-Id: <20180918131049.74840-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180918131049.74840-1-alexander.shishkin@linux.intel.com>
References: <20180918131049.74840-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core of the driver expects the resource array from the glue layer
to be indexed by even numbers, as is the case for 64-bit PCI resources.
This doesn't hold true for others, ACPI in this instance, which leads
to an out-of-bounds access and an ioremap() on whatever address that
access fetches.

This patch fixes the problem by reading resource array differently based
on whether the 64-bit flag is set, which would indicate PCI glue layer.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: ebc57e399b8e ("intel_th: Add ACPI glue layer")
CC: stable@vger.kernel.org # v4.17+
---
 drivers/hwtracing/intel_th/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 4e70ecee2103..fc6b7f8b62fb 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -488,7 +488,7 @@ static const struct intel_th_subdevice {
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.start	= TH_MMIO_SW,
+				.start	= 1, /* use resource[1] */
 				.end	= 0,
 				.flags	= IORESOURCE_MEM,
 			},
@@ -581,6 +581,7 @@ intel_th_subdevice_alloc(struct intel_th *th,
 	struct intel_th_device *thdev;
 	struct resource res[3];
 	unsigned int req = 0;
+	bool is64bit = false;
 	int r, err;
 
 	thdev = intel_th_device_alloc(th, subdev->type, subdev->name,
@@ -590,12 +591,18 @@ intel_th_subdevice_alloc(struct intel_th *th,
 
 	thdev->drvdata = th->drvdata;
 
+	for (r = 0; r < th->num_resources; r++)
+		if (th->resource[r].flags & IORESOURCE_MEM_64) {
+			is64bit = true;
+			break;
+		}
+
 	memcpy(res, subdev->res,
 	       sizeof(struct resource) * subdev->nres);
 
 	for (r = 0; r < subdev->nres; r++) {
 		struct resource *devres = th->resource;
-		int bar = TH_MMIO_CONFIG;
+		int bar = 0; /* cut subdevices' MMIO from resource[0] */
 
 		/*
 		 * Take .end == 0 to mean 'take the whole bar',
@@ -604,6 +611,8 @@ intel_th_subdevice_alloc(struct intel_th *th,
 		 */
 		if (!res[r].end && res[r].flags == IORESOURCE_MEM) {
 			bar = res[r].start;
+			if (is64bit)
+				bar *= 2;
 			res[r].start = 0;
 			res[r].end = resource_size(&devres[bar]) - 1;
 		}
-- 
2.18.0

