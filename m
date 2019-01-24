Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CDAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B09E218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAXVmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:42:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:13840 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfAXVmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:42:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 13:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="109551314"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2019 13:42:49 -0800
Subject: [PATCH] device-dax: Auto-bind device after successful new_id
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Jan 2019 13:30:12 -0800
Message-ID: <154836541248.2998916.14581880959768387544.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical 'new_id' attribute behavior is to immediately attach a
device to its driver after a new device-id is added. Implement this
behavior for the dax bus.

Reported-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c620ad52d7e5..7053ab6419db 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -92,7 +92,10 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 	} else
 		/* dax_id already added */;
 	mutex_unlock(&dax_bus_lock);
-	return rc;
+
+	if (rc < 0)
+		return rc;
+	return driver_attach(drv);
 }
 
 static ssize_t new_id_store(struct device_driver *drv, const char *buf,

