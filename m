Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277CC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD18218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUjEfuUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLZN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:59:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:59:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7897926pfi.8;
        Wed, 26 Dec 2018 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O2DVCEK/vJVB+NMtEOXLiEGoK+ETh9cQ5Byi9Hzg60c=;
        b=JUjEfuUJm1vVwV51/nZhtQW0UXpCdYDm3CccAOTt52ChVWbubwz/7Owl4/cmVtBHNH
         CoxAvOp/L7WGTfIu4I6HlLBE1OWJQ2SY5nrCQV8TvSpvpzoggNwChzYDdwT2sBwUmklJ
         7YLKgl00UbFrNMs7l43WW3bm0wJIDxUYBgRXQitItPtRdU2tAapUamXlcfPbkoXnAFXS
         aNLqKbXrRXiNguPqAlt+sj55CGR3CTF94GrMGr4PyC8GmXhTIa+RFkgjePsFs6ObMu6N
         zdDl4FMvNu0mMJ+b7WIXwYbnlvOCCK+vnCMPpLmTNO5biMsz+D31Z93sw7eDmg9wAvZ6
         102g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O2DVCEK/vJVB+NMtEOXLiEGoK+ETh9cQ5Byi9Hzg60c=;
        b=HAdJBkoDZMi8NnEnr62K1SGWNFPM9cEW08XpkC+hgquMOaCJrT0mtu9P3MSUBU/O7L
         DGh/4ovmQTtAt5TGHicCvb2Tq2TPh2rR903UGtdpTfwEKwC0OdhnE6BJss675o3Nwvky
         pozVAosqQuCExwy5uFKtpF+hnha2dTr9vbcD8T+pN4TX2w7N4bi54Muw1u4vAHsxi7pT
         7T2RQd2zCwvGK60/NDkuVexzuRkeHCptr4D73ERlMxKG5UZ9du5oEtRj26X6aJpqKabH
         7clwiNuELdFZIyz0jIJfP3ORg0aOLvvhyOC10mpt1lWQzy+qtXG4xrQ8ByPpkPGbOd1m
         LZbQ==
X-Gm-Message-State: AJcUukffWUqlMeDeaWfllWTFTIjo4uf3xk801ysaqyCI0tWRfu1HPXJP
        iXzgPI9/UgwYqKVTz1iSh3Q=
X-Google-Smtp-Source: ALg8bN4zOcEpOW1DkON5KL4ZWIHT47MFGAXjjtPbFaAvrTqM+woWuSSBdNw1BKDn/jpivWwKN5fVBA==
X-Received: by 2002:a63:e21:: with SMTP id d33mr19032559pgl.272.1545832778325;
        Wed, 26 Dec 2018 05:59:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g11sm50426381pfo.139.2018.12.26.05.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:59:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: vf610: fix refcount leak in vf610_clocks_init()
Date:   Wed, 26 Dec 2018 08:59:36 -0500
Message-Id: <20181226135936.6102-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/imx/clk-vf610.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 6dae54325a91..a334667c450a 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -203,6 +203,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-anatop");
 	anatop_base = of_iomap(np, 0);
 	BUG_ON(!anatop_base);
+	of_node_put(np);
 
 	np = ccm_node;
 	ccm_base = of_iomap(np, 0);
-- 
2.17.0

