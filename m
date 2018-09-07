Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIHA4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:56:23 -0400
Received: from foss.arm.com ([217.140.101.70]:36350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbeIHA4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:56:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4100C7A9;
        Fri,  7 Sep 2018 13:13:51 -0700 (PDT)
Received: from e113632-lin.Cambridge.Arm.com (e113632-lin.Emea.Arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C90A3F575;
        Fri,  7 Sep 2018 13:13:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        john.stultz@linaro.org, liwei213@huawei.com,
        zhangfei.gao@linaro.org, guodong.xu@linaro.org,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 1/1] arm64: defconfig: Update UFSHCD for Hi3660 soc
Date:   Fri,  7 Sep 2018 21:13:20 +0100
Message-Id: <1536351200-1427-1-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ee7ef24d02d ("scsi: arm64: defconfig: enable configs for
Hisilicon ufs") enabled the Hisilicon UFS, which means that we can
flash a rootfs to the on-board flash. However, as it stands, the
kernel gets stuck on:

[    3.360733] Waiting for root device /dev/sdd10...

That seems to be because even though we have SCSI_UFS_HISI=y,
SCSI_UFSHCD and SCSI_UFSHCD_PLATFORM are set to 'm', which means the
required drivers won't be built-in.

We need those to load the rootfs and then load the modules, so set
them as built-ins.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..ab7f80a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -193,8 +193,8 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
-CONFIG_SCSI_UFSHCD=m
-CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
 CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_ATA=y
-- 
2.7.4

