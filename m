Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5DAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D153420865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeKXVYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:24:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbeKXVYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:24:45 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15698395D212C;
        Sat, 24 Nov 2018 18:36:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 24 Nov 2018
 18:36:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ganeshgr@chelsio.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] cxgb4: remove set but not used variables 'multitrc, speed'
Date:   Sat, 24 Nov 2018 18:36:21 +0800
Message-ID: <20181124103621.24280-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:5883:6:
 warning: variable 'multitrc' set but not used [-Wunused-but-set-variable]

drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:8585:32:
 warning: variable 'speed' set but not used [-Wunused-but-set-variable]

'multitrc' never used since introduction in
commit 8e3d04fd7d70 ("cxgb4: Add MPS tracing support")

'speed' never used since introduction in
commit c3168cabe1af ("cxgb4/cxgbvf: Handle 32-bit fw port capabilities")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 4cb261d..e8c3429 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -5880,7 +5880,6 @@ int t4_set_trace_filter(struct adapter *adap, const struct trace_params *tp,
 {
 	int i, ofst = idx * 4;
 	u32 data_reg, mask_reg, cfg;
-	u32 multitrc = TRCMULTIFILTER_F;
 
 	if (!enable) {
 		t4_write_reg(adap, MPS_TRC_FILTER_MATCH_CTL_A_A + ofst, 0);
@@ -5900,7 +5899,6 @@ int t4_set_trace_filter(struct adapter *adap, const struct trace_params *tp,
 		 * maximum packet capture size of 9600 bytes is recommended.
 		 * Also in this mode, only trace0 can be enabled and running.
 		 */
-		multitrc = 0;
 		if (tp->snap_len > 9600 || idx)
 			return -EINVAL;
 	}
@@ -8606,7 +8604,7 @@ int t4_get_link_params(struct port_info *pi, unsigned int *link_okp,
 {
 	unsigned int fw_caps = pi->adapter->params.fw_caps_support;
 	struct fw_port_cmd port_cmd;
-	unsigned int action, link_ok, speed, mtu;
+	unsigned int action, link_ok, mtu;
 	fw_port_cap32_t linkattr;
 	int ret;
 
@@ -8640,7 +8638,6 @@ int t4_get_link_params(struct port_info *pi, unsigned int *link_okp,
 		mtu = FW_PORT_CMD_MTU32_G(
 			be32_to_cpu(port_cmd.u.info32.auxlinfo32_mtu32));
 	}
-	speed = fwcap_to_speed(linkattr);
 
 	*link_okp = link_ok;
 	*speedp = fwcap_to_speed(linkattr);
-- 
2.7.0


