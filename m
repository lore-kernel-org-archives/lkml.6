Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C926C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfAXXJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:09:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:21167 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfAXXIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:08:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 15:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="313295772"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2019 15:08:26 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 07/10] acpi/hmat: Register performance attributes
Date:   Thu, 24 Jan 2019 16:07:21 -0700
Message-Id: <20190124230724.10022-8-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190124230724.10022-1-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the local attached performace access attributes with the memory's
node if HMAT provides the locality table. While HMAT does make it possible
to know performance for all possible initiator-target pairings, we export
only the local and matching pairings at this time.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/Kconfig |  1 +
 drivers/acpi/hmat/hmat.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
index c9637e2e7514..08e972ead159 100644
--- a/drivers/acpi/hmat/Kconfig
+++ b/drivers/acpi/hmat/Kconfig
@@ -2,6 +2,7 @@
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
 	depends on ACPI_NUMA
+	select HMEM_REPORTING
 	help
 	 If set, this option causes the kernel to set the memory NUMA node
 	 relationships and access attributes in accordance with ACPI HMAT
diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index 85fd835c2e23..917e6122b3f0 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -430,6 +430,19 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 		hmat_register_if_local(target, initiator);
 }
 
+static __init void hmat_register_target_perf(struct memory_target *target)
+{
+	unsigned mem_nid = pxm_to_node(target->memory_pxm);
+	struct node_hmem_attrs hmem_attrs = {
+		.read_bandwidth	= target->read_bandwidth,
+		.write_bandwidth= target->write_bandwidth,
+		.read_latency	= target->read_latency,
+		.write_latency	= target->write_latency,
+	};
+
+	node_set_perf_attrs(mem_nid, &hmem_attrs, 0);
+}
+
 static __init void hmat_register_targets(void)
 {
 	struct memory_target *target, *tnext;
@@ -439,6 +452,7 @@ static __init void hmat_register_targets(void)
 	list_for_each_entry_safe(target, tnext, &targets, node) {
 		list_del(&target->node);
 		hmat_register_target_initiators(target);
+		hmat_register_target_perf(target);
 		kfree(target);
 	}
 
-- 
2.14.4

