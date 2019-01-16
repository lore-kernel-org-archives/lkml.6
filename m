Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73670C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ECE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfAPS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:56:02 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:56268 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfAPS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:56:02 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id DC09EB00583;
        Wed, 16 Jan 2019 19:55:52 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 1/6] spi: bitbang: Don't call chipselect() in spi_bitbang_setup()
Date:   Wed, 16 Jan 2019 19:55:44 +0100
Message-Id: <20190116185549.23295-1-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_setup() already call spi_set_cs() right after calling the
controller setup method, so there is no need for the bitbang driver to
do that. Because of this the chipselect() callback was confusingly
still called when CS is GPIO based.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-bitbang.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index f29176000b8d..dd9a8c54a693 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -213,19 +213,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
-	/* NOTE we _need_ to call chipselect() early, ideally with adapter
-	 * setup, unless the hardware defaults cooperate to avoid confusion
-	 * between normal (active low) and inverted chipselects.
-	 */
-
-	/* deselect chip (low or high) */
-	mutex_lock(&bitbang->lock);
-	if (!bitbang->busy) {
-		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-		ndelay(cs->nsecs);
-	}
-	mutex_unlock(&bitbang->lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_bitbang_setup);
-- 
2.19.1

