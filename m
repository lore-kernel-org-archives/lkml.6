Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6709FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C8121531
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xV3bRTuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C8121531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeJHWjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJHWjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839DD21523;
        Mon,  8 Oct 2018 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012410;
        bh=qqix+blR0NIA3VRZiSARfBXZL1NIigv1BoNvva2vslE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xV3bRTuSVcNOSct00JaD8L9PqDRjljs/GuuAvkMoQ9CaipbabXt4zri4W7b2GDT2D
         bba4ah92KhMK9OKYiuPLnGcMmP9JV8YweHfQ7qvwUclUWqfzrxybfiXRkxeSU1n729
         MrsgN3roqUoq17360Q+qzuFJLKT7roTMazWqZBCc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/32] bnxt_en: don't try to offload VLAN 'modify' action
Date:   Mon,  8 Oct 2018 11:26:18 -0400
Message-Id: <20181008152629.70812-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 8c6ec3613e7b0aade20a3196169c0bab32ed3e3f ]

bnxt offload code currently supports only 'push' and 'pop' operation: let
.ndo_setup_tc() return -EOPNOTSUPP if VLAN 'modify' action is configured.

Fixes: 2ae7408fedfe ("bnxt_en: bnxt: add TC flower filter offload support")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Sathya Perla <sathya.perla@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 6a185344b378..149d30f60459 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -78,17 +78,23 @@ static int bnxt_tc_parse_redir(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_tc_parse_vlan(struct bnxt *bp,
-			       struct bnxt_tc_actions *actions,
-			       const struct tc_action *tc_act)
+static int bnxt_tc_parse_vlan(struct bnxt *bp,
+			      struct bnxt_tc_actions *actions,
+			      const struct tc_action *tc_act)
 {
-	if (tcf_vlan_action(tc_act) == TCA_VLAN_ACT_POP) {
+	switch (tcf_vlan_action(tc_act)) {
+	case TCA_VLAN_ACT_POP:
 		actions->flags |= BNXT_TC_ACTION_FLAG_POP_VLAN;
-	} else if (tcf_vlan_action(tc_act) == TCA_VLAN_ACT_PUSH) {
+		break;
+	case TCA_VLAN_ACT_PUSH:
 		actions->flags |= BNXT_TC_ACTION_FLAG_PUSH_VLAN;
 		actions->push_vlan_tci = htons(tcf_vlan_push_vid(tc_act));
 		actions->push_vlan_tpid = tcf_vlan_push_proto(tc_act);
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
+	return 0;
 }
 
 static int bnxt_tc_parse_actions(struct bnxt *bp,
@@ -122,7 +128,9 @@ static int bnxt_tc_parse_actions(struct bnxt *bp,
 
 		/* Push/pop VLAN */
 		if (is_tcf_vlan(tc_act)) {
-			bnxt_tc_parse_vlan(bp, actions, tc_act);
+			rc = bnxt_tc_parse_vlan(bp, actions, tc_act);
+			if (rc)
+				return rc;
 			continue;
 		}
 	}
-- 
2.17.1

