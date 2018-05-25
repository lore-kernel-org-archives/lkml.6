Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968210AbeEYSpR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968166AbeEYSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:45:14 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Lijun Ou <oulijun@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH net-next 12/12] net: hns3: Fixes initalization of RoCE handle and makes it conditional
Date: Fri, 25 May 2018 19:43:07 +0100
Message-ID: <20180525184307.36288-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

When register a RoCE client with hnae3vf device, it needs to judge
the device whether support RoCE vf function. Otherwise, it will
lead to calltrace when RoCE is not support vf function and remove
roce device.

The calltrace as follows:
[   93.156614] Unable to handle kernel NULL pointer dereference at virtual address 00000015
 <SNIP>
[   93.278784] Call trace:
[   93.278788]  hnae3_match_n_instantiate+0x24/0xd8 [hnae3]
[   93.278790]  hnae3_register_client+0xcc/0x150 [hnae3]
[   93.278801]  hns_roce_hw_v2_init+0x18/0x1000 [hns_roce_hw_v2]
[   93.278805]  do_one_initcall+0x58/0x160
[   93.278807]  do_init_module+0x64/0x1d8
[   93.278809]  load_module+0x135c/0x15c8
[   93.278811]  SyS_finit_module+0x100/0x118
[   93.278816]  __sys_trace_return+0x0/0x4
[   93.278827] Code: aa0003f5 12001c56 aa1e03e0 d503201f (b9402660)

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Reported-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 2b0e329..266cdcb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1500,10 +1500,12 @@ static int hclgevf_init_instance(struct hclgevf_dev *hdev,
 			return ret;
 		break;
 	case HNAE3_CLIENT_ROCE:
-		hdev->roce_client = client;
-		hdev->roce.client = client;
+		if (hnae3_dev_roce_supported(hdev)) {
+			hdev->roce_client = client;
+			hdev->roce.client = client;
+		}
 
-		if (hdev->roce_client && hnae3_dev_roce_supported(hdev)) {
+		if (hdev->roce_client && hdev->nic_client) {
 			ret = hclgevf_init_roce_base_info(hdev);
 			if (ret)
 				return ret;
-- 
2.7.4
