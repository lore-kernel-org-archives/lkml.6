Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D420882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763697;
	bh=Bv+4IJ9d8So1EZ8MXI4SEMWvjTA6UuanqhWsk1hlftM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrfCHMd6QOjGPRzAgJk+B1y/fbVBZiqhK4I51pK0Jhp+r5n9vj1SElmYsZMlI2OyM
	 KGmuuovigUz34OGG0yhppbIRrz1ElsaqtJaHWVGXn1Rbx3oDCh/Z01yArsX7UP+Jar
	 RO8t9DzuN29TPjTFhvYMKyqxkHn31ApR3GepMYI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfA2MIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfA2Ljj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F8420989;
        Tue, 29 Jan 2019 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761979;
        bh=Bv+4IJ9d8So1EZ8MXI4SEMWvjTA6UuanqhWsk1hlftM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4PTrmjHzFFWqofD/hdQTy2pWfOYNA81kHo2C9f38jMMiS8xvo5ltq8vEJMRW/zSr
         Aorq0IiPZng9+aHtalFK2NsrBOdYQbQRvuQ71TwPsw9DMNt5e2CptJVmzLheuI2p63
         kOJ3M8+k1U8u5Bj5MbRCJnIgqDM+og9w5uJYtrbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.20 033/117] ASoC: rt5514-spi: Fix potential NULL pointer dereference
Date:   Tue, 29 Jan 2019 12:34:44 +0100
Message-Id: <20190129113209.282770984@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 060d0bf491874daece47053c4e1fb0489eb867d2 upstream.

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on rt5514_dsp.

This issue was detected with the help of Coccinelle.

Fixes: 6eebf35b0e4a ("ASoC: rt5514: add rt5514 SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5514-spi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -280,6 +280,8 @@ static int rt5514_spi_pcm_probe(struct s
 
 	rt5514_dsp = devm_kzalloc(component->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
+	if (!rt5514_dsp)
+		return -ENOMEM;
 
 	rt5514_dsp->dev = &rt5514_spi->dev;
 	mutex_init(&rt5514_dsp->dma_lock);


