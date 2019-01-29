Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DDA2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762473;
	bh=m6QpBUREPkzhER2ZLbFNWK/Xgyy3iRQjfdvzTcQ7PdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyJGXVky6g+5Ya8qOcP8r7SKySnr7jQbzq+vxghGxnoYHEeuTz4QoWUDgbl811azB
	 Yt6l08Ercn3zRBfYj+tpBpOfaeSQupxDrGZeIrKppEjtah25+T8Qr+c4NR7/UNrxFl
	 OdKoMGRuXkdNuS+lAqFRYmbRjoiu5fMiGaVZ5gwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfA2Lrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbfA2Lru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628652083B;
        Tue, 29 Jan 2019 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762469;
        bh=m6QpBUREPkzhER2ZLbFNWK/Xgyy3iRQjfdvzTcQ7PdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUscThPqTEVyu2mHcUsjJMx+if3JUv8vfmuz6CoZe+7911QClgL+dlJq9J0NdkIpR
         db8/FGyeBer53dyI64iTPSGw6KAKVOpWAfv0GcwbHaPcivBUTF5+9Ml4tuKDf1MDPy
         vVT19rccfVroyThGEdoBAh6ND7PrL4pGlo1U0Ryg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 16/68] ASoC: rt5514-spi: Fix potential NULL pointer dereference
Date:   Tue, 29 Jan 2019 12:35:38 +0100
Message-Id: <20190129113132.886472516@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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
@@ -265,6 +265,8 @@ static int rt5514_spi_pcm_probe(struct s
 
 	rt5514_dsp = devm_kzalloc(platform->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
+	if (!rt5514_dsp)
+		return -ENOMEM;
 
 	rt5514_dsp->dev = &rt5514_spi->dev;
 	mutex_init(&rt5514_dsp->dma_lock);


