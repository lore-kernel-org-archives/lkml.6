Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4802521901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498659;
	bh=kGIbrIoEGzJyHUJbMd8eitRfDmIG6O3mt3KbGW3b+Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyuqLfqFY8B/E1jX9KRn72HKDEgWadNtnH9S0r90pK+oNqZevxpeRj09ax3qX9j6v
	 Z2UAhg5i8gwmRXmsR/3Q9IIHnFrwIm8p9RQ0b8M0/xJR+FlbKbuuv/pDkJh0BcwkJi
	 1fkfK8/i6/DVn4X0y/tsVzjwkaUHiGTH3ijLRKxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbfBROES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389888AbfBROEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:04:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A985021901;
        Mon, 18 Feb 2019 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498653;
        bh=kGIbrIoEGzJyHUJbMd8eitRfDmIG6O3mt3KbGW3b+Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+yM/3c1rMOltpUK3C77G77WIBD7V36is2Bh5nclmlDE0nyQryVf7xAcBpsPMO2Hx
         dAf5d6/A5ORBOU1JpfOXghg7eQ6/3ocfTEOdCxnVHBEmZG8afWJ9WcjFplgf1kVssd
         +Tv4jIDHEpVmJ8sniH2gr6pzL6Adny1h8H4wevV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 078/143] enic: fix checksum validation for IPv6
Date:   Mon, 18 Feb 2019 14:43:26 +0100
Message-Id: <20190218133531.934903292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 7596175e99b3d4bce28022193efd954c201a782a ]

In case of IPv6 pkts, ipv4_csum_ok is 0. Because of this, driver does
not set skb->ip_summed. So IPv6 rx checksum is not offloaded.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1180,7 +1180,7 @@ static void enic_rq_indicate_buf(struct
 		 * CHECSUM_UNNECESSARY.
 		 */
 		if ((netdev->features & NETIF_F_RXCSUM) && tcp_udp_csum_ok &&
-		    ipv4_csum_ok)
+		    (ipv4_csum_ok || ipv6))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		if (vlan_stripped)


