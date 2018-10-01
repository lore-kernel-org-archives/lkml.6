Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BC02064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BC02064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeJAS0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:26:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729250AbeJAS0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:26:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6773888A9DCF;
        Mon,  1 Oct 2018 19:48:32 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Mon, 1 Oct 2018 19:48:23 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 5/7] net: hns3: Add reset handle for flow director
Date:   Mon, 1 Oct 2018 12:46:45 +0100
Message-ID: <20181001114647.15504-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181001114647.15504-1-salil.mehta@huawei.com>
References: <20181001114647.15504-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When doing reset, remove all entries in TCAM block, and keep flow
director rules list. After finishing reset, restore all entries.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  4 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 30 ++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  5 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 64 ++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index fac84d8..e185d04 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -179,6 +179,7 @@ struct hnae3_ae_dev {
 	struct list_head node;
 	u32 flag;
 	enum hnae3_dev_type dev_type;
+	enum hnae3_reset_type reset_type;
 	void *priv;
 };
 
@@ -420,12 +421,15 @@ struct hnae3_ae_ops {
 			    struct ethtool_rxnfc *cmd);
 	int (*del_fd_entry)(struct hnae3_handle *handle,
 			    struct ethtool_rxnfc *cmd);
+	void (*del_all_fd_entries)(struct hnae3_handle *handle,
+				   bool clear_list);
 	int (*get_fd_rule_cnt)(struct hnae3_handle *handle,
 			       struct ethtool_rxnfc *cmd);
 	int (*get_fd_rule_info)(struct hnae3_handle *handle,
 				struct ethtool_rxnfc *cmd);
 	int (*get_fd_all_rules)(struct hnae3_handle *handle,
 				struct ethtool_rxnfc *cmd, u32 *rule_locs);
+	int (*restore_fd_rules)(struct hnae3_handle *handle);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 605f029..df4410e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1654,6 +1654,7 @@ static int hns3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ae_dev->pdev = pdev;
 	ae_dev->flag = ent->driver_data;
 	ae_dev->dev_type = HNAE3_DEV_KNIC;
+	ae_dev->reset_type = HNAE3_NONE_RESET;
 	hns3_get_dev_capability(pdev, ae_dev);
 	pci_set_drvdata(pdev, ae_dev);
 
@@ -3150,6 +3151,25 @@ static void hns3_uninit_mac_addr(struct net_device *netdev)
 		h->ae_algo->ops->rm_uc_addr(h, netdev->dev_addr);
 }
 
+static int hns3_restore_fd_rules(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+	int ret = 0;
+
+	if (h->ae_algo->ops->restore_fd_rules)
+		ret = h->ae_algo->ops->restore_fd_rules(h);
+
+	return ret;
+}
+
+static void hns3_del_all_fd_rules(struct net_device *netdev, bool clear_list)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (h->ae_algo->ops->del_all_fd_entries)
+		h->ae_algo->ops->del_all_fd_entries(h, clear_list);
+}
+
 static void hns3_nic_set_priv_ops(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -3561,6 +3581,8 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	if (!(handle->flags & HNAE3_SUPPORT_VF))
 		hns3_restore_vlan(netdev);
 
+	hns3_restore_fd_rules(netdev);
+
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
@@ -3581,6 +3603,7 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 
 static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 {
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(handle->pdev);
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
@@ -3601,6 +3624,13 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 
 	hns3_uninit_mac_addr(netdev);
 
+	/* it is cumbersome for hardware to pick-and-choose rules for deletion
+	 * from TCAM. Hence, for function reset software intervention is
+	 * required to delete the rules
+	 */
+	if (hns3_dev_ongoing_func_reset(ae_dev))
+		hns3_del_all_fd_rules(netdev, false);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 27d704f..ac881e8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -585,6 +585,11 @@ static inline void hns3_write_reg(void __iomem *base, u32 reg, u32 value)
 	writel(value, reg_addr + reg);
 }
 
+static inline bool hns3_dev_ongoing_func_reset(struct hnae3_ae_dev *ae_dev)
+{
+	return (ae_dev && (ae_dev->reset_type == HNAE3_FUNC_RESET));
+}
+
 #define hns3_write_dev(a, reg, value) \
 	hns3_write_reg((a)->io_base, (reg), (value))
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 876c7ca..00ec4db 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2513,8 +2513,13 @@ static void hclge_clear_reset_cause(struct hclge_dev *hdev)
 
 static void hclge_reset(struct hclge_dev *hdev)
 {
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(hdev->pdev);
 	struct hnae3_handle *handle;
 
+	/* Initialize ae_dev reset status as well, in case enet layer wants to
+	 * know if device is undergoing reset
+	 */
+	ae_dev->reset_type = hdev->reset_type;
 	/* perform reset of the stack & ae device for a client */
 	handle = &hdev->vport[0].nic;
 	rtnl_lock();
@@ -2535,6 +2540,7 @@ static void hclge_reset(struct hclge_dev *hdev)
 	hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 	handle->last_reset_time = jiffies;
 	rtnl_unlock();
+	ae_dev->reset_type = HNAE3_NONE_RESET;
 }
 
 static void hclge_reset_event(struct hnae3_handle *handle)
@@ -4299,6 +4305,62 @@ static int hclge_del_fd_entry(struct hnae3_handle *handle,
 					 false);
 }
 
+static void hclge_del_all_fd_entries(struct hnae3_handle *handle,
+				     bool clear_list)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	struct hclge_fd_rule *rule;
+	struct hlist_node *node;
+
+	if (!hnae3_dev_fd_supported(hdev))
+		return;
+
+	if (clear_list) {
+		hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list,
+					  rule_node) {
+			hclge_fd_tcam_config(hdev, HCLGE_FD_STAGE_1, true,
+					     rule->location, NULL, false);
+			hlist_del(&rule->rule_node);
+			kfree(rule);
+			hdev->hclge_fd_rule_num--;
+		}
+	} else {
+		hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list,
+					  rule_node)
+			hclge_fd_tcam_config(hdev, HCLGE_FD_STAGE_1, true,
+					     rule->location, NULL, false);
+	}
+}
+
+static int hclge_restore_fd_entries(struct hnae3_handle *handle)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	struct hclge_fd_rule *rule;
+	struct hlist_node *node;
+	int ret;
+
+	if (!hnae3_dev_fd_supported(hdev))
+		return -EOPNOTSUPP;
+
+	hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list, rule_node) {
+		ret = hclge_config_action(hdev, HCLGE_FD_STAGE_1, rule);
+		if (!ret)
+			ret = hclge_config_key(hdev, HCLGE_FD_STAGE_1, rule);
+
+		if (ret) {
+			dev_warn(&hdev->pdev->dev,
+				 "Restore rule %d failed, remove it\n",
+				 rule->location);
+			hlist_del(&rule->rule_node);
+			kfree(rule);
+			hdev->hclge_fd_rule_num--;
+		}
+	}
+	return 0;
+}
+
 static int hclge_get_fd_rule_cnt(struct hnae3_handle *handle,
 				 struct ethtool_rxnfc *cmd)
 {
@@ -7274,9 +7336,11 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_link_mode = hclge_get_link_mode,
 	.add_fd_entry = hclge_add_fd_entry,
 	.del_fd_entry = hclge_del_fd_entry,
+	.del_all_fd_entries = hclge_del_all_fd_entries,
 	.get_fd_rule_cnt = hclge_get_fd_rule_cnt,
 	.get_fd_rule_info = hclge_get_fd_rule_info,
 	.get_fd_all_rules = hclge_get_all_rules,
+	.restore_fd_rules = hclge_restore_fd_entries,
 };
 
 static struct hnae3_ae_algo ae_algo = {
-- 
2.7.4


