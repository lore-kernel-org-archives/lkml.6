Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA53C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAA92081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896668;
	bh=xoEs6aHBxpEbckhdCbEIqu8EioJocWbreN5iBdDi/2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wMY/dkBfaClmwsWkABsffAT6DC+y+G6j/n08A3dkMt0I1T/DmrFS6cNfPoijguEZL
	 aVBBXBj3lA9p448/l21AooGSkua2mt4JvE+8Z+GcyIdRljYlhlG1NCS0xcsbsgG9mu
	 ptb8ByI4m9AXL+8XViqXXPWViaWhX7Ejtc9P3/Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfBKOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbfBKOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E8420700;
        Mon, 11 Feb 2019 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896664;
        bh=xoEs6aHBxpEbckhdCbEIqu8EioJocWbreN5iBdDi/2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZtOCNhu+JFQxnnJ/HA3CQNHErb5+hemv1k4W0W+xNTDe0u75YTjnfGJ0oWuC73WK
         cHMRsK7UR51S4KPs1P6vbep8ueAKUzicFeu+NsCO3JTco7gTXXIDImu6GyuqNFnvR0
         uSs0hdwiDG1W7C32ssu7951o/KsI+c4mRWy63kMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 260/313] enic: fix checksum validation for IPv6
Date:   Mon, 11 Feb 2019 15:19:00 +0100
Message-Id: <20190211141910.678482171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


