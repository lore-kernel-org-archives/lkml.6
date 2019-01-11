Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429C2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216319;
	bh=xk6sFxtVy1X01Qsq9hSE8m0dNfjWI3QMkYpgtRqB+Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GFtYDO8shZOCepUBzgbMXG/9pFHNTaTzhFkNU9yZrYK4xzD3HvWNWREd0LrMMqx/e
	 Oywg0Cv+WvS4Vq7RKotxQHX3dWtiJLbFwKrgK3iFJTBml+JqzlRJ/u2gQ0qScOQljh
	 8NvJ1oBgrpYsv0uV/t7mbjTygfkqMhnxN1h7VeMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfAKOSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfAKOSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E45C21783;
        Fri, 11 Jan 2019 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216314;
        bh=xk6sFxtVy1X01Qsq9hSE8m0dNfjWI3QMkYpgtRqB+Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRTZ9o5wzTfn3Hqv0hM+QmrugtTra74weX5t9Ab482IGa1Tvf+w9d9s59Dd01Elom
         p0V+K+QYZWRk2Tbqv88oM4XeVdUsg0uS/WKvQhplo6mEKlZ7YTv1c+tRIpjgwiwtS9
         rGt4h52JDYnQ4ke7X0jfHsRpjmG+ZNmynwZ6dQjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.4 55/88] spi: bcm2835: Unbreak the build of esoteric configs
Date:   Fri, 11 Jan 2019 15:08:24 +0100
Message-Id: <20190111131054.347142784@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

From: Lukas Wunner <lukas@wunner.de>

commit 29bdedfd9cf40e59456110ca417a8cb672ac9b92 upstream.

Commit e82b0b382845 ("spi: bcm2835: Fix race on DMA termination") broke
the build with COMPILE_TEST=y on arches whose cmpxchg() requires 32-bit
operands (xtensa, older arm ISAs).

Fix by changing the dma_pending flag's type from bool to unsigned int.

Fixes: e82b0b382845 ("spi: bcm2835: Fix race on DMA termination")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -88,7 +88,7 @@ struct bcm2835_spi {
 	u8 *rx_buf;
 	int tx_len;
 	int rx_len;
-	bool dma_pending;
+	unsigned int dma_pending;
 };
 
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)


