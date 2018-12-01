Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5E3C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B52146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679B52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeLBGdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:33:41 -0500
Received: from mail.windriver.com ([147.11.1.11]:60805 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeLBGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:33:41 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB1JJSY8025132
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 1 Dec 2018 11:19:28 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:19:27 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hiroshi Doyu <hdoyu@nvidia.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 0/9] iommu: clean up/remove modular stuff from non-modules.
Date:   Sat, 1 Dec 2018 14:19:08 -0500
Message-ID: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work here represents a scan over the iommu dir, looking for files/drivers
that have nothing to do with a modular use case, but are using modular
infrastructure regardless.

We are trying to make driver code consistent with the Makefiles/Kconfigs that
control them.  This means not using modular functions/macros for drivers that
can never be built as a module.  I've done this in other subsystem dirs
already, and some of this has already happened in drivers/iommu by others;
such as 98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads quickly.

The last two commits (arm-smmu related ones) deserve an extra mention,
and I put them at the end in case they want to be deferred for later or
altered.  Normally a "module-ectomy" allows us to delete the ".remove"
function, as per the rockchip commit above, but ...

A kexec commit (7aa8619a66ae) tried to improve reliability by trying to
shutdown the iommu in the compromised/crashing kernel, but of course the
better solution is to have the recovery kernel be able to handle all of
the possible initial conditions.  It appears this was done later in the
commit b63b3439b856 - but I don't know if that means relying on an
orderly shutdown is no longer required - I don't have the platform and
am only going on what is in git history.

So, as the kexec commit recycled the ".remove" handle to also be the
".shutdown" handle, in this series the remove function was renamed to
shutdown, and the ".remove" handle was deleted.  This was IMHO the most
back compatible way to make this update.  If the reliance on the
compromised kernel to run ".shutdown" is no longer necessary, then it
can be removed in a future change.

Patches were build tested on top of next-20181128 for ARM, ARM64, x86-64
on an allyesconfig.

Paul.

---

[ v2: use recommended iommu subject format, add Acks, trivial tweaks. ]

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nate Watterson <nwatters@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Simon Xue <xxm@rock-chips.com>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org

Paul Gortmaker (9):
  iommu: audit and remove any unnecessary uses of module.h
  iommu/rockchip: Make it explicitly non-modular
  iommu/msm: Make it explicitly non-modular
  iommu/mediatek: Make it explicitly non-modular
  iommu/ipmmu-vmsa: Make it explicitly non-modular
  iommu/qcom: Make it explicitly non-modular
  iommu/tegra: Make it explicitly non-modular
  iommu/arm-smmu: Make arm-smmu explicitly non-modular
  iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

 drivers/iommu/arm-smmu-v3.c    | 25 +++++++++----------------
 drivers/iommu/arm-smmu.c       | 32 +++++++++++++-------------------
 drivers/iommu/iommu-sysfs.c    |  2 +-
 drivers/iommu/iommu.c          |  3 ++-
 drivers/iommu/ipmmu-vmsa.c     | 18 +++---------------
 drivers/iommu/msm_iommu.c      | 13 +++----------
 drivers/iommu/mtk_iommu_v1.c   | 15 +++------------
 drivers/iommu/qcom_iommu.c     | 16 ++--------------
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 drivers/iommu/tegra-gart.c     | 37 +++++++------------------------------
 10 files changed, 49 insertions(+), 125 deletions(-)

-- 
2.7.4

