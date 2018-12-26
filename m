Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF26C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE842171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKYqIJKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeLZNzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:55:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37420 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:55:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so7610087pgb.4;
        Wed, 26 Dec 2018 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Zz16nfT58+XQAHXbGtWdJkBNWf1Jd/OYxpOKCSmJMg=;
        b=LKYqIJKyNKfkqCzs9h46JLq0ftiFFtRumRQo+2D1tJfc/HVzFFtIew5mkZI6nohLZu
         hSUpBjW9h9NnUjSd5MRLq2hdWmaIFBmBXYyeZOsdyl9vDPD9v08sgGZQIzDrc29virs8
         VlSHfZ/vGT77Sgb8wDs/z2JFAgGDUO7rVNEOm6is2A4lzrNfiBlytsjHahxSakWQ3Q/r
         j9VleG6o7u4pQcIqSaxBH/StrafRuMHslc2sDtY8uy+gqlJU8HJBu1FCPkPVelYl7iXO
         Dv7KCEsLVp+Al0QWpwjWjiUFHw71mstaYC1OToMf0LgO9QCMosFAokAoxS/Vw4fkkss4
         U1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Zz16nfT58+XQAHXbGtWdJkBNWf1Jd/OYxpOKCSmJMg=;
        b=nAHJHwDA1ycy/41iiKLllrjR+P1MdeyFk9Al0IgORIVvqhFt/Xv9KudOBS538lCnjz
         VhpUqS0wu9l++WSSItA9aqplVmYSEq7h5fDe2sPxuWCP9JqcMDGhdTVqlZSzZ0rPZJwC
         +q4LGxxL3i95zNaJvP5fybvNdodmUmjD+JMrAFVKzeEoMfMKmREEeAkk1Rv0gUVfMRJZ
         8moB+i/ZQ3j1xv90UOEnQ5IEZAy74J4RA2GdNt3j8WtMXe7IQJtMqQ0edxtOA8VLLp2I
         JPhdZu4XUPJ0sfWOM4yVuYgfuRbVIP5YnnOcVq8Dy9mUJtnjQm+TJfw6gQcRH1awcEhy
         RBnQ==
X-Gm-Message-State: AJcUukfkcH4S6rtcA1w8hSqnzHpUxaAkxfWf3bprIAK9nQrBWdYeBqaV
        E0w4KscUjwyIGqjjsM6AVTQ=
X-Google-Smtp-Source: ALg8bN5n8c6I0v108i9fF1qEo5zCn37vdEl0XaI2Jj7NXM4rmn0f2RpEsUJUIfgkQv/KPtu+QoCZBQ==
X-Received: by 2002:a63:2263:: with SMTP id t35mr18970388pgm.69.1545832512792;
        Wed, 26 Dec 2018 05:55:12 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 125sm70514701pfx.159.2018.12.26.05.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:55:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: imx6sx: fix refcount leak in imx6sx_clocks_init()
Date:   Wed, 26 Dec 2018 08:55:10 -0500
Message-Id: <20181226135510.5862-1-tiny.windzz@gmail.com>
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
 drivers/clk/imx/clk-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 18527a335ace..91558b09bf9e 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -151,6 +151,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX6SX_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 	clks[IMX6SX_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-- 
2.17.0

