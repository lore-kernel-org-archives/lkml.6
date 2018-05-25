Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968045AbeEYSo6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:44:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60913 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S967992AbeEYSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:44:54 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 07/12] net: hns3: Fixes the init of the VALID BD info in the descriptor
Date: Fri, 25 May 2018 19:43:02 +0100
Message-ID: <20180525184307.36288-8-salil.mehta@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

RX Buffer Descriptor contains a VALID bit which indicates if the BD
is valid and has some data. This field is set by HNS3 hardware to
intimate the driver of some valid data present in the BD. nd should
be reset by the driver when BD is being used again. In the existing
code this bit was not being (re-)initialized properly and hence was
causing problems.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 1bcb676..d1ef104 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1819,6 +1819,7 @@ static void hns3_replace_buffer(struct hns3_enet_ring *ring, int i,
 	hns3_unmap_buffer(ring, &ring->desc_cb[i]);
 	ring->desc_cb[i] = *res_cb;
 	ring->desc[i].addr = cpu_to_le64(ring->desc_cb[i].dma);
+	ring->desc[i].rx.bd_base_info = 0;
 }
 
 static void hns3_reuse_buffer(struct hns3_enet_ring *ring, int i)
@@ -1826,6 +1827,7 @@ static void hns3_reuse_buffer(struct hns3_enet_ring *ring, int i)
 	ring->desc_cb[i].reuse_flag = 0;
 	ring->desc[i].addr = cpu_to_le64(ring->desc_cb[i].dma
 		+ ring->desc_cb[i].page_offset);
+	ring->desc[i].rx.bd_base_info = 0;
 }
 
 static void hns3_nic_reclaim_one_desc(struct hns3_enet_ring *ring, int *bytes,
-- 
2.7.4
