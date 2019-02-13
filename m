Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88977C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567D4206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025467;
	bh=qQHn/cPbskFkR/KCb+yN8S0xGLXYeY96wswNr8pghiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USAFs+Yyw+f9MdYF/B1kklMSG79PQMKn+IfQq0lpbjyarkEvOQbBU8pA4kNfd7Ets
	 M6VplW64uRVyZFpufyVtXQ4uWOLMDG9zmdWemYHkwcIjaYTT1uAGWAOcMei5mpMj3T
	 gvZWlyCA/pKJyEykgQUiPGgq3XftjCfj7WHZdbgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfBMChp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388317AbfBMChc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FD7222C2;
        Wed, 13 Feb 2019 02:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025451;
        bh=qQHn/cPbskFkR/KCb+yN8S0xGLXYeY96wswNr8pghiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTFS58aT1R3EdhiGzLd11JE2azOti4gRMwyOXKu7doWrmzJl0w07dHeRVSQMgg0+I
         sfe31s0BZaPiY2WHZhsFC7LC5o29vfBFayd5Hp9D+5q/bZdfsHTM9cpwPh6h1V3ysz
         5jReCEYh8veHE4dQ9wU8qlCB1LmhW+EwUPztU4+Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/83] bpf: Fix [::] -> [::1] rewrite in sys_sendmsg
Date:   Tue, 12 Feb 2019 21:36:02 -0500
Message-Id: <20190213023701.20286-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ignatov <rdna@fb.com>

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
index 76ba2f34ef6b..cab8b2b647f9 100644
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

