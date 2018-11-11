Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C360C20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1JWjIEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C360C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbeKLJae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbeKLITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:43 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC696223AE;
        Sun, 11 Nov 2018 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975386;
        bh=8VxOSZ7kQEmA83ajH4y/I4L6hUIutjV2+Cwbp/+9I3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1JWjIEdEgYDNQNV+8lXbz673pa5KzNx4AKNgtzCXzmO7xpRNVkqcO9uYIc/uG2U+
         uSZTPfko8NhEXcR6PjnIPmEJSZNDcT8rrt8pP0miqLBtkjpNc6zlaTvl+klLxd5zXM
         mxHHUhOFwBkUfQ3xRJwWzQ9vWGUUh87pqa9wpGGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 064/350] net: socionext: Reset tx queue in ndo_stop
Date:   Sun, 11 Nov 2018 14:18:48 -0800
Message-Id: <20181111221709.828383838@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahisa Kojima <masahisa.kojima@linaro.org>

[ Upstream commit 8d5b0bf611ec5b7618d5b772dddc93b8afa78cb8 ]

We observed that packets and bytes count are not reset
when user performs interface down. Eventually, tx queue is
exhausted and packets will not be sent out.
To avoid this problem, resets tx queue in ndo_stop.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/socionext/netsec.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -945,6 +945,9 @@ static void netsec_uninit_pkt_dring(stru
 	dring->head = 0;
 	dring->tail = 0;
 	dring->pkt_cnt = 0;
+
+	if (id == NETSEC_RING_TX)
+		netdev_reset_queue(priv->ndev);
 }
 
 static void netsec_free_dring(struct netsec_priv *priv, int id)


