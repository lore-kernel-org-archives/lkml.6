Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424285AbeCBKLQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:11:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424236AbeCBKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:11:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E927B602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, robin.murphy@arm.com, will.deacon@arm.com,
        robdclark@gmail.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, jcrouse@codeaurora.org, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        vivek.gautam@codeaurora.org
Subject: [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Fri,  2 Mar 2018 15:40:45 +0530
Message-Id: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using the
recently introduced device links patches, which lets the smmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.

It also adds support for Qcom's arm-smmu-v2 variant that
has different clocks and power requirements.

Took some reference from the exynos runtime patches [1].

After another round of discussion [3], we now finally seem to be
in agreement to add a flag based on compatible, a flag that would
indicate if a particular implementation of arm-smmu supports
runtime pm or not.
This lets us to use the much-argued pm_runtime_get_sync/put_sync()
calls in map/unmap callbacks so that the clients do not have to
worry about handling any of the arm-smmu's power.
The patch that exported couple of pm_runtime suppliers APIS, viz.
pm_runtime_get_suppliers(), and pm_runtime_put_suppliers() can be
dropped since we don't have a user now for these APIs.
Thanks Rafael for reviewing the changes, but looks like we don't
need to export those APIs for some more time. :)

Previous version of this patch series is @ [5].

[v8]
   * Major change -
     - Added a flag 'rpm_supported' which each platform that supports
       runtime pm, can enable, and we enable runtime_pm over arm-smmu
       only when this flag is set.
     - Adding the conditional pm_runtime_get/put() calls to .map, .unmap
       and .attach_dev ops.
     - Dropped the patch [6] that exported pm_runtim_get/put_suupliers(),
       and also dropped the user driver patch [7] for these APIs.

   * Clock code further cleanup
     - doing only clk_bulk_enable() and clk_bulk_disable() in runtime pm
       callbacks. We shouldn't be taking a slow path (clk_prepare/unprepare())
       from these runtime pm callbacks. Thereby, moved clk_bulk_prepare() to
       arm_smmu_device_probe(), and clk_bulk_unprepare() to
       arm_smmu_device_remove().
     - clk data filling to a common method arm_smmu_fill_clk_data() that
       fills the clock ids and number of clocks.

   * Addressed other nits and comments
     - device_link_add() error path fixed.
     - Fix for checking negative error value from pm_runtime_get_sync().
     - Documentation redo.

   * Added another patch fixing the error path in arm_smmu_attach_dev()
     to destroy allocated domain context.

[v7]
   * Addressed review comments given by Robin Murphy -
     - Added device_link_del() in .remove_device path.
     - Error path cleanup in arm_smmu_add_device().
     - Added pm_runtime_get/put_sync() in .remove path, and replaced
        pm_runtime_force_suspend() with pm_runtime_disable().
     - clk_names cleanup in arm_smmu_init_clks()
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
[3] https://patchwork.kernel.org/patch/10204925/
[4] https://patchwork.kernel.org/patch/10102445/
[5] https://lkml.org/lkml/2018/2/7/144
[6] https://patchwork.kernel.org/patch/10204945/
[7] https://patchwork.kernel.org/patch/10204925/

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
  iommu/arm-smmu: Destroy domain context in failure path
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
 drivers/iommu/arm-smmu.c                           | 199 +++++++++++++++++++--
 2 files changed, 230 insertions(+), 11 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
