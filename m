Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080470;
	bh=PUPjDHkMRwFFZcDn4vmCV/eZlDSo/+LL/PlRRpew5Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FcJFt2MaQ5aKog1IKaQrDcgyfWDGceW67pj4o2Y5TWvMLQ4UjE6g1/ZbUOuquB4/8
	 e0GUUqpx50Cl4Y9e8WiEnncl7nn+0falmABhX+jzD906q/TNRJaDXl8Omcw0zyypyD
	 HRYtia/75c1+WdB7r2nEQlFrRetP4VbOuFYVHD/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfAUOVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbfAUNrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E1720861;
        Mon, 21 Jan 2019 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078437;
        bh=PUPjDHkMRwFFZcDn4vmCV/eZlDSo/+LL/PlRRpew5Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCgANgcnaBy0YFGtiKOq6/RzSErtuVUWP9LlTLds1DLFbLhPYyv3iioV4PUwRHY/X
         acN8ys0eG1FgJXoqaieVey1IgBCtJqlNdt129WHmUjKQPHhsm9dafjG9EDIg13i8RI
         FW52xtJOgscjGGo8n1ylC3T0C+ya5p3x18eJ+hdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com,
        syzbot+e3132895630f957306bc@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+fbd1e5476e4c94c7b34e@syzkaller.appspotmail.com
Subject: [PATCH 4.20 031/111] smc: move unhash as early as possible in smc_release()
Date:   Mon, 21 Jan 2019 14:42:25 +0100
Message-Id: <20190121122459.261048518@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

[ Upstream commit 26d92e951fe0a44ee4aec157cabb65a818cc8151 ]

In smc_release() we release smc->clcsock before unhash the smc
sock, but a parallel smc_diag_dump() may be still reading
smc->clcsock, therefore this could cause a use-after-free as
reported by syzbot.

Reported-and-tested-by: syzbot+fbd1e5476e4c94c7b34e@syzkaller.appspotmail.com
Fixes: 51f1de79ad8e ("net/smc: replace sock_put worker by socket refcounting")
Cc: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -146,6 +146,9 @@ static int smc_release(struct socket *so
 		sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
+
+	sk->sk_prot->unhash(sk);
+
 	if (smc->clcsock) {
 		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
 			/* wake up clcsock accept */
@@ -170,7 +173,6 @@ static int smc_release(struct socket *so
 		smc_conn_free(&smc->conn);
 	release_sock(sk);
 
-	sk->sk_prot->unhash(sk);
 	sock_put(sk); /* final sock_put */
 out:
 	return rc;


