Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32220857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JlSOO+7d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I/zCcTY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E32220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbeG0IXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:23:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbeG0IXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:23:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 36CB960BE8; Fri, 27 Jul 2018 07:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532674986;
        bh=i7U2PtmRaET/6Nggtmoedh5WeXZt18o3U1Gh4JaLFOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlSOO+7dscpTLkIU2M2k+QmUuQcC51//Fvlp9XIkNUFtrQd4jntsHtWcG2whrPCp/
         Op0fTc48sxL5+qvk//w3Ci0mW5RHVzL7xJExtngjOIl+ehd3V6Rg1lNcRwumu9MEkM
         PQAilZD3xK9aEOoeWS2kjX7a4pjAeSy66CfWh2Q0=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 989E460BE1;
        Fri, 27 Jul 2018 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532674980;
        bh=i7U2PtmRaET/6Nggtmoedh5WeXZt18o3U1Gh4JaLFOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/zCcTY76XcMnXw7LkpXOemaUL24qUurvvU3VUR7r9f7ilHtf/g+oFvklM+5H1Ybl
         LYEc5UIirQ9CPUAAWzDJHiO18buuWIDN/dcI9Nfwo/rP6xhSyrOfw2FT1H8JRnmply
         WOK3wphyGVdP4jN4oBprit0WeGK0xAVtjNVc8J9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 989E460BE1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v14 3/4] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Fri, 27 Jul 2018 12:32:23 +0530
Message-Id: <20180727070224.23966-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
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
---

Change since v13:
 - No change.

 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1efa5681b905..e558abf1ecfc 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1461,6 +1461,9 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return 0;
 
 out_cfg_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

