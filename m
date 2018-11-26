Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6640FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E8420817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty4N0uIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E8420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeKZVuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKZVux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:50:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A88F21104;
        Mon, 26 Nov 2018 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229829;
        bh=3QujUCfT7RZi0NMIMQvvvqh6PAUVZx610sGrNelOdbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ty4N0uIrlOqC7HB0ma0XuS/CBsy8tReSlIbRoYpnD8XVHPCzABhE3qx2kRqbiJt1U
         KxOFcD8UEESs6zZRJxgUKXf5kEDLELW86YfGEBOl49v082Q9xtNmUs4cZ73qbCdLnw
         jhdCQJEsv/rsQj8zczSKROUX0uhNaxANH9eaxy6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/46] s390/qeth: fix HiperSockets sniffer
Date:   Mon, 26 Nov 2018 11:51:07 +0100
Message-Id: <20181126105047.933950804@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bd74a7f9cc033cf4d405788f80292268987dc0c5 ]

Sniffing mode for L3 HiperSockets requires that no IP addresses are
registered with the HW. The preferred way to achieve this is for
userspace to delete all the IPs on the interface. But qeth is expected
to also tolerate a configuration where that is not the case, by skipping
the IP registration when in sniffer mode.
Since commit 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
reworked the IP registration logic in the L3 subdriver, this no longer
works. When the qeth device is set online, qeth_l3_recover_ip() now
unconditionally registers all unicast addresses from our internal
IP table.

While we could fix this particular problem by skipping
qeth_l3_recover_ip() on a sniffer device, the more future-proof change
is to skip the IP address registration at the lowest level. This way we
a) catch any future code path that attempts to register an IP address
   without considering the sniffer scenario, and
b) continue to build up our internal IP table, so that if sniffer mode
   is switched off later we can operate just like normal.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l3_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index efefe075557f..6e6ba1baf9c4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -363,9 +363,6 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 
 	QETH_CARD_TEXT(card, 4, "clearip");
 
-	if (recover && card->options.sniffer)
-		return;
-
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
@@ -823,6 +820,8 @@ static int qeth_l3_register_addr_entry(struct qeth_card *card,
 	int rc = 0;
 	int cnt = 3;
 
+	if (card->options.sniffer)
+		return 0;
 
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_CARD_TEXT(card, 2, "setaddr4");
@@ -858,6 +857,9 @@ static int qeth_l3_deregister_addr_entry(struct qeth_card *card,
 {
 	int rc = 0;
 
+	if (card->options.sniffer)
+		return 0;
+
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_CARD_TEXT(card, 2, "deladdr4");
 		QETH_CARD_HEX(card, 3, &addr->u.a4.addr, sizeof(int));
-- 
2.17.1



