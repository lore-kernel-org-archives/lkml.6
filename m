Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1EC2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498510;
	bh=LM2wCxlf4UpIdBw2ar0TYyrL5VSYNRHG+HFoNOeRpvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlzUPBAmGvrTufeVJUsSwvmqEFPw8rGlqfecWDoCz2toIRDiVrtsfDDa6pXRFkVFq
	 DESLLOK0jIf1b1OMIP71lgYQbnh255A2WOxEgLJqp5Mb+jqNFRRi4Am4K3UtnieYDg
	 kCmnYqLy2WXlegPp8fyR6JskyDTbzM3OQbWTO46A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfBROBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389163AbfBROBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1902070D;
        Mon, 18 Feb 2019 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498506;
        bh=LM2wCxlf4UpIdBw2ar0TYyrL5VSYNRHG+HFoNOeRpvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7MuOqUxbquPXSahCm7pvdA2Mc8dmnkRACEmNNT7QV+dBRYizHSaUx3jWrhoNxDLW
         O9DNKoiOzY9HpSqRxEPh+dw8kA6hvc/bbVhLegEPfEe+XAlbqMlayo0FAyp0WSPQ+O
         R5nIXFcTxf7YLebpobi+hDcp67uYaxJiOPAYXhJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 031/143] sata_rcar: fix deferred probing
Date:   Mon, 18 Feb 2019 14:42:39 +0100
Message-Id: <20190218133530.279071045@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9f83cfdb1ace3ef268ecc6fda50058d2ec37d603 ]

The driver overrides the error codes returned by platform_get_irq() to
-EINVAL, so if it returns -EPROBE_DEFER, the driver would fail the probe
permanently instead of the deferred probing. Switch to propagating the
error code upstream, still checking/overriding IRQ0 as libata regards it
as "no IRQ" (thus polling) anyway...

Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 8804127b108c..21b80f5ee092 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -875,7 +875,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
+		return irq;
+	if (!irq)
 		return -EINVAL;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sata_rcar_priv),
-- 
2.19.1



