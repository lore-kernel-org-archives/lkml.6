Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F8g3Iz9DGVvWBgAAmS7hNA
	; Thu, 07 Jun 2018 14:37:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7E423602FC; Thu,  7 Jun 2018 14:37:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D9AE1601D2;
	Thu,  7 Jun 2018 14:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9AE1601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934159AbeFGOhs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:37:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40452 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933532AbeFGOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:37:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbP-0005hO-Es; Thu, 07 Jun 2018 15:09:23 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003GE-6n; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Brandon Carpenter" <brandon.carpenter@cypherpath.com>,
        "Toshiaki Makita" <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.981971124@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 366/410] net: Fix vlan untag for bridge and vlan_dev
 with reorder_hdr off
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

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

commit 4bbb3e0e8239f9079bf1fe20b3c0cb598714ae61 upstream.

When we have a bridge with vlan_filtering on and a vlan device on top of
it, packets would be corrupted in skb_vlan_untag() called from
br_dev_xmit().

The problem sits in skb_reorder_vlan_header() used in skb_vlan_untag(),
which makes use of skb->mac_len. In this function mac_len is meant for
handling rx path with vlan devices with reorder_header disabled, but in
tx path mac_len is typically 0 and cannot be used, which is the problem
in this case.

The current code even does not properly handle rx path (skb_vlan_untag()
called from __netif_receive_skb_core()) with reorder_header off actually.

In rx path single tag case, it works as follows:

- Before skb_reorder_vlan_header()

 mac_header                                data
   v                                        v
   +-------------------+-------------+------+----
   |        ETH        |    VLAN     | ETH  |
   |       ADDRS       | TPID | TCI  | TYPE |
   +-------------------+-------------+------+----
   <-------- mac_len --------->
                       <------------->
                        to be removed

- After skb_reorder_vlan_header()

            mac_header                     data
                 v                          v
                 +-------------------+------+----
                 |        ETH        | ETH  |
                 |       ADDRS       | TYPE |
                 +-------------------+------+----
                 <-------- mac_len --------->

This is ok, but in rx double tag case, it corrupts packets:

- Before skb_reorder_vlan_header()

 mac_header                                              data
   v                                                      v
   +-------------------+-------------+-------------+------+----
   |        ETH        |    VLAN     |    VLAN     | ETH  |
   |       ADDRS       | TPID | TCI  | TPID | TCI  | TYPE |
   +-------------------+-------------+-------------+------+----
   <--------------- mac_len ---------------->
                                     <------------->
                                    should be removed
                       <--------------------------->
                         actually will be removed

- After skb_reorder_vlan_header()

            mac_header                                   data
                 v                                        v
                               +-------------------+------+----
                               |        ETH        | ETH  |
                               |       ADDRS       | TYPE |
                               +-------------------+------+----
                 <--------------- mac_len ---------------->

So, two of vlan tags are both removed while only inner one should be
removed and mac_header (and mac_len) is broken.

skb_vlan_untag() is meant for removing the vlan header at (skb->data - 2),
so use skb->data and skb->mac_header to calculate the right offset.

Reported-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Fixes: a6e18ff11170 ("vlan: Fix untag operations of stacked vlans with REORDER_HEADER off")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/uapi/linux/if_ether.h | 1 +
 net/core/skbuff.c             | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -29,6 +29,7 @@
  */
 
 #define ETH_ALEN	6		/* Octets in one ethernet addr	 */
+#define ETH_TLEN	2		/* Octets in ethernet type field */
 #define ETH_HLEN	14		/* Total octets in header.	 */
 #define ETH_ZLEN	60		/* Min. octets in frame sans FCS */
 #define ETH_DATA_LEN	1500		/* Max. octets in payload	 */
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3994,13 +3994,16 @@ EXPORT_SYMBOL_GPL(skb_gso_transport_segl
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
+	int mac_len;
+
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
 		return NULL;
 	}
 
-	memmove(skb->data - ETH_HLEN, skb->data - skb->mac_len - VLAN_HLEN,
-		2 * ETH_ALEN);
+	mac_len = skb->data - skb_mac_header(skb);
+	memmove(skb_mac_header(skb) + VLAN_HLEN, skb_mac_header(skb),
+		mac_len - VLAN_HLEN - ETH_TLEN);
 	skb->mac_header += VLAN_HLEN;
 	return skb;
 }
