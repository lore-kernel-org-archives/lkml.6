Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A4222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfBOT4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:56:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:30606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732893AbfBOT4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:56:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 11:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="147224681"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2019 11:56:45 -0800
Subject: [PATCH v2 4/6] nfit/ars: Introduce scrub_flags
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 11:44:07 -0800
Message-ID: <155025984777.1043225.11995149236324481755.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introducing new flags to gate whether ARS results are
stale, or poll the completion state, convert the existing flags to an
unsigned long with enumerated values. This conversion allows the flags
to be atomically updated outside of ->init_mutex.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   30 +++++++++++++++++-------------
 drivers/acpi/nfit/nfit.h |    8 ++++++--
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 9a23ae74e82b..90312892093e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1317,19 +1317,23 @@ static ssize_t scrub_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvdimm_bus_descriptor *nd_desc;
+	struct acpi_nfit_desc *acpi_desc;
 	ssize_t rc = -ENXIO;
+	bool busy;
 
 	device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
-	if (nd_desc) {
-		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-
-		mutex_lock(&acpi_desc->init_mutex);
-		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				acpi_desc->scrub_busy
-				&& !acpi_desc->cancel ? "+\n" : "\n");
-		mutex_unlock(&acpi_desc->init_mutex);
+	if (!nd_desc) {
+		device_unlock(dev);
+		return rc;
 	}
+	acpi_desc = to_acpi_desc(nd_desc);
+
+	mutex_lock(&acpi_desc->init_mutex);
+	busy = test_bit(ARS_BUSY, &acpi_desc->scrub_flags)
+		&& !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
+	rc = sprintf(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
+	mutex_unlock(&acpi_desc->init_mutex);
 	device_unlock(dev);
 	return rc;
 }
@@ -3072,7 +3076,7 @@ static unsigned int __acpi_nfit_scrub(struct acpi_nfit_desc *acpi_desc,
 
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	if (acpi_desc->cancel)
+	if (test_bit(ARS_CANCEL, &acpi_desc->scrub_flags))
 		return 0;
 
 	if (query_rc == -EBUSY) {
@@ -3146,7 +3150,7 @@ static void __sched_ars(struct acpi_nfit_desc *acpi_desc, unsigned int tmo)
 {
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	acpi_desc->scrub_busy = 1;
+	set_bit(ARS_BUSY, &acpi_desc->scrub_flags);
 	/* note this should only be set from within the workqueue */
 	if (tmo)
 		acpi_desc->scrub_tmo = tmo;
@@ -3162,7 +3166,7 @@ static void notify_ars_done(struct acpi_nfit_desc *acpi_desc)
 {
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	acpi_desc->scrub_busy = 0;
+	clear_bit(ARS_BUSY, &acpi_desc->scrub_flags);
 	acpi_desc->scrub_count++;
 	if (acpi_desc->scrub_count_state)
 		sysfs_notify_dirent(acpi_desc->scrub_count_state);
@@ -3451,7 +3455,7 @@ int acpi_nfit_ars_rescan(struct acpi_nfit_desc *acpi_desc,
 	struct nfit_spa *nfit_spa;
 
 	mutex_lock(&acpi_desc->init_mutex);
-	if (acpi_desc->cancel) {
+	if (test_bit(ARS_CANCEL, &acpi_desc->scrub_flags)) {
 		mutex_unlock(&acpi_desc->init_mutex);
 		return 0;
 	}
@@ -3530,7 +3534,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc_lock);
 
 	mutex_lock(&acpi_desc->init_mutex);
-	acpi_desc->cancel = 1;
+	set_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 	mutex_unlock(&acpi_desc->init_mutex);
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 871fb3de3b30..897ce10192a0 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -210,6 +210,11 @@ struct nfit_mem {
 	int family;
 };
 
+enum scrub_flags {
+	ARS_BUSY,
+	ARS_CANCEL,
+};
+
 struct acpi_nfit_desc {
 	struct nvdimm_bus_descriptor nd_desc;
 	struct acpi_table_header acpi_header;
@@ -231,8 +236,7 @@ struct acpi_nfit_desc {
 	unsigned int max_ars;
 	unsigned int scrub_count;
 	unsigned int scrub_mode;
-	unsigned int scrub_busy:1;
-	unsigned int cancel:1;
+	unsigned long scrub_flags;
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;
 	unsigned long bus_nfit_cmd_force_en;

