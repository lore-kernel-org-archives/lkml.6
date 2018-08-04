Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CBC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2701E21775
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2701E21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHDLCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:02:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeHDLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:02:45 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDE1B89C;
        Sat,  4 Aug 2018 09:02:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 07/31] rxrpc: Fix user call ID check in rxrpc_service_prealloc_one
Date:   Sat,  4 Aug 2018 11:00:42 +0200
Message-Id: <20180804082632.759832554@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c01f6c9b3207e52fc9973a066a856ddf7a0538d8 ]

There just check the user call ID isn't already in use, hence should
compare user_call_ID with xcall->user_call_ID, which is current
node's user_call_ID.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/call_accept.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -116,9 +116,9 @@ static int rxrpc_service_prealloc_one(st
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


