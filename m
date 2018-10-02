Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5114208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5114208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeJBUMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeJBUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:33 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A633C20;
        Tue,  2 Oct 2018 13:29:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.18 140/228] intel_th: Fix resource handling for ACPI glue layer
Date:   Tue,  2 Oct 2018 06:23:57 -0700
Message-Id: <20181002132508.774560466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit ebe4582281d6e90972f057318a6edea14810ea48 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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
@@ -581,6 +581,7 @@ intel_th_subdevice_alloc(struct intel_th
 	struct intel_th_device *thdev;
 	struct resource res[3];
 	unsigned int req = 0;
+	bool is64bit = false;
 	int r, err;
 
 	thdev = intel_th_device_alloc(th, subdev->type, subdev->name,
@@ -590,12 +591,18 @@ intel_th_subdevice_alloc(struct intel_th
 
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
@@ -604,6 +611,8 @@ intel_th_subdevice_alloc(struct intel_th
 		 */
 		if (!res[r].end && res[r].flags == IORESOURCE_MEM) {
 			bar = res[r].start;
+			if (is64bit)
+				bar *= 2;
 			res[r].start = 0;
 			res[r].end = resource_size(&devres[bar]) - 1;
 		}


