Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1429242-1519217232-2-3056568673340438152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217231; b=CdicO+uFM3bTTky7kxDySd0Q2CgN/0EorjS+roI9neD99e0
    ZEXOeD/0d8GCb1qh5RTKR/MD9Re2KrUHS/9Uhg8rvlLqGwMLQju6YHzS4akWMCs8
    jH+VDFeVvzJR/bu8U1PZcjWTJS36k9DNoINk86nHSQCxzsc1Pts48f1xXjG1D2RA
    jVlsC64WH+diR/gigNGXwr9QqTt2zgrp6/xXi2L4WVg59W87PU87BvaZOnmY+Znq
    qJ/7YGway62Kj/r9ZMk9wQ8yKBaNec3MmDn4xIYTFbA7lgk8cb7YV8/At3lh2EQu
    +QjcpZu+KtKYTt9qOeTkt+chK+uJi3CcdtMB+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217231; bh=/nEdrZhxQHP/hsLVY6/w0VwV7M
    c0KJvjKn1oF6Z/CTQ=; b=a/wjVgsL8jDMV/1DutFppcS9NyCBMQiinMqBAlOCXL
    mgbghGoefARFnmVGxYIivwPuEirrLAKGUGlQDmE2xkZxb4eaSoPCcvA8QyLaznA/
    rVIZII7xDIzZWyQy0sULOoeoygdGXhO+Ah/VecbZdGYyboaypX6NNfoMFvk9uPg7
    u9i3y49MHn+W4U7LWOo3VjtlUZBT2NpzyN5Y8HZ+hbbXnzIhGbNZBAyqZ8t6exGb
    d+UQjZIdeJ20mX9nKvRSxGYRxSmVkHXwEErdteShgwK+FjNnevb6Qvt0H1g8X9b9
    Vzo9ARdBzKte1tMe5eGcLVSe6LmGTzH8UPGPGa9XNEkg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeBUMqs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933990AbeBUMqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 27/33] mvpp2: fix multicast address filter
Date: Wed, 21 Feb 2018 13:45:10 +0100
Message-Id: <20180221124411.008193057@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7ac8ff95f48cbfa609a060fd6a1e361dd62feeb3 upstream.

IPv6 doesn't work on the MacchiatoBIN board. It is caused by broken
multicast address filter in the mvpp2 driver.

The driver loads doesn't load any multicast entries if "allmulti" is not
set. This condition should be reversed.

The condition !netdev_mc_empty(dev) is useless (because
netdev_for_each_mc_addr is nop if the list is empty).

This patch also fixes a possible overflow of the multicast list - if
mvpp2_prs_mac_da_accept fails, we set the allmulti flag and retry.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvpp2.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5666,6 +5666,7 @@ static void mvpp2_set_rx_mode(struct net
 	int id = port->id;
 	bool allmulti = dev->flags & IFF_ALLMULTI;
 
+retry:
 	mvpp2_prs_mac_promisc_set(priv, id, dev->flags & IFF_PROMISC);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_ALL, allmulti);
 	mvpp2_prs_mac_multi_set(priv, id, MVPP2_PE_MAC_MC_IP6, allmulti);
@@ -5673,9 +5674,13 @@ static void mvpp2_set_rx_mode(struct net
 	/* Remove all port->id's mcast enries */
 	mvpp2_prs_mcast_del_all(priv, id);
 
-	if (allmulti && !netdev_mc_empty(dev)) {
-		netdev_for_each_mc_addr(ha, dev)
-			mvpp2_prs_mac_da_accept(priv, id, ha->addr, true);
+	if (!allmulti) {
+		netdev_for_each_mc_addr(ha, dev) {
+			if (mvpp2_prs_mac_da_accept(priv, id, ha->addr, true)) {
+				allmulti = true;
+				goto retry;
+			}
+		}
 	}
 }
 
