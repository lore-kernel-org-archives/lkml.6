Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeDKDdt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:33:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45497 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKDdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:33:44 -0400
X-Google-Smtp-Source: AIpwx48ABltSZ8xU5JbaV56YgeGP/vDhb/ofSkokgkXYd6cpUH/u8niKKCOqWLT74gDx0z5VKBJ5fA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: isdn@linux-pingi.de, davem@davemloft.net, johannes.berg@intel.com,
        arvind.yadav.cs@gmail.com, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] isdn: hisax_fcpcipnp: Replace mdelay with usleep_range in fcpci_init
Date: Wed, 11 Apr 2018 11:33:37 +0800
Message-Id: <1523417617-3249-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fcpci_init() is never called in atomic context.

The call chain ending up at fcpci_init() is:
[1] fcpci_init() <- fcpcipnp_setup() <- fcpnp_probe()

fcpnp_probe() is set as ".probe" in struct pnp_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, fcpci_init()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hisax/hisax_fcpcipnp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
index e4f7573..4789c9d 100644
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c
@@ -706,7 +706,7 @@ static inline void fcpci_init(struct fritz_adapter *adapter)
 
 	outb(AVM_STATUS1_ENA_IOM | adapter->irq,
 	     adapter->io + AVM_STATUS1);
-	mdelay(10);
+	usleep_range(10000, 11000);
 }
 
 // ----------------------------------------------------------------------
-- 
1.9.1
