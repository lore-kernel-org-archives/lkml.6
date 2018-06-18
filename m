Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09BFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4122208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4122208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965799AbeFRKDr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:03:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935034AbeFRISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98FB1C83;
        Mon, 18 Jun 2018 08:18:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 073/279] s390/qeth: fix MAC address update sequence
Date:   Mon, 18 Jun 2018 10:10:58 +0200
Message-Id: <20180618080611.840311686@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

[ Upstream commit bcacfcbc82b4235d280ed9b067aa4567f4a0c756 ]

When changing the MAC address on a L2 qeth device, current code first
unregisters the old address, then registers the new one.
If HW rejects the new address (or the IO fails), the device ends up with
no operable address at all.

Re-order the code flow so that the old address only gets dropped if the
new address was registered successfully. While at it, add logic to catch
some corner-cases.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l2_main.c |   55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -122,13 +122,10 @@ static int qeth_l2_send_setmac(struct qe
 	QETH_CARD_TEXT(card, 2, "L2Setmac");
 	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_SETVMAC);
 	if (rc == 0) {
-		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
-		ether_addr_copy(card->dev->dev_addr, mac);
 		dev_info(&card->gdev->dev,
-			"MAC address %pM successfully registered on device %s\n",
-			card->dev->dev_addr, card->dev->name);
+			 "MAC address %pM successfully registered on device %s\n",
+			 mac, card->dev->name);
 	} else {
-		card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
 		switch (rc) {
 		case -EEXIST:
 			dev_warn(&card->gdev->dev,
@@ -143,19 +140,6 @@ static int qeth_l2_send_setmac(struct qe
 	return rc;
 }
 
-static int qeth_l2_send_delmac(struct qeth_card *card, __u8 *mac)
-{
-	int rc;
-
-	QETH_CARD_TEXT(card, 2, "L2Delmac");
-	if (!(card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
-		return 0;
-	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_DELVMAC);
-	if (rc == 0)
-		card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
-	return rc;
-}
-
 static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 {
 	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
@@ -522,6 +506,7 @@ static int qeth_l2_set_mac_address(struc
 {
 	struct sockaddr *addr = p;
 	struct qeth_card *card = dev->ml_priv;
+	u8 old_addr[ETH_ALEN];
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 3, "setmac");
@@ -533,14 +518,35 @@ static int qeth_l2_set_mac_address(struc
 		return -EOPNOTSUPP;
 	}
 	QETH_CARD_HEX(card, 3, addr->sa_data, ETH_ALEN);
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
 	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
 		QETH_CARD_TEXT(card, 3, "setmcREC");
 		return -ERESTARTSYS;
 	}
-	rc = qeth_l2_send_delmac(card, &card->dev->dev_addr[0]);
-	if (!rc || (rc == -ENOENT))
-		rc = qeth_l2_send_setmac(card, addr->sa_data);
-	return rc ? -EINVAL : 0;
+
+	if (!qeth_card_hw_is_reachable(card)) {
+		ether_addr_copy(dev->dev_addr, addr->sa_data);
+		return 0;
+	}
+
+	/* don't register the same address twice */
+	if (ether_addr_equal_64bits(dev->dev_addr, addr->sa_data) &&
+	    (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
+		return 0;
+
+	/* add the new address, switch over, drop the old */
+	rc = qeth_l2_send_setmac(card, addr->sa_data);
+	if (rc)
+		return rc;
+	ether_addr_copy(old_addr, dev->dev_addr);
+	ether_addr_copy(dev->dev_addr, addr->sa_data);
+
+	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
+		qeth_l2_remove_mac(card, old_addr);
+	card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
+	return 0;
 }
 
 static void qeth_promisc_to_bridge(struct qeth_card *card)
@@ -1067,8 +1073,9 @@ static int __qeth_l2_set_online(struct c
 		goto out_remove;
 	}
 
-	if (card->info.type != QETH_CARD_TYPE_OSN)
-		qeth_l2_send_setmac(card, &card->dev->dev_addr[0]);
+	if (card->info.type != QETH_CARD_TYPE_OSN &&
+	    !qeth_l2_send_setmac(card, card->dev->dev_addr))
+		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
 
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&


