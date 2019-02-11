Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38472C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18A2222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894910;
	bh=pYuLR2buWq33QtbBOd2aVBHrF65sym+uQIAbZ4e21N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZixEOnRbyZTflSOblFTiiYgnUubV/usLfRYXuiXsSqv+Q9u0cM96+iHHSkkWv+8Mz
	 SAZ4V2ushmgtq+P+lIQpy3Rk0LtfMt+D3TOAsqhijxEcTFccYoiJ1FI15apznpYpop
	 +YUNvkbOw+bI0T4TQDAiXpSOwuMGfR+GsKRHieGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfBKOVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfBKOVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4352820844;
        Mon, 11 Feb 2019 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894904;
        bh=pYuLR2buWq33QtbBOd2aVBHrF65sym+uQIAbZ4e21N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Grg8SSisZCamrrzdmLmg+Ppo6x60SGwOsMPuPONCezCMwYhFi4gR15ag6wq3SW1Sf
         gcP3ZrcBnjcqJgnNdBh+HrVSSg4uuHEA+A2HHFgaCdxkmO6jlDJR3C+j4qcBpczpHh
         Jzcr0RuDxUbpq2Z3CxFRsR2S+Od082CS2flDThJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 028/352] s390/qeth: utilize virtual MAC for Layer2 OSD devices
Date:   Mon, 11 Feb 2019 15:14:15 +0100
Message-Id: <20190211141848.132024995@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b144b99fff69a5bc0d34c8e168bedb88c68ca23d ]

By default, READ MAC on a Layer2 OSD device returns the adapter's
burnt-in MAC address. Given the default scenario of many virtual devices
on the same adapter, qeth can't make any use of this address and
therefore skips the READ MAC call for this device type.

But in some configurations, the READ MAC command for a Layer2 OSD device
actually returns a pre-provisioned, virtual MAC address. So enable the
READ MAC code to detect this situation, and let the L2 subdriver
call READ MAC for OSD devices.

This also removes the QETH_LAYER2_MAC_READ flag, which protects L2
devices against calling READ MAC multiple times. Instead protect the
whole call to qeth_l2_request_initial_mac().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 12 +++++++-----
 drivers/s390/net/qeth_core_mpc.h  | 25 +++++++++++++++----------
 drivers/s390/net/qeth_l2_main.c   | 10 ++++------
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 04e294d1d16d..99af1a0a3314 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -665,7 +665,6 @@ struct qeth_card_blkt {
 
 #define QETH_BROADCAST_WITH_ECHO    0x01
 #define QETH_BROADCAST_WITHOUT_ECHO 0x02
-#define QETH_LAYER2_MAC_READ	    0x01
 #define QETH_LAYER2_MAC_REGISTERED  0x02
 struct qeth_card_info {
 	unsigned short unit_addr2;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 254065271867..0c9a5250dd93 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4235,16 +4235,18 @@ static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	struct qeth_ipacmd_setadpparms *adp_cmd;
 
 	QETH_CARD_TEXT(card, 4, "chgmaccb");
 	if (qeth_setadpparms_inspect_rc(cmd))
 		return 0;
 
-	if (IS_LAYER3(card) || !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
-		ether_addr_copy(card->dev->dev_addr,
-				cmd->data.setadapterparms.data.change_addr.addr);
-		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
-	}
+	adp_cmd = &cmd->data.setadapterparms;
+	if (IS_LAYER2(card) && IS_OSD(card) && !IS_VM_NIC(card) &&
+	    !(adp_cmd->hdr.flags & QETH_SETADP_FLAGS_VIRTUAL_MAC))
+		return 0;
+
+	ether_addr_copy(card->dev->dev_addr, adp_cmd->data.change_addr.addr);
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 3e54be201b27..10cc487c16d6 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -80,7 +80,9 @@ enum qeth_card_types {
 };
 
 #define IS_IQD(card)	((card)->info.type == QETH_CARD_TYPE_IQD)
+#define IS_OSD(card)	((card)->info.type == QETH_CARD_TYPE_OSD)
 #define IS_OSN(card)	((card)->info.type == QETH_CARD_TYPE_OSN)
+#define IS_VM_NIC(card)	((card)->info.guestlan)
 
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
 /* only the first two bytes are looked at in qeth_get_cardname_short */
@@ -529,17 +531,20 @@ struct qeth_query_switch_attributes {
 	__u8  reserved3[8];
 };
 
+#define QETH_SETADP_FLAGS_VIRTUAL_MAC	0x80	/* for CHANGE_ADDR_READ_MAC */
+
 struct qeth_ipacmd_setadpparms_hdr {
-	__u32 supp_hw_cmds;
-	__u32 reserved1;
-	__u16 cmdlength;
-	__u16 reserved2;
-	__u32 command_code;
-	__u16 return_code;
-	__u8  used_total;
-	__u8  seq_no;
-	__u32 reserved3;
-} __attribute__ ((packed));
+	u32 supp_hw_cmds;
+	u32 reserved1;
+	u16 cmdlength;
+	u16 reserved2;
+	u32 command_code;
+	u16 return_code;
+	u8 used_total;
+	u8 seq_no;
+	u8 flags;
+	u8 reserved3[3];
+};
 
 struct qeth_ipacmd_setadpparms {
 	struct qeth_ipacmd_setadpparms_hdr hdr;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2914a1a69f83..8d3601891c62 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -461,12 +461,9 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 		/* fall back to alternative mechanism: */
 	}
 
-	if (card->info.type == QETH_CARD_TYPE_IQD ||
-	    card->info.type == QETH_CARD_TYPE_OSM ||
-	    card->info.type == QETH_CARD_TYPE_OSX ||
-	    card->info.guestlan) {
+	if (!IS_OSN(card)) {
 		rc = qeth_setadpparms_change_macaddr(card);
-		if (!rc)
+		if (!rc && is_valid_ether_addr(card->dev->dev_addr))
 			goto out;
 		QETH_DBF_MESSAGE(2, "READ_MAC Assist failed on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
@@ -917,7 +914,8 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 				       PAGE_SIZE * (QDIO_MAX_ELEMENTS_PER_BUFFER - 1));
 	}
 
-	qeth_l2_request_initial_mac(card);
+	if (!is_valid_ether_addr(card->dev->dev_addr))
+		qeth_l2_request_initial_mac(card);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
 	rc = register_netdev(card->dev);
 	if (!rc && carrier_ok)
-- 
2.19.1



