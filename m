Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoCiOcS/yVDDWDsyLb5mXKS4lJlXZ3pSY9CAhwUP9z0OOqgu0cMZxa0RzSRAIeAV1e83gk/
ARC-Seal: i=1; a=rsa-sha256; t=1526631485; cv=none;
        d=google.com; s=arc-20160816;
        b=FRuO2wdsrw6BGNe9y9UifckpoD6Qc6una42fguBFHAmXIFT8qgwSMIXoHGTFm9tS/9
         wz92wZ6qkJPuArBG0ByC1flydNP3NmdElCzuTThG3M29LcM0dE9wqyXaUNfcoxsiArTp
         zZ4aYXMcwSXroo6eb/37MklF3NwDqBaowhECU+Aq+A+4R4AGgP9vjbfYJlML/EVc7j0W
         34gNNq4TeMUi7yLAQ/4nzgb8Zfkm3iVxoR9ou280ufGsKSbOxKxILiHyJF1uiJZ5+m4w
         rPs/xbLRVkMGBG/0JBHNvEUPW9Rl330V1bZsDM9k14C7o9quBuN21ahweghxFobaExNn
         UKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QPL2KXipoqlq/odoMm1Tvy4/5NDPCoLv3E1RRBFcgYU=;
        b=jkVbEO26TkmB4GYnv1AJ7NGo3jtLfU6z+P3c+uBej9QToXG9iHqGW9m3X1b3711NAD
         Q83swyd8WVDRC9+Yn0iNrZ0df21wLAyeBkEoiRS0iZyG54T/pLkQWTZzl/R6/LFgIeNh
         T9masxcOwmmcfJ4BRTr3aH6U7YOF71RjzCRYmm8Y/ZZu1YwzDvPBYQkAMlQyawIz7RMm
         F8I/2NuW0iE829+hvst+8fojZcTAPagtwoKaixFG/uWmYvPMJtxqFgP3AyLP58xXWvfy
         vy7mtCzMRhOOQnqV/2mAQ6QE1NouD0cmKCwKbt4Gy1k+LIMXuDiTu4icxMp0FycYowAh
         wm7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wuBt3YE2;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wuBt3YE2;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Jakub Sitnicki <jkbs@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 37/55] ipv6: fix uninit-value in ip6_multipath_l3_keys()
Date: Fri, 18 May 2018 10:15:33 +0200
Message-Id: <20180518081459.207775479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789136804951457?=
X-GMAIL-MSGID: =?utf-8?q?1600789136804951457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cea67a2dd6b2419dcc13a39309b9a79a1f773193 ]

syzbot/KMSAN reported an uninit-value in ip6_multipath_l3_keys(),
root caused to a bad assumption of ICMP header being already
pulled in skb->head

ip_multipath_l3_keys() does the correct thing, so it is an IPv6 only bug.

BUG: KMSAN: uninit-value in ip6_multipath_l3_keys net/ipv6/route.c:1830 [inline]
BUG: KMSAN: uninit-value in rt6_multipath_hash+0x5c4/0x640 net/ipv6/route.c:1858
CPU: 0 PID: 4507 Comm: syz-executor661 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
 ip6_multipath_l3_keys net/ipv6/route.c:1830 [inline]
 rt6_multipath_hash+0x5c4/0x640 net/ipv6/route.c:1858
 ip6_route_input+0x65a/0x920 net/ipv6/route.c:1884
 ip6_rcv_finish+0x413/0x6e0 net/ipv6/ip6_input.c:69
 NF_HOOK include/linux/netfilter.h:288 [inline]
 ipv6_rcv+0x1e16/0x2340 net/ipv6/ip6_input.c:208
 __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4562
 __netif_receive_skb net/core/dev.c:4627 [inline]
 netif_receive_skb_internal+0x49d/0x630 net/core/dev.c:4701
 netif_receive_skb+0x230/0x240 net/core/dev.c:4725
 tun_rx_batched drivers/net/tun.c:1555 [inline]
 tun_get_user+0x740f/0x7c60 drivers/net/tun.c:1962
 tun_chr_write_iter+0x1d4/0x330 drivers/net/tun.c:1990
 call_write_iter include/linux/fs.h:1782 [inline]
 new_sync_write fs/read_write.c:469 [inline]
 __vfs_write+0x7fb/0x9f0 fs/read_write.c:482
 vfs_write+0x463/0x8d0 fs/read_write.c:544
 SYSC_write+0x172/0x360 fs/read_write.c:589
 SyS_write+0x55/0x80 fs/read_write.c:581
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 23aebdacb05d ("ipv6: Compute multipath hash for ICMP errors from offending packet")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Jakub Sitnicki <jkbs@redhat.com>
Acked-by: Jakub Sitnicki <jkbs@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1822,11 +1822,16 @@ static void ip6_multipath_l3_keys(const
 	const struct ipv6hdr *inner_iph;
 	const struct icmp6hdr *icmph;
 	struct ipv6hdr _inner_iph;
+	struct icmp6hdr _icmph;
 
 	if (likely(outer_iph->nexthdr != IPPROTO_ICMPV6))
 		goto out;
 
-	icmph = icmp6_hdr(skb);
+	icmph = skb_header_pointer(skb, skb_transport_offset(skb),
+				   sizeof(_icmph), &_icmph);
+	if (!icmph)
+		goto out;
+
 	if (icmph->icmp6_type != ICMPV6_DEST_UNREACH &&
 	    icmph->icmp6_type != ICMPV6_PKT_TOOBIG &&
 	    icmph->icmp6_type != ICMPV6_TIME_EXCEED &&
