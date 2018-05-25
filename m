Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966659AbeEYPhe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:37:34 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965570AbeEYPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:37:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yangbo Lu <yangbo.lu@nxp.com>,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fsl-dpaa2/rtc: fix PTP dependency
Date: Fri, 25 May 2018 17:37:12 +0200
Message-Id: <20180525153725.3266389-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:6g7zJvLh9w0GMdkIY49YLEiA7v5DrmDmthQ3EYrOh/5Zs9jBtIn
 95Qai6kP/Y2LxaKZAG6GyXfkDLhy/rkC5cnIl/JvqpehoaGjLCIGwdA6bdN39Hz5R6Bafxu
 gLjrolq7fSTy7exfsSbW783tgYO0yXC7ZM9cx1/IXQOkZS8njoz/6lWqQsgptseFP7OZ2eU
 bcbiIK8PZ4/DyvGSF89EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TyC44pfAd0g=:07owtX7+ta12J0H+l+TNDB
 nc5pjVAQFij+RDPLUa1J9g/5+u5a7YbwMTHo7SsIjhhJfduJdMedr87f3afyaxz2kElLCOkyc
 5CPpIkOblu+HhYRGpwS0m0tuYh9VShceAZAyAZF9qgppPFpK5f4YbxpeLy4Y0PBTSgo7Nnvh4
 fCzT0JXRAlOLSL64b5Q3uZHOkuei8L1bXp+FvU9VEMvUh/OuDyOgUyG7ibMXluX/MzxAxGFu5
 9AG72r+6kqVgVB6WHjLSMIkWBgzjeEXuud4THlvmRDez7jLX03fhkdPAMMBibqefLBcWrFld2
 QgLJhqCJoXocrrOaAJqhPMv0wMrN8KUvc/rQnlk00zJ0qIDkV2vE5u4e2L+ghQbWU2/KlQ5uk
 u7R96wp75DkVfbMpkLnkSK5RV6OsLX44/I5NFsBtLA1k3QD1oZ5fHlruk9bapTaSFiwSx5l6Z
 ZT8pDDI0PzGpX1XRILCIxfnOM8/K294/8SUI6dxqcmOf8f82jmuhM4kXrDiAm1dxbdfl/95U0
 +AFrS9DbxX0+Ht8ieJTGfJlL/BhFEN4y2vQ/UkkKyauaqrJKYtYphnF+Z19jvrNdOfoN+0imR
 8OfPX/sMjKlhV+A3bLgeXtEzfKDzc/MkEtFkruSr1NmxdrXtFR1J2b81H0ktI6gbHlr998b9Z
 suW1uSvjSM/bLisQVBnhubUlcUHu2xW0FSl+n/TxYl54RmaEUggKcYNritcufdXETTnA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't select PTP_1588_CLOCK when posix timers are completely
disabled:

WARNING: unmet direct dependencies detected for PTP_1588_CLOCK
  Depends on [n]: NET [=y] && POSIX_TIMERS [=n]
  Selected by [y]:
  - FSL_DPAA2_PTP_CLOCK [=y] && STAGING [=y] && FSL_DPAA2_ETH [=y]

This adds the necessary dependency.

Fixes: 9bdf43b3d40f ("staging: fsl-dpaa2/rtc: add rtc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/fsl-dpaa2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index cad016aee3b5..a4c4b83ddc9c 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -27,7 +27,7 @@ config FSL_DPAA2_ETHSW
 
 config FSL_DPAA2_PTP_CLOCK
 	tristate "Freescale DPAA2 PTP Clock"
-	depends on FSL_DPAA2_ETH
+	depends on FSL_DPAA2_ETH && POSIX_TIMERS
 	select PTP_1588_CLOCK
 	help
 	  This driver adds support for using the DPAA2 1588 timer module
-- 
2.9.0
