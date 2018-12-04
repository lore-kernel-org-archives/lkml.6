Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A41C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AAF2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e856ZolT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gx7rqKEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AAF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeLDGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:22:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDGW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:22:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A94F61317; Tue,  4 Dec 2018 06:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904575;
        bh=wh8nsEJUiSAJZu1Xfnwt9e/THCIUtTSliVuTfHoa8m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e856ZolTF0dBpjJD7eAIzINKj5fpjyrq6R+XvsJfZk/mjRaMlcbPmaBVZu/u2B/P7
         KUqZtmTmiTuTktFjeJ8K+x3BDkPZfAuYrHYZnvUJ1STxpweKwu2hvw/AGu1bSRgt5T
         wi/AHbjcr3bOFxRV/cdQfsM7csZ76DbthPno/D3I=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D253360C65;
        Tue,  4 Dec 2018 06:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904570;
        bh=wh8nsEJUiSAJZu1Xfnwt9e/THCIUtTSliVuTfHoa8m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gx7rqKEIHK1sv4+mKNoZ7MqoDgvRAkO4ij/050hsYhpoSfxnR933Mz+GORlsLFvup
         ZH35dHKcRecAQK4o1DWn16yqawATAFjKl22lxEYEL+UHc55QqcjdCTTtV8mMvpYG+9
         Z/dk0jm5MjQy4nY69Kkw0XdVh/h5VqQn7XknuBqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D253360C65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, jcrouse@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        thor.thayer@linux.intel.com,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v19 3/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date:   Tue,  4 Dec 2018 11:52:11 +0530
Message-Id: <20181204062213.6875-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
References: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
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

Changes since v18:
 None.

 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1917d214c4d9..b6b11642b3a9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1500,6 +1500,9 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return 0;
 
 out_cfg_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

