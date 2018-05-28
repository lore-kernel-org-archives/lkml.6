Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034350AbeE1P1S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033130AbeE1KUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:20:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brandon Carpenter <brandon.carpenter@cypherpath.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 138/268] net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
Date: Mon, 28 May 2018 12:01:52 +0200
Message-Id: <20180528100217.963535682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 4bbb3e0e8239f9079bf1fe20b3c0cb598714ae61 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/if_ether.h |    1 +
 net/core/skbuff.c             |    7 +++++--
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
@@ -4295,13 +4295,16 @@ EXPORT_SYMBOL_GPL(skb_gso_transport_segl
 
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
