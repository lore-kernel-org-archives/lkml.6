Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeEHSRg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:17:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46393 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932982AbeEHSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:29 -0400
X-Google-Smtp-Source: AB8JxZp7UxG9EnYomtjzZ/ctxSgnlqUrRHevqp5Uh0lNIiiNA1L9gbYpacG1JD3WgBBaEA8pEVXtbA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] Tegra GART driver clean up and optimization
Date: Tue,  8 May 2018 21:16:51 +0300
Message-Id: <20180508181700.5169-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series addresses multiple shortcomings of the GART driver:

1. Thierry noticed that Memory Controller driver uses registers that belong
   to GART in [0] and for now MC driver only reports the fact of GART's page
   fault. The first two patches of the series are addressing this shortcoming.

   [0] https://www.spinics.net/lists/linux-tegra/msg33072.html

2. Currently GART is kept disabled by the commit c7e3ca515e784 ("iommu/tegra:
   gart: Do not register with bus"). If GART is re-enabled than all devices
   in the system are getting assigned to the GART as it is a global systems
   IOMMU provider. This is wrong simply because GART doesn't handle all those
   devices. This series makes GART to accept only devices that are explicitly
   assigned to GART in device tree using 'iommu' phandle.

3. This series makes a generic clean up of the driver by removing dead code,
   allowing to have one IOMMU domain at max, etc.

4. This series introduces and utilizes iotlb_sync_map() callback that was
   previously suggested by Joerg Roedel in [1].

   [1] https://www.spinics.net/lists/linux-tegra/msg32914.html

Dmitry Osipenko (9):
  memory: tegra: Provide facility for integration with the GART driver
  iommu/tegra: gart: Provide access to Memory Controller driver
  iommu/tegra: gart: Remove code related to module unloading
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe failure unwinding
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu/tegra: gart: Provide single domain and group for all devices
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance

 drivers/iommu/iommu.c      |   8 +-
 drivers/iommu/tegra-gart.c | 216 +++++++++++++++++--------------------
 drivers/memory/tegra/mc.c  |  26 ++++-
 include/linux/iommu.h      |   1 +
 include/soc/tegra/mc.h     |  13 +++
 5 files changed, 143 insertions(+), 121 deletions(-)

-- 
2.17.0
