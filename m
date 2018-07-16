Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510B4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B8B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B8B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeGPIEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43AA9CA0;
        Mon, 16 Jul 2018 07:38:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Lukasz Dorau <lukasz.dorau@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.17 42/67] acpi, nfit: Fix scrub idle detection
Date:   Mon, 16 Jul 2018 09:35:11 +0200
Message-Id: <20180716073449.832521288@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 33cc2c9667561b224215e6dfb5bf98e8fa17914e upstream.

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
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Lukasz Dorau <lukasz.dorau@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   44 +++++++++++++++++++++++++++++++++-----------
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 34 insertions(+), 11 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1272,7 +1272,7 @@ static ssize_t scrub_show(struct device
 
 		mutex_lock(&acpi_desc->init_mutex);
 		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				work_busy(&acpi_desc->dwork.work)
+				acpi_desc->scrub_busy
 				&& !acpi_desc->cancel ? "+\n" : "\n");
 		mutex_unlock(&acpi_desc->init_mutex);
 	}
@@ -2949,6 +2949,32 @@ static unsigned int __acpi_nfit_scrub(st
 	return 0;
 }
 
+static void __sched_ars(struct acpi_nfit_desc *acpi_desc, unsigned int tmo)
+{
+	lockdep_assert_held(&acpi_desc->init_mutex);
+
+	acpi_desc->scrub_busy = 1;
+	/* note this should only be set from within the workqueue */
+	if (tmo)
+		acpi_desc->scrub_tmo = tmo;
+	queue_delayed_work(nfit_wq, &acpi_desc->dwork, tmo * HZ);
+}
+
+static void sched_ars(struct acpi_nfit_desc *acpi_desc)
+{
+	__sched_ars(acpi_desc, 0);
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
@@ -2959,14 +2985,10 @@ static void acpi_nfit_scrub(struct work_
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
+		__sched_ars(acpi_desc, tmo);
+	else
+		notify_ars_done(acpi_desc);
 	memset(acpi_desc->ars_status, 0, acpi_desc->max_ars);
 	mutex_unlock(&acpi_desc->init_mutex);
 }
@@ -3047,7 +3069,7 @@ static int acpi_nfit_register_regions(st
 			break;
 		}
 
-	queue_delayed_work(nfit_wq, &acpi_desc->dwork, 0);
+	sched_ars(acpi_desc);
 	return 0;
 }
 
@@ -3249,7 +3271,7 @@ int acpi_nfit_ars_rescan(struct acpi_nfi
 		}
 	}
 	if (scheduled) {
-		queue_delayed_work(nfit_wq, &acpi_desc->dwork, 0);
+		sched_ars(acpi_desc);
 		dev_dbg(dev, "ars_scan triggered\n");
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
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


