Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeA3X0g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:26:36 -0500
Received: from home.keithp.com ([63.227.221.253]:56006 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753338AbeA3X0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:26:35 -0500
From: Keith Packard <keithp@keithp.com>
To: linux-kernel@vger.kernel.org
Cc: Keith Packard <keithp@keithp.com>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] hwrng: Explicitly drop current_rng when unregistering rng device
Date: Tue, 30 Jan 2018 15:26:27 -0800
Message-Id: <20180130232627.3014-1-keithp@keithp.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the currently in-use hw rng is being removed from the system,
explicitly drop it before using enable_best_rng as enable_best_rng
will not do anything if the list of avaialble RNGs is empty.

Without this, the last RNG removed from the system will never get
cleaned up and hwrng_unregister will hang.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 drivers/char/hw_random/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 657b8770b6b9..8df3f9f147e2 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -515,8 +515,10 @@ void hwrng_unregister(struct hwrng *rng)
 	mutex_lock(&rng_mutex);
 
 	list_del(&rng->list);
-	if (current_rng == rng)
+	if (current_rng == rng) {
+		drop_current_rng();
 		enable_best_rng();
+	}
 
 	if (list_empty(&rng_list)) {
 		mutex_unlock(&rng_mutex);
-- 
2.15.1
