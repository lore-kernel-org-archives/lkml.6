Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vOi+jfdvs/IoWmLEWRRCuBzqEBjp87IHDOZWgbq4I+Uw/F3ZXmRXpzGKQtKChHIBRWNKz
ARC-Seal: i=1; a=rsa-sha256; t=1522346873; cv=none;
        d=google.com; s=arc-20160816;
        b=DhrUToo59BX1nH+lg3AkpI7TNlAhK1NUm4wSG7wq6ukZuzzTehfNdiTNS1vvlW1LHM
         FP2MHTzpxRtyd4g2B2zlFDDGcwvHNlQ6vM5kn2mNIJFLR+J+g/RgDsXGUnhy2E5UVIg9
         R+17cf790ucHjxbgLN2gkesFrjyGCkOrICXHa8qz+776gPECjpWWm2+2C5MlmOb2a4Jb
         ZZqNeBlTsxpqVClispEZM/vZSmbNjwWfKmYpzGBDcTr6NIf7V2nZCJp/XqFyzOZre55k
         0niOkUcatJtszyjU1sET5UoQbno8U3QCRPZ3Lqq4p2Fsu7uNS7AqnP86aFTQhCvEJj9h
         NqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c3v7IKD5OpSLWlG99kuwnY8wZDZKYPi7/tHoht1poYU=;
        b=pGm5BwcqLo0jrMbA722KRBUgWmCz7HjjG2FzVLMW0GbOX8v01nCBG5iAaqSAAJzUev
         cVa78Vl3eTCjhlqMLrzmZ+XToZvLlPiQ83hy5dl0NOIZW085R9TGv8tSsaYVw2M2t1fZ
         TGz3pN9q1+qN5O+VpgeaaL9sSDwEg1lFClCh2wradf69UMq+mmUKnTjS/hNrp5lMrTAU
         Z7iVlXgQLwu8AF1rXkLQTj7AQmH1XZDs5jGX7gHY2kd5PpYKBOClnFIBkHFNr+ULMfff
         IRP/E2kjyDU2Oa7AAqDAy/T4YpdXQccVA1mXGYmMJlfwpkm5G1L5FVOZ/OESjgm3CEJp
         3J/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/20] ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()
Date: Thu, 29 Mar 2018 20:00:41 +0200
Message-Id: <20180329175742.104947007@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296095626214234?=
X-GMAIL-MSGID: =?utf-8?q?1596296395434965134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>


[ Upstream commit 9f62c15f28b0d1d746734666d88a79f08ba1e43e ]

Fix the following slab-out-of-bounds kasan report in
ndisc_fill_redirect_hdr_option when the incoming ipv6 packet is not
linear and the accessed data are not in the linear data region of orig_skb.

[ 1503.122508] ==================================================================
[ 1503.122832] BUG: KASAN: slab-out-of-bounds in ndisc_send_redirect+0x94e/0x990
[ 1503.123036] Read of size 1184 at addr ffff8800298ab6b0 by task netperf/1932

[ 1503.123220] CPU: 0 PID: 1932 Comm: netperf Not tainted 4.16.0-rc2+ #124
[ 1503.123347] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
[ 1503.123527] Call Trace:
[ 1503.123579]  <IRQ>
[ 1503.123638]  print_address_description+0x6e/0x280
[ 1503.123849]  kasan_report+0x233/0x350
[ 1503.123946]  memcpy+0x1f/0x50
[ 1503.124037]  ndisc_send_redirect+0x94e/0x990
[ 1503.125150]  ip6_forward+0x1242/0x13b0
[...]
[ 1503.153890] Allocated by task 1932:
[ 1503.153982]  kasan_kmalloc+0x9f/0xd0
[ 1503.154074]  __kmalloc_track_caller+0xb5/0x160
[ 1503.154198]  __kmalloc_reserve.isra.41+0x24/0x70
[ 1503.154324]  __alloc_skb+0x130/0x3e0
[ 1503.154415]  sctp_packet_transmit+0x21a/0x1810
[ 1503.154533]  sctp_outq_flush+0xc14/0x1db0
[ 1503.154624]  sctp_do_sm+0x34e/0x2740
[ 1503.154715]  sctp_primitive_SEND+0x57/0x70
[ 1503.154807]  sctp_sendmsg+0xaa6/0x1b10
[ 1503.154897]  sock_sendmsg+0x68/0x80
[ 1503.154987]  ___sys_sendmsg+0x431/0x4b0
[ 1503.155078]  __sys_sendmsg+0xa4/0x130
[ 1503.155168]  do_syscall_64+0x171/0x3f0
[ 1503.155259]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ 1503.155436] Freed by task 1932:
[ 1503.155527]  __kasan_slab_free+0x134/0x180
[ 1503.155618]  kfree+0xbc/0x180
[ 1503.155709]  skb_release_data+0x27f/0x2c0
[ 1503.155800]  consume_skb+0x94/0xe0
[ 1503.155889]  sctp_chunk_put+0x1aa/0x1f0
[ 1503.155979]  sctp_inq_pop+0x2f8/0x6e0
[ 1503.156070]  sctp_assoc_bh_rcv+0x6a/0x230
[ 1503.156164]  sctp_inq_push+0x117/0x150
[ 1503.156255]  sctp_backlog_rcv+0xdf/0x4a0
[ 1503.156346]  __release_sock+0x142/0x250
[ 1503.156436]  release_sock+0x80/0x180
[ 1503.156526]  sctp_sendmsg+0xbb0/0x1b10
[ 1503.156617]  sock_sendmsg+0x68/0x80
[ 1503.156708]  ___sys_sendmsg+0x431/0x4b0
[ 1503.156799]  __sys_sendmsg+0xa4/0x130
[ 1503.156889]  do_syscall_64+0x171/0x3f0
[ 1503.156980]  entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ 1503.157158] The buggy address belongs to the object at ffff8800298ab600
                which belongs to the cache kmalloc-1024 of size 1024
[ 1503.157444] The buggy address is located 176 bytes inside of
                1024-byte region [ffff8800298ab600, ffff8800298aba00)
[ 1503.157702] The buggy address belongs to the page:
[ 1503.157820] page:ffffea0000a62a00 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
[ 1503.158053] flags: 0x4000000000008100(slab|head)
[ 1503.158171] raw: 4000000000008100 0000000000000000 0000000000000000 00000001800e000e
[ 1503.158350] raw: dead000000000100 dead000000000200 ffff880036002600 0000000000000000
[ 1503.158523] page dumped because: kasan: bad access detected

[ 1503.158698] Memory state around the buggy address:
[ 1503.158816]  ffff8800298ab900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1503.158988]  ffff8800298ab980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1503.159165] >ffff8800298aba00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1503.159338]                    ^
[ 1503.159436]  ffff8800298aba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1503.159610]  ffff8800298abb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1503.159785] ==================================================================
[ 1503.159964] Disabling lock debugging due to kernel taint

The test scenario to trigger the issue consists of 4 devices:
- H0: data sender, connected to LAN0
- H1: data receiver, connected to LAN1
- GW0 and GW1: routers between LAN0 and LAN1. Both of them have an
  ethernet connection on LAN0 and LAN1
On H{0,1} set GW0 as default gateway while on GW0 set GW1 as next hop for
data from LAN0 to LAN1.
Moreover create an ip6ip6 tunnel between H0 and H1 and send 3 concurrent
data streams (TCP/UDP/SCTP) from H0 to H1 through ip6ip6 tunnel (send
buffer size is set to 16K). While data streams are active flush the route
cache on HA multiple times.
I have not been able to identify a given commit that introduced the issue
since, using the reproducer described above, the kasan report has been
triggered from 4.14 and I have not gone back further.

Reported-by: Jianlin Shi <jishi@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1478,7 +1478,8 @@ static void ndisc_fill_redirect_hdr_opti
 	*(opt++) = (rd_len >> 3);
 	opt += 6;
 
-	memcpy(opt, ipv6_hdr(orig_skb), rd_len - 8);
+	skb_copy_bits(orig_skb, skb_network_offset(orig_skb), opt,
+		      rd_len - 8);
 }
 
 void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
