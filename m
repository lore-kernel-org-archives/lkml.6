Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeBVLrh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:47:37 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:45489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeBVLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:47:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_spe: include linux/vmalloc.h for vmap()
Date: Thu, 22 Feb 2018 12:47:05 +0100
Message-Id: <20180222114716.1356279-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:kDZ+7QZ7NrD/C7S2P+HPTbK/O8yThCN48zqcbkRYWFT1wzvCxal
 wXV+xQJVxflzRsNoCHJPLWnjVepmHIDcCk58ZzJfthzhJbwSAyfB+mfSVvwmcQiFNv30a0a
 xBRiVs+pl5MvnyRZuCiXQb00q9zZo4c6YsjkwD9eZTmANR3UEQ4xhqM3DMH5vtRD9AySxY7
 tqcvY3orN936w/sHs7O3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KJgSgmJCbs8=:VbO1kYaZbq1cNe8itM+SW8
 luFfFcJ7uJjnwjavLtgAN4zIcRhL7rPkDjSbml0Nr9076oNJ7M3lu3R5Qts82LkfM8bTfDB+B
 Ih0UOLAHvIjP1Cu3k8Ard73QyltRC7jFc4jRZzFMEwxxj7WxP8ywN0jFVZFglk1LJF+PphF9P
 OIpCcS1u4aL7UAmNMAaYSKHYpHcaSetcGoh7CUifNoW0gyZ8j3uLCG0Gef0n6qLghvoJ5qX/z
 FdyykW817Y7w8+EF3eeMlhK+IzzA9ERXF7Voz+pe1heB+oppiyuNd97oAqGcgB0GrEn79bCES
 CgauwLpWOLMaBlBauT03HirsJy4LsWzIK4px5kteJI5mcw7e+kGVi4rgw8WxfveVDijtRyY/K
 jqOLLa327KeiRaE9BmUIbHL+mGJONJPYG0hnsiUlDlu+pNn6SSQAGGxqrV9dmkFMh2D5NXDuk
 icZFfanYiCmHrGtsBfv+5Ud0xy+/kv3wGGLed/l/FqV4BGRuUaGF6FfKTPAck3eKbVvMPVOyr
 cz7lNhFLYek4mwce8hTdXC+XFOwZ6ET+PfLF24cuY4wkOUoSmWCGM2zyH/uKWS8NGi/kFPDDn
 X6EWSNW6ABGjJoP8DUUwYlMVQzkR7CU/rHgBxyVBzRwB8fyWiep6w/iZAtA9vJgXnez/WljfU
 DQlvxitdEP8IXfP/229VOZjYgVOxEFlZ63M/76gGvXdS8vNNyAlEV16KjCCttfye/g+yG1Vtv
 NAyFA/qb6juU5RqXIKJWEFlzc3BCk1czzO141Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-next, I get a build failure in some configurations:

drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_setup_aux':
drivers/perf/arm_spe_pmu.c:857:14: error: implicit declaration of function 'vmap'; did you mean 'swap'? [-Werror=implicit-function-declaration]
  buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
              ^~~~
              swap
drivers/perf/arm_spe_pmu.c:857:37: error: 'VM_MAP' undeclared (first use in this function); did you mean 'VM_MPX'?
  buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
                                     ^~~~~~
                                     VM_MPX
drivers/perf/arm_spe_pmu.c:857:37: note: each undeclared identifier is reported only once for each function it appears in
drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_free_aux':
drivers/perf/arm_spe_pmu.c:878:2: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]

vmap() is declared in linux/vmalloc.h, so we should include that header file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have not bisected what caused this problem, presumably some other
header stopped including vmlinux.h.
---
 drivers/perf/arm_spe_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 51b40aecb776..f90672516ada 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 #include <asm/sysreg.h>
 
-- 
2.9.0
