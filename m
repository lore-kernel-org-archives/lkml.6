Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E976421473
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543676;
	bh=xvsOO61ap6SzOLctsGys64oeS8ftftizybgDtDB7MKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fa5X17Ii8Z7vmP31+bYCGsoTpnhvQdB/WyHV5qeTocaPnUbYnYcsmwZ9jO19xrevX
	 3XDO4XRrXjrtZZQS0OKQdYFKWdxNQ9oJ/Ydbv+b8O5ju546te6ab3VmGOtRM0e6rhQ
	 5qrL4scGpcC+yDB4LZUcCCsBlpR5g9+3eXDZG2jk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E976421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeLKPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbeLKPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12BAB20855;
        Tue, 11 Dec 2018 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543670;
        bh=xvsOO61ap6SzOLctsGys64oeS8ftftizybgDtDB7MKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7RTiEktC9P88LiQzQO8xs80XYoz2AKBsebV4e/wVblXkl0JSTcxFiycaNxN+rN+U
         WP8Y5hMgP7GQQWcZ2fQc5ARdjp6AGEmU4SSxuJrxgvwfkoU6pgbN1dK74MJf2amWKU
         NcAuW8RbIzRWj5ctSSRex4tvv77Ej1aOppK7oAg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/118] qed: Fix overriding offload_tc by protocols without APP TLV
Date:   Tue, 11 Dec 2018 16:40:38 +0100
Message-Id: <20181211151645.006745041@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



