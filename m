Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61924C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BDB2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BDB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIANhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:37:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbeIANhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:37:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42912FC65C9B;
        Sat,  1 Sep 2018 17:26:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Sat, 1 Sep 2018
 17:26:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <michael.chan@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bnxt_en: Properly get address type of encapsulation IP headers
Date:   Sat, 1 Sep 2018 17:25:29 +0800
Message-ID: <20180901092529.11828-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c: In function 'bnxt_tc_parse_flow':
drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c:186:6: warning:
 variable 'addr_type' set but not used [-Wunused-but-set-variable]

As done elsewhere in TC/flower offload code, the address type of
the encapsulation IP headers should be realized accroding to the
addr_type field of the encapsulation control dissector key.

Fixes: 8c95f773b4a3 ("bnxt_en: add support for Flower based vxlan encap/decap offload")
Fixes: 2ae7408fedfe ("bnxt_en: bnxt: add TC flower filter offload support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 092c817..5c625e5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -242,7 +242,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 		flow->l2_key.num_vlans = 1;
 	}
 
-	if (dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
 		struct flow_dissector_key_ipv4_addrs *key =
 			GET_KEY(tc_flow_cmd, FLOW_DISSECTOR_KEY_IPV4_ADDRS);
 		struct flow_dissector_key_ipv4_addrs *mask =
@@ -253,8 +253,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 		flow->l3_mask.ipv4.daddr.s_addr = mask->dst;
 		flow->l3_key.ipv4.saddr.s_addr = key->src;
 		flow->l3_mask.ipv4.saddr.s_addr = mask->src;
-	} else if (dissector_uses_key(dissector,
-				      FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+	} else if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
 		struct flow_dissector_key_ipv6_addrs *key =
 			GET_KEY(tc_flow_cmd, FLOW_DISSECTOR_KEY_IPV6_ADDRS);
 		struct flow_dissector_key_ipv6_addrs *mask =
@@ -300,7 +299,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 		addr_type = key->addr_type;
 	}
 
-	if (dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS)) {
+	if (addr_type == FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) {
 		struct flow_dissector_key_ipv4_addrs *key =
 			GET_KEY(tc_flow_cmd, FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS);
 		struct flow_dissector_key_ipv4_addrs *mask =
@@ -312,8 +311,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
 		flow->tun_mask.u.ipv4.dst = mask->dst;
 		flow->tun_key.u.ipv4.src = key->src;
 		flow->tun_mask.u.ipv4.src = mask->src;
-	} else if (dissector_uses_key(dissector,
-				      FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS)) {
+	} else if (addr_type == FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) {
 		return -EOPNOTSUPP;
 	}
 
-- 
2.7.0


