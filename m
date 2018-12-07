Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06676C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03220892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC03220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLGVJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:22 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EDF9B3FEE71F4;
        Sat,  8 Dec 2018 05:09:19 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:11 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 00/14] net: hns3: Additions/optimizations related to HNS3 H/W err handling
Date:   Fri, 7 Dec 2018 21:07:57 +0000
Message-ID: <20181207210811.23844-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set primarily does following addtions and optimizations
related to error handling in HNS3 Ethernet driver:

 1. Name changes for enable and process functions and minor loop
    optimizations. [PATCH 1-6]
 2. Modify query and clearing of RAS errors using new set of commands
    because modules specific commands for clearing RCB PPP PF, SSU are
    obselete. [PATCH 7]
 3. Deletes logging 1-bit errors for RAS in HNS3 driver as these never
    get reported to the driver. [PATCH 8]
 4. Add handling of NIC hw errors reported through MSIx rather than
    PCIe AER channel. [PATCH 9]
 5. Add handling for the HW RAS and MSIx errors in the modules MAC, PPP
    PF, MSIx SRAM, RCB and SSU. [PATCH 10-13]
 6. Add handling of RoCEE RAS errors. [PATCH 14]

Salil Mehta (1):
  net: hns3: add handling of hw errors reported through MSIX

Shiju Jose (13):
  net: hns3: remove existing process error functions and reorder hw_blk
    table
  net: hns3: rename enable error interrupt functions
  net: hns3: re-enable error interrupts on hw reset
  net: hns3: deletes unnecessary settings of the descriptor data
  net: hns3: rename process_hw_error function
  net: hns3: add optimization in the hclge_hw_error_set_state
  net: hns3: add handling of hw ras errors using new set of commands
  net: hns3: deleted logging 1 bit errors
  net: hns3: add handling of hw errors of MAC
  net: hns3: handle hw errors of PPP PF
  net: hns3: handle hw errors of PPU(RCB)
  net: hns3: handle hw errors of SSU
  net: hns3: add handling of RDMA RAS errors

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    3 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   27 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 1554 ++++++++++++--------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   79 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   55 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    1 +
 7 files changed, 1067 insertions(+), 656 deletions(-)

-- 
2.7.4


