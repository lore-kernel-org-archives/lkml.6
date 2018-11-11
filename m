Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633FCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EC20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8EC20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbeKLGWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50172 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730277AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000oP-9t; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pC-5V; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "Willem de Bruijn" <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.546405889@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 312/366] packet: refine ring v3 block size test to
 hold one frame
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/packet/af_packet.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3874,6 +3874,8 @@ static int packet_set_ring(struct sock *
 	}
 
 	if (req->tp_block_nr) {
+		unsigned int min_frame_size;
+
 		/* Sanity tests and some calculations */
 		err = -EBUSY;
 		if (unlikely(rb->pg_vec))
@@ -3896,12 +3898,12 @@ static int packet_set_ring(struct sock *
 			goto out;
 		if (unlikely(req->tp_block_size & (PAGE_SIZE - 1)))
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

