Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1012821850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129710;
	bh=YrrfRNY9xwgwsujbyzpQCFAZ/ZoOq+Ei19RxAy91UB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cqCmVRMuu2JHNT568yIrtqSzE2/sVly70uhQQNCnozAlh3jsyaJs1ssSUu7ENMD6
	 jgynQOyxqX3kX8NvJMp9rzPYm7mxzkPQuYqdVDBign5NRr15bBBOAzi9PoXlnrAoaH
	 8HCqGX+nw1OSMI18IW/lHbru6rvxOeuCkjMDbnCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfBYVVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbfBYVVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13D621841;
        Mon, 25 Feb 2019 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129699;
        bh=YrrfRNY9xwgwsujbyzpQCFAZ/ZoOq+Ei19RxAy91UB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Qi4UuEuKttKnj188Y/butrvi4mRRbz6NJJP5/rwJ9EeTQqH8K0rHEIr6Mku9iPrw
         Bj9PLks9raI3GO9eu9rakzUvMhxOD6Q0FB8FxS+RDuFkVG2bQ2IT80+Cql/emQgt74
         w/f9sPbidzRKLojQYcUwTpEu0RPzlmEBiVdEIWTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitin Rawat <nitin.rawat@intel.com>,
        Andrey Ignatov <rdna@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/152] bpf: Fix [::] -> [::1] rewrite in sys_sendmsg
Date:   Mon, 25 Feb 2019 22:10:31 +0100
Message-Id: <20190225195046.355327872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit e8e36984080b55ac5e57bdb09a5b570f2fc8e963 ]

sys_sendmsg has supported unspecified destination IPv6 (wildcard) for
unconnected UDP sockets since 876c7f41. When [::] is passed by user as
destination, sys_sendmsg rewrites it with [::1] to be consistent with
BSD (see "BSD'ism" comment in the code).

This didn't work when cgroup-bpf was enabled though since the rewrite
[::] -> [::1] happened before passing control to cgroup-bpf block where
fl6.daddr was updated with passed by user sockaddr_in6.sin6_addr (that
might or might not be changed by BPF program). That way if user passed
[::] as dst IPv6 it was first rewritten with [::1] by original code from
876c7f41, but then rewritten back with [::] by cgroup-bpf block.

It happened even when BPF_CGROUP_UDP6_SENDMSG program was not present
(CONFIG_CGROUP_BPF=y was enough).

The fix is to apply BSD'ism after cgroup-bpf block so that [::] is
replaced with [::1] no matter where it came from: passed by user to
sys_sendmsg or set by BPF_CGROUP_UDP6_SENDMSG program.

Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
Reported-by: Nitin Rawat <nitin.rawat@intel.com>
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/udp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 76ba2f34ef6b1..cab8b2b647f96 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1322,10 +1322,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipc6.opt = opt;
 
 	fl6.flowi6_proto = sk->sk_protocol;
-	if (!ipv6_addr_any(daddr))
-		fl6.daddr = *daddr;
-	else
-		fl6.daddr.s6_addr[15] = 0x1; /* :: means loopback (BSD'ism) */
+	fl6.daddr = *daddr;
 	if (ipv6_addr_any(&fl6.saddr) && !ipv6_addr_any(&np->saddr))
 		fl6.saddr = np->saddr;
 	fl6.fl6_sport = inet->inet_sport;
@@ -1353,6 +1350,9 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 	}
 
+	if (ipv6_addr_any(&fl6.daddr))
+		fl6.daddr.s6_addr[15] = 0x1; /* :: means loopback (BSD'ism) */
+
 	final_p = fl6_update_dst(&fl6, opt, &final);
 	if (final_p)
 		connected = false;
-- 
2.19.1



