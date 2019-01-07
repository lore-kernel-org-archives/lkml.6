Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5F020651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865298;
	bh=Oj8DpUIXXcubFR8xPANw9Dl65Aei5mGq++YQACnqmKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JqZWYFM3VuB/x9aq9JFDPZPVVUmfQWA2mhn4hUEeYAG6rBFkL1i5gyD5IuN8oiAWa
	 RPwOavdJiVMtE51D6b2i2lV9KBDuTwHn4T9Y5rTM4IlVDCY3FyTsoKUJv6MoU+iFXM
	 zw1p/1zN4Bz7i8fexVx009IrptnVZJ0VHkBomwoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfAGMsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfAGMsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17C6206BB;
        Mon,  7 Jan 2019 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865293;
        bh=Oj8DpUIXXcubFR8xPANw9Dl65Aei5mGq++YQACnqmKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBqwNTLekIA38CiSi+pHNK6SRYhAPNF0gD4diFx6NiFmbFqb1aLz+WjEENh37cUM8
         mtmPguwRb91juQ90jK5ZQ95tFVT9ODJFcohB1Ute3H7IljVZeQzbO3n9rE1I3dFQft
         fdi0CRW0A5QZQLY0TTB5BcnPH3Jt5Vi1vs76Z66A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 046/170] nfp: flower: ensure TCP flags can be placed in IPv6 frame
Date:   Mon,  7 Jan 2019 13:31:13 +0100
Message-Id: <20190107104458.639450593@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit 290974d434783624c13a9530a23c45f9c5ffe018 ]

Previously we did not ensure tcp flags have a place to be stored
when using IPv6. We correct this by including IPv6 key layer when
we match tcp flags and the IPv6 key layer has not been included
already.

Fixes: 07e1671cfca5 ("nfp: flower: refactor shared ip header in match offload")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c |   28 +++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -375,13 +375,29 @@ nfp_flower_calculate_key_layers(struct n
 		    !(tcp_flags & (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST)))
 			return -EOPNOTSUPP;
 
-		/* We need to store TCP flags in the IPv4 key space, thus
-		 * we need to ensure we include a IPv4 key layer if we have
-		 * not done so already.
+		/* We need to store TCP flags in the either the IPv4 or IPv6 key
+		 * space, thus we need to ensure we include a IPv4/IPv6 key
+		 * layer if we have not done so already.
 		 */
-		if (!(key_layer & NFP_FLOWER_LAYER_IPV4)) {
-			key_layer |= NFP_FLOWER_LAYER_IPV4;
-			key_size += sizeof(struct nfp_flower_ipv4);
+		if (!key_basic)
+			return -EOPNOTSUPP;
+
+		if (!(key_layer & NFP_FLOWER_LAYER_IPV4) &&
+		    !(key_layer & NFP_FLOWER_LAYER_IPV6)) {
+			switch (key_basic->n_proto) {
+			case cpu_to_be16(ETH_P_IP):
+				key_layer |= NFP_FLOWER_LAYER_IPV4;
+				key_size += sizeof(struct nfp_flower_ipv4);
+				break;
+
+			case cpu_to_be16(ETH_P_IPV6):
+				key_layer |= NFP_FLOWER_LAYER_IPV6;
+				key_size += sizeof(struct nfp_flower_ipv6);
+				break;
+
+			default:
+				return -EOPNOTSUPP;
+			}
 		}
 	}
 


