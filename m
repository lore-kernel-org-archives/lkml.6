Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B60B208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zp3y6Gy9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JKFO5tkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B60B208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH0Onf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:43:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39536 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0Onf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:43:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5609B607C3; Mon, 27 Aug 2018 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367445;
        bh=NC/wWMEEcBggaXBM+ZWXvHgSsRW9eNaBhPHQLOwetPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp3y6Gy9PPBfbs+wNl5GfFmcOj/kLvn4X+SnP/dxcOkB0duK0kAoJmap95scR5li2
         7OPCnXzMiLAL765dkqJCzuzAp+72MuLK8eYdH/bRV+fc77BcFJHbjyxJb7t/XMEILW
         PjFkGHNavzC9IzwkAmYSzEVGtu8iwuJJnKqvTvyM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20A7060711;
        Mon, 27 Aug 2018 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535367439;
        bh=NC/wWMEEcBggaXBM+ZWXvHgSsRW9eNaBhPHQLOwetPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKFO5tkY5lSj82fAVm7RLyVDNA7/Rh76R0O+LPHl0OYwYq1SfQF0W13Vq3Xj3nNYk
         FesnjkVxdCyRora+RD1nXfOdFkOQaDXChamURG5kjC7/g8DmidSBn7lBf88QEgqlJs
         K3uTpQMg0dWRm+XGO1zZk7CJUD8nOaC0lhxsvY28=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20A7060711
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [Patch v15 3/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Mon, 27 Aug 2018 16:25:49 +0530
Message-Id: <20180827105551.16346-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
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
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v14:
 - none.

 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 23b4a60149b6..b5e7f72d418c 100644
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

