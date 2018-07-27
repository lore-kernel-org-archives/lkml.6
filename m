Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F1C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D420895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166D420895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbeG0LJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeG0LJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:16 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5BC6898;
        Fri, 27 Jul 2018 09:48:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 30/66] nfp: flower: ensure dead neighbour entries are not offloaded
Date:   Fri, 27 Jul 2018 11:45:23 +0200
Message-Id: <20180727093812.547502450@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit b809ec869b2cf2af053ffd99e5a46ab600e94aa2 ]

Previously only the neighbour state was checked to decide if an offloaded
entry should be removed. However, there can be situations when the entry
is dead but still marked as valid. This can lead to dead entries not
being removed from fw tables or even incorrect data being added.

Check the entry dead bit before deciding if it should be added to or
removed from fw neighbour tables.

Fixes: 8e6a9046b66a ("nfp: flower vxlan neighbour offload")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -317,7 +317,7 @@ nfp_tun_write_neigh(struct net_device *n
 	payload.dst_ipv4 = flow->daddr;
 
 	/* If entry has expired send dst IP with all other fields 0. */
-	if (!(neigh->nud_state & NUD_VALID)) {
+	if (!(neigh->nud_state & NUD_VALID) || neigh->dead) {
 		nfp_tun_del_route_from_cache(app, payload.dst_ipv4);
 		/* Trigger ARP to verify invalid neighbour state. */
 		neigh_event_send(neigh, NULL);


