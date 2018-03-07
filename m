Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt5xcQMFNnjOtlq14LfCC23itSqC6ZfkxuXt2KFihhn2H68jK70xMymr+m2U3Z/JnV3HGwv
ARC-Seal: i=1; a=rsa-sha256; t=1520451755; cv=none;
        d=google.com; s=arc-20160816;
        b=Dv/u2V6z1GNdaKMc2PR/eNNhT7MdbR9dibt+45m87z7GSOE38qyhVSWBAYZqiJoUZQ
         HygWS3HZCJwaYsr/TBwWKUVEK1ZRjbqzIMynWdYYDKOFk+XDdxQjWDUqFXDNl1tbzWVT
         eD67Vk9LTCRbj+2uJ2aNBlAxFT3ZVbrgf4/wo7plUcLnijs4mn5zb+vxZerVnFJYjVzA
         JqU1Dk8iWUjpCpsYIAQ9Ehkw65/D91+/oBhn5Oa3f5wFLlOPdaR/Ynr2QRTB6U0He/7e
         K03ZS+xyvI433GEvzUfFymH9VlG2sATJ5fK3+FgbK0HvtNk0XTVDTEOVEed70SV33MQH
         ADFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jFcHiMDwl/HFrRtMbedipEYs28T5T2YKUrpZwgKFlQg=;
        b=ovHWeWMVlNYvYoxkn7bieGjR75Mm9sSx8Fz7MmREQduS88XfEUrmh/eMVoMWMu2AwH
         l99x6xKXZ3DzStdM51+DYUgqP68Nj0Fcf5xqHeT2deq0Yk3/73DPd+584urInv5MvvIL
         08k77uxwr71Kk6mirPRj2O5psS9FK9nsrInHKApI9IPrT5sifouyj6pufutmBcT9O2JK
         MPyCOklkkD4KDD/eGvvAelKa+x3lCBrKdLFZH7twkuDH1pDiVbxWqdHZVZJpB6cXG/4h
         vnHp17WuUUwm4lrvWF3hKbK5ugzrRtIFmCkB4B9DZZvhQmgoxtY6rTvd++ahPrueVs7Z
         Zl5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 084/122] l2tp: dont use inet_shutdown on ppp session destroy
Date: Wed,  7 Mar 2018 11:38:16 -0800
Message-Id: <20180307191741.438364863@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309220051657758?=
X-GMAIL-MSGID: =?utf-8?q?1594309220051657758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Chapman <jchapman@katalix.com>


[ Upstream commit 225eb26489d05c679a4c4197ffcb81c81e9dcaf4 ]

Previously, if a ppp session was closed, we called inet_shutdown to mark
the socket as unconnected such that userspace would get errors and
then close the socket. This could race with userspace closing the
socket. Instead, leave userspace to close the socket in its own time
(our session will be detached anyway).

BUG: KASAN: use-after-free in inet_shutdown+0x5d/0x1c0
Read of size 4 at addr ffff880010ea3ac0 by task syzbot_347bd5ac/8296

CPU: 3 PID: 8296 Comm: syzbot_347bd5ac Not tainted 4.16.0-rc1+ #91
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 dump_stack+0x101/0x157
 ? inet_shutdown+0x5d/0x1c0
 print_address_description+0x78/0x260
 ? inet_shutdown+0x5d/0x1c0
 kasan_report+0x240/0x360
 __asan_load4+0x78/0x80
 inet_shutdown+0x5d/0x1c0
 ? pppol2tp_show+0x80/0x80
 pppol2tp_session_close+0x68/0xb0
 l2tp_tunnel_closeall+0x199/0x210
 ? udp_v6_flush_pending_frames+0x90/0x90
 l2tp_udp_encap_destroy+0x6b/0xc0
 ? l2tp_tunnel_del_work+0x2e0/0x2e0
 udpv6_destroy_sock+0x8c/0x90
 sk_common_release+0x47/0x190
 udp_lib_close+0x15/0x20
 inet_release+0x85/0xd0
 inet6_release+0x43/0x60
 sock_release+0x53/0x100
 ? sock_alloc_file+0x260/0x260
 sock_close+0x1b/0x20
 __fput+0x19f/0x380
 ____fput+0x1a/0x20
 task_work_run+0xd2/0x110
 exit_to_usermode_loop+0x18d/0x190
 do_syscall_64+0x389/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b
RIP: 0033:0x7fe240a45259
RSP: 002b:00007fe241132df8 EFLAGS: 00000297 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe240a45259
RDX: 00007fe240a45259 RSI: 0000000000000000 RDI: 00000000000000a5
RBP: 00007fe241132e20 R08: 00007fe241133700 R09: 0000000000000000
R10: 00007fe241133700 R11: 0000000000000297 R12: 0000000000000000
R13: 00007ffc49aff84f R14: 0000000000000000 R15: 00007fe241141040

Allocated by task 8331:
 save_stack+0x43/0xd0
 kasan_kmalloc+0xad/0xe0
 kasan_slab_alloc+0x12/0x20
 kmem_cache_alloc+0x144/0x3e0
 sock_alloc_inode+0x22/0x130
 alloc_inode+0x3d/0xf0
 new_inode_pseudo+0x1c/0x90
 sock_alloc+0x30/0x110
 __sock_create+0xaa/0x4c0
 SyS_socket+0xbe/0x130
 do_syscall_64+0x128/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b

Freed by task 8314:
 save_stack+0x43/0xd0
 __kasan_slab_free+0x11a/0x170
 kasan_slab_free+0xe/0x10
 kmem_cache_free+0x88/0x2b0
 sock_destroy_inode+0x49/0x50
 destroy_inode+0x77/0xb0
 evict+0x285/0x340
 iput+0x429/0x530
 dentry_unlink_inode+0x28c/0x2c0
 __dentry_kill+0x1e3/0x2f0
 dput.part.21+0x500/0x560
 dput+0x24/0x30
 __fput+0x2aa/0x380
 ____fput+0x1a/0x20
 task_work_run+0xd2/0x110
 exit_to_usermode_loop+0x18d/0x190
 do_syscall_64+0x389/0x3b0
 entry_SYSCALL_64_after_hwframe+0x26/0x9b

Fixes: fd558d186df2c ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -420,16 +420,6 @@ abort:
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct sock *sk;
-
-	BUG_ON(session->magic != L2TP_SESSION_MAGIC);
-
-	sk = pppol2tp_session_get_sock(session);
-	if (sk) {
-		if (sk->sk_socket)
-			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
-		sock_put(sk);
-	}
 }
 
 /* Really kill the session socket. (Called from sock_put() if
