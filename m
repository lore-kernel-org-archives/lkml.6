Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x225XA3XdJ8Sh8dReVwCUckxlHO2uQBPwlLPsYEkANhpsthRbUZqp+IQxF7snAXCgtj5WLJn5
ARC-Seal: i=1; a=rsa-sha256; t=1517999499; cv=none;
        d=google.com; s=arc-20160816;
        b=nDwl7khyCixjuZX+My8FDUkiFGrAiR1+IuEAT4vPZ0JDC9mCxvBoWCrwItD6ufqQIk
         e7w31uAGx0BBeW1BBsg5cSumL18dzai0mlW6tZFFoMxL6NIkOdcxKJBAITIxRivrTj/9
         xR9ve8HjhWHuEbjQ7kg+XKEEDB9cFk9Wvj5fa446yZ9Aj2Hs3dC6pjVk/c4xTpvwdpcl
         mLr3PMq/Nv/alAVkDkaDpW+o0Z6C1h3QCfJCTqLgx53a2aTUnDD72fm0afOndtk1MdXO
         jz5+XXRf0jqGdBHm2x2XUMJ37koAg04m40JEHe6qCrS+kXpSI9U2Xj8NiJ21wS2BL1gu
         QriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=RSiYcWABTvoUfFPqfwPaiIlClKhnqMNeMecPugEMA+Q=;
        b=A6y1w61WdV6SqKhN/leelf2Wu9doSFvsXLaTdpKITk/FVWvs8ollBn1Ouxq4nfz70f
         2Qup3pQM14b3aTfVgxhaYFjBcKBlso0Lw6Oj0WuUJQUR5P7IsqbILV6IL08+v3X3Inb6
         r2zh9DZUeK3ZelW/t+xvFi8u9vHZco5O0YwcJo+xo5DJxVHF6gafpmJ49Fbf0xyzTJIW
         J/F7enmHm39h9bCOmKW8AABIZM4sD4SjnJuHxhJgxZKr5WNqsrc/iZClBPkdXJWRZUYH
         zhxjLZKyzb7wHjMQQkGHsbKwEprbs7YYUbfXTHDP4HJtwczqDrl1poCgm7g8VAn77nv4
         S0fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eMsJNVzW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RpH780cr;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eMsJNVzW;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RpH780cr;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B87D8601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	rjw@rjwysocki.net,
	robin.murphy@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: alex.williamson@redhat.com,
	gregkh@linuxfoundation.org,
	airlied@linux.ie,
	sboyd@codeaurora.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org
Subject: [PATCH v7 0/6] iommu/arm-smmu: Add runtime pm/sleep support
Date: Wed,  7 Feb 2018 16:01:16 +0530
Message-Id: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737843063957158?=
X-GMAIL-MSGID: =?utf-8?q?1591737843063957158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using the
recently introduced device links patches, which lets the smmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.

It also adds support for Qcom's arm-smmu-v2 variant that
has different clocks and power requirements.

Took some reference from the exynos runtime patches [1].

After much discussion [3] over the use of pm_runtime_get/put() in
.unmap op path for the arm-smmu, and after disussing over more than
a couple of approaches to address this, we are putting forward the
changes *without* using pm_runtime APIs in 'unmap'. Rather, letting
the client device take the control of powering on/off the connected
iommu through pm_runtime_get(put)_suppliers() APIs for the scnerios
when the iommu power can't be directly controlled by clients through
device links.
Rafael acked the change to export the suppliers APIs.

Previous version of this patch series is @ [5].

[v7]
   * Addressed review comments given by Robin Murphy -
     -- Added device_link_del() in .remove_device path.
     -- Error path cleanup in arm_smmu_add_device().
     -- Added pm_runtime_get/put_sync() in .remove path, and replaced
        pm_runtime_force_suspend() with pm_runtime_disable().
     -- clk_names cleanup in arm_smmu_init_clks()
   * Added 'Reviewed-by' given by Rob H.

[V6]
   * Added Ack given by Rafael to first patch in the series.
   * Addressed Rob Herring's comment for adding soc specific compatible
     string as well besides 'qcom,smmu-v2'.

[V5]
   * Dropped runtime pm calls from "arm_smmu_unmap" op as discussed over
     the list [3] for the last patch series.
   * Added a patch to export pm_runtime_get/put_suppliers() APIs to the
     series as agreed with Rafael [4].
   * Added the related patch for msm drm iommu layer to use
     pm_runtime_get/put_suppliers() APIs in msm_mmu_funcs.
   * Dropped arm-mmu500 clock patch since that would break existing
     platforms.
   * Changed compatible 'qcom,msm8996-smmu-v2' to 'qcom,smmu-v2' to reflect
     the IP version rather than the platform on which it is used.
     The same IP is used across multiple platforms including msm8996,
     and sdm845 etc.
   * Using clock bulk APIs to handle the clocks available to the IP as
     suggested by Stephen Boyd.
   * The first patch in v4 version of the patch-series:
     ("iommu/arm-smmu: Fix the error path in arm_smmu_add_device") has
     already made it to mainline.

[V4]
   * Reworked the clock handling part. We now take clock names as data
     in the driver for supported compatible versions, and loop over them
     to get, enable, and disable the clocks.
   * Using qcom,msm8996 based compatibles for bindings instead of a generic
     qcom compatible.
   * Refactor MMU500 patch to just add the necessary clock names data and
     corresponding bindings.
   * Added the pm_runtime_get/put() calls in .unmap iommu op (fix added by
     Stanimir on top of previous patch version.
   * Added a patch to fix error path in arm_smmu_add_device()
   * Removed patch 3/5 of V3 patch series that added qcom,smmu-v2 bindings.

[V3]
   * Reworked the patches to keep the clocks init/enabling function
     separately for each compatible.

   * Added clocks bindings for MMU40x/500.

   * Added a new compatible for qcom,smmu-v2 implementation and
     the clock bindings for the same.

   * Rebased on top of 4.11-rc1

[V2]
   * Split the patches little differently.

   * Addressed comments.

   * Removed the patch #4 [2] from previous post
     for arm-smmu context save restore. Planning to
     post this separately after reworking/addressing Robin's
     feedback.

   * Reversed the sequence to disable clocks than enabling.
     This was required for those cases where the
     clocks are populated in a dependent order from DT.

[1] https://lkml.org/lkml/2016/10/20/70
[2] https://patchwork.kernel.org/patch/9389717/
[3] https://patchwork.kernel.org/patch/9827825/
[4] https://patchwork.kernel.org/patch/10102445/
[5] https://lkml.org/lkml/2018/1/19/217

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (3):
  base: power: runtime: Export pm_runtime_get/put_suppliers
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant
  drm/msm: iommu: Replace runtime calls with runtime suppliers

 .../devicetree/bindings/iommu/arm,smmu.txt         |  43 +++++++
 drivers/base/power/runtime.c                       |   2 +
 drivers/gpu/drm/msm/msm_iommu.c                    |  16 +--
 drivers/iommu/arm-smmu.c                           | 127 ++++++++++++++++++++-
 4 files changed, 174 insertions(+), 14 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
