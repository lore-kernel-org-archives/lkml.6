Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CFC25C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E1D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965424AbeFOArV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:47:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:44122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965405AbeFOArR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 17:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237299799"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2018 17:47:16 -0700
Subject: [PATCH 1/3] libnvdimm: Introduce locked DIMM capacity support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jun 2018 17:37:19 -0700
Message-ID: <152902303977.10541.4641412754161257441.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DIMM is locked its namespace label area may not be. Introduce the
distinction of locked namespaces to allow namespace enumeration while
the capacity is locked.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm.c           |   24 ++++++++++++++++++++++--
 drivers/nvdimm/namespace_devs.c |   23 +++++++++++++++++++++++
 drivers/nvdimm/nd.h             |    1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 233907889f96..6c8fb7590838 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -34,6 +34,9 @@ static int nvdimm_probe(struct device *dev)
 		return rc;
 	}
 
+	/* reset locked, to be validated below... */
+	nvdimm_clear_locked(dev);
+
 	ndd = kzalloc(sizeof(*ndd), GFP_KERNEL);
 	if (!ndd)
 		return -ENOMEM;
@@ -48,12 +51,30 @@ static int nvdimm_probe(struct device *dev)
 	get_device(dev);
 	kref_init(&ndd->kref);
 
+	/*
+	 * EACCES failures reading the namespace label-area-properties
+	 * are interpreted as the DIMM capacity being locked but the
+	 * namespace labels themselves being accessible.
+	 */
 	rc = nvdimm_init_nsarea(ndd);
-	if (rc == -EACCES)
+	if (rc == -EACCES) {
+		/*
+		 * See nvdimm_namespace_common_probe() where we fail to
+		 * allow namespaces to probe while the DIMM is locked,
+		 * but we do allow for namespace enumeration.
+		 */
 		nvdimm_set_locked(dev);
+		rc = 0;
+	}
 	if (rc)
 		goto err;
 
+	/*
+	 * EACCES failures reading the namespace label-data are
+	 * interpreted as the label area being locked in addition to the
+	 * DIMM capacity. We fail the dimm probe to prevent regions from
+	 * attempting to parse the label area.
+	 */
 	rc = nvdimm_init_config_data(ndd);
 	if (rc == -EACCES)
 		nvdimm_set_locked(dev);
@@ -72,7 +93,6 @@ static int nvdimm_probe(struct device *dev)
 		if (rc == 0)
 			nvdimm_set_aliasing(dev);
 	}
-	nvdimm_clear_locked(dev);
 	nvdimm_bus_unlock(dev);
 
 	if (rc)
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 28afdd668905..cb322f2bc605 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1144,6 +1144,26 @@ resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nvdimm_namespace_capacity);
 
+bool nvdimm_namespace_locked(struct nd_namespace_common *ndns)
+{
+	int i;
+	bool locked = false;
+	struct device *dev = &ndns->dev;
+	struct nd_region *nd_region = to_nd_region(dev->parent);
+
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+		struct nvdimm *nvdimm = nd_mapping->nvdimm;
+
+		if (test_bit(NDD_LOCKED, &nvdimm->flags)) {
+			dev_dbg(dev, "%s locked\n", nvdimm_name(nvdimm));
+			locked = true;
+		}
+	}
+	return locked;
+}
+EXPORT_SYMBOL(nvdimm_namespace_locked);
+
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1695,6 +1715,9 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		}
 	}
 
+	if (nvdimm_namespace_locked(ndns))
+		return ERR_PTR(-EACCES);
+
 	size = nvdimm_namespace_capacity(ndns);
 	if (size < ND_MIN_NAMESPACE_SIZE) {
 		dev_dbg(&ndns->dev, "%pa, too small must be at least %#x\n",
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 32e0364b48b9..9d17abd9f8d0 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -357,6 +357,7 @@ struct resource *nvdimm_allocate_dpa(struct nvdimm_drvdata *ndd,
 		struct nd_label_id *label_id, resource_size_t start,
 		resource_size_t n);
 resource_size_t nvdimm_namespace_capacity(struct nd_namespace_common *ndns);
+bool nvdimm_namespace_locked(struct nd_namespace_common *ndns);
 struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev);
 int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns);
 int nvdimm_namespace_detach_btt(struct nd_btt *nd_btt);

