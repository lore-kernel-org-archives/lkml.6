Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF67C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6026421736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866502;
	bh=xa4UyYbmTrDjxrwR35+WJYey5+UQQb/DZL+Lenv8B1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vf7nqRyWs/TpadAmg8jxlY8hKKkUz0TKbbMOIbxhuQafYGYGrPqqjhXlyhMPwgG45
	 59f6Pwib0Ibqu68BcfeBOrujtiwULwDXRSGlYrNsTBYJ95XsVQIZ7Sr/0TNgwENPA2
	 4AU1G+zfKAfDJiLwpPWvxocQI+RrFWQI6ZGgSNQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfAGNIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfAGNIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050CD21736;
        Mon,  7 Jan 2019 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866495;
        bh=xa4UyYbmTrDjxrwR35+WJYey5+UQQb/DZL+Lenv8B1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SY9jid6czf2dSD9BhpWn05mfh7WrISdSDBMdUcu5cV4f0C9ZbX3hDOPs5Q0RRuRFA
         bpJZpB6iEor0S8jzziePa1CoIRJ0pAc3O53Aap6MiR0hpsHp1skXFspv+t3j0jJ280
         phQT09rz0xQNAdasK4zSIidIbzw4qEDUt9vniXWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/71] tipc: use lock_sock() in tipc_sk_reinit()
Date:   Mon,  7 Jan 2019 13:32:52 +0100
Message-Id: <20190107105334.125764155@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 15ef70e286176165d28b0b8a969b422561a68dfc ]

lock_sock() must be used in process context to be race-free with
other lock_sock() callers, for example, tipc_release(). Otherwise
using the spinlock directly can't serialize a parallel tipc_release().

As it is blocking, we have to hold the sock refcnt before
rhashtable_walk_stop() and release it after rhashtable_walk_start().

Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2281,11 +2281,15 @@ void tipc_sk_reinit(struct net *net)
 			goto walk_stop;
 
 		while ((tsk = rhashtable_walk_next(&iter)) && !IS_ERR(tsk)) {
-			spin_lock_bh(&tsk->sk.sk_lock.slock);
+			sock_hold(&tsk->sk);
+			rhashtable_walk_stop(&iter);
+			lock_sock(&tsk->sk);
 			msg = &tsk->phdr;
 			msg_set_prevnode(msg, tn->own_addr);
 			msg_set_orignode(msg, tn->own_addr);
-			spin_unlock_bh(&tsk->sk.sk_lock.slock);
+			release_sock(&tsk->sk);
+			rhashtable_walk_start(&iter);
+			sock_put(&tsk->sk);
 		}
 walk_stop:
 		rhashtable_walk_stop(&iter);


