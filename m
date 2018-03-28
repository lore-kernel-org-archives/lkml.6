Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeC1NqA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:46:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1Np5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:45:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: exynos_tmu: avoid uninitialized variables
Date: Wed, 28 Mar 2018 15:44:44 +0200
Message-Id: <20180328134520.1970967-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:tnqi/xk05bSjeWxw7K4Em0TJIso4HcTnOmlTAhaP89T3TMI/zoK
 f/dlI81QADNtu6QhaymoFFuf+k+taO6Da/31Mb09FnW27I+y4XrqeR7ceX/qEXJiC2lOQPl
 sy47TF14pI8nzwC3wszZtRDi+wVf6Dzcnqw2+MLTnQl6kFB46jizPzdZb2lg9cMJGOseEaG
 AkteiTl+1Ra3E0J9PBRjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ly3cRcJtkr4=:UHgcC0Yu2sSyqQFH5Rkl3G
 vvCTpSQBe1Ixbg2XX59ADkHvew5udTh3a2PTyyRmJPQy1/YnHSQLrMBOW0cHGFc5JwjzKBqWS
 YTqX2asumWWSiBUbswHLNodU67WtIkl8rajVqc0vjLN+TvfS2/GOBbYrhkAeb+upjRiG0ba8o
 U9HkDYcXLY7x+9tcsVGrKI2lA72NajPVjKMrfFz8JCI7DB1+yH33NSxXiCBiIN+xjhuxa9tD/
 iS10i6PzeGQahgh+w4A64hGOZuHKODGQNf8su1ogk8EXyvU3qCr7yfxl4GYSqHwYTyXWZo4Do
 F6vLCGCG8Yz8m+ol8ikH/Ep/ncUpDeCygQsdzL9KIr9rwNqNZtC72LqUhGXVKwVt7gPARh3rN
 WfWrMPld44wzUR29Mli1VfJmTKNaS9dsvJHPlvpRQgX1HRjdeh3hdrpYSM8CIMMATMJVemJ8g
 wj7P08r25yosZn3JgU7CPU/EbbGg5h6tbCnmE8dIClPHf+XI3cv0tp/korOnQRiSLjcS+jMeD
 8h1swkTyUcxA/twSpqppL6bWDDarrD/8eFi6D5D4tmH+IaXypRVWUyq0Sh1z4+c4RYUxbewND
 3OuLJrboWPDK3aBA5F0V5Ou1hYlU6D+KkLLTz72qDY+ujUES9+bkldgspuc2aq7kr5N3zjsei
 hd6frsCeVgwTBEbPZZ77Q7n8nr3qcry+knYmQQwlmYbFIEwWBexjVIZAU9JBsJaF9lws83x2r
 rHSB9wkafLX0rIrocsATXB+zruPEWo6L6i7xYQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the initialization in the error case introduced
a compile-time warning:

drivers/thermal/samsung/exynos_tmu.c: In function 'temp_to_code':
drivers/thermal/samsung/exynos_tmu.c:304:9: error: 'temp_code' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  return temp_code;
         ^~~~~~~~~
drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_get_temp':
drivers/thermal/samsung/exynos_tmu.c:931:37: error: 'temp' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   *temp = code_to_temp(data, value) * MCELSIUS;

Let's assume the runtime warning is sufficient, and make it
return a well-defined number instead of unintialized data.

Fixes: 480b5bfc16e1 ("thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2ec854851da1..7e351fffdaee 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -298,6 +298,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 		break;
 	default:
 		WARN_ON(1);
+		temp_code = 0;
 		break;
 	}
 
@@ -324,6 +325,7 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 		break;
 	default:
 		WARN_ON(1);
+		temp = 0;
 		break;
 	}
 
-- 
2.9.0
