Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532FAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FB2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762660;
	bh=TjZ24ny6NsEvDDKiQ3aauAMUg2qxM1x+mH0LFo9obb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tcIzgmhBlrKV4UJ5gm6K1Z47Dbgqc2pgUp2BDv3WDFBqwO1U4/cGN7cOUtZ41Q7rB
	 1150rX1ILUakty7VpqIzH7aBhbkDYk4CkGSLgrvN0XwMxsQiZNHTbYZFMY9o5lEXbi
	 Xo3UJtCparmJWdBJpgYi1dEQ9KlDYPvGPC5QZOf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfA2Lu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731739AbfA2Lux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506492083B;
        Tue, 29 Jan 2019 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762652;
        bh=TjZ24ny6NsEvDDKiQ3aauAMUg2qxM1x+mH0LFo9obb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4yY7EqkWEbXdwE5ZOb3KwR/fpqMslK5aup2HZg6P0EIQsGmodalIhUSFG6SkEf4B
         goxkJOCBvYdT6AUhyJTpguFyetXMKPBY/JTFLZF39MvE/3Dr4Z7vL2osmiAW/5/ZdW
         jRDZgYvSbt/rq3uELANNTulrAUHv1fmDFp6469Y4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 12/44] ASoC: rt5514-spi: Fix potential NULL pointer dereference
Date:   Tue, 29 Jan 2019 12:36:07 +0100
Message-Id: <20190129113141.062080611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -253,6 +253,8 @@ static int rt5514_spi_pcm_probe(struct s
 
 	rt5514_dsp = devm_kzalloc(platform->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
+	if (!rt5514_dsp)
+		return -ENOMEM;
 
 	rt5514_dsp->dev = &rt5514_spi->dev;
 	mutex_init(&rt5514_dsp->dma_lock);


