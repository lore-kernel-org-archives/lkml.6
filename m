Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B922192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503064AbfBNUXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:23:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:45004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390400AbfBNUXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:23:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="138698904"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2019 12:22:59 -0800
Subject: [PATCH 3/6] nfit/ars: Allow root to busy-poll the ARS state machine
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 12:10:21 -0800
Message-ID: <155017502147.944049.2893295352368862579.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 drivers/acpi/nfit/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 934be96dc149..5ec0e19760ea 100644
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
+			queue_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
+		}
 		mutex_unlock(&acpi_desc->init_mutex);
 	}
 	device_unlock(dev);

