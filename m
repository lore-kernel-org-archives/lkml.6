Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA09C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701F7217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079539;
	bh=BCrYWYGS0O5QFvsav80F3A3CU2BHizguBa/w0EybphY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CVHUFQkXfenhqfZ05Kdi3WanDtjGRF2Yq3xtUvrMAyD9Pdh9JaJmQm+OIct2yoSX8
	 j/uSI+3f9b5m/HKu0AwqwD1xd7Z0Kh2kidlglFyo66dC05iM6Mmu2t01X824uZn/4B
	 gqUT+7Hpgp4snQZL5+fXpDzhs8Db0Ot1hoXtQ1Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfAUOFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732559AbfAUOBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632D321019;
        Mon, 21 Jan 2019 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079263;
        bh=BCrYWYGS0O5QFvsav80F3A3CU2BHizguBa/w0EybphY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYh6dSDMAi4M+t1FP722W9K416t2fCbbx9V5SBO28WU7KUcmrarLa68VNbtV3j9yp
         raAiN2qpR6/n368zTfS9+uNQI/62VUin2rlVa7bhG4dspx2cpsGIpYUNloUcG/t+fW
         vnSRTdpeIW0qshDXZ4TKy8lnSSMYM8RjjpwajVlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.19 64/99] bpf: in __bpf_redirect_no_mac pull mac only if present
Date:   Mon, 21 Jan 2019 14:48:56 +0100
Message-Id: <20190121134916.400696189@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488 upstream.

Syzkaller was able to construct a packet of negative length by
redirecting from bpf_prog_test_run_skb with BPF_PROG_TYPE_LWT_XMIT:

    BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:345 [inline]
    BUG: KASAN: slab-out-of-bounds in skb_copy_from_linear_data include/linux/skbuff.h:3421 [inline]
    BUG: KASAN: slab-out-of-bounds in __pskb_copy_fclone+0x2dd/0xeb0 net/core/skbuff.c:1395
    Read of size 4294967282 at addr ffff8801d798009c by task syz-executor2/12942

    kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
    check_memory_region_inline mm/kasan/kasan.c:260 [inline]
    check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
    memcpy+0x23/0x50 mm/kasan/kasan.c:302
    memcpy include/linux/string.h:345 [inline]
    skb_copy_from_linear_data include/linux/skbuff.h:3421 [inline]
    __pskb_copy_fclone+0x2dd/0xeb0 net/core/skbuff.c:1395
    __pskb_copy include/linux/skbuff.h:1053 [inline]
    pskb_copy include/linux/skbuff.h:2904 [inline]
    skb_realloc_headroom+0xe7/0x120 net/core/skbuff.c:1539
    ipip6_tunnel_xmit net/ipv6/sit.c:965 [inline]
    sit_tunnel_xmit+0xe1b/0x30d0 net/ipv6/sit.c:1029
    __netdev_start_xmit include/linux/netdevice.h:4325 [inline]
    netdev_start_xmit include/linux/netdevice.h:4334 [inline]
    xmit_one net/core/dev.c:3219 [inline]
    dev_hard_start_xmit+0x295/0xc90 net/core/dev.c:3235
    __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3805
    dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
    __bpf_tx_skb net/core/filter.c:2016 [inline]
    __bpf_redirect_common net/core/filter.c:2054 [inline]
    __bpf_redirect+0x5cf/0xb20 net/core/filter.c:2061
    ____bpf_clone_redirect net/core/filter.c:2094 [inline]
    bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2066
    bpf_prog_41f2bcae09cd4ac3+0xb25/0x1000

The generated test constructs a packet with mac header, network
header, skb->data pointing to network header and skb->len 0.

Redirecting to a sit0 through __bpf_redirect_no_mac pulls the
mac length, even though skb->data already is at skb->network_header.
bpf_prog_test_run_skb has already pulled it as LWT_XMIT !is_l2.

Update the offset calculation to pull only if skb->data differs
from skb->network_header, which is not true in this case.

The test itself can be run only from commit 1cf1cae963c2 ("bpf:
introduce BPF_PROG_TEST_RUN command"), but the same type of packets
with skb at network header could already be built from lwt xmit hooks,
so this fix is more relevant to that commit.

Also set the mac header on redirect from LWT_XMIT, as even after this
change to __bpf_redirect_no_mac that field is expected to be set, but
is not yet in ip_finish_output2.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/filter.c  |   21 +++++++++++----------
 net/core/lwt_bpf.c |    1 +
 2 files changed, 12 insertions(+), 10 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2018,18 +2018,19 @@ static inline int __bpf_tx_skb(struct ne
 static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
 				 u32 flags)
 {
-	/* skb->mac_len is not set on normal egress */
-	unsigned int mlen = skb->network_header - skb->mac_header;
+	unsigned int mlen = skb_network_offset(skb);
 
-	__skb_pull(skb, mlen);
+	if (mlen) {
+		__skb_pull(skb, mlen);
 
-	/* At ingress, the mac header has already been pulled once.
-	 * At egress, skb_pospull_rcsum has to be done in case that
-	 * the skb is originated from ingress (i.e. a forwarded skb)
-	 * to ensure that rcsum starts at net header.
-	 */
-	if (!skb_at_tc_ingress(skb))
-		skb_postpull_rcsum(skb, skb_mac_header(skb), mlen);
+		/* At ingress, the mac header has already been pulled once.
+		 * At egress, skb_pospull_rcsum has to be done in case that
+		 * the skb is originated from ingress (i.e. a forwarded skb)
+		 * to ensure that rcsum starts at net header.
+		 */
+		if (!skb_at_tc_ingress(skb))
+			skb_postpull_rcsum(skb, skb_mac_header(skb), mlen);
+	}
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
 	return flags & BPF_F_INGRESS ?
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -63,6 +63,7 @@ static int run_lwt_bpf(struct sk_buff *s
 				     lwt->name ? : "<unknown>");
 			ret = BPF_OK;
 		} else {
+			skb_reset_mac_header(skb);
 			ret = skb_do_redirect(skb);
 			if (ret == 0)
 				ret = BPF_REDIRECT;


