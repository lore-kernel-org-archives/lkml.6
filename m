Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36092C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC648218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864855;
	bh=dIXcbOTSnnn60WUJW+t1D74SXkb5A0pNyWBAs4TXI+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sngHX+7O/X3wA4FNmTN27HhnNGZwOJ4kFt1HLHIKgb6CiCNMrhMP4VwjN2Aa/REPi
	 IdjWj3SOZmUXfwJn1NY2jPiZTnM+KKNI7HX3jVFYEYzg8UflZ0CNkEzrs61/npnTa8
	 P07ZDii1Ki7HfxCa1z6nZmJFQh9vg5JN5IZUY01o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeLZWyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbeLZWyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8672021741;
        Wed, 26 Dec 2018 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864849;
        bh=dIXcbOTSnnn60WUJW+t1D74SXkb5A0pNyWBAs4TXI+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ho2NFlkKR5buoq4xDjKYVu8kyRuDayQqWp+Ahk+hPsf3pjuFMHE19jEf9mu+BzuTr
         f5vNW7Bmhf7mwL0/UJLD1ClZ1k+xRmK6P+6WRzNrlRX77WS1n023ZN6GsnKll/kuYS
         kyP6dwNaZ7pYmnEPE04gYNv0N88DCzjG8ocl9K3Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/35] bnx2x: Clear fip MAC when fcoe offload support is disabled
Date:   Wed, 26 Dec 2018 17:41:20 -0500
Message-Id: <20181226224142.150866-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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

