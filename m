Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeE0VnD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:43:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeE0VnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:43:02 -0400
From: Colin King <colin.king@canonical.com>
To: David Airlie <airlied@linux.ie>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Hans Verkuil <hans.verkuil@cisco.com>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i2c: tda9950: fix timeout counter check
Date: Sun, 27 May 2018 22:42:55 +0100
Message-Id: <20180527214255.24473-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check to see if the timeout has reached zero is incorrect
and the check is instead checking if the timeout is non-zero and not
zero, hence it will break out of the loop on the first iteration and
the msleep is never executed.  Fix this by breaking from the loop when
timeout is zero.

Detected by CoverityScan, CID#1469404 ("Logically Dead Code")

Fixes: f0316f93897c ("drm/i2c: tda9950: add CEC driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i2c/tda9950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 3f7396caad48..f2186409f0cf 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -307,7 +307,7 @@ static void tda9950_release(struct tda9950_priv *priv)
 	/* Wait up to .5s for it to signal non-busy */
 	do {
 		csr = tda9950_read(client, REG_CSR);
-		if (!(csr & CSR_BUSY) || --timeout)
+		if (!(csr & CSR_BUSY) || !--timeout)
 			break;
 		msleep(10);
 	} while (1);
-- 
2.17.0
