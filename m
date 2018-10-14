Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5849C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975BF20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975BF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeJNXdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:33:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36133 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cA-5O; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000eP-QG; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marek Lindner" <mareklindner@neomailbox.ch>,
        "Simon Wunderlich" <sw@simonwunderlich.de>,
        "Sven Eckelmann" <sven@narfation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.912929694@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 295/366] batman-adv: prevent TT request storms by not
 sending inconsistent TT TLVLs
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

From: Marek Lindner <mareklindner@neomailbox.ch>

commit 16116dac23396e73c01eeee97b102e4833a4b205 upstream.

A translation table TVLV changset sent with an OGM consists
of a number of headers (one per VLAN) plus the changeset
itself (addition and/or deletion of entries).

The per-VLAN headers are used by OGM recipients for consistency
checks. Said consistency check might determine that a full
translation table request is needed to restore consistency. If
the TT sender adds per-VLAN headers of empty VLANs into the OGM,
recipients are led to believe to have reached an inconsistent
state and thus request a full table update. The full table does
not contain empty VLANs (due to missing entries) the cycle
restarts when the next OGM is issued.

Consequently, when the translation table TVLV headers are
composed, empty VLANs are to be excluded.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -786,14 +786,21 @@ batadv_tt_prepare_tvlv_local_data(struct
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_softif_vlan *vlan;
-	uint16_t num_vlan = 0, num_entries = 0, tvlv_len;
+	u16 num_vlan = 0;
+	u16 vlan_entries = 0;
+	u16 total_entries = 0;
+	u16 tvlv_len;
 	uint8_t *tt_change_ptr;
 	int change_offset;
 
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		num_vlan++;
-		num_entries += atomic_read(&vlan->tt.num_entries);
+		total_entries += vlan_entries;
 	}
 
 	change_offset = sizeof(**tt_data);
@@ -801,7 +808,7 @@ batadv_tt_prepare_tvlv_local_data(struct
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len = batadv_tt_len(num_entries);
+		*tt_len = batadv_tt_len(total_entries);
 
 	tvlv_len = *tt_len;
 	tvlv_len += change_offset;
@@ -818,6 +825,10 @@ batadv_tt_prepare_tvlv_local_data(struct
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries = atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
 

