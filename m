Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D092C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23AC20659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23AC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJNANm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:13:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:46425 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeJNANm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:13:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2018 09:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,377,1534834800"; 
   d="scan'208";a="99136291"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2018 09:35:53 -0700
Subject: [PATCH] libnvdimm: Provide a simplified nvdimm_create() for
 non-security enabled DIMMs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Sat, 13 Oct 2018 09:24:05 -0700
Message-ID: <153944784534.1508664.6365625408163933467.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not require libnvdimm provider implementations to include security
parameters if the bus / dimm-devices do not have that support.

Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c   |    2 +-
 drivers/nvdimm/dimm_devs.c |    4 ++--
 include/linux/libnvdimm.h  |   11 ++++++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a287a773012b..a0dfbcf8220d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1992,7 +1992,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 
 		flush = nfit_mem->nfit_flush ? nfit_mem->nfit_flush->flush
 			: NULL;
-		nvdimm = nvdimm_create(acpi_desc->nvdimm_bus, nfit_mem,
+		nvdimm = __nvdimm_create(acpi_desc->nvdimm_bus, nfit_mem,
 				acpi_nfit_dimm_attribute_groups,
 				flags, cmd_mask, flush ? flush->hint_count : 0,
 				nfit_mem->flush_wpq, &nfit_mem->id[0],
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index d1bfb8975b07..5d34251c4f3b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -459,7 +459,7 @@ struct attribute_group nvdimm_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
 
-struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
+struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
 		const struct attribute_group **groups, unsigned long flags,
 		unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
@@ -496,7 +496,7 @@ struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
 
 	return nvdimm;
 }
-EXPORT_SYMBOL_GPL(nvdimm_create);
+EXPORT_SYMBOL_GPL(__nvdimm_create);
 
 int alias_dpa_busy(struct device *dev, void *data)
 {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index c352b8195675..1071fe12081b 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -207,11 +207,20 @@ const char *nvdimm_name(struct nvdimm *nvdimm);
 struct kobject *nvdimm_kobj(struct nvdimm *nvdimm);
 unsigned long nvdimm_cmd_mask(struct nvdimm *nvdimm);
 void *nvdimm_provider_data(struct nvdimm *nvdimm);
-struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
+struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus, void *provider_data,
 		const struct attribute_group **groups, unsigned long flags,
 		unsigned long cmd_mask, int num_flush,
 		struct resource *flush_wpq, const char *dimm_id,
 		const struct nvdimm_security_ops *sec_ops);
+static inline struct nvdimm *nvdimm_create(struct nvdimm_bus *nvdimm_bus,
+		void *provider_data, const struct attribute_group **groups,
+		unsigned long flags, unsigned long cmd_mask, int num_flush,
+		struct resource *flush_wpq)
+{
+	return __nvdimm_create(nvdimm_bus, provider_data, groups, flags,
+			cmd_mask, num_flush, flush_wpq, NULL, NULL);
+}
+
 const struct nd_cmd_desc *nd_cmd_dimm_desc(int cmd);
 const struct nd_cmd_desc *nd_cmd_bus_desc(int cmd);
 u32 nd_cmd_in_size(struct nvdimm *nvdimm, int cmd,

