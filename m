Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D508C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C1421841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216848;
	bh=zXsYByoZ9HLbbr1YqMMBgDfj54EYLobaf+Cu4Xzfc0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h2RcRIZFUfcjy0IWhNQrBEBfj2e4VRwoSx3F8Trd+cnU+bd8ucjiGvPdZ4xg04Pqf
	 IeXfYfqB9ezEgRpxJv7KrLSvs1RN1/NB6SaBGg8Kk46vRRu8GdTS4nXXjTumc7txHr
	 9q4RIkS3GSHEiey/7fbB7MiawJK/QZpeb7oTzfsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbfAKO11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388089AbfAKO1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA112177B;
        Fri, 11 Jan 2019 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216845;
        bh=zXsYByoZ9HLbbr1YqMMBgDfj54EYLobaf+Cu4Xzfc0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUK+5JJ2U7bFdcB32xtxnT/ZCU0mIbRPQrZj+Knk78YBnD4GTBg7csBaezEdFjq+m
         AmK4MznWu+drZ7zw7M4aQiQF2hWuVHIViVTaUhTZD4dPeuuIAd6JWC7Q29XAxJk1H1
         XsSgxgFSL7zdByTZUzB89Zf2TKL+4pktWY7urThI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/63] bnx2x: Clear fip MAC when fcoe offload support is disabled
Date:   Fri, 11 Jan 2019 15:14:15 +0100
Message-Id: <20190111131047.997066952@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bbf666c1af916ed74795493c564df6fad462cc80 ]

On some customer setups it was observed that shmem contains a non-zero fip
MAC for 57711 which would lead to enabling of SW FCoE.
Add a software workaround to clear the bad fip mac address if no FCoE
connections are supported.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 54dab4eac804..77f53e4122c3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -11733,8 +11733,10 @@ static void bnx2x_get_fcoe_info(struct bnx2x *bp)
 	 * If maximum allowed number of connections is zero -
 	 * disable the feature.
 	 */
-	if (!bp->cnic_eth_dev.max_fcoe_conn)
+	if (!bp->cnic_eth_dev.max_fcoe_conn) {
 		bp->flags |= NO_FCOE_FLAG;
+		eth_zero_addr(bp->fip_mac);
+	}
 }
 
 static void bnx2x_get_cnic_info(struct bnx2x *bp)
-- 
2.19.1



