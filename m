Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7165B208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja/Nq25a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7165B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeK2RB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeK2RB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:01:56 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9693D21019;
        Thu, 29 Nov 2018 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471066;
        bh=UKps64bjrcNutFV5OllWXUdBS+0c1qm8tdyVxUr++bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja/Nq25ayqmt1iMCpQoGVO31VGRQQ5u6u3nZ+mUluyxFTlujfmXdcHO0oIxUyrZXJ
         q9ffmJ3Rb7s97SatAFSj6+KbLKkh8BOudwTDr/C4ji7VZWSTwyygUrjG6YECZN9/ZN
         XRkm5XVEx7Xf0RWCbjLhbfbYceNcTXAyF5KeHfh8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/68] qed: Fix overriding offload_tc by protocols without APP TLV
Date:   Thu, 29 Nov 2018 00:55:10 -0500
Message-Id: <20181129055559.159228-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit e90202ed1cf9672c48a363c84a929932ebfe6fc0 ]

The TC received from APP TLV is stored in offload_tc, and should not be
set by protocols which did not receive an APP TLV. Fixed the condition
when overriding the offload_tc.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index f5459de6d60a..5900a506bf8d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -191,7 +191,7 @@ qed_dcbx_dp_protocol(struct qed_hwfn *p_hwfn, struct qed_dcbx_results *p_data)
 static void
 qed_dcbx_set_params(struct qed_dcbx_results *p_data,
 		    struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
-		    bool enable, u8 prio, u8 tc,
+		    bool app_tlv, bool enable, u8 prio, u8 tc,
 		    enum dcbx_protocol_type type,
 		    enum qed_pci_personality personality)
 {
@@ -210,7 +210,7 @@ qed_dcbx_set_params(struct qed_dcbx_results *p_data,
 		p_data->arr[type].dont_add_vlan0 = true;
 
 	/* QM reconf data */
-	if (p_hwfn->hw_info.personality == personality)
+	if (app_tlv && p_hwfn->hw_info.personality == personality)
 		qed_hw_info_set_offload_tc(&p_hwfn->hw_info, tc);
 
 	/* Configure dcbx vlan priority in doorbell block for roce EDPM */
@@ -225,7 +225,7 @@ qed_dcbx_set_params(struct qed_dcbx_results *p_data,
 static void
 qed_dcbx_update_app_info(struct qed_dcbx_results *p_data,
 			 struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
-			 bool enable, u8 prio, u8 tc,
+			 bool app_tlv, bool enable, u8 prio, u8 tc,
 			 enum dcbx_protocol_type type)
 {
 	enum qed_pci_personality personality;
@@ -240,7 +240,7 @@ qed_dcbx_update_app_info(struct qed_dcbx_results *p_data,
 
 		personality = qed_dcbx_app_update[i].personality;
 
-		qed_dcbx_set_params(p_data, p_hwfn, p_ptt, enable,
+		qed_dcbx_set_params(p_data, p_hwfn, p_ptt, app_tlv, enable,
 				    prio, tc, type, personality);
 	}
 }
@@ -318,8 +318,8 @@ qed_dcbx_process_tlv(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 				enable = true;
 			}
 
-			qed_dcbx_update_app_info(p_data, p_hwfn, p_ptt, enable,
-						 priority, tc, type);
+			qed_dcbx_update_app_info(p_data, p_hwfn, p_ptt, true,
+						 enable, priority, tc, type);
 		}
 	}
 
@@ -340,7 +340,7 @@ qed_dcbx_process_tlv(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt,
 			continue;
 
 		enable = (type == DCBX_PROTOCOL_ETH) ? false : !!dcbx_version;
-		qed_dcbx_update_app_info(p_data, p_hwfn, p_ptt, enable,
+		qed_dcbx_update_app_info(p_data, p_hwfn, p_ptt, false, enable,
 					 priority, tc, type);
 	}
 
-- 
2.17.1

