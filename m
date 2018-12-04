Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F9CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D451D21527
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXJNRRnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D451D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLDLE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeLDLEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:04:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4892521508;
        Tue,  4 Dec 2018 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921464;
        bh=XrvhqPbzedG8a8nhggLBTcSV16WAHiB6wVsc9n3hxfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXJNRRnZ4p2VzWX4IzU3eUrG87poG4adxYtLW/ooD/KALzVaTqc5PzTUpg1mFY/Na
         B3zyJrvmVBoTpCysPyPeNkBDtbijAq9gw9jpSQ9C+NNWrzac5224JyfwDJBDHaSb9F
         QXQLsjrIP4mrFZE6pYOO6SILf0bwRRMTC409hrfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Anand H. Krishnan" <anandhkrishnan@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 064/146] packet: copy user buffers before orphan or clone
Date:   Tue,  4 Dec 2018 11:49:10 +0100
Message-Id: <20181204103729.416508828@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 5cd8d46ea1562be80063f53c7c6a5f40224de623 ]

tpacket_snd sends packets with user pages linked into skb frags. It
notifies that pages can be reused when the skb is released by setting
skb->destructor to tpacket_destruct_skb.

This can cause data corruption if the skb is orphaned (e.g., on
transmit through veth) or cloned (e.g., on mirror to another psock).

Create a kernel-private copy of data in these cases, same as tun/tap
zerocopy transmission. Reuse that infrastructure: mark the skb as
SKBTX_ZEROCOPY_FRAG, which will trigger copy in skb_orphan_frags(_rx).

Unlike other zerocopy packets, do not set shinfo destructor_arg to
struct ubuf_info. tpacket_destruct_skb already uses that ptr to notify
when the original skb is released and a timestamp is recorded. Do not
change this timestamp behavior. The ubuf_info->callback is not needed
anyway, as no zerocopy notification is expected.

Mark destructor_arg as not-a-uarg by setting the lower bit to 1. The
resulting value is not a valid ubuf_info pointer, nor a valid
tpacket_snd frame address. Add skb_zcopy_.._nouarg helpers for this.

The fix relies on features introduced in commit 52267790ef52 ("sock:
add MSG_ZEROCOPY"), so can be backported as is only to 4.14.

Tested with from `./in_netns.sh ./txring_overwrite` from
http://github.com/wdebruij/kerneltools/tests

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Reported-by: Anand H. Krishnan <anandhkrishnan@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |   18 +++++++++++++++++-
 net/packet/af_packet.c |    4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1288,6 +1288,22 @@ static inline void skb_zcopy_set(struct
 	}
 }
 
+static inline void skb_zcopy_set_nouarg(struct sk_buff *skb, void *val)
+{
+	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t) val | 0x1UL);
+	skb_shinfo(skb)->tx_flags |= SKBTX_ZEROCOPY_FRAG;
+}
+
+static inline bool skb_zcopy_is_nouarg(struct sk_buff *skb)
+{
+	return (uintptr_t) skb_shinfo(skb)->destructor_arg & 0x1UL;
+}
+
+static inline void *skb_zcopy_get_nouarg(struct sk_buff *skb)
+{
+	return (void *)((uintptr_t) skb_shinfo(skb)->destructor_arg & ~0x1UL);
+}
+
 /* Release a reference on a zerocopy structure */
 static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy)
 {
@@ -1297,7 +1313,7 @@ static inline void skb_zcopy_clear(struc
 		if (uarg->callback == sock_zerocopy_callback) {
 			uarg->zerocopy = uarg->zerocopy && zerocopy;
 			sock_zerocopy_put(uarg);
-		} else {
+		} else if (!skb_zcopy_is_nouarg(skb)) {
 			uarg->callback(uarg, zerocopy);
 		}
 
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2433,7 +2433,7 @@ static void tpacket_destruct_skb(struct
 		void *ph;
 		__u32 ts;
 
-		ph = skb_shinfo(skb)->destructor_arg;
+		ph = skb_zcopy_get_nouarg(skb);
 		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
@@ -2499,7 +2499,7 @@ static int tpacket_fill_skb(struct packe
 	skb->priority = po->sk.sk_priority;
 	skb->mark = po->sk.sk_mark;
 	sock_tx_timestamp(&po->sk, sockc->tsflags, &skb_shinfo(skb)->tx_flags);
-	skb_shinfo(skb)->destructor_arg = ph.raw;
+	skb_zcopy_set_nouarg(skb, ph.raw);
 
 	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);


