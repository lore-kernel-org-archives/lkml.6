Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966795AbeEYPwk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:52:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965666AbeEYPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:52:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/exynos: fix scaler_task_done return type
Date: Fri, 25 May 2018 17:50:13 +0200
Message-Id: <20180525155030.3667352-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:IeYDxoepEF3K07loDeAEQjFUqNru020qvDEONZYRpd19ZlaZutS
 rb9//WJwk8g2uox3LQpnEX8BRpy3hHbs9FxGsOVTCiSpTC33PzsggztvP3I4gIqYVUXQli/
 uZHNxYxaoU01Agb5GnZ5vvrmzqGJs4DymfIwRJh9QcdS+fY1y5RPKnepu7Lfl7GkCRrjd5I
 4TW84NHyhbKUjHOfcatWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OgOYizXz/tU=:J07lSl1AFFN+LE2Nr8xk8z
 Kl+8woDqZHTSKs4yLZbUruY3E77F2dJZkEKxH4+/XtlhB5KpKsNEow2m6ZrR0saY35e4mnBuO
 rtSQGtLbi9zfopX/y1Sh4NRfSbeNoceN3FD261cJnJLndAu2NBMnJHAFEqj5TZOdqLav7fQ/3
 5ALAyWJAnU1iHp/df8MZagsOF/Jl3mg6OdNGr1fZkc7863Jnukfneqx6uW9WpG167q/D3RQ1S
 hKX+YCoArVD57wMNKAyjZMnRryw4t8y0hMNQ1bXWju3aJdH2pLNTwgge0+y0jQRP9p9WqkpS/
 pKQNyfJxyBaohXzcE5LhJIvGzDcBzfmcmppb7yknmddJWvF1JhLzmbZsT3womSeQSkAV/xYL/
 oEdPGmnCeDv4jlV5k+GPD/4QFyDBlhytjBHOqxsi0v63NYN0/qmuBkww+VKKr2hKDvM0n504l
 MXgUxoz9b1V002/m38XfFt+d4fxWmNkS9m8s1JMc4ZCzJ/VWAGubJ8GNyHnGXL/M3je1SE73V
 4YnTr/IcH4C67I7G1BMd4CCO8w9Hr0LwBk2NYdxrkTlZbB4kEKn/r8HfZazWSKx0Zkj1WnDbW
 jgT5lkUT4yu6ojEI5/pC0GavXJ3TCtX3xfLvE2bmRhDn5KpO6dZfmA4WYmiQfjrpryx4P9u1W
 xdE5lYVZe7FWeuiP36QlsiWOrcTy6Xv0/znTl2T+RsLDi0fthNvg/GgiWvDYgVSEZoMk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern gcc versions warn about returning a ternary operator with an 'int'
type in a function returning type 'bool':

drivers/gpu/drm/exynos/exynos_drm_scaler.c: In function 'scaler_task_done':
drivers/gpu/drm/exynos/exynos_drm_scaler.c:402:47: error: ?: using integer constants in boolean context [-Werror=int-in-bool-context]
  return val & SCALER_INT_STATUS_FRAME_END ? 0 : -EINVAL;

>From context, it becomes clear that this should have been 'int',
so I'm fixing it, along with parenthesizing the expression to make
it clearer what is meant here (I got confused at first, after seeing
the warning).

Fixes: 01fb9185dc18 ("drm/exynos: Add driver for Exynos Scaler module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 63b05b7c846a..4ad49d7782cd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -397,9 +397,9 @@ static inline u32 scaler_get_int_status(struct scaler_context *scaler)
 	return scaler_read(SCALER_INT_STATUS);
 }
 
-static inline bool scaler_task_done(u32 val)
+static inline int scaler_task_done(u32 val)
 {
-	return val & SCALER_INT_STATUS_FRAME_END ? 0 : -EINVAL;
+	return (val & SCALER_INT_STATUS_FRAME_END) ? 0 : -EINVAL;
 }
 
 static irqreturn_t scaler_irq_handler(int irq, void *arg)
-- 
2.9.0
