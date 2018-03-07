Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthnVQtpCfXLh/kzI/N0ZtVSpy8iuzzDz2A31XrEMc9+bR5FfEdgCcp72xPbMKo2paZEsOK
ARC-Seal: i=1; a=rsa-sha256; t=1520451753; cv=none;
        d=google.com; s=arc-20160816;
        b=AD8cwRXN3MHlpB6cROVfvY5m+NGMpu5rAekIEzR54m5ERj2OV3IN90qBChz+r9VHxo
         KQPLOWYmqXcSdJEbZ8CwZMZzm3xFXdioVkZQGQTqp1MY+K1WqiJTipq+xW33d04mWG9q
         KDoerYMdFmxb0ebuqqdplROuR6I5wWVPkbUGPbwZQTr5QlPPiSWRBlV+6YbbKJ6+NRKw
         0rfbmDyTc/F7lVk2nE5RpVgm4NfMrFLNIpSwtQRv2KiPJCCxyogcDWsQaIacAnhLy70x
         /zuofROrR6S3LY/pCRXVBld+jB/LKJW8DkqC1tEClYjLsCgmaOHA9+TtjbhPewjeZLuX
         39oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hd282jIlZbfHVt5Ljlvr0j23K0R25B5sHptfIExxxik=;
        b=CpIDZfXxNUbkwXbuERzLc+a+5iTCX3RsQz5odgTLOv0v7XnapMNn4TV0R4rZarMSFu
         acLYq6rGLQPByf1cDe9qmzRFaKsYTMRQf2hqiIJAjAxanZagAVL26x7vBlHkgRTyCgxA
         xJepvcu9CU13dBu8zhbRsw6h5jvpCD5n5BdWJw+6IeAAKYfxi+JEdisOMMv5d/gzD7Hn
         ZidOrHNQUqemgVvNXoDlc3N+fjKybciRHfFsfFHwC2szSGSEF9Vz2jpcN2nhv7Bnt0bQ
         ZNgFdBELi8lOkFtb1xmusWU+oNqlvIH/SRRyE7UxMBW51o2ctUVg5dcHzjzcGfbtprEU
         /OKA==
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
Subject: [PATCH 4.15 083/122] l2tp: dont use inet_shutdown on tunnel destroy
Date: Wed,  7 Mar 2018 11:38:15 -0800
Message-Id: <20180307191741.248562108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309217601982498?=
X-GMAIL-MSGID: =?utf-8?q?1594309217601982498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Chapman <jchapman@katalix.com>


[ Upstream commit 76a6abdb2513ad4ea0ded55d2c66160491f2e848 ]

Previously, if a tunnel was closed, we called inet_shutdown to mark
the socket as unconnected such that userspace would get errors and
then close the socket. This could race with userspace closing the
socket. Instead, leave userspace to close the socket in its own time
(our tunnel will be detached anyway).

BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
IP: __lock_acquire+0x263/0x1630
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN
Modules linked in:
CPU: 2 PID: 42 Comm: kworker/u8:2 Not tainted 4.15.0-rc7+ #129
Workqueue: l2tp l2tp_tunnel_del_work
RIP: 0010:__lock_acquire+0x263/0x1630
RSP: 0018:ffff88001a37fc70 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000088 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88001a37fd18 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000076fd R12: 00000000000000a0
R13: ffff88001a3722c0 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88001ad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a0 CR3: 000000001730b000 CR4: 00000000000006e0
Call Trace:
 ? __lock_acquire+0xc77/0x1630
 ? console_trylock+0x11/0xa0
 lock_acquire+0x117/0x230
 ? lock_sock_nested+0x3a/0xa0
 _raw_spin_lock_bh+0x3a/0x50
 ? lock_sock_nested+0x3a/0xa0
 lock_sock_nested+0x3a/0xa0
 inet_shutdown+0x33/0xf0
 l2tp_tunnel_del_work+0x60/0xef
 process_one_work+0x1ea/0x5f0
 ? process_one_work+0x162/0x5f0
 worker_thread+0x48/0x3e0
 ? trace_hardirqs_on+0xd/0x10
 kthread+0x108/0x140
 ? process_one_work+0x5f0/0x5f0
 ? kthread_stop+0x2a0/0x2a0
 ret_from_fork+0x24/0x30
Code: 00 41 81 ff ff 1f 00 00 0f 87 7a 13 00 00 45 85 f6 49 8b 85
68 08 00 00 0f 84 ae 03 00 00 c7 44 24 18 00 00 00 00 e9 f0 00 00 00 <49> 81 3c
24 80 93 3f 83 b8 00 00 00 00 44 0f 44 c0 83 fe 01 0f
RIP: __lock_acquire+0x263/0x1630 RSP: ffff88001a37fc70
CR2: 00000000000000a0

Fixes: 309795f4bec2d ("l2tp: Add netlink control API for L2TP")
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1336,17 +1336,10 @@ static void l2tp_tunnel_del_work(struct
 
 	sock = sk->sk_socket;
 
-	/* If the tunnel socket was created by userspace, then go through the
-	 * inet layer to shut the socket down, and let userspace close it.
-	 * Otherwise, if we created the socket directly within the kernel, use
+	/* If the tunnel socket was created within the kernel, use
 	 * the sk API to release it here.
-	 * In either case the tunnel resources are freed in the socket
-	 * destructor when the tunnel socket goes away.
 	 */
-	if (tunnel->fd >= 0) {
-		if (sock)
-			inet_shutdown(sock, 2);
-	} else {
+	if (tunnel->fd < 0) {
 		if (sock) {
 			kernel_sock_shutdown(sock, SHUT_RDWR);
 			sock_release(sock);
