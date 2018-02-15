Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427223AbeBORUp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:20:45 -0500
Received: from muru.com ([72.249.23.125]:57172 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422692AbeBORUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:20:42 -0500
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: Fix checking of no-reset-on-init quirk
Date: Thu, 15 Feb 2018 09:20:36 -0800
Message-Id: <20180215172036.31938-1-tony@atomide.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently only checking for the first entry in the table while
we should check them all. Usual no-idle-on-init is together with
no-reset-on-init, so this has gone unnoticed.

Fixes: 566a9b05e1fa ("bus: ti-sysc: Handle module quirks based dts
configuration")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -630,7 +630,7 @@ static int sysc_init_dts_quirks(struct sysc *ddata)
 	for (i = 0; i < ARRAY_SIZE(sysc_dts_quirks); i++) {
 		prop = of_get_property(np, sysc_dts_quirks[i].name, &len);
 		if (!prop)
-			break;
+			continue;
 
 		ddata->cfg.quirks |= sysc_dts_quirks[i].mask;
 	}
-- 
2.16.1
