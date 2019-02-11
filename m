Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB4DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D579222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895344;
	bh=C7N1cyhPDUEi0fBjXBCft4Aq+RaJXqkYBHSjs/oJ+EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuS3p0KyNy9Ez9h0nvG33EzESOu7D5RQZECmGF61h2aTUaZE++oWJJ5I3xhdX7ZOf
	 6xZV92RvC9GQUGGdP3ioJqRRPbJhGbuEKFfE1spDXha8Nbq/HBMSnDG5n+dTX9mMW1
	 8+kvJr/+7t05dyq5dE/sRV+UYNm28TJeIlsMo6r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfBKO3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfBKO3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B278120675;
        Mon, 11 Feb 2019 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895339;
        bh=C7N1cyhPDUEi0fBjXBCft4Aq+RaJXqkYBHSjs/oJ+EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQxJKilcRlplApfaWQ59vGBWuuzq9rcIewHLjCbIyT4mUzXrd3C9T6hyomgz6iqcH
         y28RCh3HsVFE+yRebwwoziIOb4Fhj7W9cztdx0aXfVHzviKwxs5Kw28lZFRoXrYUU9
         oDCM9YHMliuIaT8wO4UPWIZjd9pDuzBIJrZjfE34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 145/352] sata_rcar: fix deferred probing
Date:   Mon, 11 Feb 2019 15:16:12 +0100
Message-Id: <20190211141855.786017467@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 4b1ff5bc256a..59b2317acea9 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -891,7 +891,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	int ret = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq < 0)
+		return irq;
+	if (!irq)
 		return -EINVAL;
 
 	priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
-- 
2.19.1



