Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6DB208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6DB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbeHALb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:31:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60567 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387639AbeHALb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:31:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63FD7C4067B7D;
        Wed,  1 Aug 2018 17:47:02 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 17:46:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dhowells@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-afs@lists.infradead.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] rxrpc: Fix user ID check in rxrpc_service_prealloc_one
Date:   Wed, 1 Aug 2018 17:46:51 +0800
Message-ID: <20180801094651.7136-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There just check the user ID isn't already in use, hence should 
compare user_call_ID with xcall->user_call_ID, which is current
node's user_call_ID.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rxrpc/call_accept.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a9a9be5..9d1e298 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -116,9 +116,9 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 		while (*pp) {
 			parent = *pp;
 			xcall = rb_entry(parent, struct rxrpc_call, sock_node);
-			if (user_call_ID < call->user_call_ID)
+			if (user_call_ID < xcall->user_call_ID)
 				pp = &(*pp)->rb_left;
-			else if (user_call_ID > call->user_call_ID)
+			else if (user_call_ID > xcall->user_call_ID)
 				pp = &(*pp)->rb_right;
 			else
 				goto id_in_use;
-- 
2.7.0


