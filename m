Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D77C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C543821855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899942;
	bh=5Dqnx0N1yBymIkiPe2ClsVOuJfiiZ1R1JLxZJ3Qy8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mOyijTnn5yW2WQJrVJCRQeyjXeGgGWLS+yIq72vwgbMmhhdX1VwkUpBrvgDhdfR1O
	 rjB493tA1lUX+MSlGO4ZOQ2fRdOrtQVrNhLyVkbPbQRAaNm8Ht5OkMSaP/4EuUf8gF
	 /IiqE8q/TKVwr5baqL28wBuYvPJVmis2Ll8zZVks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfBKOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbfBKOnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F9D20700;
        Mon, 11 Feb 2019 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896190;
        bh=5Dqnx0N1yBymIkiPe2ClsVOuJfiiZ1R1JLxZJ3Qy8XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6iox4mlQf1JJo0GZmb/XlILnzEVziGHJ6jZACYmtF7bLvv6a0OkFg7IBkrUcZ0+r
         GswCFpO/WcBzgvgAh378u25KAyQ+rVx/k/Udl8EPQIP6f5T1S65kVuFBDRS1pQOvGj
         XFbQ49Ukh56JPJtzaPGAySIq4gDfZhelYNni4so4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Hoang Le <hoang.h.le@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/313] tipc: fix node keep alive interval calculation
Date:   Mon, 11 Feb 2019 15:16:23 +0100
Message-Id: <20190211141900.741087187@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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



