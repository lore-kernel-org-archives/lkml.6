Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A2EC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF2220825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF2220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKIXtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:49:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728457AbeKIXtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:49:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E1CAFDC34F105;
        Fri,  9 Nov 2018 22:07:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:07:43 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [Patch net-next 00/11] add code optimization for VF reset and some new reset feature
Date:   Fri, 9 Nov 2018 22:07:45 +0800
Message-ID: <1541772476-41478-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently hardware supports below reset:
1. VF reset: triggered by sending cmd to IMP(Integrated Management
   Processor). Only reset specific VF function and do not affect
   other PF or VF.
2. PF reset: triggered by sending cmd to IMP. Only reset specific PF
   and it's VF.
3. PF FLR: triggered by PCIe subsystem. Only reset specific PF and
   it's VF.
4. VF FLR: triggered by PCIe subsystem. Only reset specific VF function
   and do not affect other PF or VF.
5. Core reset: triggered by writing to register. Reset most hardware
   unit, such as SSU, which affects all the PF and VF.
6. Global reset: triggered by writing to register. Reset all hardware
   unit, which affects all the PF and VF.
7. IMP reset: triggered by IMU(Intelligent Management Unit) when
   IMP is not longer feeding IMU's watchdog. IMU will reload the IMP
   firmware and IMP will perform global reset after firmware reloading,
   which affects all the PF and VF.

Current driver only support PF/VF reset, incomplete core and global
reset(lacking the vf reset handling). So this patchset adds complete
reset support in hns3 driver.

Also, this patchset contains some optimization related to reset.

Huazhong Tan (11):
  net: hns3: add reset_hdev to reinit the hdev in VF's reset process
  net: hns3: adjust VF's reset process
  net: hns3: add reset handling for VF when doing PF reset
  net: hns3: add reset handling for VF when doing Core/Global/IMP reset
  net: hns3: stop handling command queue while resetting VF
  net: hns3: add error handler for hclgevf_reset()
  net: hns3: stop napi polling when HNS3_NIC_STATE_DOWN is set
  net: hns3: implement the IMP reset processing for PF
  net: hns3: add PCIe FLR support for PF
  net: hns3: do VF's pci re-initialization while PF doing FLR
  net: hns3: add PCIe FLR support for VF

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   6 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  11 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  66 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   6 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  11 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 185 +++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  11 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  35 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  13 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 404 +++++++++++++++------
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  36 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  18 +-
 12 files changed, 638 insertions(+), 164 deletions(-)

-- 
2.7.4

