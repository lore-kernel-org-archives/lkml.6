Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58852086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MVBd1x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58852086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeIEBtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIEBtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:49:39 -0400
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACB220836;
        Tue,  4 Sep 2018 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536096163;
        bh=iyx33zltDo3rjY2T9mRTH7plLK6ugYNviVWl+bYExlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MVBd1x79HC0gTVYPmPdZKswf3PBTE+30/Yg6tqS8gYkz82F8FZMJzMBTIB6R7VeM
         BDa49+jvfajgjie3YwPbQc9c7LdznBv0SrhuFejMmKRdnSuUfSme04fragf1Njs+oB
         Qmn7fPpvMe5J18jhGJX4YCEt5sMPCVEcQ5FHdrLY=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 1/8] fpga: do not access region struct after fpga_region_unregister
Date:   Tue,  4 Sep 2018 16:22:30 -0500
Message-Id: <20180904212237.3078-2-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple drivers were accessing the region struct after it had been
freed.  Save off the pointer to the mgr before the region struct gets
freed.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: no change in v2 of patchset
---
 drivers/fpga/dfl-fme-region.c | 4 +++-
 drivers/fpga/of-fpga-region.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c..51a5ac2 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 
 #include "dfl-fme-pr.h"
@@ -66,9 +67,10 @@ static int fme_region_probe(struct platform_device *pdev)
 static int fme_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-	fpga_mgr_put(region->mgr);
+	fpga_mgr_put(mgr);
 
 	return 0;
 }
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35fabb8..052a134 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -437,9 +437,10 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 static int of_fpga_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
+	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
-	fpga_mgr_put(region->mgr);
+	fpga_mgr_put(mgr);
 
 	return 0;
 }
-- 
2.7.4

