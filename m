Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeDJOWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:22:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42450 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeDJOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:22:42 -0400
X-Google-Smtp-Source: AIpwx4+SvGOcwf7P2/XT7gitOvb4wKZ6urfD36KIpbKHnAvG2iYL0nV1T29BeGI2+RToxbzPn6zASA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: sbni: Replace mdelay with msleep in sbni_probe1
Date: Tue, 10 Apr 2018 22:22:33 +0800
Message-Id: <1523370153-32354-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbni_probe1() is never called in atomic context.

The call chains ending up at sbni_probe1() are:
[1] sbni_probe1() <- sbni_init() <- sbni_probe() <- net_olddevs_init()
[2] sbni_probe1() <- sbni_isa_probe() <- sbni_init() <- 
	sbni_probe() <- net_olddevs_init()
[3] sbni_probe1() <- sbni_pci_probe() <- sbni_init() <- 
	sbni_probe() <- net_olddevs_init()

net_olddevs_init() is set as a parameter of device_initcall().
This function is not called in atomic context.

Despite never getting called from atomic context, sbni_probe1()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wan/sbni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/sbni.c b/drivers/net/wan/sbni.c
index bde8c03..b7dd665 100644
--- a/drivers/net/wan/sbni.c
+++ b/drivers/net/wan/sbni.c
@@ -361,7 +361,7 @@ static int __init sbni_init(struct net_device *dev)
 		irq_mask = probe_irq_on();
 		outb( EN_INT | TR_REQ, ioaddr + CSR0 );
 		outb( PR_RES, ioaddr + CSR1 );
-		mdelay(50);
+		msleep(50);
 		irq = probe_irq_off(irq_mask);
 		outb( 0, ioaddr + CSR0 );
 
-- 
1.9.1
