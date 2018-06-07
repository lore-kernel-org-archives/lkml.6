Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NdjdA/RYGVvPBAAAmS7hNA
	; Thu, 07 Jun 2018 16:11:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 43C7C607E7; Thu,  7 Jun 2018 16:11:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3EB860115;
	Thu,  7 Jun 2018 16:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3EB860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964832AbeFGQKq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:10:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39184 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932980AbeFGOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zv-QQ; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hn-OR; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Marcelo Ricardo Leitner" <marcelo.leinter@gmail.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>,
        "Neil Horman" <nhorman@tuxdriver.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.911510489@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 022/410] sctp: verify size of a new chunk in
 _sctp_make_chunk()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>

commit 07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c upstream.

When SCTP makes INIT or INIT_ACK packet the total chunk length
can exceed SCTP_MAX_CHUNK_LEN which leads to kernel panic when
transmitting these packets, e.g. the crash on sending INIT_ACK:

[  597.804948] skbuff: skb_over_panic: text:00000000ffae06e4 len:120168
               put:120156 head:000000007aa47635 data:00000000d991c2de
               tail:0x1d640 end:0xfec0 dev:<NULL>
...
[  597.976970] ------------[ cut here ]------------
[  598.033408] kernel BUG at net/core/skbuff.c:104!
[  600.314841] Call Trace:
[  600.345829]  <IRQ>
[  600.371639]  ? sctp_packet_transmit+0x2095/0x26d0 [sctp]
[  600.436934]  skb_put+0x16c/0x200
[  600.477295]  sctp_packet_transmit+0x2095/0x26d0 [sctp]
[  600.540630]  ? sctp_packet_config+0x890/0x890 [sctp]
[  600.601781]  ? __sctp_packet_append_chunk+0x3b4/0xd00 [sctp]
[  600.671356]  ? sctp_cmp_addr_exact+0x3f/0x90 [sctp]
[  600.731482]  sctp_outq_flush+0x663/0x30d0 [sctp]
[  600.788565]  ? sctp_make_init+0xbf0/0xbf0 [sctp]
[  600.845555]  ? sctp_check_transmitted+0x18f0/0x18f0 [sctp]
[  600.912945]  ? sctp_outq_tail+0x631/0x9d0 [sctp]
[  600.969936]  sctp_cmd_interpreter.isra.22+0x3be1/0x5cb0 [sctp]
[  601.041593]  ? sctp_sf_do_5_1B_init+0x85f/0xc30 [sctp]
[  601.104837]  ? sctp_generate_t1_cookie_event+0x20/0x20 [sctp]
[  601.175436]  ? sctp_eat_data+0x1710/0x1710 [sctp]
[  601.233575]  sctp_do_sm+0x182/0x560 [sctp]
[  601.284328]  ? sctp_has_association+0x70/0x70 [sctp]
[  601.345586]  ? sctp_rcv+0xef4/0x32f0 [sctp]
[  601.397478]  ? sctp6_rcv+0xa/0x20 [sctp]
...

Here the chunk size for INIT_ACK packet becomes too big, mostly
because of the state cookie (INIT packet has large size with
many address parameters), plus additional server parameters.

Later this chunk causes the panic in skb_put_data():

  skb_packet_transmit()
      sctp_packet_pack()
          skb_put_data(nskb, chunk->skb->data, chunk->skb->len);

'nskb' (head skb) was previously allocated with packet->size
from u16 'chunk->chunk_hdr->length'.

As suggested by Marcelo we should check the chunk's length in
_sctp_make_chunk() before trying to allocate skb for it and
discard a chunk if its size bigger than SCTP_MAX_CHUNK_LEN.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - Keep using WORD_ROUND() instead of SCTP_PAD4()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/sm_make_chunk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1367,10 +1367,14 @@ static struct sctp_chunk *_sctp_make_chu
 	sctp_chunkhdr_t *chunk_hdr;
 	struct sk_buff *skb;
 	struct sock *sk;
+	int chunklen;
+
+	chunklen = WORD_ROUND(sizeof(*chunk_hdr) + paylen);
+	if (chunklen > SCTP_MAX_CHUNK_LEN)
+		goto nodata;
 
 	/* No need to allocate LL here, as this is only a chunk. */
-	skb = alloc_skb(WORD_ROUND(sizeof(sctp_chunkhdr_t) + paylen),
-			GFP_ATOMIC);
+	skb = alloc_skb(chunklen, GFP_ATOMIC);
 	if (!skb)
 		goto nodata;
 
