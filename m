Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jEUjFj31G1usbwAAmS7hNA
	; Sat, 09 Jun 2018 15:41:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47699605A5; Sat,  9 Jun 2018 15:41:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC7N2j6H"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 851F2605A5;
	Sat,  9 Jun 2018 15:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 851F2605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbeFIPlu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932961AbeFIPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:58 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81487208AD;
        Sat,  9 Jun 2018 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558498;
        bh=0JTNr9/F5tLtn5ynHTi+d95tKngDPEcPU+CFHnkv54I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pC7N2j6H6O5LF8ml10iBIIT7+btHpZ8986xFMDHigINwUkiYgjb90yMM9GTEWMt59
         /5cV7kpCYqU0x2OP3KLoJBWuGhXhyrOF9dfx8NYNJtqA6uvazNQF6qIHdAVeb7NnyJ
         UGcYXSv60F2hx4ht38tA7Hq5gbYjLIXu9TRp0WNQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Yuval Mintz <yuvalm@mellanox.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 13/41] ipmr: properly check rhltable_init() return value
Date: Sat,  9 Jun 2018 17:29:45 +0200
Message-Id: <20180609152927.155044014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 66fb33254f45df4b049f487aff1cbde1ef919390 ]

commit 8fb472c09b9d ("ipmr: improve hash scalability")
added a call to rhltable_init() without checking its return value.

This problem was then later copied to IPv6 and factorized in commit
0bbbf0e7d0e7 ("ipmr, ip6mr: Unite creation of new mr_table")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 31552 Comm: syz-executor7 Not tainted 4.17.0-rc5+ #60
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rht_key_hashfn include/linux/rhashtable.h:277 [inline]
RIP: 0010:__rhashtable_lookup include/linux/rhashtable.h:630 [inline]
RIP: 0010:rhltable_lookup include/linux/rhashtable.h:716 [inline]
RIP: 0010:mr_mfc_find_parent+0x2ad/0xbb0 net/ipv4/ipmr_base.c:63
RSP: 0018:ffff8801826aef70 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffc90001ea0000
RDX: 0000000000000079 RSI: ffffffff8661e859 RDI: 000000000000000c
RBP: ffff8801826af1c0 R08: ffff8801b2212000 R09: ffffed003b5e46c2
R10: ffffed003b5e46c2 R11: ffff8801daf23613 R12: dffffc0000000000
R13: ffff8801826af198 R14: ffff8801cf8225c0 R15: ffff8801826af658
FS:  00007ff7fa732700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000003ffffff9c CR3: 00000001b0210000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ip6mr_cache_find_parent net/ipv6/ip6mr.c:981 [inline]
 ip6mr_mfc_delete+0x1fe/0x6b0 net/ipv6/ip6mr.c:1221
 ip6_mroute_setsockopt+0x15c6/0x1d70 net/ipv6/ip6mr.c:1698
 do_ipv6_setsockopt.isra.9+0x422/0x4660 net/ipv6/ipv6_sockglue.c:163
 ipv6_setsockopt+0xbd/0x170 net/ipv6/ipv6_sockglue.c:922
 rawv6_setsockopt+0x59/0x140 net/ipv6/raw.c:1060
 sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3039
 __sys_setsockopt+0x1bd/0x390 net/socket.c:1903
 __do_sys_setsockopt net/socket.c:1914 [inline]
 __se_sys_setsockopt net/socket.c:1911 [inline]
 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1911
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 8fb472c09b9d ("ipmr: improve hash scalability")
Fixes: 0bbbf0e7d0e7 ("ipmr, ip6mr: Unite creation of new mr_table")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Yuval Mintz <yuvalm@mellanox.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -323,6 +323,7 @@ static const struct rhashtable_params ip
 static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
+	int err;
 
 	/* "pimreg%u" should not exceed 16 bytes (IFNAMSIZ) */
 	if (id != RT_TABLE_DEFAULT && id >= 1000000000)
@@ -338,7 +339,11 @@ static struct mr_table *ipmr_new_table(s
 	write_pnet(&mrt->net, net);
 	mrt->id = id;
 
-	rhltable_init(&mrt->mfc_hash, &ipmr_rht_params);
+	err = rhltable_init(&mrt->mfc_hash, &ipmr_rht_params);
+	if (err) {
+		kfree(mrt);
+		return ERR_PTR(err);
+	}
 	INIT_LIST_HEAD(&mrt->mfc_cache_list);
 	INIT_LIST_HEAD(&mrt->mfc_unres_queue);
 
