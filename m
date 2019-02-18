Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05719217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499055;
	bh=cWkvYAIYSuuxTWFENCUoA4MC6iEiqsfnTdUI59HMRtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eudW7+6irYfUU+T2Kql39+CqxbnZPI1wG7HQfK0Rt/hgdl99e5deCFA+kaYR877wW
	 mRNPQM7a1W01UUauiECeCq1FljROd5mRcyOdMVVV/Bpz0Oy18YtXoZ4P6w5eFU+AlE
	 puokfxPOW5VDlaJMZvIFBk5fcRTlQQMcBL7p822w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbfBROKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391578AbfBROKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:10:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DD1217D7;
        Mon, 18 Feb 2019 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499050;
        bh=cWkvYAIYSuuxTWFENCUoA4MC6iEiqsfnTdUI59HMRtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvQrt7HJJ+60bvbEgN1oiYhZRQq9zFcmCY+kO3/HBbcNUa04BB9THGe3jiSte02UD
         w4kWqj69ySxcFShGGzUF4WQwfEJvj4tJ0f3f1g4qZsxS9RKwjdVi0B66O5HzWBkUNc
         h+Y4y0OT1JZTFIq15lRQ311c7pumWZPMs+u8v66s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 061/108] enic: fix checksum validation for IPv6
Date:   Mon, 18 Feb 2019 14:43:57 +0100
Message-Id: <20190218133522.350361632@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1065,7 +1065,7 @@ static void enic_rq_indicate_buf(struct
 		 * CHECSUM_UNNECESSARY.
 		 */
 		if ((netdev->features & NETIF_F_RXCSUM) && tcp_udp_csum_ok &&
-		    ipv4_csum_ok)
+		    (ipv4_csum_ok || ipv6))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		if (vlan_stripped)


