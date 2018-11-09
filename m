Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26684C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC2820818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC2820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKJHvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:51:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15073 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbeKJHvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:51:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD4E020D40163;
        Sat, 10 Nov 2018 06:08:43 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 06:08:35 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <andrew@lunn.ch>, <yuvalm@mellanox.com>,
        <leon@kernel.org>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH 00/10] net: hns3: Adds support of debugfs to HNS3 driver
Date:   Fri, 9 Nov 2018 22:07:33 +0000
Message-ID: <20181109220743.10264-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support of debugfs to the HNS3 driver. 

Support has been added to query info related to below items:
1. Queue related
2. Flow Director
3. Promisc mode
4. TC config
5. Transmit Module/Scheduler
6. Checksum
7. QoS buffer
8. QoS prio map

Note: This patch-set has been floated as an RFC as it is an
an effort to understand what type information can be fetched
from the kernel and how it can be exported to user-space in
the HNS3 driver. There are few questions revolving our minds
like,
1. Is it allowed to dump the information of register in the
   syslog using the printk or we should use debugfs
   to export information to user-space using file interface only?
2. Can we export the information from the firmware to the
   userspace using debugfs?
3. Debugfs looks more unstructured unlike sysfs. Is there any
   de-facto standard of the user-api or drivers are allowed to
   use it in any way to expose the information from kernel.
4. Last but not least, is there any good driver reference
   within kernel which can be used as a reference. We could
   see Intel IXGBE/i40e/mellanox drivers having debugfs
   interface but with some discussions it looked they have
   some of the *might be* objectionable implementations.
5. With the idea started from Greg KH original patch
   Link: https://lwn.net/Articles/115282/
   Is the heart-and-soul of debugfs i.e. the reason why it was
   created still the same?

It would be a great help if people can help in throwing light
and reviewing this patch-set.

Thanks!


liuzhongzhu (10):
  net: hns3: Add debugfs framework registration
  net: hns3: Add "queue info" query function
  net: hns3: Add "FD flow table" info query function
  net: hns3: Add "promisc mode" config info query function
  net: hns3: Add "tc config" info query function
  net: hns3: Add "tm config" info query function
  net: hns3: Add checksum info query function
  net: hns3: Add PFC config info query function
  net: hns3: Add "qos prio map" info query function
  net: hns3: Add "qos buffer" config info query function

 drivers/net/ethernet/hisilicon/hns3/Makefile       |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 264 +++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  17 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   4 +
 .../net/ethernet/hisilicon/hns3/hns3pf/Makefile    |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   4 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 589 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h |  24 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   6 +
 12 files changed, 912 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h

-- 
2.7.4


