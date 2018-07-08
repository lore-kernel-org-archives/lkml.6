Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D31C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F267120890
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O9/u9g7d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cTlvOIjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F267120890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeGHRea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 13:34:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeGHRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 13:34:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F165660B68; Sun,  8 Jul 2018 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071268;
        bh=t/9HUqzbaquaIJ4KqO1mqngqu8gzmpmRewrmxQWmiFU=;
        h=From:To:Cc:Subject:Date:From;
        b=O9/u9g7dL7670Q2iWbEzst5ll7nm5zC74IWFtjsp8VuNe/sCFhV3SclraA3XmL63Z
         y+y5RxzXihYERtcSgOlPNaB9gkqS1T5FjM5xbKa12R+RH0/tDhdrc0lSEbTuU4AdJZ
         Odlkbd16db9j30lcIxCPl9hMrPGBOqWnbOO3LFQ4=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18E7D607DC;
        Sun,  8 Jul 2018 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531071266;
        bh=t/9HUqzbaquaIJ4KqO1mqngqu8gzmpmRewrmxQWmiFU=;
        h=From:To:Cc:Subject:Date:From;
        b=cTlvOIjpzEaBd39+2eQa6Jj9yCp9p7k53e7ehkJqWi3gOzfv8sDMjbl0QFSNgoNUY
         DJZHUqumfcDxsrfB8TuR8VXx/iNifGr4SBCt/mIZEQuMr7CIM4j16/dK9acnIKGSu/
         1kcM/gbgqOGjTMWnXznBKWCpILkH3Hb44avk0F88=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18E7D607DC
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
        vivek.gautam@codeaurora.org
Subject: [PATCH v12 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date:   Sun,  8 Jul 2018 23:04:09 +0530
Message-Id: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using the
recently introduced device links patches, which lets the smmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.
As not all implementations support clock/power gating, we are checking
for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
power management for such smmu implementations that can support it.
With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [11]
the device links created between arm-smmu and its clients will be
automatically purged when arm-smmu driver unbinds from its device.

This series also adds support for Qcom's arm-smmu-v2 variant that
has different clocks and power requirements.

Took some reference from the exynos runtime patches [1].

With conditional runtime pm now, we avoid touching dev->power.lock
in fastpaths for smmu implementations that don't need to do anything
useful with pm_runtime.
This lets us to use the much-argued pm_runtime_get_sync/put_sync()
calls in map/unmap callbacks so that the clients do not have to
worry about handling any of the arm-smmu's power.

Previous version of this patch series is @ [5].

Note: This series is now based on the device link changes [11] for
adding new flag - DL_FLAG_AUTOREMOVE_SUPPLIER.
Rafael will pull in the device link changes and these patches have
to be pulled in based on Rafael's branch. As Rafael said -
"I would prefer to apply them myself to be honest and put them on an
public git branch for you to pull from."

[v12]
   * Use new device link's flag introduced in [11] -
     DL_FLAG_AUTOREMOVE_SUPPLIER. With this devices links are automatically
     purged when arm-smmu driver unbinds.
   * Using pm_runtime_force_suspend() instead of pm_runtime_disable() to
     avoid following warning from arm_smmu_device_remove()

     [295711.537507] ------------[ cut here ]------------
     [295711.544226] Unpreparing enabled smmu_mdp_ahb_clk
     [295711.549099] WARNING: CPU: 0 PID: 1 at ../drivers/clk/clk.c:697
                     clk_core_unprepare+0xd8/0xe0
     ...
     [295711.674073] Call trace:
     [295711.679454]  clk_core_unprepare+0xd8/0xe0
     [295711.682059]  clk_unprepare+0x28/0x40
     [295711.685964]  clk_bulk_unprepare+0x28/0x40
     [295711.689701]  arm_smmu_device_remove+0x88/0xd8
     [295711.693692]  arm_smmu_device_shutdown+0xc/0x18
     [295711.698120]  platform_drv_shutdown+0x20/0x30

[v11]
   * Some more cleanups for device link. We don't need an explicit
     delete for device link from the driver, but just set the flag
     DL_FLAG_AUTOREMOVE.
     device_link_add() API description says -
     "If the DL_FLAG_AUTOREMOVE is set, the link will be removed
     automatically when the consumer device driver unbinds."
   * Addressed the comments for 'smmu' in arm_smmu_map/unmap().
   * Dropped the patch [10] that introduced device_link_del_dev() API. 

[v10]
   * Introduce device_link_del_dev() API to delete the link between
     given consumer and supplier devices. The users of device link
     do not need to store link pointer to delete the link later.
     They can straightaway use this API by passing consumer and
     supplier devices.
   * Made corresponding changes to arm-smmu driver patch handling the
     device links.
   * Dropped the patch [9] that was adding device_link_find() API to
     device core layer. device_link_del_dev() serves the purpose to
     directly delete the link between two given devices.

[v9]
   * Removed 'rpm_supported' flag, instead checking on pm_domain
     to enable runtime pm.
   * Creating device link only when the runtime pm is enabled, as we
     don't need a device link besides managing the power dependency
     between supplier and consumer devices.
   * Introducing a patch to add device_link_find() API that finds
     and existing link between supplier and consumer devices.
     Also, made necessary change to device_link_add() to use this API.
   * arm_smmu_remove_device() now uses this device_link_find() to find
     the device link between smmu device and the master device, and then
     delete this link.
   * Dropped the destroy_domain_context() fix [8] as it was rather,
     introducing catastrophically bad problem by destroying
     'good dev's domain context.
   * Added 'Reviwed-by' tag for Tomasz's review.

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
[5] https://lkml.org/lkml/2018/3/22/191
[6] https://patchwork.kernel.org/patch/10204945/
[7] https://patchwork.kernel.org/patch/10204925/
[8] https://patchwork.kernel.org/patch/10254105/
[9] https://patchwork.kernel.org/patch/10277975/
[10] https://patchwork.kernel.org/patch/10281613/
[11] https://patchwork.kernel.org/patch/10491481/

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (1):
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
 drivers/iommu/arm-smmu.c                           | 178 +++++++++++++++++++--
 2 files changed, 210 insertions(+), 10 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

