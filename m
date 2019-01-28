Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F732C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ABB20811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693440;
	bh=AQ6wOpX14TvRnGOBRNTzc0hVSVjFhi5IcEp4dTRuJKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StGaIEugL7NfV4Bd3E2kZRlAKkWbu2MtPC4zR9kdb3FcKMrS4AHmGXnLQJEysTmoq
	 9/1zmMJts4XNTecr4qfGxPb1fdwHZnilKWbngmBsRilmvR9ZPvIfQckP1i0+m7ULEe
	 71ppwWefHNzvdBtKTo9g8lKEAxNNSeimXuacISbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbfA1QZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389814AbfA1QZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:25:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D282173C;
        Mon, 28 Jan 2019 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692701;
        bh=AQ6wOpX14TvRnGOBRNTzc0hVSVjFhi5IcEp4dTRuJKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RB9M7ajwfD8FAswQr34b/FvM3t6yDkqQZKGDA+J6VA9KH0FKy05F4I9wj29Ouz57p
         e/VSWO4XC6s5mNETcUPIck//nJofsC2/hE82p4v/R5/tZOmPAEUTOlVrC6MnD9KMiL
         aqEi9q5AcJr4n1jDpXlIgRswF+N7ByXyBmNSHKBA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 36/80] sata_rcar: fix deferred probing
Date:   Mon, 28 Jan 2019 11:23:17 -0500
Message-Id: <20190128162401.58841-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

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

