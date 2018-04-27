Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrBwXhn7kDa+wfOLU3Yskh/8FDyjCSjRR0vCuV20Y+B6W3jKl9ofMnRvPlTXFXTRd7JCzYI
ARC-Seal: i=1; a=rsa-sha256; t=1524837695; cv=none;
        d=google.com; s=arc-20160816;
        b=IqZLe5JgqBfATE/XV/0zNOMKkSRDjq+heemKpNYtvjCGOtzFQu35HjKhAYj8JNyP7Q
         chSCM6i2mgQgVISatArnuElzO4D1uecLEHBzKpxzR9G2b05bA30LghPBq+jLNEsqvVW0
         8IfEuy/dIuRqbrEnpcVPYZ4DiZ/7zg5QXeK82uABFPBxtUsk++0lgV2d+YisOdftxFcd
         cDPjuXzw2xHm8a+x88ccVeT9oaWrFrYdY2/2WhpJBUsd94y9AxIdmkvQYFxSoxL0hSbj
         KpVKy/Z1h9mjK4D9dvPQxKFr1nCn33JC0ZiFoj4jZQRxJ/fok4OHyrSlYBQJteho3elR
         3IIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=VriKx/Invdf1NyG1AwbREmdC0ucloGDUzRdcXiz6RRI=;
        b=0A3zcRrXwlyA7pcVbjlCkwY3x3ZiaillDX9Un1x6AnbM/QkS8bFVkjGE1hBtC3DQBv
         PCjuqx+NU6c3zOFcT77KvL3hNVfYs+znrtPyPypwRRo1k4iewj8TwGO4lCohW6ZKJ73k
         IgmwcTrKKeaMn9yEqULJA21nMsxbbsxj04rJlntxHArpkq86XWHQwpIaeFIxXWsy1SOB
         0UdqFildUOICB5PO3tMldIKOlFhk+gIuHI5HxlLUZIqCUiAgBwHwv41dr/vWhAyHqB8O
         Mu5jvxRBbv2lpCXKAeDuLUrDKUo6vrZKsGITTEryVgCK3036s1x0mFKtBr22fRbup+1k
         GzXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E8D2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsa@cumulusnetworks.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 31/50] net: validate attribute sizes in neigh_dump_table()
Date: Fri, 27 Apr 2018 15:58:33 +0200
Message-Id: <20180427135657.534290263@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908211126878257?=
X-GMAIL-MSGID: =?utf-8?q?1598908211126878257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 7dd07c143a4b54d050e748bee4b4b9e94a7b1744 ]

Since neigh_dump_table() calls nlmsg_parse() without giving policy
constraints, attributes can have arbirary size that we must validate

Reported by syzbot/KMSAN :

BUG: KMSAN: uninit-value in neigh_master_filtered net/core/neighbour.c:2292 [inline]
BUG: KMSAN: uninit-value in neigh_dump_table net/core/neighbour.c:2348 [inline]
BUG: KMSAN: uninit-value in neigh_dump_info+0x1af0/0x2250 net/core/neighbour.c:2438
CPU: 1 PID: 3575 Comm: syzkaller268891 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 neigh_master_filtered net/core/neighbour.c:2292 [inline]
 neigh_dump_table net/core/neighbour.c:2348 [inline]
 neigh_dump_info+0x1af0/0x2250 net/core/neighbour.c:2438
 netlink_dump+0x9ad/0x1540 net/netlink/af_netlink.c:2225
 __netlink_dump_start+0x1167/0x12a0 net/netlink/af_netlink.c:2322
 netlink_dump_start include/linux/netlink.h:214 [inline]
 rtnetlink_rcv_msg+0x1435/0x1560 net/core/rtnetlink.c:4598
 netlink_rcv_skb+0x355/0x5f0 net/netlink/af_netlink.c:2447
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4653
 netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
 netlink_unicast+0x1672/0x1750 net/netlink/af_netlink.c:1337
 netlink_sendmsg+0x1048/0x1310 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fed9
RSP: 002b:00007ffddbee2798 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fed9
RDX: 0000000000000000 RSI: 0000000020005000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401800
R13: 0000000000401890 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
 slab_post_alloc_hook mm/slab.h:445 [inline]
 slab_alloc_node mm/slub.c:2737 [inline]
 __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:984 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1183 [inline]
 netlink_sendmsg+0x9a6/0x1310 net/netlink/af_netlink.c:1875
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 21fdd092acc7 ("net: Add support for filtering neigh dump by master device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsa@cumulusnetworks.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2280,12 +2280,16 @@ static int neigh_dump_table(struct neigh
 
 	err = nlmsg_parse(nlh, sizeof(struct ndmsg), tb, NDA_MAX, NULL);
 	if (!err) {
-		if (tb[NDA_IFINDEX])
+		if (tb[NDA_IFINDEX]) {
+			if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32))
+				return -EINVAL;
 			filter_idx = nla_get_u32(tb[NDA_IFINDEX]);
-
-		if (tb[NDA_MASTER])
+		}
+		if (tb[NDA_MASTER]) {
+			if (nla_len(tb[NDA_MASTER]) != sizeof(u32))
+				return -EINVAL;
 			filter_master_idx = nla_get_u32(tb[NDA_MASTER]);
-
+		}
 		if (filter_idx || filter_master_idx)
 			flags |= NLM_F_DUMP_FILTERED;
 	}
