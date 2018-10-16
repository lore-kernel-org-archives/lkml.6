Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C705C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90E021477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z4eLsSHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90E021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeJQBFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbeJQBFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4394F20866;
        Tue, 16 Oct 2018 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710031;
        bh=WsZ+8ohiRaS1naHgvXUnLd+xCx6pDxq0nisL7KwZsq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4eLsSHFen57AZXjpLiawlaRqmn4j7Qis6bIF7EVp4xiWu8HyO/gPJTvzJ8RAKOnU
         eWCQchlfsUexBsz8tculNc2HWMFRzWh29e/Ip6dRzCci6v+RpJWenQTwjNGD4FxTDW
         M2njsb7o/5bGcR1/aKWJFzAWf9Vo2AV8Qb+WwFrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Sathya Perla <sathya.perla@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 043/135] bnxt_en: dont try to offload VLAN modify action
Date:   Tue, 16 Oct 2018 19:04:33 +0200
Message-Id: <20181016170517.777497660@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 8c6ec3613e7b0aade20a3196169c0bab32ed3e3f ]

bnxt offload code currently supports only 'push' and 'pop' operation: let
.ndo_setup_tc() return -EOPNOTSUPP if VLAN 'modify' action is configured.

Fixes: 2ae7408fedfe ("bnxt_en: bnxt: add TC flower filter offload support")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Sathya Perla <sathya.perla@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -75,17 +75,23 @@ static int bnxt_tc_parse_redir(struct bn
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
 
 static int bnxt_tc_parse_tunnel_set(struct bnxt *bp,
@@ -136,7 +142,9 @@ static int bnxt_tc_parse_actions(struct
 
 		/* Push/pop VLAN */
 		if (is_tcf_vlan(tc_act)) {
-			bnxt_tc_parse_vlan(bp, actions, tc_act);
+			rc = bnxt_tc_parse_vlan(bp, actions, tc_act);
+			if (rc)
+				return rc;
 			continue;
 		}
 


