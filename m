Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424709AbeE1LQg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424670AbeE1LQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 238/272] hwrng: bcm2835 - Handle deferred clock properly
Date: Mon, 28 May 2018 12:04:31 +0200
Message-Id: <20180528100300.334492143@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 7b4c5d30d0bd2b22c09d4d993a76e0973a873891 ]

In case the probe of the clock is deferred, we would assume it is
optional. This is wrong, so defer the probe of this driver until
the clock is available.

Fixes: 791af4f4907a ("hwrng: bcm2835 - Manage an optional clock")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hw_random/bcm2835-rng.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -163,6 +163,8 @@ static int bcm2835_rng_probe(struct plat
 
 	/* Clock is optional on most platforms */
 	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk) && PTR_ERR(priv->clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	priv->rng.name = pdev->name;
 	priv->rng.init = bcm2835_rng_init;
