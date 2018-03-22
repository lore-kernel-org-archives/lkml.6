Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756014AbeCVOaI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754583AbeCVOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:06 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <mehta.salil.lnk@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 0/9] Add support of VF Reset to HNS3 VF driver
Date: Thu, 22 Mar 2018 14:28:51 +0000
Message-ID: <20180322142900.22860-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds the support of VF reset to the existing VF driver.
VF Reset can be triggered due to TX watchdog firing  as a result of TX
data-path not working. VF reset could also be a result of some internal
configuration changes if that requires reset, or as a result of the
PF/Core/Global/IMP(Integrated Management Processor) reset happened in
the PF. 

Summary of Patches:
* Watchdog timer trigger chnages are present in Patch 1.
* Reset Service Task and related Event handling is present in Patches {2,3}
* Changes to send reset request to PF, reset stack and re-initialization
  of the hclge device is present in Patches {4,5,6}
* Changes related to ARQ (Asynchronous Receive Queue) and its event handling
  are present in Patches {7,8}
* Changes required in PF to handle the VF Reset request and actually perform
  hardware VF reset is there in Patch 9.


NOTE: This patch depends upon "[PATCH net-next 00/11] fix some bugs for HNS3 driver"
	Link: https://lkml.org/lkml/2018/3/21/72

Salil Mehta (9):
  net: hns3: Changes to make enet watchdog timeout func common for PF/VF
  net: hns3: Add VF Reset Service Task to support event handling
  net: hns3: Add VF Reset device state and its handling
  net: hns3: Add support to request VF Reset to PF
  net: hns3: Add support to reset the enet/ring mgmt layer
  net: hns3: Add support to re-initialize the hclge device
  net: hns3: Changes to support ARQ(Asynchronous Receive Queue)
  net: hns3: Add *Asserting Reset* mailbox message & handling in VF
  net: hns3: Changes required in PF mailbox to support VF reset

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |  16 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  30 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  38 +--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  42 +++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |   6 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 336 +++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  31 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  95 +++++-
 11 files changed, 534 insertions(+), 71 deletions(-)

-- 
2.7.4
