Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162288AbeBNSqD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:46:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162120AbeBNSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:46:02 -0500
From: Colin King <colin.king@canonical.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: make const arrays int_reg static, shrinks object size
Date: Wed, 14 Feb 2018 18:45:59 +0000
Message-Id: <20180214184559.8616-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const read-only arrays int_reg on the stack but instead
make them static. Makes the object code smaller by over 80 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  28024	   8936	    192	  37152	   9120	drivers/gpu/ipu-v3/ipu-common.o

After:
   text	   data	    bss	    dec	    hex	filename
  27794	   9080	    192	  37066	   90ca	drivers/gpu/ipu-v3/ipu-common.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 658fa2d3e40c..48685cddbad1 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1089,7 +1089,7 @@ static void ipu_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
+	static const int int_reg[] = { 0, 1, 2, 3, 10, 11, 12, 13, 14};
 
 	chained_irq_enter(chip, desc);
 
@@ -1102,7 +1102,7 @@ static void ipu_err_irq_handler(struct irq_desc *desc)
 {
 	struct ipu_soc *ipu = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	const int int_reg[] = { 4, 5, 8, 9};
+	static const int int_reg[] = { 4, 5, 8, 9};
 
 	chained_irq_enter(chip, desc);
 
-- 
2.15.1
