Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB123E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ARhWnksF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EonJhhqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDB123E10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeGDOUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:20:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:20:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FA2360B3B; Wed,  4 Jul 2018 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530714037;
        bh=t6soV3278ILYh0Azr+oQu7QbMd5xF3RN4KtNFACJYMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARhWnksFTTacszNZFeDashR8uSLRDuFAzGcA1r1o7cSqbxN2e4vj00luzZk84dmt1
         I8chGmgjfgZCKT2Ef9KHvc9a2K1tFy//mhh+omYdrdAvpCWdPbm2vxCd2do8a4iJ2P
         m+kocANwfHeoAbkAzneftI1UPC8sxy9qQlmsjI3o=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94FC0607EB;
        Wed,  4 Jul 2018 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530714036;
        bh=t6soV3278ILYh0Azr+oQu7QbMd5xF3RN4KtNFACJYMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EonJhhqpqHVvcEbJifUFRTxedLtqJChLjLAAuQWHKWTMb6BcOfldnqn8MOSUch9PD
         W6HtVyso/0m9cMudiO4W4ZHfPNqOvBKXdFyQwPFOLQykgQQANhvyHZbEJMynCqyk6Z
         WkipZYF4eUyJ+zAk3nEpqyUN/NkfQsxb8kI2wZ0k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94FC0607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     davem@davemloft.net, bjorn.andersson@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 2/2] net: qrtr: Reset the node and port ID of broadcast messages
Date:   Wed,  4 Jul 2018 19:49:33 +0530
Message-Id: <1530713973-26696-3-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530713973-26696-1-git-send-email-aneela@codeaurora.org>
References: <1530713973-26696-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the control messages broadcast to remote routers are using
QRTR_NODE_BCAST instead of using local router NODE ID which cause
the packets to be dropped on remote router due to invalid NODE ID.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 net/qrtr/qrtr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 7ffc9a3..86e1e37 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -191,8 +191,13 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	hdr->type = cpu_to_le32(type);
 	hdr->src_node_id = cpu_to_le32(from->sq_node);
 	hdr->src_port_id = cpu_to_le32(from->sq_port);
-	hdr->dst_node_id = cpu_to_le32(to->sq_node);
-	hdr->dst_port_id = cpu_to_le32(to->sq_port);
+	if (to->sq_port == QRTR_PORT_CTRL) {
+		hdr->dst_node_id = cpu_to_le32(node->nid);
+		hdr->dst_port_id = cpu_to_le32(QRTR_NODE_BCAST);
+	} else {
+		hdr->dst_node_id = cpu_to_le32(to->sq_node);
+		hdr->dst_port_id = cpu_to_le32(to->sq_port);
+	}
 
 	hdr->size = cpu_to_le32(len);
 	hdr->confirm_rx = 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

