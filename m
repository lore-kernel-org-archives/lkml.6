Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034794AbeE1PnC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:43:02 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031240AbeE1Pmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:42:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/bus: arm-cci: fix build warnings
Date: Mon, 28 May 2018 17:41:47 +0200
Message-Id: <20180528154228.2403116-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:/yx/1QOlx3ewRLu25nrvKZ/qIEMBSypbAZ4ESfUals4FDe6mk4N
 2uoBGNIqHr9CHAU/4jbZQG5Ap5otXgfW/2XdkdGPVQoQuaiyYpJeU6F3iHA4rJPIh1cLWS9
 Aq9BtM51pkJwSnZEZ4D2oga1JY0Zp2iJW11ICYHSQJhk14KH7OjpUik4Upo9o1wKaf9fUOh
 csUKDEPrOAxzoYTgVrySw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vJ4r2fWp9aY=:XT5pfWNQXud8CanLSF26Fa
 /8rTkzxGxqHfUbH2fixPVmjpW+x85hpUGk7wAGc/iNWRy2gxnQe349OqUtR0645P/AqmUbTB1
 MFKjzDTsLxOEWRac8MKYAmgDEqlU1W3gT7WIXbrsRBDgVBx+vf0GRMkGj19V4s3SaIWyy0d6T
 SckEvJWEEVBvAPDFG4zS/U7RNqEqGFY/VfsyF/uXuxUqA/yXe6+WPKRyoXm0WmxlDMMxOPMon
 Suse2A8MSpJsrf45kIdEX1K1B4p8TxOXh7Kv6QF/LsVYpJqj9DCGCzi5iF48IpmUy/f+OcdDc
 J1cPTj4mGFd9BlE7RI/JsPQqEAIdmPhI8d12j7RhWvc9pnHEEbMsRPkcx5NxlEIQtRjQhuGLx
 5Tu/UwdVyl86PZuZOa3ZCwb1npfg3hQhjIsD/43z7fXzUsfMXss8Izr3r7rq+U37PheS4XmhY
 5bNfDplhg0flxqoKP7cPhdB4iYSyYuLvx+ZsazOgSxlg7R3p0VrA6/pXdR4CqTN72c6EDP/sY
 qWRnxlePQaAC7putdHX3xKA6WZn8vRoXOR37VwH7BRUaZ035zBA06WYa7VxxdYKAtNgqNDzfF
 DYD8ycSAgZCP/MXC2PWTD/0ttlIiM6M/Y0c8tcJIXDP5o9UrlyY8+fuybmTscIeGXVL5sJe0D
 q1Idy3YhXBJeuS0x2jDLWohPMlvGBCLmEQ8ENOzk0RgA2Fa4wz32WCPaJz2UT9g45CTs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the arm-cci driver is enabled, but both CONFIG_ARM_CCI5xx_PMU and
CONFIG_ARM_CCI400_PMU are not, we get a warning about how parts of
the driver are never used:

drivers/perf/arm-cci.c:1454:29: error: 'cci_pmu_models' defined but not used [-Werror=unused-variable]
drivers/perf/arm-cci.c:693:16: error: 'cci_pmu_event_show' defined but not used [-Werror=unused-function]
drivers/perf/arm-cci.c:685:16: error: 'cci_pmu_format_show' defined but not used [-Werror=unused-function]

Marking all three functions as __maybe_unused avoids the warnings in
randconfig builds. I'm doing this lacking any ideas for a better fix.

Fixes: 3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/perf/arm-cci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index e6fadc8e1178..0d09d8e669cd 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -120,9 +120,9 @@ enum cci_models {
 
 static void pmu_write_counters(struct cci_pmu *cci_pmu,
 				 unsigned long *mask);
-static ssize_t cci_pmu_format_show(struct device *dev,
+static ssize_t __maybe_unused cci_pmu_format_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
-static ssize_t cci_pmu_event_show(struct device *dev,
+static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 
 #define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
@@ -1451,7 +1451,7 @@ static int cci_pmu_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-static struct cci_pmu_model cci_pmu_models[] = {
+static __maybe_unused struct cci_pmu_model cci_pmu_models[] = {
 #ifdef CONFIG_ARM_CCI400_PMU
 	[CCI400_R0] = {
 		.name = "CCI_400",
-- 
2.9.0
