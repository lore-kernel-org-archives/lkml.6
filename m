Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969190AbeE1PpO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:45:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969158AbeE1PpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:45:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
Date: Mon, 28 May 2018 17:44:36 +0200
Message-Id: <20180528154448.2494709-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:8tTZwYnTKOxDxKFq/cqYu/ayCt+lvD6f9sQsNhUkHXWMrD79pLg
 FMNFAh3m/tJ878qIHLrlk4fKgqxTFKWUKmGC5C07UqzvPa2YTHC2+uCpTvbm/B8vWJTka7S
 a582Nf2EYTI8VVrFRdbb1Wme7pqURo8HzgXDzXnKIDBGN/sytHXFrORrOSVEzYIo5OSGqrd
 ecvHHWZH7aY54pWOEjdBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:meAKAB9w3nQ=:g3a0kjw6qhE5ENi28413Uc
 I+HetbjTopr9YoPTmsj95LPZ282lKmgmwjimU1vdx7xN439oILE+EIikA1Aim70193SB2HbsR
 R0jTUZoqg/PJV3PzNNK/+H/Z+HrmTO1SWQQTYrds6ZTVNgE44fTGNGSqKosatJpLwM6vCvmMo
 UiAMyKHuri0moZFXcTVoTQEGZY8RHqOGFvaKH/BigaI2YQG2/9OoIBYBTmY2h9ug3tvCfyweA
 aVRBNLyeYjImCEEQQ09+9UcqRDoAAtCRCC6C0yZRWu7GN/59jCWrMktzgu8+SSZEZ60/FUF2X
 deolmB+ZdpBG22+neLASBRpqbe372NblIug/xUEfiDsaD9UFiejn37YljeFfKCqSz2B0tyA7Z
 8OtJKtP6BI4VYs4NvXmYg2GycPcgr3+1ybIim6dNYO9vbDG+JKA5wuLdYN9bdubqfjB/Yt0hK
 yYWpboMk9OWDVv4Z2EU08azbuKL3/Q18ZSelNJREYAYGPnrdDuYdU/aVdLd1t2Ki4NUhpuUGf
 cB5P+IlGOO64aytct3ejwbBq/vJEoentF3tN8k6gT4ME5lZvi3DEdy+Bk8BIcot5uKce+h0dN
 KKroEXobYdVaVqlTFW+rXCB1eTICvpUQmDw0RV0bisDqHr8el0XXi2OOdlu0CD9Vu+rLewQFn
 dVHk88UL2n6dpZeDbvabCDDe5mlK4rt3orZfK6fp8+zZ96FynrY24l0ONcu2H3qHdLP4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the ARM CCI PMU driver can be built as a loadable module,
we get a link failure when MCPM is enabled:

ERROR: "mcpm_is_available" [drivers/perf/arm-cci.ko] undefined!

The simplest fix is to export that helper function.

Fixes: 8b0c93c20ef7 ("perf/arm-cci: Allow building as a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch that caused this is currently part of the arm-perf/for-next/perf
branch, it would be good to have the fix there as well.
---
 arch/arm/common/mcpm_entry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index ed9e87ddbb06..037a4479b8c3 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
@@ -174,6 +175,7 @@ bool mcpm_is_available(void)
 {
 	return (platform_ops) ? true : false;
 }
+EXPORT_SYMBOL_GPL(mcpm_is_available);
 
 /*
  * We can't use regular spinlocks. In the switcher case, it is possible
-- 
2.9.0
