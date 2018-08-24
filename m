Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FB421571
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FB421571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHXGpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:45:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbeHXGpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:45:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25F19486E7275;
        Fri, 24 Aug 2018 11:12:33 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 24 Aug 2018 11:12:26 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net 0/3] net: hns: fix some bugs about speed and duplex change
Date:   Fri, 24 Aug 2018 11:42:20 +0800
Message-ID: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1, If there are packets in hardware when changing the spped
or duplex, it may cause hardware hang up.

This patchset adds the code for waiting chip to clean the all
pkts(TX & RX) in chip when the driver uses the function named
"adjust link".

This patchset cleans the pkts as follows:
1) close rx of chip, close tx of protocol stack.
2) wait rcb, ppe, mac to clean.
3) adjust link
4) open rx of chip, open tx of protocol stack.

2, Hisilicon hip05 and hip06 board network card do not
support 1000M half configuration. Driver can not config
gmac as 1000M half.

Peng Li (3):
  net: hns: add the code for cleaning pkt in chip
  net: hns: add netif_carrier_off before change speed and duplex
  net: hns: add configuration constraints for 1000M half

 drivers/net/ethernet/hisilicon/hns/hnae.h          |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  | 67 +++++++++++++++++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 41 +++++++++++++
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
 14 files changed, 262 insertions(+), 4 deletions(-)

-- 
2.9.3

