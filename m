Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBDW21 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 17:28:27 -0500
Received: from ozlabs.org ([103.22.144.67]:59683 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeBDW2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 17:28:21 -0500
Date: Mon, 5 Feb 2018 09:28:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build failure in Linus' tree
Message-ID: <20180205092818.5ba62766@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just building you tree, today's linux-next build (arm multi_v7_defconfig)
failed like this:

drivers/usb/host/ehci-st.c: In function 'st_ehci_suspend':
drivers/usb/host/ehci-st.c:300:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_sleep_state(dev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/usb/host/ehci-st.c: In function 'st_ehci_resume':
drivers/usb/host/ehci-st.c:312:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_default_state(dev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  23c35f48f5fb ("pinctrl: remove include file from <linux/device.h>")

I have added teh following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 Feb 2018 09:24:30 +1100
Subject: [PATCH] pinctrl: files should directly include apis they use

Fixes: 23c35f48f5fb ("pinctrl: remove include file from <linux/device.h>")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/usb/host/ehci-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index 3c1362ab70be..dc42981047c9 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -23,6 +23,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "ehci.h"
 
-- 
2.15.1

-- 
Cheers,
Stephen Rothwell
