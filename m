Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78272C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321AD20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321AD20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeHAUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:18:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404178AbeHATDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0DD51054;
        Wed,  1 Aug 2018 17:00:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <wangxi11@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 149/336] net: hns3: Fix for hns3 module is loaded multiple times problem
Date:   Wed,  1 Aug 2018 18:48:04 +0200
Message-Id: <20180801165034.835114969@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit 3c7624d8fc0b893b644b945ab904c629ebc9611e ]

If the hns3 driver has been built into kernel and then loaded with
the same driver which built as KLM, it may trigger an error like
below:

[   20.009555] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[   20.016789] hns3: Copyright (c) 2017 Huawei Corporation.
[   20.022100] Error: Driver 'hns3' is already registered, aborting...
[   23.517397] Unable to handle kernel NULL pointer dereference at virtual address 00000000
...
[   23.691583] Process insmod (pid: 1982, stack limit = 0x00000000cd5f21cb)
[   23.698270] Call trace:
[   23.700705]  __list_del_entry_valid+0x2c/0xd8
[   23.705049]  hnae3_unregister_client+0x68/0xa8
[   23.709487]  hns3_init_module+0x98/0x1000 [hns3]
[   23.714093]  do_one_initcall+0x5c/0x170
[   23.717918]  do_init_module+0x64/0x1f4
[   23.721654]  load_module+0x1d14/0x24b0
[   23.725390]  SyS_init_module+0x158/0x208
[   23.729300]  el0_svc_naked+0x30/0x34

This patch fixes it by adding module version info.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c               |    1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |    2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |    1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h           |    2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h |    2 +-
 6 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -283,3 +283,4 @@ EXPORT_SYMBOL(hnae3_unregister_ae_dev);
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HNAE3(Hisilicon Network Acceleration Engine) Framework");
+MODULE_VERSION(HNAE3_MOD_VERSION);
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -36,6 +36,8 @@
 #include <linux/pci.h>
 #include <linux/types.h>
 
+#define HNAE3_MOD_VERSION "1.0"
+
 /* Device IDs */
 #define HNAE3_DEV_ID_GE				0xA220
 #define HNAE3_DEV_ID_25GE			0xA221
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3631,3 +3631,4 @@ MODULE_DESCRIPTION("HNS3: Hisilicon Ethe
 MODULE_AUTHOR("Huawei Tech. Co., Ltd.");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("pci:hns-nic");
+MODULE_VERSION(HNS3_MOD_VERSION);
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -14,6 +14,8 @@
 
 #include "hnae3.h"
 
+#define HNS3_MOD_VERSION "1.0"
+
 extern const char hns3_driver_version[];
 
 enum hns3_nic_state {
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -15,7 +15,7 @@
 #include "hclge_cmd.h"
 #include "hnae3.h"
 
-#define HCLGE_MOD_VERSION "v1.0"
+#define HCLGE_MOD_VERSION "1.0"
 #define HCLGE_DRIVER_NAME "hclge"
 
 #define HCLGE_INVALID_VPORT 0xffff
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -9,7 +9,7 @@
 #include "hclgevf_cmd.h"
 #include "hnae3.h"
 
-#define HCLGEVF_MOD_VERSION "v1.0"
+#define HCLGEVF_MOD_VERSION "1.0"
 #define HCLGEVF_DRIVER_NAME "hclgevf"
 
 #define HCLGEVF_ROCEE_VECTOR_NUM	0


