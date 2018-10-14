Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363EC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5568020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeJNXL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36135 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cD-4c; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000eL-Pd; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Leonardo =?UTF-8?Q?M=C3=B6rlein?=" <me@irrelefant.net>,
        "=?UTF-8?q?Linus=20L=C3=BCssing?=" <linus.luessing@c0d3.blue>,
        "Sven Eckelmann" <sven@narfation.org>,
        "Simon Wunderlich" <sw@simonwunderlich.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.840390487@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 294/366] batman-adv: Fix TT sync flags for
 intermediate TT responses
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Lüssing <linus.luessing@c0d3.blue>

commit 7072337e52b3e9d5460500d8dc9cbc1ba2db084c upstream.

The previous TT sync fix so far only fixed TT responses issued by the
target node directly. So far, TT responses issued by intermediate nodes
still lead to the wrong flags being added, leading to CRC mismatches.

This behaviour was observed at Freifunk Hannover in a 800 nodes setup
where a considerable amount of nodes were still infected with 'WI'
TT flags even with (most) nodes having the previous TT sync fix applied.

I was able to reproduce the issue with intermediate TT responses in a
four node test setup and this patch fixes this issue by ensuring to
use the per originator instead of the summarized, OR'd ones.

Fixes: e9c00136a475 ("batman-adv: fix tt_global_entries flags update")
Reported-by: Leonardo Mörlein <me@irrelefant.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16:
 - Drop inapplicable comment changes
 - Change return types of batadv_tt_{local,global}_valid() to bool, done
   as part of a larger conversion upstream
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1219,7 +1219,8 @@ batadv_tt_global_orig_entry_find(const s
  */
 static bool
 batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
-				const struct batadv_orig_node *orig_node)
+				const struct batadv_orig_node *orig_node,
+				u8 *flags)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	bool found = false;
@@ -1227,6 +1228,10 @@ batadv_tt_global_entry_has_orig(const st
 	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found = true;
+
+		if (flags)
+			*flags = orig_entry->flags;
+
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
 	}
 
@@ -1403,7 +1408,7 @@ static bool batadv_tt_global_add(struct
 			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
 				goto out;
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
-							    orig_node))
+							    orig_node, NULL))
 				goto out_remove;
 			batadv_tt_global_del_orig_list(tt_global_entry);
 			goto add_orig_entry;
@@ -2311,23 +2316,46 @@ unlock:
 }
 
 /**
- * batadv_tt_local_valid - verify that given tt entry is a valid one
+ * batadv_tt_local_valid() - verify local tt entry and get flags
  * @entry_ptr: to be checked local tt entry
  * @data_ptr: not used but definition required to satisfy the callback prototype
+ * @flags: a pointer to store TT flags for this client to
  *
- * Returns 1 if the entry is a valid, 0 otherwise.
+ * Checks the validity of the given local TT entry. If it is, then the provided
+ * flags pointer is updated.
+ *
+ * Return: true if the entry is a valid, false otherwise.
  */
-static int batadv_tt_local_valid(const void *entry_ptr, const void *data_ptr)
+static bool batadv_tt_local_valid(const void *entry_ptr,
+				  const void *data_ptr,
+				  u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
-		return 0;
-	return 1;
+		return false;
+
+	if (flags)
+		*flags = tt_common_entry->flags;
+
+	return true;
 }
 
-static int batadv_tt_global_valid(const void *entry_ptr,
-				  const void *data_ptr)
+/**
+ * batadv_tt_global_valid() - verify global tt entry and get flags
+ * @entry_ptr: to be checked global tt entry
+ * @data_ptr: an orig_node object (may be NULL)
+ * @flags: a pointer to store TT flags for this client to
+ *
+ * Checks the validity of the given global TT entry. If it is, then the provided
+ * flags pointer is updated either with the common (summed) TT flags if data_ptr
+ * is NULL or the specific, per originator TT flags otherwise.
+ *
+ * Return: true if the entry is a valid, false otherwise.
+ */
+static bool batadv_tt_global_valid(const void *entry_ptr,
+				   const void *data_ptr,
+				   u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry = entry_ptr;
 	const struct batadv_tt_global_entry *tt_global_entry;
@@ -2341,7 +2369,8 @@ static int batadv_tt_global_valid(const
 				       struct batadv_tt_global_entry,
 				       common);
 
-	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node);
+	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node,
+					       flags);
 }
 
 /**
@@ -2351,24 +2380,34 @@ static int batadv_tt_global_valid(const
  * @hash: hash table containing the tt entries
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
- * @valid_cb: function to filter tt change entries
+ * @valid_cb: function to filter tt change entries and to return TT flags
  * @cb_data: data passed to the filter function as argument
+ *
+ * Fills the tvlv buff with the tt entries from the specified hash. If valid_cb
+ * is not provided then this becomes a no-op.
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				    struct batadv_hashtable *hash,
 				    void *tvlv_buff, uint16_t tt_len,
-				    int (*valid_cb)(const void *, const void *),
+				    bool (*valid_cb)(const void *,
+						     const void *,
+						     u8 *flags),
 				    void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
 	uint16_t tt_tot, tt_num_entries = 0;
+	u8 flags;
+	bool ret;
 	uint32_t i;
 
 	tt_tot = batadv_tt_entries(tt_len);
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
+	if (!valid_cb)
+		return;
+
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2378,11 +2417,12 @@ static void batadv_tt_tvlv_generate(stru
 			if (tt_tot == tt_num_entries)
 				break;
 
-			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
+			ret = valid_cb(tt_common_entry, cb_data, &flags);
+			if (!ret)
 				continue;
 
 			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
-			tt_change->flags = tt_common_entry->flags;
+			tt_change->flags = flags;
 			tt_change->vid = htons(tt_common_entry->vid);
 			memset(tt_change->reserved, 0,
 			       sizeof(tt_change->reserved));

