Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A264C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695F620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeLIWUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:20:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35414 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbeLIVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:24 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72o-0002if-6P; Sun, 09 Dec 2018 21:55:22 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003gP-66; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.417813080@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 309/328] net: make skb_partial_csum_set() more robust
 against overflows
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 52b5d6f5dcf0e5201392f7d417148ccb537dbf6f upstream.

syzbot managed to crash in skb_checksum_help() [1] :

        BUG_ON(offset + sizeof(__sum16) > skb_headlen(skb));

Root cause is the following check in skb_partial_csum_set()

	if (unlikely(start > skb_headlen(skb)) ||
	    unlikely((int)start + off > skb_headlen(skb) - 2))
		return false;

If skb_headlen(skb) is 1, then (skb_headlen(skb) - 2) becomes 0xffffffff
and the check fails to detect that ((int)start + off) is off the limit,
since the compare is unsigned.

When we fix that, then the first condition (start > skb_headlen(skb))
becomes obsolete.

Then we should also check that (skb_headroom(skb) + start) wont
overflow 16bit field.

[1]
kernel BUG at net/core/dev.c:2880!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7330 Comm: syz-executor4 Not tainted 4.19.0-rc6+ #253
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:skb_checksum_help+0x9e3/0xbb0 net/core/dev.c:2880
Code: 85 00 ff ff ff 48 c1 e8 03 42 80 3c 28 00 0f 84 09 fb ff ff 48 8b bd 00 ff ff ff e8 97 a8 b9 fb e9 f8 fa ff ff e8 2d 09 76 fb <0f> 0b 48 8b bd 28 ff ff ff e8 1f a8 b9 fb e9 b1 f6 ff ff 48 89 cf
RSP: 0018:ffff8801d83a6f60 EFLAGS: 00010293
RAX: ffff8801b9834380 RBX: ffff8801b9f8d8c0 RCX: ffffffff8608c6d7
RDX: 0000000000000000 RSI: ffffffff8608cc63 RDI: 0000000000000006
RBP: ffff8801d83a7068 R08: ffff8801b9834380 R09: 0000000000000000
R10: ffff8801d83a76d8 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000010001 R14: 000000000000ffff R15: 00000000000000a8
FS:  00007f1a66db5700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7d77f091b0 CR3: 00000001ba252000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 skb_csum_hwoffload_help+0x8f/0xe0 net/core/dev.c:3269
 validate_xmit_skb+0xa2a/0xf30 net/core/dev.c:3312
 __dev_queue_xmit+0xc2f/0x3950 net/core/dev.c:3797
 dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
 packet_snd net/packet/af_packet.c:2928 [inline]
 packet_sendmsg+0x422d/0x64c0 net/packet/af_packet.c:2953

Fixes: 5ff8dda3035d ("net: Ensure partial checksum offset is inside the skb head")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/skbuff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3593,14 +3593,16 @@ EXPORT_SYMBOL_GPL(skb_complete_wifi_ack)
  */
 bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 {
-	if (unlikely(start > skb_headlen(skb)) ||
-	    unlikely((int)start + off > skb_headlen(skb) - 2)) {
-		net_warn_ratelimited("bad partial csum: csum=%u/%u len=%u\n",
-				     start, off, skb_headlen(skb));
+	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
+	u32 csum_start = skb_headroom(skb) + (u32)start;
+
+	if (unlikely(csum_start > U16_MAX || csum_end > skb_headlen(skb))) {
+		net_warn_ratelimited("bad partial csum: csum=%u/%u headroom=%u headlen=%u\n",
+				     start, off, skb_headroom(skb), skb_headlen(skb));
 		return false;
 	}
 	skb->ip_summed = CHECKSUM_PARTIAL;
-	skb->csum_start = skb_headroom(skb) + start;
+	skb->csum_start = csum_start;
 	skb->csum_offset = off;
 	skb_set_transport_header(skb, start);
 	return true;

