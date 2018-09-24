Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A95C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0885A2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885A2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbeIXSax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbeIXSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BEEA1018;
        Mon, 24 Sep 2018 12:28:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 005/235] tipc: orphan sock in tipc_release()
Date:   Mon, 24 Sep 2018 13:49:51 +0200
Message-Id: <20180924113104.776291653@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 0a3b8b2b215f9e84b82ae97df71292ccfd92b1e7 ]

Before we unlock the sock in tipc_release(), we have to
detach sk->sk_socket from sk, otherwise a parallel
tipc_sk_fill_sock_diag() could stil read it after we
free this socket.

Fixes: c30b70deb5f4 ("tipc: implement socket diagnostics for AF_TIPC")
Reported-and-tested-by: syzbot+48804b87c16588ad491d@syzkaller.appspotmail.com
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -578,6 +578,7 @@ static int tipc_release(struct socket *s
 	sk_stop_timer(sk, &sk->sk_timer);
 	tipc_sk_remove(tsk);
 
+	sock_orphan(sk);
 	/* Reject any messages that accumulated in backlog queue */
 	release_sock(sk);
 	tipc_dest_list_purge(&tsk->cong_links);


