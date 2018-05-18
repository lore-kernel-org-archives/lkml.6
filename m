Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoTQ+zsV/5LbupY5EbDT2srb9AShF3/luU8TEj7ev+9MNVp2yWM70CsTg1m8NApG0Ve3v2R
ARC-Seal: i=1; a=rsa-sha256; t=1526631514; cv=none;
        d=google.com; s=arc-20160816;
        b=DH6TGYHYggjm24150JoKkanR1D7ERYIfGTdZryC+ymlux2nY3g/ABzYwf5BdfRI9pn
         E2J+BW+zKCBJEuPle7HbI6BDZRUTquQPYO90qKF+vPBf+i5LfCNh1V3eijFSSxgeqLe7
         cdarxksRUBo4JQGJjYfbNPKDudWLY9Af4YUJQCnXAyhnfBfiEQiMYgajNx3y8CL0YNix
         lLyZps6bvzm1YCbn7QhXdaP2dCXFDsB3yYjfjLeulD+YTFCm1DZfH6IFdHC9aXgPFLAN
         M1KsNJU6+S+O5J5tUBPdVxkzOxIdS7Wrd3RMwpyo/Zc022jQSgz2prPT9ncVU31MkFv1
         SMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+2wt6PnniHwjYMKklIzG+xJBA4f4VAp1EG6Y4lpN7u4=;
        b=ciTqm7baJ91lHVAUF87hW9/mKCjKzIOSgHwGvhdP52fsJMzYQaEFmSR/zSzjJQM8WM
         20yNxws3QZrU+3FVyGn4XNVXusmQXRuxLy+OimPQS7ycSBot4DwiCNQP7qQ9IJYyJ3CQ
         crydi/tXGnSAYI7lSEWHkFWONWD8Fz6mjIg7prKmB6Uri6H+7idf9n88ClzCseh4T4kQ
         rgHaukk6C/11LHu0lVFDh4dC78SpelMrqTfwgOWkJaLKEWUcN6/9RlulOLi6NEpLZUdi
         BnSrEQ3K6izXr+Zbs2boxZsBShrbIa7uCB9w0aeLJFhWxXTgPWtlEdxQMC8I3wEypEJ6
         fUgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TEKI1MzI;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TEKI1MzI;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 47/55] tipc: fix one byte leak in tipc_sk_set_orig_addr()
Date: Fri, 18 May 2018 10:15:43 +0200
Message-Id: <20180518081459.635365594@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789167345348201?=
X-GMAIL-MSGID: =?utf-8?q?1600789167345348201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 09c8b9718a7af674036643fa2e0dbb2f09aba75e ]

sysbot/KMSAN reported an uninit-value in recvmsg() that
I tracked down to tipc_sk_set_orig_addr(), missing
srcaddr->member.scope initialization.

This patches moves srcaddr->sock.scope init to follow
fields order and ease future verifications.

BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184 [inline]
BUG: KMSAN: uninit-value in move_addr_to_user+0x32e/0x530 net/socket.c:226
CPU: 0 PID: 4549 Comm: syz-executor287 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 kmsan_internal_check_memory+0x135/0x1e0 mm/kmsan/kmsan.c:1157
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:226
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2285
 __sys_recvmsg net/socket.c:2328 [inline]
 __do_sys_recvmsg net/socket.c:2338 [inline]
 __se_sys_recvmsg net/socket.c:2335 [inline]
 __x64_sys_recvmsg+0x325/0x460 net/socket.c:2335
 do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4455e9
RSP: 002b:00007fe3bd36ddb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 00000000004455e9
RDX: 0000000000002002 RSI: 0000000020000400 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff98ce4b6f R14: 00007fe3bd36e9c0 R15: 0000000000000003

Local variable description: ----addr@___sys_recvmsg
Variable was created at:
 ___sys_recvmsg+0xd5/0x810 net/socket.c:2246
 __sys_recvmsg net/socket.c:2328 [inline]
 __do_sys_recvmsg net/socket.c:2338 [inline]
 __se_sys_recvmsg net/socket.c:2335 [inline]
 __x64_sys_recvmsg+0x325/0x460 net/socket.c:2335

Byte 19 of 32 is uninitialized

Fixes: 31c82a2d9d51 ("tipc: add second source address to recvmsg()/recvfrom()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Cc: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1518,10 +1518,10 @@ static void tipc_sk_set_orig_addr(struct
 
 	srcaddr->sock.family = AF_TIPC;
 	srcaddr->sock.addrtype = TIPC_ADDR_ID;
+	srcaddr->sock.scope = 0;
 	srcaddr->sock.addr.id.ref = msg_origport(hdr);
 	srcaddr->sock.addr.id.node = msg_orignode(hdr);
 	srcaddr->sock.addr.name.domain = 0;
-	srcaddr->sock.scope = 0;
 	m->msg_namelen = sizeof(struct sockaddr_tipc);
 
 	if (!msg_in_group(hdr))
@@ -1530,6 +1530,7 @@ static void tipc_sk_set_orig_addr(struct
 	/* Group message users may also want to know sending member's id */
 	srcaddr->member.family = AF_TIPC;
 	srcaddr->member.addrtype = TIPC_ADDR_NAME;
+	srcaddr->member.scope = 0;
 	srcaddr->member.addr.name.name.type = msg_nametype(hdr);
 	srcaddr->member.addr.name.name.instance = TIPC_SKB_CB(skb)->orig_member;
 	srcaddr->member.addr.name.domain = 0;
