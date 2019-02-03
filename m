Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F3C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC02084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfBCN6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53792 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728353AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9l-0003wD-7M; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007BG-AA; Sun, 03 Feb 2019 14:49:52 +0100
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
Message-ID: <lsq.1549201508.401147094@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 188/305] batman-adv: Use only queued fragments when
 merging
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

commit 83e8b87721f21b26b843633caca8ef453e943623 upstream.

The fragment queueing code now validates the total_size of each fragment,
checks when enough fragments are queued to allow to merge them into a
single packet and if the fragments have the correct size. Therefore, it is
not required to have any other parameter for the merging function than a
list of queued fragments.

This change should avoid problems like in the past when the different skb
from the list and the function parameter were mixed incorrectly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/batman-adv/fragmentation.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -234,19 +234,13 @@ err:
  * Returns the merged skb or NULL on error.
  */
 static struct sk_buff *
-batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
+batadv_frag_merge_packets(struct hlist_head *chain)
 {
 	struct batadv_frag_packet *packet;
 	struct batadv_frag_list_entry *entry;
 	struct sk_buff *skb_out = NULL;
 	int size, hdr_size = sizeof(struct batadv_frag_packet);
 
-	/* Make sure incoming skb has non-bogus data. */
-	packet = (struct batadv_frag_packet *)skb->data;
-	size = ntohs(packet->total_size);
-	if (size > batadv_frag_size_limit())
-		goto free;
-
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
 	 */
@@ -255,6 +249,9 @@ batadv_frag_merge_packets(struct hlist_h
 	skb_out = entry->skb;
 	kfree(entry);
 
+	packet = (struct batadv_frag_packet *)skb_out->data;
+	size = ntohs(packet->total_size);
+
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
 		kfree_skb(skb_out);
@@ -311,7 +308,7 @@ bool batadv_frag_skb_buffer(struct sk_bu
 	if (hlist_empty(&head))
 		goto out;
 
-	skb_out = batadv_frag_merge_packets(&head, *skb);
+	skb_out = batadv_frag_merge_packets(&head);
 	if (!skb_out)
 		goto out_err;
 

