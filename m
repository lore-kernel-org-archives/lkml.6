Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC41C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B284E218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfBCNui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53796 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003tr-V2; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007B3-6J; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Marek Lindner" <mareklindner@neomailbox.ch>,
        "Martin =?UTF-8?Q?Hundeb=C3=B8ll?=" <martin@hundeboll.net>,
        "Sven Eckelmann" <sven@narfation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.891563866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 187/305] batman-adv: Check total_size when queueing
 fragments
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 53e771457e823fbc21834f60508c42a4270534fd upstream.

The fragmentation code was replaced in
610bfc6bc99bc83680d190ebc69359a05fc7f605 ("batman-adv: Receive fragmented
packets and merge") by an implementation which handles the queueing+merging
of fragments based on their size and the total_size of the non-fragmented
packet. This total_size is announced by each fragment. The new
implementation doesn't check if the the total_size information of the
packets inside one chain is consistent.

This is consistency check is recommended to allow using any of the packets
in the queue to decide whether all fragments of a packet are received or
not.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/fragmentation.c | 7 +++++--
 net/batman-adv/types.h         | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -162,6 +162,7 @@ static bool batadv_frag_insert_packet(st
 		hlist_add_head(&frag_entry_new->list, &chain->head);
 		chain->size = skb->len - hdr_size;
 		chain->timestamp = jiffies;
+		chain->total_size = ntohs(frag_packet->total_size);
 		ret = true;
 		goto out;
 	}
@@ -196,9 +197,11 @@ static bool batadv_frag_insert_packet(st
 
 out:
 	if (chain->size > batadv_frag_size_limit() ||
-	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
+	    chain->total_size != ntohs(frag_packet->total_size) ||
+	    chain->total_size > batadv_frag_size_limit()) {
 		/* Clear chain if total size of either the list or the packet
-		 * exceeds the maximum size of one merged packet.
+		 * exceeds the maximum size of one merged packet. Don't allow
+		 * packets to have different total_size.
 		 */
 		batadv_frag_clear_chain(&chain->head);
 		chain->size = 0;
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
  * @timestamp: time (jiffie) of last received fragment
  * @seqno: sequence number of the fragments in the list
  * @size: accumulated size of packets in list
+ * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
 	struct hlist_head head;
@@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
 
 /**

