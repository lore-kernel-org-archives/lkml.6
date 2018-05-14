Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+yTODFpL7i/sm/gmeBxNfI0PUGYXXx8BTkvuiWTvPnIOA610X0qV7ZgplpgdaEpygJ8ZH
ARC-Seal: i=1; a=rsa-sha256; t=1526280836; cv=none;
        d=google.com; s=arc-20160816;
        b=eYkVfflMigaR3u92XEkYSeLIWsJy3sacKpfnutqdCAWlEpZf9sQp2PBVdHPxwselQh
         CrLIYBIfJaTnvVz69HEr4AXK5WPRDOmBkSVuIsA5VT5mETgirVdOaV1y/86yvwomneVP
         JAYkAXM8BkVQBE/Ba5hDA183pUTewV9uMZZMlqQAGsRjqn1dST39mE8IbMU7mxWGaupw
         Ki6SvdE6urPqsJzIzANq4FyO14NS0EX+z4iHBBfEOHHefiFesMgXnPpGA1K23ut/gbg2
         TWkrv3stf4qp0+I/zj/52KSU5F0JD/J5f0VyXR1xlbqvrd5Fc+5T9nqam7ADR8zGCEB2
         JfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DXDhkKN7kHFZ7ucWJ9Q5ecJV1Wp490ozZNrJjj+7YXQ=;
        b=UYQkcVSOp7k8zTsChUCC2iD0fSBA3jP6pqU7iJrnmXe7I2Rlm953k/jn0+fJibu0yp
         ETolgEL+iv1pMM+odHe53TWp8ikE1TRXjUmhQj8xfVsgoGSdqeMdUtp2hhYaBXD+WM+0
         6Dtvh8KKTdniA/PxgaleQRg3QqMR9tsy3q2hC08J7v05HIIvhe42nOTCFowmna/tticN
         7KBxocpM8pzloEBeCJwceYNJF75mvxStj9G52Y1BvOuMNEjr67Yq+ZE1pWkcyKZh5KqP
         87xZD8G82+gDlU/jgiXYC0anLIHoH6R4xD3M3VWPPJv7l7e0VDf75cYYdDmhxT19iF6W
         6bDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CW8n6uVx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CW8n6uVx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 09/36] dccp: initialize ireq->ir_mark
Date: Mon, 14 May 2018 08:48:43 +0200
Message-Id: <20180514064805.006535967@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421418810944624?=
X-GMAIL-MSGID: =?utf-8?q?1600421453796404649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b855ff827476adbdc2259e9895681d82b7b26065 upstream.

syzbot reported an uninit-value read of skb->mark in iptable_mangle_hook()

Thanks to the nice report, I tracked the problem to dccp not caring
of ireq->ir_mark for passive sessions.

BUG: KMSAN: uninit-value in ipt_mangle_out net/ipv4/netfilter/iptable_mangle.c:66 [inline]
BUG: KMSAN: uninit-value in iptable_mangle_hook+0x5e5/0x720 net/ipv4/netfilter/iptable_mangle.c:84
CPU: 0 PID: 5300 Comm: syz-executor3 Not tainted 4.16.0+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 ipt_mangle_out net/ipv4/netfilter/iptable_mangle.c:66 [inline]
 iptable_mangle_hook+0x5e5/0x720 net/ipv4/netfilter/iptable_mangle.c:84
 nf_hook_entry_hookfn include/linux/netfilter.h:120 [inline]
 nf_hook_slow+0x158/0x3d0 net/netfilter/core.c:483
 nf_hook include/linux/netfilter.h:243 [inline]
 __ip_local_out net/ipv4/ip_output.c:113 [inline]
 ip_local_out net/ipv4/ip_output.c:122 [inline]
 ip_queue_xmit+0x1d21/0x21c0 net/ipv4/ip_output.c:504
 dccp_transmit_skb+0x15eb/0x1900 net/dccp/output.c:142
 dccp_xmit_packet+0x814/0x9e0 net/dccp/output.c:281
 dccp_write_xmit+0x20f/0x480 net/dccp/output.c:363
 dccp_sendmsg+0x12ca/0x12d0 net/dccp/proto.c:818
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x455259
RSP: 002b:00007f1a4473dc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1a4473e6d4 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000020b76fc8 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004f0 R14: 00000000006fa720 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
 __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
 ip_queue_xmit+0x1e35/0x21c0 net/ipv4/ip_output.c:502
 dccp_transmit_skb+0x15eb/0x1900 net/dccp/output.c:142
 dccp_xmit_packet+0x814/0x9e0 net/dccp/output.c:281
 dccp_write_xmit+0x20f/0x480 net/dccp/output.c:363
 dccp_sendmsg+0x12ca/0x12d0 net/dccp/proto.c:818
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
 __sys_sendmsg net/socket.c:2080 [inline]
 SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
 SyS_sendmsg+0x54/0x80 net/socket.c:2087
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_save_stack mm/kmsan/kmsan.c:293 [inline]
 kmsan_internal_chain_origin+0x12b/0x210 mm/kmsan/kmsan.c:684
 __msan_chain_origin+0x69/0xc0 mm/kmsan/kmsan_instr.c:521
 inet_csk_clone_lock+0x503/0x580 net/ipv4/inet_connection_sock.c:797
 dccp_create_openreq_child+0x7f/0x890 net/dccp/minisocks.c:92
 dccp_v4_request_recv_sock+0x22c/0xe90 net/dccp/ipv4.c:408
 dccp_v6_request_recv_sock+0x290/0x2000 net/dccp/ipv6.c:414
 dccp_check_req+0x7b9/0x8f0 net/dccp/minisocks.c:197
 dccp_v4_rcv+0x12e4/0x2630 net/dccp/ipv4.c:840
 ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:449 [inline]
 ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 process_backlog+0x62d/0xe20 net/core/dev.c:5307
 napi_poll net/core/dev.c:5705 [inline]
 net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
 __do_softirq+0x56d/0x93d kernel/softirq.c:285
Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmem_cache_alloc+0xaab/0xb90 mm/slub.c:2756
 reqsk_alloc include/net/request_sock.h:88 [inline]
 inet_reqsk_alloc+0xc4/0x7f0 net/ipv4/tcp_input.c:6145
 dccp_v4_conn_request+0x5cc/0x1770 net/dccp/ipv4.c:600
 dccp_v6_conn_request+0x299/0x1880 net/dccp/ipv6.c:317
 dccp_rcv_state_process+0x2ea/0x2410 net/dccp/input.c:612
 dccp_v4_do_rcv+0x229/0x340 net/dccp/ipv4.c:682
 dccp_v6_do_rcv+0x16d/0x1220 net/dccp/ipv6.c:578
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __sk_receive_skb+0x60e/0xf20 net/core/sock.c:513
 dccp_v4_rcv+0x24d4/0x2630 net/dccp/ipv4.c:874
 ip_local_deliver_finish+0x6ed/0xd40 net/ipv4/ip_input.c:216
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_local_deliver+0x43c/0x4e0 net/ipv4/ip_input.c:257
 dst_input include/net/dst.h:449 [inline]
 ip_rcv_finish+0x1253/0x16d0 net/ipv4/ip_input.c:397
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 process_backlog+0x62d/0xe20 net/core/dev.c:5307
 napi_poll net/core/dev.c:5705 [inline]
 net_rx_action+0x7c1/0x1a70 net/core/dev.c:5771
 __do_softirq+0x56d/0x93d kernel/softirq.c:285

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dccp/ipv4.c |    1 +
 net/dccp/ipv6.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -620,6 +620,7 @@ int dccp_v4_conn_request(struct sock *sk
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
+	ireq->ir_mark = inet_request_mark(sk, skb);
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -349,6 +349,7 @@ static int dccp_v6_conn_request(struct s
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ireq_family = AF_INET6;
+	ireq->ir_mark = inet_request_mark(sk, skb);
 
 	if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
