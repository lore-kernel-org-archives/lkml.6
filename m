Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E77C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828ED20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695975;
	bh=2qzd0+B6XblkdYmm48qera4WArBsBZcfgpLkVGqjXds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCqDXsgKGFeIX+vTNHx8BPo3uKVOIqu+/RAAqAJ1MIe7IcK6ApHAikedV0RP2pPDT
	 aq8nuDJq5b0COExY1wDmK8HHLAjXz7KcM9UNb/YMLL2m3FnPu+6nO2VRcaoQdjUhmj
	 aNrGTevHS3cO9q3J4XMZ2ABHVLl+yZflrT/mllrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfA1RTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbfA1QEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB9E21738;
        Mon, 28 Jan 2019 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691485;
        bh=2qzd0+B6XblkdYmm48qera4WArBsBZcfgpLkVGqjXds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejAOrdaAYr1GioeAp3LOfHwpto/YYrs9ihMDaYvU0faqgSbY+FMtK+5yTdG0p4N1L
         UAA4bb25rhBKTWxeOdQkM1SYsbcaxdKCXbN6uCsw5ayvwvRzjCt0sqJGh58AZ4zPWX
         Yp5NSIy0h6wv7Cw9G2xNYSkMSbS2nxia7rOHmxGg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hoang Le <hoang.h.le@dektech.com.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 110/258] tipc: fix node keep alive interval calculation
Date:   Mon, 28 Jan 2019 10:56:56 -0500
Message-Id: <20190128155924.51521-110-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoang Le <hoang.h.le@dektech.com.au>

[ Upstream commit f5d6c3e5a359c0507800e7ac68d565c21de9b5a1 ]

When setting LINK tolerance, node timer interval will be calculated
base on the LINK with lowest tolerance.

But when calculated, the old node timer interval only updated if current
setting value (tolerance/4) less than old ones regardless of number of
links as well as links' lowest tolerance value.

This caused to two cases missing if tolerance changed as following:
Case 1:
1.1/ There is one link (L1) available in the system
1.2/ Set L1's tolerance from 1500ms => lower (i.e 500ms)
1.3/ Then, fallback to default (1500ms) or higher (i.e 2000ms)

Expected:
    node timer interval is 1500/4=375ms after 1.3

Result:
node timer interval will not being updated after changing tolerance at 1.3
since its value 1500/4=375ms is not less than 500/4=125ms at 1.2.

Case 2:
2.1/ There are two links (L1, L2) available in the system
2.2/ L1 and L2 tolerance value are 2000ms as initial
2.3/ Set L2's tolerance from 2000ms => lower 1500ms
2.4/ Disable link L2 (bring down its bearer)

Expected:
    node timer interval is 2000ms/4=500ms after 2.4

Result:
node timer interval will not being updated after disabling L2 since
its value 2000ms/4=500ms is still not less than 1500/4=375ms at 2.3
although L2 is already not available in the system.

To fix this, we start the node interval calculation by initializing it to
a value larger than any conceivable calculated value. This way, the link
with the lowest tolerance will always determine the calculated value.

Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Hoang Le <hoang.h.le@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/node.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 488019766433..32556f480a60 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -624,6 +624,12 @@ static void tipc_node_timeout(struct timer_list *t)
 
 	__skb_queue_head_init(&xmitq);
 
+	/* Initial node interval to value larger (10 seconds), then it will be
+	 * recalculated with link lowest tolerance
+	 */
+	tipc_node_read_lock(n);
+	n->keepalive_intv = 10000;
+	tipc_node_read_unlock(n);
 	for (bearer_id = 0; remains && (bearer_id < MAX_BEARERS); bearer_id++) {
 		tipc_node_read_lock(n);
 		le = &n->links[bearer_id];
-- 
2.19.1

