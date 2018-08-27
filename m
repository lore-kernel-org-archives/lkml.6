Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9A72174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9A72174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeH0FOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:14:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbeH0FOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:14:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADAA19759920F;
        Mon, 27 Aug 2018 09:29:38 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Mon, 27 Aug 2018 09:29:29 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH V2 net 0/2] net: hns: fix some bugs about speed and duplex change
Date:   Mon, 27 Aug 2018 09:59:28 +0800
Message-ID: <1535335170-111030-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are packets in hardware when changing the spped
or duplex, it may cause hardware hang up.

This patchset adds the code for waiting chip to clean the all
pkts(TX & RX) in chip when the driver uses the function named
"adjust link".

This patchset cleans the pkts as follows:
1) close rx of chip, close tx of protocol stack.
2) wait rcb, ppe, mac to clean.
3) adjust link
4) open rx of chip, open tx of protocol stack.

---
Change log:
V1 -> V2:
1, remove a patch according to the comment reported by Andrew Lunn.
---
Peng Li (2):
  net: hns: add the code for cleaning pkt in chip
  net: hns: add netif_carrier_off before change speed and duplex

 drivers/net/ethernet/hisilicon/hns/hnae.h          |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  | 67 +++++++++++++++++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 36 ++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  | 44 ++++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |  8 +++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 29 ++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  | 23 ++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  | 23 ++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 21 ++++++-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  2 +
 14 files changed, 257 insertions(+), 4 deletions(-)

-- 
2.9.3

