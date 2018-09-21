Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05AC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD97215E6
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD97215E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbeIUVcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390218AbeIUVcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:32 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09A709F5F7BC0;
        Fri, 21 Sep 2018 23:43:03 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:42:56 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 06/12] net: hns3: Add handle for default case
Date:   Fri, 21 Sep 2018 16:41:42 +0100
Message-ID: <20180921154148.26756-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

There are a few "switch-case" codes missed handle for default case. For
some abnormal case, it should return error code instead of return 0.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           | 2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c        | 7 +++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c  | 8 ++++----
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +++
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e404130..fc27f3f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2176,6 +2176,8 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		     l4_type == HNS3_L4_TYPE_SCTP))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index ce2e6ea..46701cf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -351,9 +351,10 @@ static int hns3_get_sset_count(struct net_device *netdev, int stringset)
 
 	case ETH_SS_TEST:
 		return ops->get_sset_count(h, stringset);
-	}
 
-	return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
@@ -417,6 +418,8 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	case ETH_SS_TEST:
 		ops->get_strings(h, stringset, data);
 		break;
+	default:
+		break;
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 86d3d8b..73d9d0d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2224,6 +2224,8 @@ static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 	case HCLGE_VECTOR0_EVENT_MBX:
 		hclge_write_dev(&hdev->hw, HCLGE_VECTOR0_CMDQ_SRC_REG, regclr);
 		break;
+	default:
+		break;
 	}
 }
 
@@ -5218,6 +5220,10 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 
 				hnae3_set_client_init_flag(client, ae_dev, 1);
 			}
+
+			break;
+		default:
+			return -EINVAL;
 		}
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
index d8c0cc8..0d3b445 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c
@@ -134,7 +134,7 @@ static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
 
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_HEAD_REG, 0);
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CSQ_TAIL_REG, 0);
-		break;
+		return 0;
 	case HCLGEVF_TYPE_CRQ:
 		reg_val = (u32)ring->desc_dma_addr;
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_BASEADDR_L_REG, reg_val);
@@ -147,10 +147,10 @@ static int hclgevf_init_cmd_queue(struct hclgevf_dev *hdev,
 
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_HEAD_REG, 0);
 		hclgevf_write_dev(hw, HCLGEVF_NIC_CRQ_TAIL_REG, 0);
-		break;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return 0;
 }
 
 void hclgevf_cmd_setup_basic_desc(struct hclgevf_desc *desc,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 84129c5..b644187 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1667,6 +1667,9 @@ static int hclgevf_init_client_instance(struct hnae3_client *client,
 		}
 
 		hnae3_set_client_init_flag(client, ae_dev, 1);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.7.4


