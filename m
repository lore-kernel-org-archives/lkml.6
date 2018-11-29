Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BDDC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F925213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Z55EPXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F925213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbeK3Bau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732932AbeK3Bau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04344213A2;
        Thu, 29 Nov 2018 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501518;
        bh=JEgnDnKFeGbOvuO36kJoGdd+DhjhK6ivSMpwMP1FBlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Z55EPXhatx5L/lFQnEx3W1vS9RWUuYuU2F3aapmWdrUxYhAgT6/FPazljfpPdZPh
         GfZsdsQrtdpS9wd468h24ESu/e4H9eewAEzvNRbn2sI0NktmtQZgS/zTmTmplvLnY2
         rbiSuOGwmp3+jPU0QiTKTMAZ/BV3LWODF3EuKcLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 030/100] tcp: do not release socket ownership in tcp_close()
Date:   Thu, 29 Nov 2018 15:12:00 +0100
Message-Id: <20181129140101.383355615@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 8873c064d1de579ea23412a6d3eee972593f142b upstream.

syzkaller was able to hit the WARN_ON(sock_owned_by_user(sk));
in tcp_close()

While a socket is being closed, it is very possible other
threads find it in rtnetlink dump.

tcp_get_info() will acquire the socket lock for a short amount
of time (slow = lock_sock_fast(sk)/unlock_sock_fast(sk, slow);),
enough to trigger the warning.

Fixes: 67db3e4bfbc9 ("tcp: no longer hold ehash lock while calling tcp_get_info()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/sock.h |    1 +
 net/core/sock.c    |    2 +-
 net/ipv4/tcp.c     |   11 +++--------
 3 files changed, 5 insertions(+), 9 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1452,6 +1452,7 @@ static inline void lock_sock(struct sock
 	lock_sock_nested(sk, 0);
 }
 
+void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 
 /* BH context may only use the following locking interface. */
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2242,7 +2242,7 @@ static void __lock_sock(struct sock *sk)
 	finish_wait(&sk->sk_lock.wq, &wait);
 }
 
-static void __release_sock(struct sock *sk)
+void __release_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 	__acquires(&sk->sk_lock.slock)
 {
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2217,16 +2217,10 @@ adjudge_to_death:
 	sock_hold(sk);
 	sock_orphan(sk);
 
-	/* It is the last release_sock in its life. It will remove backlog. */
-	release_sock(sk);
-
-
-	/* Now socket is owned by kernel and we acquire BH lock
-	 *  to finish close. No need to check for user refs.
-	 */
 	local_bh_disable();
 	bh_lock_sock(sk);
-	WARN_ON(sock_owned_by_user(sk));
+	/* remove backlog if any, without releasing ownership. */
+	__release_sock(sk);
 
 	percpu_counter_inc(sk->sk_prot->orphan_count);
 
@@ -2295,6 +2289,7 @@ adjudge_to_death:
 out:
 	bh_unlock_sock(sk);
 	local_bh_enable();
+	release_sock(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);


