Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BE92086A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956055;
	bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnb4r/zmjvNj1hXhaimoFuUurmDgSWSJy+kZmnfNg452d6f0jaV8HtbZw6UZ0ggxe
	 T0ZMzrmYbetakLRlaUTZz2rMJINK7Ld18q7BdGdqZqc/aw/A/4r3qSldwg8LVNFY0H
	 Q5kmhHi1IZkS4kMz1lp0PMZ/N7p5kLTEma0W+qOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfBWVHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfBWVH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0FB520855;
        Sat, 23 Feb 2019 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956048;
        bh=0SeNmAA7hH0M4ARlqj/TFjRbHU1OUisX6F8lskq7uBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBskbpq39zidM8E0+N/JKk4Abs3cX4YVdE48wcbX5hyUJS+36hznBwuYGeVI8auNl
         +2/GF4Ec3YDEsj2hjUvK3mgf182mX2TkjAf2WWLb2qIEbJ74nbu+WaFrhKLVTQumIV
         wrmG5ViqrFImsSEj2o4Z6BEf79SezrXNtZijyj9c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomonori Sakita <tomonori.sakita@sord.co.jp>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/65] net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case
Date:   Sat, 23 Feb 2019 16:06:03 -0500
Message-Id: <20190223210640.200911-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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

