Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85620C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554BF21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYMxfrht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeLZNxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:53:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39416 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeLZNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:53:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so7604006pgl.6;
        Wed, 26 Dec 2018 05:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5FXaWZsMfVjfhjeSAU5ziKDkglFowmr6zU79UoVGuz0=;
        b=KYMxfrhth6JXWBRUr61nVEdxdElVrV9/GJcC46ypIDX/w5earrx2pa5KGkN+LwkEEy
         4psO0Hrhbl2zhLTbPlUovsduSe8BndtaX5w/8qj3UYTr6DcG6ezUDiTS4bPzEAgvnuqr
         X4zR0fEXPgf+OmO8IjNr7cZ/wkqv1nEyarJWH3bzN08g1VetywlwfPAoT1qCLwORzU9A
         fMtr09Q09SdqFGF6voJ1imyJiZqyqhkSQ05j+w/EMQJMGfKcc6DxOBIFf/4aNIxa5h2B
         N3lIEGgIyChdZJa4DGMVilq4+ILzf9TOj5nZOfxRBtjp4+4HhrgGum3N+7AftURLLZRw
         baBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5FXaWZsMfVjfhjeSAU5ziKDkglFowmr6zU79UoVGuz0=;
        b=C5Vwr8FuuJ7AzpAcZ8VBeeF7V0mY5EHER1PEc5oGHruGp57Eb5HgSzr/Ua2OtzsyeC
         DG4WfWEsZ108mDzWUmoSEgqqnd3sa+BaEE4emiIgCpC9ipvgLrG1E7dlM+mjFwl0Bhb4
         qHrsz/Q+qWSWJDMJla+P6QcEwiONhUWvB7TR+9wewMeRyifO4kguPghkvpX7C0GEK2Z6
         P7kcQcn3/8h/votbYNg5pjxe5oSz/sdz4ZuR+HYEyTDUrBPnYnlKqw5NWHngBdvBGXId
         oBxgC7yGJoi8cU7oNmM9n4SjU3xpeiBtt6sIqFJ4xoZo5GBDwNwye4QFQy7/v+WpZqbx
         4D2A==
X-Gm-Message-State: AJcUukdv/ru3VoopHNsFT54o64aan4mUKBlAarz82naPZi50vxyYHKcT
        rEQw8bhWBmWsmBW94Gaa6i8=
X-Google-Smtp-Source: ALg8bN5Ou+0fMbc+6GCeji2jxLv41sAd5SmTkCV9oV0PXl3I8/BgHoiqTzdGml9gPxUkTXWaAZrRmQ==
X-Received: by 2002:a63:d604:: with SMTP id q4mr18732008pgg.175.1545832382282;
        Wed, 26 Dec 2018 05:53:02 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b2sm51280777pgg.87.2018.12.26.05.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:53:01 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: imx6q: fix refcount leak in imx6q_clocks_init()
Date:   Wed, 26 Dec 2018 08:53:00 -0500
Message-Id: <20181226135300.5710-1-tiny.windzz@gmail.com>
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
 drivers/clk/imx/clk-imx6q.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bbe0c60f4d09..53617e0632a9 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -424,6 +424,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base = base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
 	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
-- 
2.17.0

