Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E8F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iutxEYln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E8F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbeGYT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:28:08 -0400
Received: from localhost.localdomain (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5D220893;
        Wed, 25 Jul 2018 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532542519;
        bh=2rsjs1XTo17y7tXZ7z32CB+LMIjxYQA3SyqO+W/tAMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iutxEYlnkRlXb+z7Skgz1epL5/wSWQWoAt69OjUFV1DOIsuuofHs8rB8YBBXWfsdy
         quo3LIHNohs2sQYCZ1Ai65/GUpDGZzOuxElxuN20cDGzK8bPKX9ZryJFGOruZXaUK9
         INM1E/Ns0Mu69DuEWsX4k/SaBu0Rbn0LfcrSsdI4=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alan Tull <atull@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 2/2] fpga: do not access region struct after fpga_region_unregister
Date:   Wed, 25 Jul 2018 13:15:14 -0500
Message-Id: <20180725181514.3501-2-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180725181514.3501-1-atull@kernel.org>
References: <20180725181514.3501-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPGA region class's dev_release handles freeing the struct
fpga_region when fpga_region_unregister() unregisters the device.  A
couple drivers were accessing the region struct after it had been
freed.  Save off the pointer to the mgr before the region struct gets
freed.

Signed-off-by: Alan Tull <atull@kernel.org>
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

