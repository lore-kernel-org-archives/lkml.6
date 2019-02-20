Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1000DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94B521773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfBTCex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:34:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730339AbfBTCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2247CC2BE4A5830F38F9;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:28 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 01/12] net: hns3: add pointer checking at the beginning of the exported functions.
Date:   Wed, 20 Feb 2019 10:32:40 +0800
Message-ID: <1550629971-23999-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

These functions are exported, add pointer checking at the beginning
can make them more safe.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 50011aa..9f5349b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -32,6 +32,9 @@ static bool hnae3_client_match(enum hnae3_client_type client_type,
 void hnae3_set_client_init_flag(struct hnae3_client *client,
 				struct hnae3_ae_dev *ae_dev, int inited)
 {
+	if (!client || !ae_dev)
+		return;
+
 	switch (client->type) {
 	case HNAE3_CLIENT_KNIC:
 		hnae3_set_bit(ae_dev->flag, HNAE3_KNIC_CLIENT_INITED_B, inited);
@@ -109,6 +112,9 @@ int hnae3_register_client(struct hnae3_client *client)
 	struct hnae3_ae_dev *ae_dev;
 	int ret = 0;
 
+	if (!client)
+		return -ENODEV;
+
 	mutex_lock(&hnae3_common_lock);
 	/* one system should only have one client for every type */
 	list_for_each_entry(client_tmp, &hnae3_client_list, node) {
@@ -141,6 +147,9 @@ void hnae3_unregister_client(struct hnae3_client *client)
 {
 	struct hnae3_ae_dev *ae_dev;
 
+	if (!client)
+		return;
+
 	mutex_lock(&hnae3_common_lock);
 	/* un-initialize the client on every matched port */
 	list_for_each_entry(ae_dev, &hnae3_ae_dev_list, node) {
@@ -163,6 +172,9 @@ void hnae3_register_ae_algo(struct hnae3_ae_algo *ae_algo)
 	struct hnae3_client *client;
 	int ret = 0;
 
+	if (!ae_algo)
+		return;
+
 	mutex_lock(&hnae3_common_lock);
 
 	list_add_tail(&ae_algo->node, &hnae3_ae_algo_list);
@@ -209,6 +221,9 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 	struct hnae3_ae_dev *ae_dev;
 	struct hnae3_client *client;
 
+	if (!ae_algo)
+		return;
+
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_dev */
 	list_for_each_entry(ae_dev, &hnae3_ae_dev_list, node) {
@@ -245,6 +260,9 @@ int hnae3_register_ae_dev(struct hnae3_ae_dev *ae_dev)
 	struct hnae3_client *client;
 	int ret = 0;
 
+	if (!ae_dev)
+		return -ENODEV;
+
 	mutex_lock(&hnae3_common_lock);
 
 	list_add_tail(&ae_dev->node, &hnae3_ae_dev_list);
@@ -307,6 +325,9 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 	struct hnae3_ae_algo *ae_algo;
 	struct hnae3_client *client;
 
+	if (!ae_dev)
+		return;
+
 	mutex_lock(&hnae3_common_lock);
 	/* Check if there are matched ae_algo */
 	list_for_each_entry(ae_algo, &hnae3_ae_algo_list, node) {
-- 
2.7.4

