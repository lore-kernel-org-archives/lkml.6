Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZofHkQxCiz89zSGjDkYwf1MVBsCJ9vHg92YASSknta8M9I6h1IFcTP3GGnvmMbwH7ZUMQez
ARC-Seal: i=1; a=rsa-sha256; t=1526280799; cv=none;
        d=google.com; s=arc-20160816;
        b=zRYUeyhRoGwMq+qyY/2oJger5TtUQ8di5ZOzcHYwFU0lmY2tYhSzIGvnz+GQ+Gli7I
         vOoLBpYv2R8f0J0lM5GgZ+pmdpRH2i/I9oAo7XjZMvZX5JGe7DnepZ8o8LEJd71Q4Yk6
         Jq56yfHdD/nfm2sLkUGBAVS3jrjXBecLRVjjgHkBaMgisJ4kNTr2wAmXi+xXvfo3YIQD
         q38nIQb0gMhp1IOm7TBYRn97QsyTvH8vFNSBPaehO6pwffkSSB924FIdmJqg7sG5lKBz
         QUq/jtpzvDA36XlAJdeKUz0R7Jq9voj/ocp+mrrU4/HMjgJEPl28ojS52FH6CkmpLyen
         xOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=pwnG+gRwjdh6hlMTLTuro9qbfFSMPv0hP0hhCeE+xy0=;
        b=Ve0CzLkdtkSMl3sOtdUW3NfxY7UnEoraRON352DVwUanBdStxOa2UR6o+uFN0dZHEK
         65ftbOkaNKNEozK5StnaZBLv0nWQeJ7LmNZRyTRzceL7Xj1/8y+AVyI8inJ3aLgxHFuc
         E8tOzpukKqwQg7g8kJWHWikZz1lMQGr3L1iT+GweQd1YJuqY4Xo8LVrMsXP6ATovvD4z
         Bb0Ua5ipgo55VmKUz2OY9V0Jg3qZRDGwcsmHfOhmeBl8IlROJj/j/ydZJiizuBvIdlRm
         Q/pwRWh5o9wokxe8artdtmKluJc4mBqNwn2MvV7ZwUK5LjQhf3vmOgqq+g1GZ6laZ6jz
         UizQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uHwxhc2Y;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uHwxhc2Y;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 36/56] net: fix uninit-value in __hw_addr_add_ex()
Date: Mon, 14 May 2018 08:48:41 +0200
Message-Id: <20180514064758.269850889@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421247484712480?=
X-GMAIL-MSGID: =?utf-8?q?1600421415660707850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 77d36398d99f2565c0a8d43a86fd520a82e64bb8 upstream.

syzbot complained :

BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 memcmp+0x119/0x180 lib/string.c:861
 __hw_addr_add_ex net/core/dev_addr_lists.c:60 [inline]
 __dev_mc_add+0x1c2/0x8e0 net/core/dev_addr_lists.c:670
 dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
 igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
 ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
 addrconf_join_solict net/ipv6/addrconf.c:2078 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:3828 [inline]
 addrconf_dad_work+0x427/0x2150 net/ipv6/addrconf.c:3954
 process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2113
 worker_thread+0x113c/0x24f0 kernel/workqueue.c:2247
 kthread+0x539/0x720 kernel/kthread.c:239

Fixes: f001fde5eadd ("net: introduce a list of device addresses dev_addr_list (v6)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev_addr_lists.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -57,8 +57,8 @@ static int __hw_addr_add_ex(struct netde
 		return -EINVAL;
 
 	list_for_each_entry(ha, &list->list, list) {
-		if (!memcmp(ha->addr, addr, addr_len) &&
-		    ha->type == addr_type) {
+		if (ha->type == addr_type &&
+		    !memcmp(ha->addr, addr, addr_len)) {
 			if (global) {
 				/* check if addr is already used as global */
 				if (ha->global_use)
