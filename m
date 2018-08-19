Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2CEC04E83
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D793820C0B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D793820C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeHSLGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 07:06:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbeHSLGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 07:06:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6DD2F3357094C;
        Sun, 19 Aug 2018 15:55:20 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Sun, 19 Aug 2018
 15:55:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 0/2] bugfix and optimization about CMD_SYNC
Date:   Sun, 19 Aug 2018 15:51:09 +0800
Message-ID: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
1. create a new function arm_smmu_cmdq_build_sync_msi_cmd, it's only used to
build CMD_SYNC for CS=SIG_IRQ mode.
2. In order to observe the optimization effect, I conducted 5 tests for each
case. Although the test result is volatility, but we can still get which case
is good or bad.

Test command: fio -numjobs=8 -rw=randread -runtime=30 ... -bs=4k
Test Result: IOPS

Case 1: (without these patches)
675480
672055
665275
648610
661146

Case 2: (only apply the variant of patch 1, move arm_smmu_cmdq_build_cmd into lock)
688714
697355
632951
700540
678459

Case 3: (only apply patch 1)
721582
729226
689574
679710
727770

Case 4: (apply both patch 1 and patch 2)
734077
742868
738194
682544
740586

v2 -> v3:
Although I have no data to show how many performance will be impacted
because of arm_smmu_cmdq_build_cmd is protected by spinlock. But it's
clear that the performance is bound to drop, a memset operation and 
a complicate switch..case in the function arm_smmu_cmdq_build_cmd.

v1 -> v2:
1. move the call to arm_smmu_cmdq_build_cmd into the critical section,
   and keep itself unchange.
2. Although patch2 can make sure no two CMD_SYNCs will be adjacent,
but patch1 is still needed, see below:

cpu0			cpu1			cpu2
msidata=0
			msidata=1
			insert cmd1
						insert a TLBI command
insert cmd0
			smmu execute cmd1
						smmu execute TLBI
smmu execute cmd0
			poll timeout, because msidata=1 is overridden by
			cmd0, that means VAL=0, sync_idx=1.

Zhen Lei (2):
  iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
  iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if possible

 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
1.8.3


