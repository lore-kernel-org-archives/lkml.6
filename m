Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422788AbeE1LB4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164868AbeE1LBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:01:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lionel Debieve <lionel.debieve@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 449/496] hwrng: stm32 - add reset during probe
Date: Mon, 28 May 2018 12:03:54 +0200
Message-Id: <20180528100338.807420884@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "lionel.debieve@st.com" <lionel.debieve@st.com>

[ Upstream commit 326ed382256475aa4b8b7eae8a2f60689fd25e78 ]

Avoid issue when probing the RNG without
reset if bad status has been detected previously

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hw_random/stm32-rng.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #define RNG_CR 0x00
@@ -46,6 +47,7 @@ struct stm32_rng_private {
 	struct hwrng rng;
 	void __iomem *base;
 	struct clk *clk;
+	struct reset_control *rst;
 };
 
 static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
@@ -140,6 +142,13 @@ static int stm32_rng_probe(struct platfo
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	priv->rst = devm_reset_control_get(&ofdev->dev, NULL);
+	if (!IS_ERR(priv->rst)) {
+		reset_control_assert(priv->rst);
+		udelay(2);
+		reset_control_deassert(priv->rst);
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	priv->rng.name = dev_driver_string(dev),
