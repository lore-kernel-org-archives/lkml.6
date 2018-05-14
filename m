Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpAL3ojFCDjjtMuIy7c3DT8bV8ld19itX7z5vLYBeqgnLTqBv14SN+NNNojL+OlZAXmeKDK
ARC-Seal: i=1; a=rsa-sha256; t=1526280916; cv=none;
        d=google.com; s=arc-20160816;
        b=y585zkXXwbfp9yHFwx1tAxqSGfSiBmLNkLloow2L2+5KruitGWSmNCuf5muRFhrxT1
         HRzkyaJmScogaFL8Lzfd9CLIYh4nzMv/rSDooEFNxZCE/spwhH5rVD1GzZNfpN9JQDwt
         FhXtkUeVZZlFj4UsI0UsYuRgZQyTGKcuMmrzn5JSAq7uFZICYGRl/HBkNYRjEASu9BUw
         1Wqmy66HtbNhnDf9C2YNnDNYZeY58fF6QBUBfzF0Q5g94rt6qjJ+ttf7hRnPHTOmGBzp
         AXzLNgVlB82bGhaZLcD+Ix/EBOMF9HSNA4QLLEqR7Z2Zj8j0BQrJq+MKQLO+PSULuF1l
         X3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=pZFIXnma7QQsrr4OPpG8mWZUD4mn+xoAlMcTpaGSZ5g=;
        b=u4sVTy17MJqhqPwSH50gx1q9ZTi5RFhhRmHzI/2fy3a18eS3YrBcxazGklsmPBfZ6D
         L2k+B9jCiyHUDpBOtoCONNdnJyITgeKxQq0Dpl2W6nFcVl78ik9p1z8bc76/Y9NGki77
         VAiJ+PlcVxWyyuP8OnsEgcHB1VuNPcR1vb/ur+Sh8Kb1BBuBlAXtPNg9eN67mLD3UGKd
         JfvFmAY1Y3hGiho2z29T0tpqKmbbcY3jsTRSttlX+mJNQJ5s/idT79TuzZN3YRfgPVWB
         neZyytG8lq7jENNH8EETGzut5fquPs6J8yOwPv0WNOSm5/RaEHgRTW4STLWVfXCID/KM
         dQFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1fR/gzfV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1fR/gzfV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/62] inetpeer: fix uninit-value in inet_getpeer
Date: Mon, 14 May 2018 08:48:28 +0200
Message-Id: <20180514064817.105209094@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421538439220228?=
X-GMAIL-MSGID: =?utf-8?q?1600421538439220228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b6a37e5e25414df4b8e9140a5c6f5ee0ec6f3b90 upstream.

syzbot/KMSAN reported that p->dtime was read while it was
not yet initialized in :

	delta = (__u32)jiffies - p->dtime;
	if (delta < ttl || !refcount_dec_if_one(&p->refcnt))
		gc_stack[i] = NULL;

This is a false positive, because the inetpeer wont be erased
from rb-tree if the refcount_dec_if_one(&p->refcnt) does not
succeed. And this wont happen before first inet_putpeer() call
for this inetpeer has been done, and ->dtime field is written
exactly before the refcount_dec_and_test(&p->refcnt).

The KMSAN report was :

BUG: KMSAN: uninit-value in inet_peer_gc net/ipv4/inetpeer.c:163 [inline]
BUG: KMSAN: uninit-value in inet_getpeer+0x1567/0x1e70 net/ipv4/inetpeer.c:228
CPU: 0 PID: 9494 Comm: syz-executor5 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 inet_peer_gc net/ipv4/inetpeer.c:163 [inline]
 inet_getpeer+0x1567/0x1e70 net/ipv4/inetpeer.c:228
 inet_getpeer_v4 include/net/inetpeer.h:110 [inline]
 icmpv4_xrlim_allow net/ipv4/icmp.c:330 [inline]
 icmp_send+0x2b44/0x3050 net/ipv4/icmp.c:725
 ip_options_compile+0x237c/0x29f0 net/ipv4/ip_options.c:472
 ip_rcv_options net/ipv4/ip_input.c:284 [inline]
 ip_rcv_finish+0xda8/0x16d0 net/ipv4/ip_input.c:365
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ip_rcv+0x119d/0x16f0 net/ipv4/ip_input.c:493
 __netif_receive_skb_core+0x47cf/0x4a80 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
 netif_receive_skb+0x230/0x240 net/core/dev.c:4725
 tun_rx_batched drivers/net/tun.c:1555 [inline]
 tun_get_user+0x6d88/0x7580 drivers/net/tun.c:1962
 tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
 do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
 do_iter_write+0x30d/0xd40 fs/read_write.c:932
 vfs_writev fs/read_write.c:977 [inline]
 do_writev+0x3c9/0x830 fs/read_write.c:1012
 SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
 SyS_writev+0x56/0x80 fs/read_write.c:1082
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x455111
RSP: 002b:00007fae0365cba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000002e RCX: 0000000000455111
RDX: 0000000000000001 RSI: 00007fae0365cbf0 RDI: 00000000000000fc
RBP: 0000000020000040 R08: 00000000000000fc R09: 0000000000000000
R10: 000000000000002e R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000658 R14: 00000000006fc8e0 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmem_cache_alloc+0xaab/0xb90 mm/slub.c:2756
 inet_getpeer+0xed8/0x1e70 net/ipv4/inetpeer.c:210
 inet_getpeer_v4 include/net/inetpeer.h:110 [inline]
 ip4_frag_init+0x4d1/0x740 net/ipv4/ip_fragment.c:153
 inet_frag_alloc net/ipv4/inet_fragment.c:369 [inline]
 inet_frag_create net/ipv4/inet_fragment.c:385 [inline]
 inet_frag_find+0x7da/0x1610 net/ipv4/inet_fragment.c:418
 ip_find net/ipv4/ip_fragment.c:275 [inline]
 ip_defrag+0x448/0x67a0 net/ipv4/ip_fragment.c:676
 ip_check_defrag+0x775/0xda0 net/ipv4/ip_fragment.c:724
 packet_rcv_fanout+0x2a8/0x8d0 net/packet/af_packet.c:1447
 deliver_skb net/core/dev.c:1897 [inline]
 deliver_ptype_list_skb net/core/dev.c:1912 [inline]
 __netif_receive_skb_core+0x314a/0x4a80 net/core/dev.c:4545
 __netif_receive_skb net/core/dev.c:4627 [inline]
 netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
 netif_receive_skb+0x230/0x240 net/core/dev.c:4725
 tun_rx_batched drivers/net/tun.c:1555 [inline]
 tun_get_user+0x6d88/0x7580 drivers/net/tun.c:1962
 tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
 do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
 do_iter_write+0x30d/0xd40 fs/read_write.c:932
 vfs_writev fs/read_write.c:977 [inline]
 do_writev+0x3c9/0x830 fs/read_write.c:1012
 SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
 SyS_writev+0x56/0x80 fs/read_write.c:1082
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/inetpeer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -210,6 +210,7 @@ struct inet_peer *inet_getpeer(struct in
 		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
+			p->dtime = (__u32)jiffies;
 			refcount_set(&p->refcnt, 2);
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
