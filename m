Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA7BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D957C2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D957C2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeHWL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:28:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbeHWL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:28:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1939C5C;
        Thu, 23 Aug 2018 08:00:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 72/79] packet: refine ring v3 block size test to hold one frame
Date:   Thu, 23 Aug 2018 09:53:48 +0200
Message-Id: <20180823074923.877356466@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit 4576cd469d980317c4edd9173f8b694aa71ea3a3 upstream.

TPACKET_V3 stores variable length frames in fixed length blocks.
Blocks must be able to store a block header, optional private space
and at least one minimum sized frame.

Frames, even for a zero snaplen packet, store metadata headers and
optional reserved space.

In the block size bounds check, ensure that the frame of the
chosen configuration fits. This includes sockaddr_ll and optional
tp_reserve.

Syzbot was able to construct a ring with insuffient room for the
sockaddr_ll in the header of a zero-length frame, triggering an
out-of-bounds write in dev_parse_header.

Convert the comparison to less than, as zero is a valid snap len.
This matches the test for minimum tp_frame_size immediately below.

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Fixes: eb73190f4fbe ("net/packet: refine check for priv area size")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/packet/af_packet.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4176,6 +4176,8 @@ static int packet_set_ring(struct sock *
 	}
 
 	if (req->tp_block_nr) {
+		unsigned int min_frame_size;
+
 		/* Sanity tests and some calculations */
 		err = -EBUSY;
 		if (unlikely(rb->pg_vec))
@@ -4198,12 +4200,12 @@ static int packet_set_ring(struct sock *
 			goto out;
 		if (unlikely(!PAGE_ALIGNED(req->tp_block_size)))
 			goto out;
+		min_frame_size = po->tp_hdrlen + po->tp_reserve;
 		if (po->tp_version >= TPACKET_V3 &&
-		    req->tp_block_size <=
-		    BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv) + sizeof(struct tpacket3_hdr))
+		    req->tp_block_size <
+		    BLK_PLUS_PRIV((u64)req_u->req3.tp_sizeof_priv) + min_frame_size)
 			goto out;
-		if (unlikely(req->tp_frame_size < po->tp_hdrlen +
-					po->tp_reserve))
+		if (unlikely(req->tp_frame_size < min_frame_size))
 			goto out;
 		if (unlikely(req->tp_frame_size & (TPACKET_ALIGNMENT - 1)))
 			goto out;


