Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9561C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155C20890
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hy42urMI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Idl/7upH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8155C20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeGHRes (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:34:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeGHRep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:34:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14C9F60B3C; Sun,  8 Jul 2018 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071285;
        bh=R1gcNArpy3wnZXhn8mZNzbM83k4i6alX2IgmXFcenZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hy42urMIc18V0AroUWzVcBZ+8S1doLuu6TyYai6U+u2MJIxaBdGznNH6MZCvlImuW
         tJbZ9VIRJB23GKIBjrWRfoBHbJw2RytbdD0vfCQDtqXQeD1UyF43zYIi0UKIkF2tex
         KNZRPNYK5wyQpCS5BsiBqNwtB8g/P+Nc+i8o7490=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32AC1607DC;
        Sun,  8 Jul 2018 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071283;
        bh=R1gcNArpy3wnZXhn8mZNzbM83k4i6alX2IgmXFcenZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Idl/7upH90ExDN5ynBmZnpeuuxGcfe/T3CwNUT1ni/VK7RmvyRSLwBDRo0kUJFRkX
         Ao/MIIsdDKxvBVZbbhqKnM71zi6O6f1n6Th2qMR3GEyZMMQ0nt7JThHyXOTSwaRe06
         +qHL3S0TvEEg625LVAEUWQt21xR8AwaSStlrLxLI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32AC1607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, rjw@rjwysocki.net, robdclark@gmail.com,
        linux-pm@vger.kernel.org, freedreno@lists.freedesktop.org,
        sboyd@kernel.org, tfiga@chromium.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org,
        vivek.gautam@codeaurora.org, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Sun,  8 Jul 2018 23:04:12 +0530
Message-Id: <20180708173413.1965-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>
---

 - Change since v11
   * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.

 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 09265e206e2d..916cde4954d2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	if (pm_runtime_enabled(smmu->dev) &&
+	    !device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+		dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
+			dev_name(dev));
+		ret = -ENODEV;
+		goto out_unlink;
+	}
+
 	return 0;
 
+out_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_master_free_smes(fwspec);
 out_cfg_free:
 	kfree(cfg);
 out_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

