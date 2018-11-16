Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926A12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qmw70qbh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q9nRRBIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926A12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbeKPVgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:36:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeKPVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:36:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9855C6086B; Fri, 16 Nov 2018 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367491;
        bh=dJsCD4VJq/3qxIOySecyX/pvujGyRLolEnJCkX6+Ngg=;
        h=From:To:Cc:Subject:Date:From;
        b=Qmw70qbhR3cxcD+zK35PR5be8Kl+6vtwHROLo1qLJLz6+P/i28PVHJUNe276G/2pP
         coXrFlL9zEwdq6Ug7mI7P/x9JAltK1IXAOjlnQM5YVCFrZa+g1Lwe4UDBuF6xmqF4j
         C40ciwJp/rKv4RW/Qn2GDKT5P6SqY5lQgHtKyGcU=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3615605A2;
        Fri, 16 Nov 2018 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542367490;
        bh=dJsCD4VJq/3qxIOySecyX/pvujGyRLolEnJCkX6+Ngg=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9nRRBIomt0z0s02o4bbvUm9iH5ujCW8fiuAMJGH6pMowRYxoh5wg3lXiUbfRkEWZ
         7OyhItqQ8IBuscgjkgltB+Un7ANl6jueTYqv8DhTwO4FpydtugmWJ3GnR/h5OhkBa4
         RAAskDqoivhA59828hxa04Y8OF7JYADDzFP7rbwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3615605A2
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
Subject: [RESEND PATCH v17 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date:   Fri, 16 Nov 2018 16:54:25 +0530
Message-Id: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,
I am resending this series after we concluded on comments [1,2] on v16 of
this patch-series, and the subsequent patch [3] was posted.
Kindly merge this series.

Thanks
Vivek

Previous version of this patch series is @ [4].
Also refer to [4] for change logs for previous versions.

[1] https://lore.kernel.org/patchwork/patch/979430/
[2] https://lore.kernel.org/patchwork/patch/979433/
[3] https://lore.kernel.org/patchwork/patch/994194/
[4] https://lore.kernel.org/patchwork/cover/979429/

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  39 +++++
 drivers/iommu/arm-smmu.c                           | 192 +++++++++++++++++++--
 2 files changed, 219 insertions(+), 12 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

