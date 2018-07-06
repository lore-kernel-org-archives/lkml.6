Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59722449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC59722449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934276AbeGFSaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:30:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:64018 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933978AbeGFSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:30:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 11:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,317,1526367600"; 
   d="scan'208";a="213979564"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2018 11:30:11 -0700
Subject: [PATCH] acpi, nfit: Fix scrub idle detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Lukasz Dorau <lukasz.dorau@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 06 Jul 2018 11:20:13 -0700
Message-ID: <153090121374.28055.14156217568809004334.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notification of scrub completion happens within the scrub workqueue.
That can clearly race someone running scrub_show() and work_busy()
before the workqueue has a chance to flush the recently completed work.
Add a flag to reliably indicate the idle vs busy state. Without this
change applications using poll(2) to wait for scrub-completion may
falsely wakeup and read ARS as being busy even though the thread is
going idle and then hang indefinitely.

Fixes: bc6ba8085842 ("nfit, address-range-scrub: rework and simplify ARS...")
Cc: <stable@vger.kernel.org>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Lukasz Dorau <lukasz.dorau@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   37 ++++++++++++++++++++++++++-----------
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 471402cee1f1..cd26484d1cee 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1275,7 +1275,7 @@ static ssize_t scrub_show(struct device *dev,
 
 		mutex_lock(&acpi_desc->init_mutex);
 		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				work_busy(&acpi_desc->dwork.work)
+				acpi_desc->scrub_busy
 				&& !acpi_desc->cancel ? "+\n" : "\n");
 		mutex_unlock(&acpi_desc->init_mutex);
 	}
@@ -2941,6 +2941,25 @@ static unsigned int __acpi_nfit_scrub(struct acpi_nfit_desc *acpi_desc,
 	return 0;
 }
 
+static void sched_ars(struct acpi_nfit_desc *acpi_desc, unsigned int tmo)
+{
+	lockdep_assert_held(&acpi_desc->init_mutex);
+
+	acpi_desc->scrub_busy = 1;
+	acpi_desc->scrub_tmo = tmo;
+	queue_delayed_work(nfit_wq, &acpi_desc->dwork, tmo * HZ);
+}
+
+static void notify_ars_done(struct acpi_nfit_desc *acpi_desc)
+{
+	lockdep_assert_held(&acpi_desc->init_mutex);
+
+	acpi_desc->scrub_busy = 0;
+	acpi_desc->scrub_count++;
+	if (acpi_desc->scrub_count_state)
+		sysfs_notify_dirent(acpi_desc->scrub_count_state);
+}
+
 static void acpi_nfit_scrub(struct work_struct *work)
 {
 	struct acpi_nfit_desc *acpi_desc;
@@ -2951,14 +2970,10 @@ static void acpi_nfit_scrub(struct work_struct *work)
 	mutex_lock(&acpi_desc->init_mutex);
 	query_rc = acpi_nfit_query_poison(acpi_desc);
 	tmo = __acpi_nfit_scrub(acpi_desc, query_rc);
-	if (tmo) {
-		queue_delayed_work(nfit_wq, &acpi_desc->dwork, tmo * HZ);
-		acpi_desc->scrub_tmo = tmo;
-	} else {
-		acpi_desc->scrub_count++;
-		if (acpi_desc->scrub_count_state)
-			sysfs_notify_dirent(acpi_desc->scrub_count_state);
-	}
+	if (tmo)
+		sched_ars(acpi_desc, tmo);
+	else
+		notify_ars_done(acpi_desc);
 	memset(acpi_desc->ars_status, 0, acpi_desc->max_ars);
 	mutex_unlock(&acpi_desc->init_mutex);
 }
@@ -3039,7 +3054,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 			break;
 		}
 
-	queue_delayed_work(nfit_wq, &acpi_desc->dwork, 0);
+	sched_ars(acpi_desc, 0);
 	return 0;
 }
 
@@ -3241,7 +3256,7 @@ int acpi_nfit_ars_rescan(struct acpi_nfit_desc *acpi_desc, unsigned long flags)
 		}
 	}
 	if (scheduled) {
-		queue_delayed_work(nfit_wq, &acpi_desc->dwork, 0);
+		sched_ars(acpi_desc, 0);
 		dev_dbg(dev, "ars_scan triggered\n");
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 7d15856a739f..a97ff42fe311 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -203,6 +203,7 @@ struct acpi_nfit_desc {
 	unsigned int max_ars;
 	unsigned int scrub_count;
 	unsigned int scrub_mode;
+	unsigned int scrub_busy:1;
 	unsigned int cancel:1;
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;

