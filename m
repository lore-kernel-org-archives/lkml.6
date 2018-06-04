Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeFDVM4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:12:56 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:38818 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751213AbeFDVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:12:55 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH] gpio: Fix wrong rounding in gpio-menz127
Date: Mon, 4 Jun 2018 06:58:14 -0700
Message-ID: <20180604135814.101343-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

men_z127_debounce() tries to round up and down, but uses functions which
are only suitable when the divider is a power of two, which is not the
case. Use the appropriate ones.

Found by static check. Compile tested.

Fixes: f436bc2726c64 ("gpio: add driver for MEN 16Z127 GPIO controller")

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/gpio/gpio-menz127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index e1037582e34d..b2635326546e 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -56,9 +56,9 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 		rnd = fls(debounce) - 1;
 
 		if (rnd && (debounce & BIT(rnd - 1)))
-			debounce = round_up(debounce, MEN_Z127_DB_MIN_US);
+			debounce = roundup(debounce, MEN_Z127_DB_MIN_US);
 		else
-			debounce = round_down(debounce, MEN_Z127_DB_MIN_US);
+			debounce = rounddown(debounce, MEN_Z127_DB_MIN_US);
 
 		if (debounce > MEN_Z127_DB_MAX_US)
 			debounce = MEN_Z127_DB_MAX_US;
-- 
2.17.0
