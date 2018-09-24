Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7458FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4372147C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcxGBPzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4372147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeIXGpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:45:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40187 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:45:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so1529367pgm.7;
        Sun, 23 Sep 2018 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YIX/CtHRppEuMTxE39ePv82rMFJoINJEVk228KkOVo=;
        b=YcxGBPzKygLIFHW7YWELnLsqXIsNiMCEohBaV9YMzqxCm/+fr+2JLUgQx1nblnFbAT
         RXHd2I7FF+/+cQw3CV0u5GIpEcDFJTE45Rf1cT/6a7/CS3nbohKifC/C0eEDqCPIToKr
         yAeAkNXXHGU8mnd8raHIZUj2lTYw74P1leZSyUMvzvzChYmJl/XxCSwgLGZ041vuJMvn
         SZS9nn+s8Bi0si5z6sTXZG8BboELgyqPRfMYEo4lnd/94uMQx2DfjUk16Huugx4TdXtP
         q3OXMITixjvWEbG6M9VhIpFeYzycZXT05Btfpe4goV0WAOQhd5gF0ssXg9RnlnLF7gez
         4sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YIX/CtHRppEuMTxE39ePv82rMFJoINJEVk228KkOVo=;
        b=O30CT3+R80R4L1H7+WQh29hU6rvvK34cAkG+gRhe2Wr0j8TgUdAb3eanmejuutuDNn
         kLnHKkAhECKCLY81D0b5IUrlwmpW9GSZU/cZbAmTL3Vn5GK4pnUteE3/c9FMGnfQz5fy
         xtpT+U+Y9tQn0XjmRaweLge0+11fF2JSK0ZJ5Hmzbn6KyXWg+Z49N0WHPA148wQhuzS7
         dVnG5+UO4PjU6ed4gFJ4MDanLdqzEEEhmHaxq2A7LAjjNjKJzip/kk6trxr7DGl9aD7r
         iBHsD2v231VFuB1i/Z9eZUqNe79Ttks6jcYfOEOrAkXMlcobvNRTTFyQZx0y19UAPlcI
         FUVg==
X-Gm-Message-State: APzg51AxfJNQH3Ssvzxj0UZ3M9qwvuY7ZPpP2tTFbTgAmQ04JKkoa8bH
        nDpOrIXM/+BXff9OMm8qFrk=
X-Google-Smtp-Source: ANB0VdZWYYw/YaXGKOff7N8N3KpyfI6ftTF/XmVBEBex8tM0jv4Sprtk/D3yUHJJxGo26Ru6TwvRLg==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr8005841pfz.85.1537749957693;
        Sun, 23 Sep 2018 17:45:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:45:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/20] IOMMU: Tegra GART driver clean up and optimization
Date:   Mon, 24 Sep 2018 03:41:33 +0300
Message-Id: <20180924004153.8232-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-series integrates the GART (IOMMU) driver with the Memory
Controller driver, that allows to report the name of a faulty memory
client on GART page fault. A major cleanup of the code is performed by
this series as well, it also optimizes performance of the GART driver.

In the previous v2 iteration Thierry Reding suggested that it is better to
break/change GART's device-tree ABI in order to integrate it with Memory
Controller without much churning. This patch series includes patches that
change the device tree binding in a way that updated driver will work only
with the new binding and older kernels won't be broken by the new binding.

Changelog:

v4: In the v3 Rob Herring requested to make device-tree binding changes
    backwards-compatible with the older kernels, that is achieved by
    changing the 'compatible' value of the DT node.

    The code-refactoring patches got some more (minor) polish.

    Added new patch "memory: tegra: Use of_device_get_match_data()".

v3: Memory Controller integration part has been reworked and now GART's
    device-tree binding is changed. Adding Rob Herring for the device-tree
    changes reviewing.

    GART now disallows more than one active domain at a time.

    Fixed "spinlock recursion", "NULL pointer dereference" and "detaching
    of all devices from inactive domains".

    New code-refactoring patches.

    The previously standalone patch "memory: tegra: Don't invoke Tegra30+
    specific memory timing setup on Tegra20" is now included into this
    series because there is a dependency on that patch and it wasn't applied
    yet.

v2: Addressed review comments from Robin Murphy to v1 by moving devices
    iommu_fwspec check to gart_iommu_add_device().

    Dropped the "Provide single domain and group for all devices" patch from
    the series for now because after some more considering it became not
    exactly apparent whether that is what we need, that was also suggested
    by Robin Murphy in the review comment. Maybe something like a runtime
    IOMMU usage for devices would be a better solution, allowing to implement
    transparent context switching of virtual IOMMU domains.

    Some very minor code cleanups, reworded commit messages.

Dmitry Osipenko (20):
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe errors handling
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance
  dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
  ARM: dts: tegra20: Update Memory Controller node to the new binding
  memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
    Tegra20
  memory: tegra: Adapt to Tegra20 device-tree binding changes
  memory: tegra: Read client ID on GART page fault
  memory: tegra: Use of_device_get_match_data()
  iommu/tegra: gart: Integrate with Memory Controller driver
  iommu/tegra: gart: Fix spinlock recursion
  iommu/tegra: gart: Fix NULL pointer dereference
  iommu/tegra: gart: Allow only one active domain at a time
  iommu/tegra: gart: Don't use managed resources
  iommu/tegra: gart: Prepend error/debug messages with "GART:"
  iommu/tegra: gart: Don't detach devices from inactive domains
  iommu/tegra: gart: Simplify clients-tracking code
  iommu/tegra: gart: Perform code refactoring

 .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt  |  27 +-
 arch/arm/boot/dts/tegra20.dtsi                |  15 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/iommu.c                         |   8 +-
 drivers/iommu/tegra-gart.c                    | 478 +++++++-----------
 drivers/memory/tegra/mc.c                     |  95 +++-
 drivers/memory/tegra/mc.h                     |   6 -
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  29 +-
 10 files changed, 298 insertions(+), 376 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.19.0

