Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74944C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956149;
	bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IfoUBWpYDAod9la0R9WMvCzNVuwmDvQHDca60EN6dex2dtFthE9xkU5r0T6N0oB7S
	 nPYQx0OTXS60sjfpWdHLxTqnuAivHoy3DvR8tOazHcPeTpXKtagN2Alg5nQDN/ALNk
	 JDF02jPPgoRCXSEZc4h6aYeU0ycYeVsGLu/ueMvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfBWVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfBWVJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:09:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C9D2085A;
        Sat, 23 Feb 2019 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956143;
        bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeW9y+Cwrwfoj2/Xa/KdFmSzQuCIww26WrgpHpYZcHER6OGZPCd3C/moVZ/y1TkU0
         HTAoLEUB9pWFG+TJNxXF8bqNyd5zK6bY0JnpyZJU2flhmKmBKKg/rBQVMJZ1Q8u5TL
         Z1R7lGEfWCkZ/0m3iSchIeWbnF8vNLktUdptb6mY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/45] net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case
Date:   Sat, 23 Feb 2019 16:08:06 -0500
Message-Id: <20190223210835.201708-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210835.201708-1-sashal@kernel.org>
References: <20190223210835.201708-1-sashal@kernel.org>
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

