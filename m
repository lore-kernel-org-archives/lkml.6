Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A8C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDAE2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfA3U4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:56:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728943AbfA3U4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D94EC506EF42CA72CF9;
        Thu, 31 Jan 2019 04:56:20 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.134.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 31 Jan 2019 04:56:12 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        liyongxin <liyongxin1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: reuse the definition of l3 and l4 header info union
Date:   Thu, 31 Jan 2019 04:55:41 +0800
Message-ID: <20190130205552.8512-2-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190130205552.8512-1-tanhuazhong@huawei.com>
References: <20190130205552.8512-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.134.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liyongxin <liyongxin1@huawei.com>

Union l3_hdr_info and l4_hdr_info have already been defined in
the hns3_enet.h, so it is unnecessary to define them elsewhere.

This patch removes the redundant definition, and reuses the one
defined in the hns3_enet.h.

Signed-off-by: liyongxin <liyongxin1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 32 +++----------------
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  1 +
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4b38c37eef8f..048b5fbdf8fa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -655,11 +655,7 @@ static int hns3_set_tso(struct sk_buff *skb, u32 *paylen,
 static int hns3_get_l4_protocol(struct sk_buff *skb, u8 *ol4_proto,
 				u8 *il4_proto)
 {
-	union {
-		struct iphdr *v4;
-		struct ipv6hdr *v6;
-		unsigned char *hdr;
-	} l3;
+	union l3_hdr_info l3;
 	unsigned char *l4_hdr;
 	unsigned char *exthdr;
 	u8 l4_proto_tmp;
@@ -712,17 +708,8 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 				u8 il4_proto, u32 *type_cs_vlan_tso,
 				u32 *ol_type_vlan_len_msec)
 {
-	union {
-		struct iphdr *v4;
-		struct ipv6hdr *v6;
-		unsigned char *hdr;
-	} l3;
-	union {
-		struct tcphdr *tcp;
-		struct udphdr *udp;
-		struct gre_base_hdr *gre;
-		unsigned char *hdr;
-	} l4;
+	union l3_hdr_info l3;
+	union l4_hdr_info l4;
 	unsigned char *l2_hdr;
 	u8 l4_proto = ol4_proto;
 	u32 ol2_len;
@@ -821,12 +808,7 @@ static void hns3_set_l2l3l4_len(struct sk_buff *skb, u8 ol4_proto,
 static bool hns3_tunnel_csum_bug(struct sk_buff *skb)
 {
 #define IANA_VXLAN_PORT	4789
-	union {
-		struct tcphdr *tcp;
-		struct udphdr *udp;
-		struct gre_base_hdr *gre;
-		unsigned char *hdr;
-	} l4;
+	union l4_hdr_info l4;
 
 	l4.hdr = skb_transport_header(skb);
 
@@ -842,11 +824,7 @@ static int hns3_set_l3l4_type_csum(struct sk_buff *skb, u8 ol4_proto,
 				   u8 il4_proto, u32 *type_cs_vlan_tso,
 				   u32 *ol_type_vlan_len_msec)
 {
-	union {
-		struct iphdr *v4;
-		struct ipv6hdr *v6;
-		unsigned char *hdr;
-	} l3;
+	union l3_hdr_info l3;
 	u32 l4_proto = ol4_proto;
 
 	l3.hdr = skb_network_header(skb);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f3d248626ab3..71ff8f4d6c18 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -574,6 +574,7 @@ union l3_hdr_info {
 union l4_hdr_info {
 	struct tcphdr *tcp;
 	struct udphdr *udp;
+	struct gre_base_hdr *gre;
 	unsigned char *hdr;
 };
 
-- 
2.20.1


