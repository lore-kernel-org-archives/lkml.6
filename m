Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF68B2184B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277499;
	bh=m+LPsmr2d7WPKUEbf79q4oUqVWtaQB6FMBWMnd+gWaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcUD0JvMfVnfn3vYCxlSe1mOyYdQm0abWrM8YsTGTIWSBuL5AjBgsqIDssl9Wn8e7
	 /QPUntuz/xglr4x/GTn2+EvURsx25xZZ3jIe2jxpbw2XPh2T/Zdxt7iBlqSsxi0yCq
	 MkUn2TuLG3bTVtH4dJ2U5pFmDmWR2ezh/HkGi3b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfBDKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbfBDKvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA9D2070C;
        Mon,  4 Feb 2019 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277492;
        bh=m+LPsmr2d7WPKUEbf79q4oUqVWtaQB6FMBWMnd+gWaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mofbbj6brG4o9grOpziCDbsiF8c6KQWEyyZJiNrn4mUoZZaMuzO0w2zXQJe8PeAeP
         JE73l6UB7mo87ZOeui5452Zmi1OV/AcRyq4UA8Lwr51BINNMIghYPE84wmcpZcdPEC
         1/2Tosy4zgxzGfCHCL9MRNVvZem3RQ3UQkQNy8dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-hams@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com
Subject: [PATCH 4.20 10/80] netrom: switch to sock timer API
Date:   Mon,  4 Feb 2019 11:36:30 +0100
Message-Id: <20190204103621.678995364@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 63346650c1a94a92be61a57416ac88c0a47c4327 ]

sk_reset_timer() and sk_stop_timer() properly handle
sock refcnt for timer function. Switching to them
could fix a refcounting bug reported by syzbot.

Reported-and-tested-by: syzbot+defa700d16f1bd1b9a05@syzkaller.appspotmail.com
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-hams@vger.kernel.org
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/nr_timer.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/net/netrom/nr_timer.c
+++ b/net/netrom/nr_timer.c
@@ -52,21 +52,21 @@ void nr_start_t1timer(struct sock *sk)
 {
 	struct nr_sock *nr = nr_sk(sk);
 
-	mod_timer(&nr->t1timer, jiffies + nr->t1);
+	sk_reset_timer(sk, &nr->t1timer, jiffies + nr->t1);
 }
 
 void nr_start_t2timer(struct sock *sk)
 {
 	struct nr_sock *nr = nr_sk(sk);
 
-	mod_timer(&nr->t2timer, jiffies + nr->t2);
+	sk_reset_timer(sk, &nr->t2timer, jiffies + nr->t2);
 }
 
 void nr_start_t4timer(struct sock *sk)
 {
 	struct nr_sock *nr = nr_sk(sk);
 
-	mod_timer(&nr->t4timer, jiffies + nr->t4);
+	sk_reset_timer(sk, &nr->t4timer, jiffies + nr->t4);
 }
 
 void nr_start_idletimer(struct sock *sk)
@@ -74,37 +74,37 @@ void nr_start_idletimer(struct sock *sk)
 	struct nr_sock *nr = nr_sk(sk);
 
 	if (nr->idle > 0)
-		mod_timer(&nr->idletimer, jiffies + nr->idle);
+		sk_reset_timer(sk, &nr->idletimer, jiffies + nr->idle);
 }
 
 void nr_start_heartbeat(struct sock *sk)
 {
-	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void nr_stop_t1timer(struct sock *sk)
 {
-	del_timer(&nr_sk(sk)->t1timer);
+	sk_stop_timer(sk, &nr_sk(sk)->t1timer);
 }
 
 void nr_stop_t2timer(struct sock *sk)
 {
-	del_timer(&nr_sk(sk)->t2timer);
+	sk_stop_timer(sk, &nr_sk(sk)->t2timer);
 }
 
 void nr_stop_t4timer(struct sock *sk)
 {
-	del_timer(&nr_sk(sk)->t4timer);
+	sk_stop_timer(sk, &nr_sk(sk)->t4timer);
 }
 
 void nr_stop_idletimer(struct sock *sk)
 {
-	del_timer(&nr_sk(sk)->idletimer);
+	sk_stop_timer(sk, &nr_sk(sk)->idletimer);
 }
 
 void nr_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 int nr_t1timer_running(struct sock *sk)


