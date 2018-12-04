Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90012146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PNdwUWPE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QhDQbiH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90012146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLDGWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:22:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDGWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:22:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D69A60B62; Tue,  4 Dec 2018 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904553;
        bh=+icGgS9tg5Lem35tK5WB+RH1MCLtnho6/QLX2bFxdAk=;
        h=From:To:Cc:Subject:Date:From;
        b=PNdwUWPEIGdmW42RxVBAEpollXe9MbSgaFKpAO8tYoiPCS3f4sPiKZXp18AuVDomP
         kz4is8hKCfgfdeK1edF6xUBZVDBruj8W0uvZGohJ4TYzz7F20e1DzBxOCApOjekzcr
         QUBfFnMEI56Mx2bc8L9+2uPS+yGaptYd5qvy6bIU=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15CF760115;
        Tue,  4 Dec 2018 06:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543904552;
        bh=+icGgS9tg5Lem35tK5WB+RH1MCLtnho6/QLX2bFxdAk=;
        h=From:To:Cc:Subject:Date:From;
        b=QhDQbiH8hWDvLLdkMNI2cLPY2+0+fjQd4w15MyuLvhzh35Q0d/gnwEHFcbVlJcW1P
         3iygKN+q/mqeMwjgsrPhEccTMtNRy1Iq4vs73IE6E0d+Nl0fmtLEdNdnGEKTVKzEyt
         hGDL4hDftvaSMSR2Fqc3Kjy6axxO9+WDu7HxQJPE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15CF760115
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
Subject: [PATCH v19 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date:   Tue,  4 Dec 2018 11:52:08 +0530
Message-Id: <20181204062213.6875-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v18:
 - Addressing Stephen's comment [5]:
     Replaced the entire clock bulk data filling and handling with
     devm_clk_bulk_get_all().

Changes since v17:
 - Addressing Will's comment to embed Thor's change [2] for pulling
   clocks information from device tree. This is done by squashing
   Thor's change [2] in v17's 1/5 patch [3].
 - Another minor change is addition of runtime pm hooks to
   arm_smmu_iova_to_phys_hard().

Previous version of this patch series is @ [1].
Also refer to [4] for change logs for previous versions.

[1] https://lore.kernel.org/patchwork/cover/1017699/
[2] https://lore.kernel.org/patchwork/patch/996143/
[3] https://lore.kernel.org/patchwork/patch/1013167/
[4] https://lore.kernel.org/patchwork/cover/979429/
[5] https://lore.kernel.org/patchwork/patch/1017700/

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  39 +++++
 drivers/iommu/arm-smmu.c                           | 170 +++++++++++++++++++--
 2 files changed, 197 insertions(+), 12 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

