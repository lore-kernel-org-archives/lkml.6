Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE11220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJPTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:46:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbeJPTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:46:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0C61C320FBA4;
        Tue, 16 Oct 2018 19:56:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 16 Oct 2018 19:56:41 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <huangdaode@hisilicon.com>, <xuwei5@hisilicon.com>,
        <liguozhu@hisilicon.com>, <Yisen.Zhuang@huawei.com>,
        <john.garry@huawei.com>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/5] Some cleanup and bugfix for desc filling
Date:   Tue, 16 Oct 2018 19:58:47 +0800
Message-ID: <1539691132-158455-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retransmiting packets, skb_cow_head which is called in
hns3_set_tso may clone a new header. And driver will clear the
checksum of the header after doing DMA map, so HW will read the
old header whose L3 checksum is not cleared and calculate a
wrong L3 checksum.

Also When sending a big fragment using multiple buffer descriptor,
hns3 does one maping, but do multiple unmapping when tx is done,
which may cause unmapping problem.

This patchset does some cleanup before fixing the above problem.

Fuyun Liang (3):
  net: hns3: add handling for big TX fragment
  net: hns3: rename hns_nic_dma_unmap
  net: hns3: fix for multiple unmapping DMA problem

Peng Li (2):
  net: hns3: remove hns3_fill_desc_tso
  net: hns3: move DMA map into hns3_fill_desc

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 137 +++++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |   3 +-
 2 files changed, 62 insertions(+), 78 deletions(-)

-- 
1.9.1

