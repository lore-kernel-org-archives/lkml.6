Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030323AbeEYVMF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:12:05 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030215AbeEYVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:12:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memory: tegra: include linux/spinlock.h
Date: Fri, 25 May 2018 23:11:39 +0200
Message-Id: <20180525211155.1928474-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:bP0TGfcS6XVBn7/ubog0PrLggysZXM841KRYrrWvfAG3EZRx1yx
 ea983Az+LxD50F2aTI03E++Xmj24oIDqJ88olnJioATKiTnvvNxVJB4b8hDJqNCHiMOKlZ3
 DArAzCFgHrIMZYTRl6HZh4qqYN4oNg0Jql7Q+PNiscLho4LHoRPit0qGEwQbbnQjtDZwu6p
 cx0H22XHHA6HUfwBCqOJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NZb1dFA3uWk=:uo4mJl76VhjeYcGE8h+nfh
 9KjBLhhhhy43xRyQbes9BnzHLfyBENw9t1JVwS0lq93lwbsq4cShHlDfc6/ayaG9E0yq2bql0
 7eirGviAWo2DYMrbSAi0VlV36Hky5lNdzdXxAI7TxEOkDdIZVzhdfE3sWW3r46si6O92dWZyZ
 VGT5Ohh4Uuk/VlMmC3vFn9iWP7fHZXZAzd+9HvVortNQIxl8Li+1f3LaOnPopJdlsyDR5zqIo
 pRR03oprFA/IDeVUSsFdnoPpJm2Us+wp0EqMqtZYDrDzv7p4n/1gMWDVjCHcwojJ5lLCwohZ8
 7VKXLxIWIwcfWKiRMZqkK2N3jFESr09Yk2kI2ojADYZFe4ruW+sZdYYyQ8cEe5+GmTyKW9OIH
 JdsTxtOltzfvFadbIHqR0Nqhw0n5gJ5+WZ4amvvQlMSljvSZN+pM4beI/bYvtzqMr8p34Tpez
 AOrqER+HmGgXtiggOh3kH8BAKNmm/9Us1HVbm729UljNCSd2C3C8Jq6t8zTldfE7wY4rPo19N
 Svlklm/dx9zt1n41K7K00Tb+ofbcMyhfZC+92cCFo+iOY7lgpeZg3Lj3cHJ9zzoyo8Sac9Eu8
 cIYunnTFG+UFOtntl/+3XdXckdZutCwCFDM4fTQUKEGv1fcTFOUuv2/m9p9EKAM1yrbmrFJFP
 uXuQyRtGejebYuIqzVIKXXRN9Jf9kxpF7rOaQxNHYw2ryw+DSJsUHcTv8ivjoUutVarQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added code in this file causes a build error unless
we include linux/spinlock.h, at least in some configurations:

In file included from drivers/memory/tegra/mc.h:15,
                 from drivers/memory/tegra/tegra20.c:11:
include/soc/tegra/mc.h:159:2: error: unknown type name 'spinlock_t'
  spinlock_t lock;
  ^~~~~~~~~~
drivers/memory/tegra/tegra20.c: In function 'terga20_mc_hotreset_assert':
drivers/memory/tegra/tegra20.c:207:2: error: implicit declaration of function 'spin_lock_irqsave'; did you mean 'arch_local_irq_save'? [-Werror=implicit-function-declaration]
  spin_lock_irqsave(&mc->lock, flags);
  ^~~~~~~~~~~~~~~~~

Fixes: cb557757e1aa ("memory: tegra: Add Tegra20 memory controller hot resets")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memory/tegra/tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index 7119e532471c..8853e21b773f 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/spinlock.h>
 #include <dt-bindings/memory/tegra20-mc.h>
 
 #include "mc.h"
-- 
2.9.0
