Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451772-2-5634996837020399295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451771; b=vNWxgtp/hm3zLhXcyrJWnydgMfwWodIs7D3QCWv7SibUM53
    tp+u1cEh7H6BLvw0ZB1RJqS8q4uhmU3s9T3/pngwgmYXZbjycVsWiqaO0P8m/d7p
    o3xXg6FrBB1Izhyy87AjLazfdYOEyGg2eV/Ojxx3yqJPUVWJFpOE0wiUvJyCJpaR
    r5s3bj6giIsPTE613xwhNcCS4kpc6nsHBfqU1eFivvV8Ldq8S+qrGriXgCgGvV7f
    t3j+RGgTWwwegYetgmK1latUld9xaD/Colz/Nfxga/bAuWawYp4/6+kTknvZZz9k
    pCbqETPkOHvU/JNxUG+7rQJepKhxNh+CSzvjcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451771; bh=xFj3pZGB16CtzlJ3RgI0ecfo9E
    sDjqnp7wwyl3NrMhg=; b=ONrvPH50YyOOqgNWJWg4/lNl7Se+lEmf/Qi1zylJKC
    TGhq7ow/UAZnd2KjyV3L3nzq5UrM+B/4Fu1b87ro2J61TZFbNr4IusZmv1mqHNkX
    z7aRf8twiz2+S6Z7q74JglK8CzZCWUAEaHlr2Kqbe5JO1HnjREY+7QntOxRib+lC
    iTYyl86Oq6195E5L9ZW7i3ckn/R37aXD7Fl5MkleoAkM+oEJIfxCtV9kNv17QEXW
    V8FiaX9ef59ISlJAYHUnJaXmdGVHjJzxUzfrczzezWEobVC7SyNyPw0lCwcZ3rZw
    YGUG7Yd9DoAnRwDVFskPITO4QKn3azulaieCMKu1+sCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934899AbeCGTmo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:42:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933537AbeCGTmm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:42:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 087/122] l2tp: fix tunnel lookup use-after-free race
Date: Wed,  7 Mar 2018 11:38:19 -0800
Message-Id: <20180307191741.971623639@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Chapman <jchapman@katalix.com>


[ Upstream commit 28f5bfb819195ad9c2eb9486babe7b0e4efe925f ]

l2tp_tunnel_get walks the tunnel list to find a matching tunnel
instance and if a match is found, its refcount is increased before
returning the tunnel pointer. But when tunnel objects are destroyed,
they are on the tunnel list after their refcount hits zero. Fix this
by moving the code that removes the tunnel from the tunnel list from
the tunnel socket destructor into in the l2tp_tunnel_delete path,
before the tunnel refcount is decremented.

refcount_t: increment on 0; use-after-free.
WARNING: CPU: 3 PID: 13507 at lib/refcount.c:153 refcount_inc+0x47/0x50
Modules linked in:
CPU: 3 PID: 13507 Comm: syzbot_6e6a5ec8 Not tainted 4.16.0-rc2+ #36
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
RIP: 0010:refcount_inc+0x47/0x50
RSP: 0018:ffff8800136ffb20 EFLAGS: 00010286
RAX: dffffc0000000008 RBX: ffff880017068e68 RCX: ffffffff814d3333
RDX: 0000000000000000 RSI: ffff88001a59f6d8 RDI: ffff88001a59f6d8
RBP: ffff8800136ffb28 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8800136ffab0 R11: 0000000000000000 R12: ffff880017068e50
R13: 0000000000000000 R14: ffff8800174da800 R15: 0000000000000004
FS:  00007f403ab1e700(0000) GS:ffff88001a580000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000205fafd2 CR3: 0000000016770000 CR4: 00000000000006e0
Call Trace:
 l2tp_tunnel_get+0x2dd/0x4e0
 pppol2tp_connect+0x428/0x13c0
 ? pppol2tp_session_create+0x170/0x170
 ? __might_fault+0x115/0x1d0
 ? lock_downgrade+0x860/0x860
 ? __might_fault+0xe5/0x1d0
 ? security_socket_connect+0x8e/0xc0
 SYSC_connect+0x1b6/0x310
 ? SYSC_bind+0x280/0x280
 ? __do_page_fault+0x5d1/0xca0
 ? up_read+0x1f/0x40
 ? __do_page_fault+0x3c8/0xca0
 SyS_connect+0x29/0x30
 ? SyS_accept+0x40/0x40
 do_syscall_64+0x1e0/0x730
 ? trace_hardirqs_off_thunk+0x1a/0x1c
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x7f403a42f259
RSP: 002b:00007f403ab1dee8 EFLAGS: 00000296 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000205fafe4 RCX: 00007f403a42f259
RDX: 000000000000002e RSI: 00000000205fafd2 RDI: 0000000000000004
RBP: 00007f403ab1df20 R08: 00007f403ab1e700 R09: 0000000000000000
R10: 00007f403ab1e700 R11: 0000000000000296 R12: 0000000000000000
R13: 00007ffc81906cbf R14: 0000000000000000 R15: 00007f403ab2b040
Code: 3b ff 5b 5d c3 e8 ca 5f 3b ff 80 3d 49 8e 66 04 00 75 ea e8 bc 5f 3b ff 48 c7 c7 60 69 64 85 c6 05 34 8e 66 04 01 e8 59 49 15 ff <0f> 0b eb ce 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 53 49

Fixes: f8ccac0e44934 ("l2tp: put tunnel socket release on a workqueue")
Reported-and-tested-by: syzbot+19c09769f14b48810113@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+347bd5acde002e353a36@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+6e6a5ec8de31a94cd015@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+9df43faf09bd400f2993@syzkaller.appspotmail.com
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1173,7 +1173,6 @@ EXPORT_SYMBOL_GPL(l2tp_xmit_skb);
 static void l2tp_tunnel_destruct(struct sock *sk)
 {
 	struct l2tp_tunnel *tunnel = l2tp_tunnel(sk);
-	struct l2tp_net *pn;
 
 	if (tunnel == NULL)
 		goto end;
@@ -1196,12 +1195,6 @@ static void l2tp_tunnel_destruct(struct
 	sk->sk_destruct = tunnel->old_sk_destruct;
 	sk->sk_user_data = NULL;
 
-	/* Remove the tunnel struct from the tunnel list */
-	pn = l2tp_pernet(tunnel->l2tp_net);
-	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
-	list_del_rcu(&tunnel->list);
-	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
-
 	/* Call the original destructor */
 	if (sk->sk_destruct)
 		(*sk->sk_destruct)(sk);
@@ -1280,6 +1273,7 @@ static void l2tp_tunnel_del_work(struct
 						  del_work);
 	struct sock *sk = tunnel->sock;
 	struct socket *sock = sk->sk_socket;
+	struct l2tp_net *pn;
 
 	l2tp_tunnel_closeall(tunnel);
 
@@ -1293,6 +1287,12 @@ static void l2tp_tunnel_del_work(struct
 		}
 	}
 
+	/* Remove the tunnel struct from the tunnel list */
+	pn = l2tp_pernet(tunnel->l2tp_net);
+	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
+	list_del_rcu(&tunnel->list);
+	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
 	/* drop initial ref */
 	l2tp_tunnel_dec_refcount(tunnel);
 
