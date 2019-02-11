Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E405BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B384421B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900549;
	bh=9iqADzwZ7J3ut5GRzbEAG8xRWgIka3ptkqIJiuUtaa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2CMsEe9aW6fsm/TyIRj2rWxYOEUwtlJZOEIzgzTYSETigwVOJTyUr8zerGoL+cpv9
	 /LL1XYyffL2imQRQYSTV94TMgQ4qwCz5ZSBYOmwlRmfccO2+YA0zzLmwiCaZyrga0K
	 kn2jZwLIwkz2MzaWG/qQpw4pAKMSXnAmTqdHYLAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfBKOfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730739AbfBKOe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55FF92081B;
        Mon, 11 Feb 2019 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895697;
        bh=9iqADzwZ7J3ut5GRzbEAG8xRWgIka3ptkqIJiuUtaa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7pxQXgyHKWNgbHxc6XwktxK8SyBGmS7nen9Pc+rZ7abbtR5i6rP8ejxE8h5C0PR0
         mXJq0XkQ+4bJnfjA2f1Rk1Vy4BhmD8L6pnMmq8zn6OqnE840igkLwUY8DatdzKcRYl
         ryaDYo0G8LHTkLNiXPX2Btiw2Oc4O7oYhiUwkP0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 293/352] enic: fix checksum validation for IPv6
Date:   Mon, 11 Feb 2019 15:18:40 +0100
Message-Id: <20190211141905.538482156@linuxfoundation.org>
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

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 7596175e99b3d4bce28022193efd954c201a782a ]

In case of IPv6 pkts, ipv4_csum_ok is 0. Because of this, driver does
not set skb->ip_summed. So IPv6 rx checksum is not offloaded.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1434,7 +1434,8 @@ static void enic_rq_indicate_buf(struct
 		 * csum is correct or is zero.
 		 */
 		if ((netdev->features & NETIF_F_RXCSUM) && !csum_not_calc &&
-		    tcp_udp_csum_ok && ipv4_csum_ok && outer_csum_ok) {
+		    tcp_udp_csum_ok && outer_csum_ok &&
+		    (ipv4_csum_ok || ipv6)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			skb->csum_level = encap;
 		}


