Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 77NXIklQGVv1BQAAmS7hNA
	; Thu, 07 Jun 2018 15:34:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98042607E7; Thu,  7 Jun 2018 15:34:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DFE8160590;
	Thu,  7 Jun 2018 15:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFE8160590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935349AbeFGPeL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:34:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40658 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934319AbeFGOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:56 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbJ-0005Zk-8r; Thu, 07 Jun 2018 15:09:17 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0003Ix-9U; Thu, 07 Jun 2018 15:09:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        syzbot+91e6f9932ff122fa4410@syzkaller.appspotmail.com,
        "Paolo Abeni" <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.189134184@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 398/410] ipv6: the entire IPv6 header chain must fit
 the first fragment
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 10b8a3de603df7b96004179b1b33b1708c76d144 upstream.

While building ipv6 datagram we currently allow arbitrary large
extheaders, even beyond pmtu size. The syzbot has found a way
to exploit the above to trigger the following splat:

kernel BUG at ./include/linux/skbuff.h:2073!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4230 Comm: syzkaller672661 Not tainted 4.16.0-rc2+ #326
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__skb_pull include/linux/skbuff.h:2073 [inline]
RIP: 0010:__ip6_make_skb+0x1ac8/0x2190 net/ipv6/ip6_output.c:1636
RSP: 0018:ffff8801bc18f0f0 EFLAGS: 00010293
RAX: ffff8801b17400c0 RBX: 0000000000000738 RCX: ffffffff84f01828
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8801b415ac18
RBP: ffff8801bc18f360 R08: ffff8801b4576844 R09: 0000000000000000
R10: ffff8801bc18f380 R11: ffffed00367aee4e R12: 00000000000000d6
R13: ffff8801b415a740 R14: dffffc0000000000 R15: ffff8801b45767c0
FS:  0000000001535880(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000b000 CR3: 00000001b4123001 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip6_finish_skb include/net/ipv6.h:969 [inline]
  udp_v6_push_pending_frames+0x269/0x3b0 net/ipv6/udp.c:1073
  udpv6_sendmsg+0x2a96/0x3400 net/ipv6/udp.c:1343
  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:764
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  ___sys_sendmsg+0x320/0x8b0 net/socket.c:2046
  __sys_sendmmsg+0x1ee/0x620 net/socket.c:2136
  SYSC_sendmmsg net/socket.c:2167 [inline]
  SyS_sendmmsg+0x35/0x60 net/socket.c:2162
  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4404c9
RSP: 002b:00007ffdce35f948 EFLAGS: 00000217 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404c9
RDX: 0000000000000003 RSI: 0000000020001f00 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000020000080 R11: 0000000000000217 R12: 0000000000401df0
R13: 0000000000401e80 R14: 0000000000000000 R15: 0000000000000000
Code: ff e8 1d 5e b9 fc e9 15 e9 ff ff e8 13 5e b9 fc e9 44 e8 ff ff e8 29
5e b9 fc e9 c0 e6 ff ff e8 3f f3 80 fc 0f 0b e8 38 f3 80 fc <0f> 0b 49 8d
87 80 00 00 00 4d 8d 87 84 00 00 00 48 89 85 20 fe
RIP: __skb_pull include/linux/skbuff.h:2073 [inline] RSP: ffff8801bc18f0f0
RIP: __ip6_make_skb+0x1ac8/0x2190 net/ipv6/ip6_output.c:1636 RSP:
ffff8801bc18f0f0

As stated by RFC 7112 section 5:

   When a host fragments an IPv6 datagram, it MUST include the entire
   IPv6 Header Chain in the First Fragment.

So this patch addresses the issue dropping datagrams with excessive
extheader length. It also updates the error path to report to the
calling socket nonnegative pmtu values.

The issue apparently predates git history.

v1 -> v2: cleanup error path, as per Eric's suggestion

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+91e6f9932ff122fa4410@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/ip6_output.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1146,7 +1146,7 @@ int ip6_append_data(struct sock *sk, int
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct inet_cork *cork;
 	struct sk_buff *skb, *skb_prev = NULL;
-	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, headersize;
+	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, headersize, pmtu;
 	int exthdrlen;
 	int dst_exthdrlen;
 	int hh_len;
@@ -1242,6 +1242,12 @@ int ip6_append_data(struct sock *sk, int
 		      sizeof(struct frag_hdr) : 0) +
 		     rt->rt6i_nfheader_len;
 
+	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
+	 * the first fragment
+	 */
+	if (headersize + transhdrlen > mtu)
+		goto emsgsize;
+
 	if (mtu <= sizeof(struct ipv6hdr) + IPV6_MAXPLEN) {
 		unsigned int maxnonfragsize;
 
@@ -1261,9 +1267,8 @@ int ip6_append_data(struct sock *sk, int
 
 		if (cork->length + length > maxnonfragsize - headersize) {
 emsgsize:
-			ipv6_local_error(sk, EMSGSIZE, fl6,
-					 mtu - headersize +
-					 sizeof(struct ipv6hdr));
+			pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
+			ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
 			return -EMSGSIZE;
 		}
 	}
