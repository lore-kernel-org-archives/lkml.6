Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeCROuq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 10:50:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35099 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbeCROuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 10:50:44 -0400
X-Google-Smtp-Source: AG47ELus692KsFo/FfStJoEA1tyhIYyfHxs9UFW6d5LzkLCP97K7bBGi4UzsVC98cRbJX9jegNnZgw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: george.cherian@cavium.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] crypto: cavium: cpt: Replace mdelay with msleep in cpt_device_init
Date: Sun, 18 Mar 2018 22:50:38 +0800
Message-Id: <1521384638-23251-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpt_device_init() is never called in atomic context.

The call chain ending up at cpt_device_init() is:
[1] cpt_device_init() <- cpt_probe()
cpt_probe() is only set as ".probe" in pci_driver structure 
"cpt_pci_driver".

Despite never getting called from atomic context, cpt_device_init() calls
mdelay(100), i.e. busy wait for 100ms.
That is not necessary and can be replaced with msleep to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 34a6d8b..06ad85a 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -436,7 +436,7 @@ static int cpt_device_init(struct cpt_device *cpt)
 
 	/* Reset the PF when probed first */
 	cpt_reset(cpt);
-	mdelay(100);
+	msleep(100);
 
 	/*Check BIST status*/
 	bist = (u64)cpt_check_bist_status(cpt);
-- 
1.9.1
