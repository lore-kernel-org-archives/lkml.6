Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4AAC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F8E20850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfASBAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:00:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:58459 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfASBAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:00:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 17:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,493,1539673200"; 
   d="scan'208";a="119662427"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2019 17:00:00 -0800
Subject: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Jan 2019 16:47:23 -0800
Message-ID: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In recent days, 2 engineers, including the original author of
nd_pfn_init(), overlooked the internal call to nd_pfn_validate() and the
implications to memory allocation.

Clarify this situation to help anyone that reads through this code in
the future.

Reported-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/btt_devs.c |    5 +++++
 drivers/nvdimm/dax_devs.c |    5 +++++
 drivers/nvdimm/pfn_devs.c |   21 +++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 795ad4ff35ca..e0a6f2491e57 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -354,6 +354,11 @@ int nd_btt_probe(struct device *dev, struct nd_namespace_common *ndns)
 		put_device(btt_dev);
 	}
 
+	/*
+	 * Successful probe indicates to the caller that an nd_btt
+	 * personality device has been registered and the caller can
+	 * fail the probe of the baseline namespace device.
+	 */
 	return rc;
 }
 EXPORT_SYMBOL(nd_btt_probe);
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 0453f49dc708..65010d955fa7 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -136,6 +136,11 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 	} else
 		__nd_device_register(dax_dev);
 
+	/*
+	 * Successful probe indicates to the caller that a device-dax
+	 * personality device has been registered and the caller can
+	 * fail the probe of the baseline namespace device.
+	 */
 	return rc;
 }
 EXPORT_SYMBOL(nd_dax_probe);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 6f22272e8d80..a8783b5a76ba 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -576,6 +576,11 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 	} else
 		__nd_device_register(pfn_dev);
 
+	/*
+	 * Successful probe indicates to the caller that an nd_pfn
+	 * personality device has been registered and the caller can
+	 * fail the probe of the baseline namespace device.
+	 */
 	return rc;
 }
 EXPORT_SYMBOL(nd_pfn_probe);
@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		sig = DAX_SIG;
 	else
 		sig = PFN_SIG;
+
+	/*
+	 * Check for an existing 'pfn' superblock before writing a new
+	 * one. The intended flow is that on the first probe of an
+	 * nd_{pfn,dax} device the superblock is calculated and written
+	 * to the namespace. In this case nd_pfn_validate() returns
+	 * -ENODEV because no valid superblock exists currently.
+	 *
+	 * On subsequent probes nd_pfn_validate() will find a valid
+	 * superblock and return 0.
+	 *
+	 * If an assumption of the superblock has been violated, like a
+	 * change to the physical alignment of the namespace,
+	 * nd_pfn_validate() will return an error other than -ENODEV to
+	 * fail probing.
+	 */
 	rc = nd_pfn_validate(nd_pfn, sig);
 	if (rc != -ENODEV)
 		return rc;

