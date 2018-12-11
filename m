Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E6720880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544555;
	bh=uQsCC59JKgkf4GEpfsYbOLXlPETtP4iiaUKEievQhPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b3BJv33I23kra2CSPKF1OlPy36UNOYnwy1lPJ/T9YHfNG7aR+km7jTZ/LTbpPEM0T
	 NIROL23aP/RqDO36YncOFL0+uAgokRlIDSmesu3LG7SixDiKuLcrdt4hvbDaeXV2pG
	 5wJ5oYjCPZl4aKr+7YKENvCCVsoDFR/+ia+awDew=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E6720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeLKPwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeLKPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940D820855;
        Tue, 11 Dec 2018 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543552;
        bh=uQsCC59JKgkf4GEpfsYbOLXlPETtP4iiaUKEievQhPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfQp33GW7p97anqMVmrnnoeguyPUm/adaaClG45wTLE1lwhGg6wKsobC+MCtNOcSi
         J2eLdrrmPvkoApaBtEH7TDf4tUESxgV2p3Vv8SdKKCF+piBUIhgJ+148qoRfCqfkUh
         bxPMZssAiHsn9fT50jjuGhongAoZ4yHIkXL9EU1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/67] batman-adv: Use explicit tvlv padding for ELP packets
Date:   Tue, 11 Dec 2018 16:41:08 +0100
Message-Id: <20181211151630.794271195@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f4156f9656feac21f4de712fac94fae964c5d402 ]

The announcement messages of batman-adv COMPAT_VERSION 15 have the
possibility to announce additional information via a dynamic TVLV part.
This part is optional for the ELP packets and currently not parsed by the
Linux implementation. Still out-of-tree versions are using it to transport
things like neighbor hashes to optimize the rebroadcast behavior.

Since the ELP broadcast packets are smaller than the minimal ethernet
packet, it often has to be padded. This is often done (as specified in
RFC894) with octets of zero and thus work perfectly fine with the TVLV
part (making it a zero length and thus empty). But not all ethernet
compatible hardware seems to follow this advice. To avoid ambiguous
situations when parsing the TVLV header, just force the 4 bytes (TVLV
length + padding) after the required ELP header to zero.

Fixes: d6f94d91f766 ("batman-adv: ELP - adding basic infrastructure")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e92dfedccc16..fbc132f4670e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -338,19 +338,21 @@ out:
  */
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 {
+	static const size_t tvlv_padding = sizeof(__be32);
 	struct batadv_elp_packet *elp_packet;
 	unsigned char *elp_buff;
 	u32 random_seqno;
 	size_t size;
 	int res = -ENOMEM;
 
-	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
+	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN + tvlv_padding;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
 	if (!hard_iface->bat_v.elp_skb)
 		goto out;
 
 	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
-	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
+	elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb,
+				BATADV_ELP_HLEN + tvlv_padding);
 	elp_packet = (struct batadv_elp_packet *)elp_buff;
 
 	elp_packet->packet_type = BATADV_ELP;
-- 
2.19.1



