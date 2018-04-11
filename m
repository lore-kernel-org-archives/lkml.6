Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDKDeB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:34:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36262 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeDKDd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:33:59 -0400
X-Google-Smtp-Source: AIpwx4846WKyV5To7lm8OCJuyCLwlERsF/ePer2krzY/fSvKiObj5PiLAmoHp8esr4Lva7CyPMgFrQ==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: isdn@linux-pingi.de, davem@davemloft.net, stephen@networkplumber.org,
        johannes.berg@intel.com, arvind.yadav.cs@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] isdn: hisax_fcpcipnp: Replace mdelay with usleep_range in fcpcipnp_setup
Date: Wed, 11 Apr 2018 11:33:51 +0800
Message-Id: <1523417631-3295-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fcpcipnp_setup() is never called in atomic context.

The call chain ending up at fcpcipnp_setup() is:
[1] fcpcipnp_setup() <- fcpnp_probe()

fcpnp_probe() is set as ".probe" in struct pnp_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, fcpcipnp_setup()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hisax/hisax_fcpcipnp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hisax/hisax_fcpcipnp.c b/drivers/isdn/hisax/hisax_fcpcipnp.c
index e4f7573..06068a42 100644
--- a/drivers/isdn/hisax/hisax_fcpcipnp.c
+++ b/drivers/isdn/hisax/hisax_fcpcipnp.c
@@ -772,11 +772,11 @@ static int fcpcipnp_setup(struct fritz_adapter *adapter)
 
 	// Reset
 	outb(0, adapter->io + AVM_STATUS0);
-	mdelay(10);
+	usleep_range(10000, 11000);
 	outb(AVM_STATUS0_RESET, adapter->io + AVM_STATUS0);
-	mdelay(10);
+	usleep_range(10000, 11000);
 	outb(0, adapter->io + AVM_STATUS0);
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	switch (adapter->type) {
 	case AVM_FRITZ_PCIV2:
-- 
1.9.1
