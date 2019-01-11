Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC4E2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218987;
	bh=I325aI7M92gMHajSOAnNufpsZBCZ4yCWgSk+WygFTZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xsSWEQVJl5rFd/j+TnCCbI5gshp0uIgeMzPW0YkUn1sAi35dWBV9nDXazp6tRdZG8
	 znZJ6a9+B92NdG5Pvj5SZaizmoK01TdFCz4lTgPeE0redHFBt3jl3qtRx9wPvri7GF
	 AokYG7j35rVx+fbGepuEXIv+feL3/tnHyDi8sSJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391826AbfAKPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389115AbfAKObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A9F21841;
        Fri, 11 Jan 2019 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217069;
        bh=I325aI7M92gMHajSOAnNufpsZBCZ4yCWgSk+WygFTZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuBkWYVYkomSzpQrPfZYg5LOMoR5VdloM2R4E2hh6P15pX3io40t7Y71FDvWdRR3K
         yY3a8Hqpi7YDUkAwRckhC8CrqpAw9qoO+VLT6+0zg5ddvKPjL0zbX62MEtblFADIcP
         qkFeGG0HKo0GQQHfYENMKLoWDG8vbphk4H7WoItc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 023/105] bnx2x: Clear fip MAC when fcoe offload support is disabled
Date:   Fri, 11 Jan 2019 15:13:54 +0100
Message-Id: <20190111131105.282232427@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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
index bd3e3f080ebf..688d84cd6187 100644
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



