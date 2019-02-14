Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3D2192D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406841AbfBNUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:32:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:9049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394555AbfBNUcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:32:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,370,1544515200"; 
   d="scan'208";a="116289937"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2019 12:32:04 -0800
Subject: [PATCH v2] nfit/ars: Allow root to busy-poll the ARS state machine
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>, linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 12:19:26 -0800
Message-ID: <155017550946.954637.8586902409974005660.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARS implementation implements exponential back-off on the poll
interval to prevent high-frequency access to the DIMM / platform
interface. Depending on when the ARS completes the poll interval may
exceed the completion event by minutes. Allow root to reset the timeout
each time it probes the status. A one-second timeout is still enforced,
but root can otherwise can control the poll interval.

Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Change since v1: Use mod_delayed_work() instead of queue_delayed_work()
to modify the timeout for existing work.

 drivers/acpi/nfit/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 934be96dc149..b1ab593a808a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1328,6 +1328,12 @@ static ssize_t scrub_show(struct device *dev,
 		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
 				acpi_desc->scrub_busy
 				&& !acpi_desc->cancel ? "+\n" : "\n");
+		/* Allow an admin to poll the busy state at a higher rate */
+		if (acpi_desc->scrub_busy && !acpi_desc->cancel
+				&& capable(CAP_SYS_RAWIO)) {
+			acpi_desc->scrub_tmo = 1;
+			mod_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
+		}
 		mutex_unlock(&acpi_desc->init_mutex);
 	}
 	device_unlock(dev);

