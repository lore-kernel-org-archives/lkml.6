Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpxpcvgP6TVcyqTgq/6f8wKbU4fSi+WEKyXXv8w8CUETqGYI/Qj4YBlpD4WPNi8ajZbiY0E
ARC-Seal: i=1; a=rsa-sha256; t=1526631421; cv=none;
        d=google.com; s=arc-20160816;
        b=qF2dnYLOq9sKLKvx7zMKTXW7XoAtmukpDAt/AXSJbEP4BLS2VoSMUXy0T/OX6okOAH
         3eFjRR2aEQ/Iabd6/KuZ7Ot+bja+LHT4JhucHuIvCBGBciKzpubwW6Zke9GISqi6lxsF
         ymqwn7wcWcnLeso0xZIc7yk1u26fFBBY60B4kMwDMy5/zQrFCExfq1EvYRm1hcx/Lr0s
         iOPKU6ZdhH9GNMag4UeoOLwooeCRlz5zkaXxFqLj+bLbUp7c0711hJ3dRTIzIbk7uQrL
         egPEhKhVQb8N112jEXNx2J9nkpWcCq2wj3C1MgdEfsU4yi2Yh6x+Tu7yiGyicYrG05Ov
         2s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WQ0cgFPenZYbAHX/4m+4LaDNVTbSY0K9YwDlidYx0uY=;
        b=ZLuZA8L/h25bLQd66y7HhgFD0CD0aHgzuksxwQ8IFcutPyqTO8C4hO8o5A0688kLCu
         YHivD7oZbAHgfYY/98zL6N8pLUdsZLl2tQWBzlr//wDeqspR1YeZWvzsEMGsYZs1cB/Z
         TQtCCQT0CYwigb8HKdljge7t7Emhy5xZGbzpjkHQkHjUyqJlUp5eMyAbQTk26LMULius
         InFv1x2OyA4PH1qoVN1b3wD8EBJIe3neuI3m2KRseYqtEbTqW3bzw84+B8q1VINHy8Qc
         QibnyxmsJ2Y0baZPwg3bLj6L05Zs9+0H0WlBUIlKbCQdESe0a045wMJ5FNVFvaKqVSVW
         3mag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dB2rTPdH;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dB2rTPdH;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Gerrit Renker <gerrit@erg.abdn.ac.uk>,
	dccp@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 03/55] dccp: fix tasklet usage
Date: Fri, 18 May 2018 10:14:59 +0200
Message-Id: <20180518081457.569005400@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789069560147522?=
X-GMAIL-MSGID: =?utf-8?q?1600789069560147522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a8d7aa17bbc970971ccdf71988ea19230ab368b1 ]

syzbot reported a crash in tasklet_action_common() caused by dccp.

dccp needs to make sure socket wont disappear before tasklet handler
has completed.

This patch takes a reference on the socket when arming the tasklet,
and moves the sock_put() from dccp_write_xmit_timer() to dccp_write_xmitlet()

kernel BUG at kernel/softirq.c:514!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 17 Comm: ksoftirqd/1 Not tainted 4.17.0-rc3+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515
RSP: 0018:ffff8801d9b3faf8 EFLAGS: 00010246
dccp_close: ABORT with 65423 bytes unread
RAX: 1ffff1003b367f6b RBX: ffff8801daf1f3f0 RCX: 0000000000000000
RDX: ffff8801cf895498 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff8801d9b3fc40 R08: ffffed0039f12a95 R09: ffffed0039f12a94
dccp_close: ABORT with 65423 bytes unread
R10: ffffed0039f12a94 R11: ffff8801cf8954a3 R12: 0000000000000000
R13: ffff8801d9b3fc18 R14: dffffc0000000000 R15: ffff8801cf895490
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc28000 CR3: 00000001a08a9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tasklet_action+0x1d/0x20 kernel/softirq.c:533
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
dccp_close: ABORT with 65423 bytes unread
 run_ksoftirqd+0x86/0x100 kernel/softirq.c:646
 smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
 kthread+0x345/0x410 kernel/kthread.c:238
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: 48 8b 85 e8 fe ff ff 48 8b 95 f0 fe ff ff e9 94 fb ff ff 48 89 95 f0 fe ff ff e8 81 53 6e 00 48 8b 95 f0 fe ff ff e9 62 fb ff ff <0f> 0b 48 89 cf 48 89 8d e8 fe ff ff e8 64 53 6e 00 48 8b 8d e8
RIP: tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515 RSP: ffff8801d9b3faf8

Fixes: dc841e30eaea ("dccp: Extend CCID packet dequeueing interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: dccp@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccids/ccid2.c |   14 ++++++++++++--
 net/dccp/timer.c       |    2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -126,6 +126,16 @@ static void ccid2_change_l_seq_window(st
 						  DCCPF_SEQ_WMAX));
 }
 
+static void dccp_tasklet_schedule(struct sock *sk)
+{
+	struct tasklet_struct *t = &dccp_sk(sk)->dccps_xmitlet;
+
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		sock_hold(sk);
+		__tasklet_schedule(t);
+	}
+}
+
 static void ccid2_hc_tx_rto_expire(struct timer_list *t)
 {
 	struct ccid2_hc_tx_sock *hc = from_timer(hc, t, tx_rtotimer);
@@ -166,7 +176,7 @@ static void ccid2_hc_tx_rto_expire(struc
 
 	/* if we were blocked before, we may now send cwnd=1 packet */
 	if (sender_was_blocked)
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	/* restart backed-off timer */
 	sk_reset_timer(sk, &hc->tx_rtotimer, jiffies + hc->tx_rto);
 out:
@@ -706,7 +716,7 @@ static void ccid2_hc_tx_packet_recv(stru
 done:
 	/* check if incoming Acks allow pending packets to be sent */
 	if (sender_was_blocked && !ccid2_cwnd_network_limited(hc))
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	dccp_ackvec_parsed_cleanup(&hc->tx_av_chunks);
 }
 
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -232,6 +232,7 @@ static void dccp_write_xmitlet(unsigned
 	else
 		dccp_write_xmit(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 static void dccp_write_xmit_timer(struct timer_list *t)
@@ -240,7 +241,6 @@ static void dccp_write_xmit_timer(struct
 	struct sock *sk = &dp->dccps_inet_connection.icsk_inet.sk;
 
 	dccp_write_xmitlet((unsigned long)sk);
-	sock_put(sk);
 }
 
 void dccp_init_xmit_timers(struct sock *sk)
