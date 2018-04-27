Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqB/hqZEvRaS7UwJTHvdJcQi8G7HDyOCBnHDDXfZ04gXHfSeyAcEvoOzaa3G6eTl3g+Uklz
ARC-Seal: i=1; a=rsa-sha256; t=1524837715; cv=none;
        d=google.com; s=arc-20160816;
        b=Em3oDY1LVUrGOrVZFU72FaqJY+vPHr4IO3JQbweioxh8DSCQG9HDr2Vmv4dcnPSEQM
         L9j+jzXScwUsxmKcrTLHuhwvOhld17JD8IfEjk7etcmTMeu/EqpIZMVuveYgjAzXU4g8
         Wdq2sKeV8k0dqNFH2/EGDqApOnLZ/c0GCE7vR4KBKJVy4mklwrUTuyogdWoBkylZNKbg
         IfqWE+sciP9hyaEbqkRTR0EVAZdX5WRzm7CRwfSVXsYc9G+qZTerMJX8iNxR+WRegwXt
         JuHZJdzkMwGbhgdLJwRFNEVMezcHiB2dqDeuKYFcZLrP14DmGILap6tmoien24jnLEAf
         pwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=6ur3U1HJvVcp6Fkk4P4711DleGVYx3Paj7nvjnz1N8Y=;
        b=H1izS7B6nATDEdjSDwzcFmF4IVM0AWqvTZNIbUVYyMz3xuD1QDrk80xUy81nyeTp9F
         EbugWufQ388KV/ICwaLfBC/4/BfK7InGdQN01Oj+2+Sy3gCZ6s+wqXkNGdizWp81JtBH
         scuYK+Yr+ZRsexonyinP9M1AH7kjRpQsq9659D9Am4tOINB20CXEAVmVBtbrTKCFacQQ
         ndXhKxy7lzQYptJz6HlgZCHAWTBpO7IQI7aHhMxMiYVbQmO7GON8rTOSqf/S0sXIj6JQ
         tSpD4ZI0cif363Zomiz6xYq+l2pfG0Hvf0VbxLCZZMXwT59E5AfiTKIt9qNzQMtnOTZ4
         Asbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD5B21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 38/50] vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi
Date: Fri, 27 Apr 2018 15:58:40 +0200
Message-Id: <20180427135657.935184817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908232509203798?=
X-GMAIL-MSGID: =?utf-8?q?1598908232509203798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>


[ Upstream commit 7ce2367254e84753bceb07327aaf5c953cfce117 ]

Syzkaller spotted an old bug which leads to reading skb beyond tail by 4
bytes on vlan tagged packets.
This is caused because skb_vlan_tagged_multi() did not check
skb_headlen.

BUG: KMSAN: uninit-value in eth_type_vlan include/linux/if_vlan.h:283 [inline]
BUG: KMSAN: uninit-value in skb_vlan_tagged_multi include/linux/if_vlan.h:656 [inline]
BUG: KMSAN: uninit-value in vlan_features_check include/linux/if_vlan.h:672 [inline]
BUG: KMSAN: uninit-value in dflt_features_check net/core/dev.c:2949 [inline]
BUG: KMSAN: uninit-value in netif_skb_features+0xd1b/0xdc0 net/core/dev.c:3009
CPU: 1 PID: 3582 Comm: syzkaller435149 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
  eth_type_vlan include/linux/if_vlan.h:283 [inline]
  skb_vlan_tagged_multi include/linux/if_vlan.h:656 [inline]
  vlan_features_check include/linux/if_vlan.h:672 [inline]
  dflt_features_check net/core/dev.c:2949 [inline]
  netif_skb_features+0xd1b/0xdc0 net/core/dev.c:3009
  validate_xmit_skb+0x89/0x1320 net/core/dev.c:3084
  __dev_queue_xmit+0x1cb2/0x2b60 net/core/dev.c:3549
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x7c57/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43ffa9
RSP: 002b:00007fff2cff3948 EFLAGS: 00000217 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043ffa9
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018d0
R13: 0000000000401960 R14: 0000000000000000 R15: 0000000000000000

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
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x6444/0x8a10 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  sock_write_iter+0x3b9/0x470 net/socket.c:909
  do_iter_readv_writev+0x7bb/0x970 include/linux/fs.h:1776
  do_iter_write+0x30d/0xd40 fs/read_write.c:932
  vfs_writev fs/read_write.c:977 [inline]
  do_writev+0x3c9/0x830 fs/read_write.c:1012
  SYSC_writev+0x9b/0xb0 fs/read_write.c:1085
  SyS_writev+0x56/0x80 fs/read_write.c:1082
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 58e998c6d239 ("offloading: Force software GSO for multiple vlan tags.")
Reported-and-tested-by: syzbot+0bbe42c764feafa82c5a@syzkaller.appspotmail.com
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_vlan.h |    7 +++++--
 net/core/dev.c          |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -585,7 +585,7 @@ static inline bool skb_vlan_tagged(const
  * Returns true if the skb is tagged with multiple vlan headers, regardless
  * of whether it is hardware accelerated or not.
  */
-static inline bool skb_vlan_tagged_multi(const struct sk_buff *skb)
+static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
 {
 	__be16 protocol = skb->protocol;
 
@@ -596,6 +596,9 @@ static inline bool skb_vlan_tagged_multi
 			   protocol != htons(ETH_P_8021AD)))
 			return false;
 
+		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN)))
+			return false;
+
 		veh = (struct vlan_ethhdr *)skb->data;
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
@@ -613,7 +616,7 @@ static inline bool skb_vlan_tagged_multi
  *
  * Returns features without unsafe ones if the skb has multiple tags.
  */
-static inline netdev_features_t vlan_features_check(const struct sk_buff *skb,
+static inline netdev_features_t vlan_features_check(struct sk_buff *skb,
 						    netdev_features_t features)
 {
 	if (skb_vlan_tagged_multi(skb)) {
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2706,7 +2706,7 @@ netdev_features_t passthru_features_chec
 }
 EXPORT_SYMBOL(passthru_features_check);
 
-static netdev_features_t dflt_features_check(const struct sk_buff *skb,
+static netdev_features_t dflt_features_check(struct sk_buff *skb,
 					     struct net_device *dev,
 					     netdev_features_t features)
 {
