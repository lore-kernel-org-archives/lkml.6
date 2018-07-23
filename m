Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B728ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC79E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbeGWN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388492AbeGWN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:00 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 377D8BDB;
        Mon, 23 Jul 2018 12:27:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsa@cumulusnetworks.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 40/63] net: diag: Dont double-free TCP_NEW_SYN_RECV sockets in tcp_abort
Date:   Mon, 23 Jul 2018 14:24:46 +0200
Message-Id: <20180723122447.891749088@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: Lorenzo Colitti <lorenzo@google.com>

[ Upstream commit acc2cf4e37174646a24cba42fa53c668b2338d4e ]

When tcp_diag_destroy closes a TCP_NEW_SYN_RECV socket, it first
frees it by calling inet_csk_reqsk_queue_drop_and_and_put in
tcp_abort, and then frees it again by calling sock_gen_put.

Since tcp_abort only has one caller, and all the other codepaths
in tcp_abort don't free the socket, just remove the free in that
function.

Cc: David Ahern <dsa@cumulusnetworks.com>
Tested: passes Android sock_diag_test.py, which exercises this codepath
Fixes: d7226c7a4dd1 ("net: diag: Fix refcnt leak in error path destroying socket")
Signed-off-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsa@cumulusnetworks.com>
Tested-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3524,8 +3524,7 @@ int tcp_abort(struct sock *sk, int err)
 			struct request_sock *req = inet_reqsk(sk);
 
 			local_bh_disable();
-			inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
-							  req);
+			inet_csk_reqsk_queue_drop(req->rsk_listener, req);
 			local_bh_enable();
 			return 0;
 		}


