Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeBFVUk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:20:40 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39697 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeBFVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:20:36 -0500
X-Google-Smtp-Source: AH8x227kI1YlKOPvJ92M+/h2rwAEJBAKeEIPPt2z8d6B5L2BNbbmpFlo6KsvpRfbLuKM1+BLKF6n3Q==
From: Artem Savkov <artem.savkov@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Artem Savkov <artem.savkov@gmail.com>
Subject: [PATCH 2/2] sun4i_ss_prng: convert lock to _bh in sun4i_ss_prng_generate
Date: Tue,  6 Feb 2018 22:20:22 +0100
Message-Id: <20180206212022.1309-3-artem.savkov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep detects a possible deadlock in sun4i_ss_prng_generate() and
throws an "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage" warning.
Disabling softirqs to fix this.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
index 5754e0b92fb0..63d636424161 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -28,7 +28,7 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	algt = container_of(alg, struct sun4i_ss_alg_template, alg.rng);
 	ss = algt->ss;
 
-	spin_lock(&ss->slock);
+	spin_lock_bh(&ss->slock);
 
 	writel(mode, ss->base + SS_CTL);
 
@@ -51,6 +51,6 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 	}
 
 	writel(0, ss->base + SS_CTL);
-	spin_unlock(&ss->slock);
+	spin_unlock_bh(&ss->slock);
 	return 0;
 }
-- 
2.15.1
