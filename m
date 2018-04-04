Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDDMOB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:14:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDDMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:13:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Ahern <dsa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netdevsim: remove incorrect __net_initdata annotations
Date: Wed,  4 Apr 2018 14:12:39 +0200
Message-Id: <20180404121347.3089169-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Y4w8IFzZwUpl/UV/uL6Tvw9mOfu2Nor5UtXMOVRM+T/GH0x4rUZ
 31jJ+G4ptHx8yMiNOBplQY8tqq9QDtp67VJ0IMBYxK8pYwFaWwb2ocOVtgx6+flueSs5rWg
 wVkfGWltato/f26ryZiZWb94mrhC8RulvzLUH+LztyDy1TFKEbp1+T4BjSGPKancUYgk5LV
 YtmFLSUZt1Bzy+z2ZI+DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9o51JnehvP0=:pxkzzYSKDoFt0blUl7h2dC
 eAUpnHkE9pYL7dnnDEThviUWhmBZvz2NUhONVP9TYQ4yjyx4OVc2h8rXQpIThAYWwMIqnxrY4
 nilFDgeQHGsdQWKEkgFa4/BG+f8Rr0r/9nn2QjI9OGAwv0Zp9cELe818vZesuMWDswP4RHYSY
 4cbegllu5WnTIBdTk95kaJ2p3mmdG2ebMAGgMsuve8Qu108AZBSSzGfimRCnd2ZubHaWNx6lA
 /l3CSFcbWhfiUWsRN8CoXLX1de0SpTMnUoOP9a+28+hLHhYf44saAkUjG627HnnzPtUI/5Rqe
 JyAeMAKx9cJPsigk2I5x8RETi6RVl9ukfSjzbhck+xKbwblRSGYMnCduovQjzMy0uC9/Lpzz5
 9D4Z/N0k1swvDY61QF/tkRoW4cW/YU5qVXF9TRUoIh61x2ExKB4/rdAZa8buuMx80QkIHonF8
 A4vZTZp5Vj70ri9Dk4T9KYziabTbGPst1ihhVn+LYtyqQxEg9N1DHA5Gp8qqxG3QXxsctEzhc
 BaeU7HCVCFdDyyn7P7EQtkCXrpsEGi24UnfbbnWroYC6COaB4Xgvrm4KpZBmxfTApAK3ExusQ
 hn8w8NeHYalScEawWCnhMKlPBfxnAOf+lnt03U+XozEYDdchbj8ocxkCso+7d74lKglp7Q8/P
 /ZeWz1uZfz+lH9orzzBt2LR3OeQVMrSKFzGADMNqZA7u9QEJIG7qJrpwp7KpAco+M5LqzuW//
 G6qIyCC6K4B8e5JVXRsHO71hKmwR3Nh03UCXkg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __net_initdata section cannot currently be used for structures that
get cleaned up in an exitcall using unregister_pernet_operations:

WARNING: vmlinux.o(.text+0x868c34): Section mismatch in reference from the function nsim_devlink_exit() to the (unknown reference) .init.data:(unknown)
The function nsim_devlink_exit() references
the (unknown reference) __initdata (unknown).
This is often because nsim_devlink_exit lacks a __initdata
annotation or the annotation of (unknown) is wrong.
WARNING: vmlinux.o(.text+0x868c64): Section mismatch in reference from the function nsim_devlink_init() to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.text+0x8692bc): Section mismatch in reference from the function nsim_fib_exit() to the (unknown reference) .init.data:(unknown)
WARNING: vmlinux.o(.text+0x869300): Section mismatch in reference from the function nsim_fib_init() to the (unknown reference) .init.data:(unknown)

As that warning tells us, discarding the structure after a module is
loaded would lead to a undefined behavior when that module is removed.

It might be possible to change that annotation so it has no effect for
loadable modules, but I have not figured out exactly how to do that, and
we want this to be fixed in -rc1.

This just removes the annotations, just like we do for all other such
modules.

Fixes: 37923ed6b8ce ("netdevsim: Add simple FIB resource controller via devlink")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/netdevsim/devlink.c | 2 +-
 drivers/net/netdevsim/fib.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/devlink.c b/drivers/net/netdevsim/devlink.c
index 27ae05c5fdaf..1dba47936456 100644
--- a/drivers/net/netdevsim/devlink.c
+++ b/drivers/net/netdevsim/devlink.c
@@ -267,7 +267,7 @@ static int __net_init nsim_devlink_netns_init(struct net *net)
 	return 0;
 }
 
-static struct pernet_operations nsim_devlink_net_ops __net_initdata = {
+static struct pernet_operations nsim_devlink_net_ops = {
 	.init = nsim_devlink_netns_init,
 	.id   = &nsim_devlink_id,
 	.size = sizeof(bool),
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 0d105bafa261..9bfe9e151e13 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -230,7 +230,7 @@ static int __net_init nsim_fib_netns_init(struct net *net)
 	return 0;
 }
 
-static struct pernet_operations nsim_fib_net_ops __net_initdata = {
+static struct pernet_operations nsim_fib_net_ops = {
 	.init = nsim_fib_netns_init,
 	.id   = &nsim_fib_net_id,
 	.size = sizeof(struct nsim_fib_data),
-- 
2.9.0
