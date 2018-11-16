Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370D12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WNy1iTcx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kr2UqSy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370D12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbeKPVhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:37:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:37:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4922960C4B; Fri, 16 Nov 2018 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367516;
        bh=h/IdrKvjrxt2jtzAmYim2qWAUDkQYPvkoQJHoA48nqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNy1iTcxCd2kjS6OBx0hyHiZKx/Q7ZlgY4p9SKSUw+vmMsCkb9Ccqw7SLdCtI+Od7
         AdZ9JpFjPDuSfUp5OLediPT0wMSGXCQjvog5x9eepWV/oIWoQJRIAom6rfqhEO75L7
         jK+M0emLVk8CN/lxgpnn/Lbo1aP9xpiOfnKnHdAk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B8FC60B62;
        Fri, 16 Nov 2018 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367512;
        bh=h/IdrKvjrxt2jtzAmYim2qWAUDkQYPvkoQJHoA48nqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kr2UqSy/kUzcTmXAZGbvnNUGNuWq1f1RZmvTVALxYlW4aqU5BEPtPBHgQAttXxghX
         RVwHx+sXCsbxKSeghibgFy56e0yp/c2D+KUhUYoXlheSTiX2XAaaWq/YOs7p8dxUEd
         UVnDsdGxKNfCuFOTMsM7Ms9eNskw7qETu0BERzNw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B8FC60B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [RESEND PATCH v17 3/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Fri, 16 Nov 2018 16:54:28 +0530
Message-Id: <20181116112430.31248-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index cae88c9f83ca..2098c3141f5f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1493,6 +1493,9 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return 0;
 
 out_cfg_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

