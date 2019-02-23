Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968020651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956485;
	bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MRe4cMZnZ3wnSe9TGjrZvQ4jy40Q2tg3TCjwzbCYMfMtgVm0cvyZA8oEgchuqusj
	 sjOQ8f337t2T4fP4gN6q5y4Ah2yIPG7SGUnBCE2V8p9UupuwpJaq5Pvd7tcr8jIjGU
	 B4IA/yiyO1U5cBzFnWxPLaQa37l4YzwOmI/Qa45U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfBWVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfBWVLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD812085A;
        Sat, 23 Feb 2019 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956269;
        bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWGahNSq3PrdCVMz76ipZWrBJMrJVkXOohLGUWjFYTd/wW67PFRFiHS00hY2I5Xge
         mT7hrQzxKk5jE6U9qgx3VDNrSX8oElXw5TbxZpmszzspe9gnQ6cIVMTO0WNxoePtcd
         6BBOLAsnh8lzyefWM03yWbexFGslISFoq9L71pCo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 12/26] net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case
Date:   Sat, 23 Feb 2019 16:10:33 -0500
Message-Id: <20190223211047.202725-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomonori Sakita <tomonori.sakita@sord.co.jp>

[ Upstream commit 6571ebce112a21ec9be68ef2f53b96fcd41fd81b ]

If fill_level was not zero and status was not BUSY,
result of "tx_prod - tx_cons - inuse" might be zero.
Subtracting 1 unconditionally results invalid negative return value
on this case.
Make sure not to return an negative value.

Signed-off-by: Tomonori Sakita <tomonori.sakita@sord.co.jp>
Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Reviewed-by: Dalon L Westergreen <dalon.westergreen@linux.intel.com>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/altera/altera_msgdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_msgdma.c b/drivers/net/ethernet/altera/altera_msgdma.c
index 0fb986ba32905..0ae723f753417 100644
--- a/drivers/net/ethernet/altera/altera_msgdma.c
+++ b/drivers/net/ethernet/altera/altera_msgdma.c
@@ -145,7 +145,8 @@ u32 msgdma_tx_completions(struct altera_tse_private *priv)
 			& 0xffff;
 
 	if (inuse) { /* Tx FIFO is not empty */
-		ready = priv->tx_prod - priv->tx_cons - inuse - 1;
+		ready = max_t(int,
+			      priv->tx_prod - priv->tx_cons - inuse - 1, 0);
 	} else {
 		/* Check for buffered last packet */
 		status = csrrd32(priv->tx_dma_csr, msgdma_csroffs(status));
-- 
2.19.1

