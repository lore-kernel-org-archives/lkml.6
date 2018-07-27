Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZLG135ER";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ekXRb+A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A2A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeG0IXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:23:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeG0IXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:23:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40CDA60B11; Fri, 27 Jul 2018 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532674963;
        bh=iBUMzkfIUsZnWWypuHQ5aZ968dLmC9M8oXVBsvqWTxY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLG135ERPiJbGEEdaDxaXoO/mf6brFUKAwktOG+BJ1ei+VGjf4MLDRpZTW4HzZ9bV
         Ew3gxf2/zWyJJAEmk9beaj8dS+wsCuWMkrA465MgrJUPYW05G50vv5yQ7quFo20F/9
         uaHm7xvt2L/lOZ9kIXWFXZCfHHpyV6ko0FvzdyDM=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1365860585;
        Fri, 27 Jul 2018 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532674962;
        bh=iBUMzkfIUsZnWWypuHQ5aZ968dLmC9M8oXVBsvqWTxY=;
        h=From:To:Cc:Subject:Date:From;
        b=ekXRb+A62roHPSxkl8D5wRdOO370MyODNxmMjZy11HLL5x3lqhC2eHTdlrduQ312L
         lpFBmM2OTWWX2SRX1lK3+qc98o8qCVfNsrPZ1i7+aPDNc7oTUleMRcdgqDphNsZzav
         +TsuCnqlW+jnwV3Cf7S1qm2AvvJJHXXkuxnEBo40=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1365860585
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
Subject: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
Date:   Fri, 27 Jul 2018 12:32:20 +0530
Message-Id: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using
device links between smmu and client devices. The device link
framework keeps the two devices in correct order for power-cycling
across runtime PM or across system-wide PM.

With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
(available in linux-next of Rafael's linux-pm tree [9]), the device links
created between arm-smmu and its clients will be automatically purged
when arm-smmu driver unbinds from its device.

As not all implementations support clock/power gating, we are checking
for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
power management for such smmu implementations that can support it.
Otherwise, the clocks are turned to be always on in .probe until .remove.
With conditional runtime pm now, we avoid touching dev->power.lock
in fastpaths for smmu implementations that don't need to do anything
useful with pm_runtime.
This lets us to use the much-argued pm_runtime_get_sync/put_sync()
calls in map/unmap callbacks so that the clients do not have to
worry about handling any of the arm-smmu's power.

This series also adds support for Qcom's arm-smmu-v2 variant that
has different clocks and power requirements.

Previous version of this patch series is @ [2].

Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
linux-next[9] and Joerg's iommu next[10] branches, and related changes for
device tree, etc.

Hi Robin, Will,
I have addressed the comments for v13. If there's still a chance
can you please consider pulling this for v4.19.
Thanks.

[v14]
   * Moved arm_smmu_device_reset() from arm_smmu_pm_resume() to
     arm_smmu_runtime_resume() so that the pm_resume callback calls
     only runtime_resume to resume the device.
     This should take care of restoring the state of smmu in systems
     in which smmu lose register state on power-domain collapse.

[v13]
   Addressing Rafael's comments:
   * Added .suspend pm callback to disable the clocks in system wide suspend.
   * Added corresponding clock enable in .resume pm callback.
   * Explicitly enabling/disabling the clocks now when runtime PM is disabled.
   * device_link_add() doesn't depend on pm_runtime_enabled() as we can
     use device links across system suspend/resume too.

   Addressing Robin's comments:
   * Making device_link_add failures as non-fatal.

   * Removed IOMMU_OF_DECLARE() declaration as we don't need this after Rob's
     patch that removed all of these declarations.

[v12]
   * Use new device link's flag introduced in [8] -
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
   * Dropped the patch [7] that introduced device_link_del_dev() API. 

[v10]
   * Introduce device_link_del_dev() API to delete the link between
     given consumer and supplier devices. The users of device link
     do not need to store link pointer to delete the link later.
     They can straightaway use this API by passing consumer and
     supplier devices.
   * Made corresponding changes to arm-smmu driver patch handling the
     device links.
   * Dropped the patch [6] that was adding device_link_find() API to
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
   * Dropped the destroy_domain_context() fix [5] as it was rather,
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
     - Dropped the patch [3] that exported pm_runtim_get/put_suupliers(),
       and also dropped the user driver patch [4] for these APIs.

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

** Change logs for previous versions is available in last series [4].


[1] https://patchwork.kernel.org/patch/10204925/
[2] https://lore.kernel.org/patchwork/cover/964655/
[3] https://patchwork.kernel.org/patch/10204945/
[4] https://patchwork.kernel.org/patch/10204925/
[5] https://patchwork.kernel.org/patch/10254105/
[6] https://patchwork.kernel.org/patch/10277975/
[7] https://patchwork.kernel.org/patch/10281613/
[8] https://patchwork.kernel.org/patch/10491481/
[9] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next
[10] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=next


Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (1):
  iommu/arm-smmu: Add support for qcom,smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
 drivers/iommu/arm-smmu.c                           | 194 +++++++++++++++++++--
 2 files changed, 225 insertions(+), 11 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

