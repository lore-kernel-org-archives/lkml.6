Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B774EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8665F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865138;
	bh=lWJX2kqpTJC6wrycR+IORMmkiC7FZ6ONK4+wk/m7V+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGMPvOTIgMwfX1fWElKwtTjUXFCnhxGOLhN/sHEjYP3re3sLno5yuAD3AaMuv6cuj
	 a5sux3ELEGO2+PBiAYJXKsFyeVo04aFfGg4e3gYCpSijGzah4ro0kHTFBr2u2Fhfdz
	 IIs1bwC5HZqQMCX7LscpBEOCaZ9RxllZVoDElheo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbeLZW64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbeLZW5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC8A20651;
        Wed, 26 Dec 2018 22:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865033;
        bh=lWJX2kqpTJC6wrycR+IORMmkiC7FZ6ONK4+wk/m7V+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZl7v5r3FqlRS7mq43KAP6CpkKeZgJ76cKYNTVQAjCXLtTMEMTjU853PWoBmpL0n/
         EWKUqNYxM4jbMXChG0ULv+JpWMcX/b/waqbDVfUJHtFINRUBav3CaAEAwfvLKtvxUY
         +Ldqdb0BpFu6oBmAl9yriOKepUZhfl01pd6Dih30=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 09/21] bnx2x: Clear fip MAC when fcoe offload support is disabled
Date:   Wed, 26 Dec 2018 17:54:47 -0500
Message-Id: <20181226225501.151365-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

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
index 403fa8d98aa3..7f07999b3561 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -11679,8 +11679,10 @@ static void bnx2x_get_fcoe_info(struct bnx2x *bp)
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

