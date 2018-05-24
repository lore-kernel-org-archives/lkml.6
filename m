Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpwOvEQtyig+f9mfQ6w1PYw32ilmiFlHacaz3FziXnm+IFSd28chKY1WYbJPg3oaXMJhv01
ARC-Seal: i=1; a=rsa-sha256; t=1527155991; cv=none;
        d=google.com; s=arc-20160816;
        b=XqF8BOhVqZyGezQMLd9TcYMuDeUs0RSXPde+JM31a+uky29Z3Qp3Fk+2s4TFyNbbXw
         yKVXMU1+yKK0Dvf/Om2TyIscH1fTT4gXY7w3O+mMgTh7osyPxxGPHc0ZYy3x2xJdDzVY
         A8EUYW0Z8vGabuXKPe5KrG6fDudTMFBwe3jkGSYB73smXLf0aegej1zIYD7fKokQw6XD
         0an/casFSxiWY3AA9zQUh1wJxWzu/l+VYrean2k+wbRIPCew314h4NoL23m99SI0g7YC
         LX4F2dthUENQBHcQdpeOFwccK6MNUfew3f5cx4ErXtDMV5WvAa47jHVPhxCRO4kuo2d5
         xNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KZbZLaM5Eir39FXKV4c1+fTsKGcg80sbx597/yFZJDk=;
        b=SWW2Hk1CXI35WF0YGjW4A15SXlRl/V+ZWtcZVKRfCpVuEGGsF4rBLHmIEzp1ZN+YUI
         jD4+SyFDBb9kYU5y2wHEJyEBYkDVk8qh9yJhNePnmZ5XbUaKMM8n06+VDiI9Btc0n6bP
         drRSD5a+RhqcpAvJoxS+I6vDLnaS1VE5fpJ1BhO4+NtSHKaPLie/3SZ0A4joGwE3hDX9
         +yXiNgCHgnTy2938YS6Lgljq71fXx020c3k2MfJ4cyLPOnT9919B7cwSC1/+0C+5iFT4
         URgZWVJaFArZoRnxjSiG7LVNxQY2bVCLmqeB9DPA5Rub+eqAfSuvOJ3mzf6rHKXnG8Sh
         cAhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MZG472V1;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MZG472V1;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 005/161] net: sched: red: avoid hashing NULL child
Date: Thu, 24 May 2018 11:37:10 +0200
Message-Id: <20180524093019.005211394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338635238929910?=
X-GMAIL-MSGID: =?utf-8?q?1601339120848267471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 44a63b137f7b6e4c7bd6c9cc21615941cb36509d ]

Hangbin reported an Oops triggered by the syzkaller qdisc rules:

 kasan: GPF could be caused by NULL-ptr deref or user memory access
 general protection fault: 0000 [#1] SMP KASAN PTI
 Modules linked in: sch_red
 CPU: 0 PID: 28699 Comm: syz-executor5 Not tainted 4.17.0-rc4.kcov #1
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:qdisc_hash_add+0x26/0xa0
 RSP: 0018:ffff8800589cf470 EFLAGS: 00010203
 RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff824ad971
 RDX: 0000000000000007 RSI: ffffc9000ce9f000 RDI: 000000000000003c
 RBP: 0000000000000001 R08: ffffed000b139ea2 R09: ffff8800589cf4f0
 R10: ffff8800589cf50f R11: ffffed000b139ea2 R12: ffff880054019fc0
 R13: ffff880054019fb4 R14: ffff88005c0af600 R15: ffff880054019fb0
 FS:  00007fa6edcb1700(0000) GS:ffff88005ce00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000020000740 CR3: 000000000fc16000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  red_change+0x2d2/0xed0 [sch_red]
  qdisc_create+0x57e/0xef0
  tc_modify_qdisc+0x47f/0x14e0
  rtnetlink_rcv_msg+0x6a8/0x920
  netlink_rcv_skb+0x2a2/0x3c0
  netlink_unicast+0x511/0x740
  netlink_sendmsg+0x825/0xc30
  sock_sendmsg+0xc5/0x100
  ___sys_sendmsg+0x778/0x8e0
  __sys_sendmsg+0xf5/0x1b0
  do_syscall_64+0xbd/0x3b0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x450869
 RSP: 002b:00007fa6edcb0c48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fa6edcb16b4 RCX: 0000000000450869
 RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000013
 RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
 R13: 0000000000008778 R14: 0000000000702838 R15: 00007fa6edcb1700
 Code: e9 0b fe ff ff 0f 1f 44 00 00 55 53 48 89 fb 89 f5 e8 3f 07 f3 fe 48 8d 7b 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 51
 RIP: qdisc_hash_add+0x26/0xa0 RSP: ffff8800589cf470

When a red qdisc is updated with a 0 limit, the child qdisc is left
unmodified, no additional scheduler is created in red_change(),
the 'child' local variable is rightfully NULL and must not add it
to the hash table.

This change addresses the above issue moving qdisc_hash_add() right
after the child qdisc creation. It additionally removes unneeded checks
for noop_qdisc.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Fixes: 49b499718fa1 ("net: sched: make default fifo qdiscs appear in the dump")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_red.c |    5 +++--
 net/sched/sch_tbf.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -222,10 +222,11 @@ static int red_change(struct Qdisc *sch,
 					 extack);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
-	}
 
-	if (child != &noop_qdisc)
+		/* child is fifo, no need to check for noop_qdisc */
 		qdisc_hash_add(child, true);
+	}
+
 	sch_tree_lock(sch);
 	q->flags = ctl->flags;
 	q->limit = ctl->limit;
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -383,6 +383,9 @@ static int tbf_change(struct Qdisc *sch,
 			err = PTR_ERR(child);
 			goto done;
 		}
+
+		/* child is fifo, no need to check for noop_qdisc */
+		qdisc_hash_add(child, true);
 	}
 
 	sch_tree_lock(sch);
@@ -391,8 +394,6 @@ static int tbf_change(struct Qdisc *sch,
 					  q->qdisc->qstats.backlog);
 		qdisc_destroy(q->qdisc);
 		q->qdisc = child;
-		if (child != &noop_qdisc)
-			qdisc_hash_add(child, true);
 	}
 	q->limit = qopt->limit;
 	if (tb[TCA_TBF_PBURST])
