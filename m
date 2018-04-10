Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+uf57Z8WWVEyfEAwdgIF0pnGj4A3eSypUjcLi/cLi836SKtQ966YFspCj/VPrUAO33yQNf
ARC-Seal: i=1; a=rsa-sha256; t=1523399526; cv=none;
        d=google.com; s=arc-20160816;
        b=gvSTwTlL5Fq1JtqFjlLBbBQlJSNCMyabhsawahPu/8VCJijHUjel4JHu6Q8j0h5Z0S
         yNRuoHuoEHiuMZq7w8yscOaSY/RkSHDa37ylTrhCF9mOAhTdpL1+EGTtnx3LIM84nGps
         lNoojcxnHlTBa4WuH7Oiv93XqQq+J3CtxbRZVklO1MynocROPuwbGX4+9kUurTPVFVOM
         tV5OHmUVvRK2binCTQQ3lzvI2Rg4qi5gnhMVnr8vSDHm6LNNmyfC5eNh5cwe7mSZ5AsH
         Pgw07KUHKS86JZlmh9qUKH/f5Y+b1TfjvQah/8TsFj0ETjuAVm7XwPjI9p1Kc/f7sSTS
         WGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S7+Izb/ZXHsSiVfx2jTiQX5qUSnsAquU1+AAzEbT0tg=;
        b=mz7MWQcEnbKRzGbljt7kPZINWKTHNYUZiDLTktGld+pzOHIxMqMwIazJc+y7vzxD9n
         zzFD6+OQlj6S64Lj5Vctt1iNRGlR/KMhvwcqZ3kYwNj8ZHQWVHxEjQ5U7B/IwLFlGJhK
         hy5P0/TRgh2uM/asSNwcj8DgeyDTonV4x9kDoSlU6QC88o5zlZIXYFFQpENHpnkQi2m5
         lWWNMoyG1WJ7ydwIA+mWXVIh6NdnxEDTkyM664mIfZL3/U7nJgd1j0NJZQUMYra/yLkv
         Zl2eISfajabEcbHkXANKvKb4gqF6D7goqoKICfRxwc04UNchG985Mti2y/h6qZBCBCwA
         WWEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+91e6f9932ff122fa4410@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 122/168] ipv6: the entire IPv6 header chain must fit the first fragment
Date: Wed, 11 Apr 2018 00:24:24 +0200
Message-Id: <20180410212805.753698588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400181936050508?=
X-GMAIL-MSGID: =?utf-8?q?1597400181936050508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit 10b8a3de603df7b96004179b1b33b1708c76d144 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1245,7 +1245,7 @@ static int __ip6_append_data(struct sock
 			     const struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
-	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu;
+	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
 	int exthdrlen = 0;
 	int dst_exthdrlen = 0;
 	int hh_len;
@@ -1281,6 +1281,12 @@ static int __ip6_append_data(struct sock
 		      sizeof(struct frag_hdr) : 0) +
 		     rt->rt6i_nfheader_len;
 
+	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
+	 * the first fragment
+	 */
+	if (headersize + transhdrlen > mtu)
+		goto emsgsize;
+
 	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1296,9 +1302,8 @@ static int __ip6_append_data(struct sock
 
 	if (cork->length + length > maxnonfragsize - headersize) {
 emsgsize:
-		ipv6_local_error(sk, EMSGSIZE, fl6,
-				 mtu - headersize +
-				 sizeof(struct ipv6hdr));
+		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
+		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
 		return -EMSGSIZE;
 	}
 
