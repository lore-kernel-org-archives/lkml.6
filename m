Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A19620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbeGTNaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbeGTNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:16 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0F7ECC3;
        Fri, 20 Jul 2018 12:38:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 058/101] s390/qeth: fix race when setting MAC address
Date:   Fri, 20 Jul 2018 14:14:04 +0200
Message-Id: <20180720121425.609072926@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 4789a21880488048105590049fc41a99f53d565d ]

When qeth_l2_set_mac_address() finds the card in a non-reachable state,
it merely copies the new MAC address into dev->dev_addr so that
__qeth_l2_set_online() can later register it with the HW.

But __qeth_l2_set_online() may very well be running concurrently, so we
can't trust the card state without appropriate locking:
If the online sequence is past the point where it registers
dev->dev_addr (but not yet in SOFTSETUP state), any address change needs
to be properly programmed into the HW. Otherwise the netdevice ends up
with a different MAC address than what's set in the HW, and inbound
traffic is not forwarded as expected.

This is most likely to occur for OSD in LPAR, where
commit 21b1702af12e ("s390/qeth: improve fallback to random MAC address")
now triggers eg. systemd to immediately change the MAC when the netdevice
is registered with a NET_ADDR_RANDOM address.

Fixes: bcacfcbc82b4 ("s390/qeth: fix MAC address update sequence")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l2_main.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -523,27 +523,34 @@ static int qeth_l2_set_mac_address(struc
 		return -ERESTARTSYS;
 	}
 
+	/* avoid racing against concurrent state change: */
+	if (!mutex_trylock(&card->conf_mutex))
+		return -EAGAIN;
+
 	if (!qeth_card_hw_is_reachable(card)) {
 		ether_addr_copy(dev->dev_addr, addr->sa_data);
-		return 0;
+		goto out_unlock;
 	}
 
 	/* don't register the same address twice */
 	if (ether_addr_equal_64bits(dev->dev_addr, addr->sa_data) &&
 	    (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
-		return 0;
+		goto out_unlock;
 
 	/* add the new address, switch over, drop the old */
 	rc = qeth_l2_send_setmac(card, addr->sa_data);
 	if (rc)
-		return rc;
+		goto out_unlock;
 	ether_addr_copy(old_addr, dev->dev_addr);
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
 
 	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
 		qeth_l2_remove_mac(card, old_addr);
 	card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
-	return 0;
+
+out_unlock:
+	mutex_unlock(&card->conf_mutex);
+	return rc;
 }
 
 static void qeth_promisc_to_bridge(struct qeth_card *card)


