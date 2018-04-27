Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpjUk6eYNI9xYTfeCCizoRDGb2QQZL97s2JtCmvDXTfZw19YeLQS/hKd7GZXILL7mbqwk84
ARC-Seal: i=1; a=rsa-sha256; t=1524837913; cv=none;
        d=google.com; s=arc-20160816;
        b=n9NgxBGT9WFHrCjYV9gwKiKU2+i7oIrIwHJES07fncWX7DneAWb9VW8eqh8FNR3Fw7
         5j5UUfOCbyBu1sId4qU8BzhuVCDylLB08aYN87g+RIHpao1fGPEqm8QhIpeN9jm8zYtT
         8Wl2nYi7LmbCF5CwzwySf709MxUwmXW2SvwXsF5pspEujwP1eXdY7f/753A3JJ+ytoQM
         7eUQ+BCegXPgdGM9fhkEGh/FnaFrk27/v5yrH8q1DY6HdypMy24Zl4i4Ll9nbC3cmR1Q
         dIr9VeJ9Af0c97sFXxJrofPQBryaFYHkEkFDdRjjI7NA385dk6VRBtzk+fGWdl6B8DKC
         vxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=OocS/SQW83Ydcnhf8HpZ1emVu1WiDMhF2MoirKShjXA=;
        b=McvpEPJfRMuBlzLRj3TVoK8RcaM3JtHwdYK9wcse/0c2/SdJuYlO4NQ5Kdg6k8+XnI
         0xhOBO7QqkDPvsgqHdDKzNYs5trTMPcAo8doWSrsG58Y/3wpFNHUgArQq1MlEVhKbbSo
         06CMbv8mhEjOwRl8OhIjq2xAknzqs7eq45irQPamQAw0Kr/JQZRtDJ0kuU41t2wbkC6u
         vFXlpeMSpkb4fjR9SYNFt2nIdP443LLkRoxoB3EIPLi3NkSaUgKUTNPQ89JgnTbzZvPx
         ky11gjJJini+B3KkpajccHCT5zRlHyF+JQjsjVbwyPr+kCnWPOzUZUEeVvDWYGUIptmI
         4JjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B922189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Yuchung Cheng <ycheng@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 65/74] tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
Date: Fri, 27 Apr 2018 15:58:55 +0200
Message-Id: <20180427135712.637073433@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908111210232536?=
X-GMAIL-MSGID: =?utf-8?q?1598908439770699054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 7212303268918b9a203aebeacfdbd83b5e87b20d ]

syzbot/KMSAN reported an uninit-value in tcp_parse_options() [1]

I believe this was caused by a TCP_MD5SIG being set on live
flow.

This is highly unexpected, since TCP option space is limited.

For instance, presence of TCP MD5 option automatically disables
TCP TimeStamp option at SYN/SYNACK time, which we can not do
once flow has been established.

Really, adding/deleting an MD5 key only makes sense on sockets
in CLOSE or LISTEN state.

[1]
BUG: KMSAN: uninit-value in tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
CPU: 1 PID: 6177 Comm: syzkaller192004 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
 tcp_fast_parse_options net/ipv4/tcp_input.c:3858 [inline]
 tcp_validate_incoming+0x4f1/0x2790 net/ipv4/tcp_input.c:5184
 tcp_rcv_established+0xf60/0x2bb0 net/ipv4/tcp_input.c:5453
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x448fe9
RSP: 002b:00007fd472c64d38 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000006e5a30 RCX: 0000000000448fe9
RDX: 000000000000029f RSI: 0000000020a88f88 RDI: 0000000000000004
RBP: 00000000006e5a34 R08: 0000000020e68000 R09: 0000000000000010
R10: 00000000200007fd R11: 0000000000000216 R12: 0000000000000000
R13: 00007fff074899ef R14: 00007fd472c659c0 R15: 0000000000000009

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
 tcp_send_ack+0x18c/0x910 net/ipv4/tcp_output.c:3624
 __tcp_ack_snd_check net/ipv4/tcp_input.c:5040 [inline]
 tcp_ack_snd_check net/ipv4/tcp_input.c:5053 [inline]
 tcp_rcv_established+0x2103/0x2bb0 net/ipv4/tcp_input.c:5469
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2662,8 +2662,10 @@ static int do_tcp_setsockopt(struct sock
 
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
-		/* Read the IP->Key mappings from userspace */
-		err = tp->af_specific->md5_parse(sk, optval, optlen);
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			err = tp->af_specific->md5_parse(sk, optval, optlen);
+		else
+			err = -EINVAL;
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
