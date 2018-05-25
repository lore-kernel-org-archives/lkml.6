Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965773AbeEYPZk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:25:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964823AbeEYPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:25:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, Pavel Machek <pavel@ucw.cz>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] media: omap3isp: fix warning for !CONFIG_PM
Date: Fri, 25 May 2018 17:25:08 +0200
Message-Id: <20180525152523.2821369-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Z8CaZDK3mNc5lxbRVyWrbs+HRb0VXJKIKd1hniATTuoV+fZf9bP
 gxihhjX/r2Z9g9UqvAnwjb+hiVRGv3t9d/5uuET19dy23He2nVVgzio/fD7dI3k+0ijBDIh
 08FlXjaz3D/eekx1MJ2WgIeIS3ZbUczghcw8ygehQqZif5IF25GxuPt9R4+ancqz9NWeWHk
 b2X0rJCi/R2CoQ0ul0+FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U/KhIl74fKM=:CZ3Ig2zZd/JRUdMBfBDWSt
 xb3ZEfgGs9bqq8LPpGMqF9yrAPB3Oy2FtIcn7pJujNjmRMSI5mpCGo2KEoUu7Bv2Le12bpj6V
 YgskILbTpuh4mdXILiSjDrDebP+KEyVUXUzU4dO0MFxm18x0zt29wv1i+iIu6W25SGtiLGkZJ
 BJvR1cTu15qHxa6HTQwX5BJmAbDO6sK5ndB3n2n1jHzTZBhVZRkmkgsIunBm4i/8gSMZmKjO7
 DSguNXymfTMvMeIUwsM0WLLJe5G9FdadY1pqhZIZw2ofWcTvaGE7AmjjuJrN4Gke+AdGZeKpg
 jYBFqO0HVrpV4oXAt7k/Dz/hcsFwvnn1Wo/L5RsWwHcl75XhDfVH2a6QmfenfW2QIR2pY01T9
 QbS2fIliF6SaCfLlsEUVWqzdWW1mOA95c2R1IE5/MQKrxeMTM57dGTXrEPFOGyiwqYfYU3j+A
 Mt2XMk0IWHpFE262SXxM46xa1Gs1UQLYropnPAQ17l4DzR04vHnXNAIet0ScGhgSiKVo7w1md
 xfVBIoGaaY7AVKRotQvslg9cZyAjbbCIEFFsByx6QDDB/4ZUTGQLmDJ7NILSl1ObV/UnFWVFB
 ggow2nFuX0ftvBRXxlg/02L690lenju6HJceLLhtmQ7EpbsrMBNb0KCTTGDArVW+0rUE2N2p7
 5ZPIMWomRtxruEzIVVkImBNnAQguBA/HDSHSGuKXx8NtOE9K04l45fyF61yPmQdgwEGQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final version of the COMPILE_TEST patch for this driver missed
one warning about suspend/resume functions that can now appear
on platforms that don't always set CONFIG_PM:

drivers/media/platform/omap3isp/isp.c:1008:13: error: 'isp_resume_modules' defined but not used [-Werror=unused-function]
 static void isp_resume_modules(struct isp_device *isp)
             ^~~~~~~~~~~~~~~~~~
drivers/media/platform/omap3isp/isp.c:974:12: error: 'isp_suspend_modules' defined but not used [-Werror=unused-function]
 static int isp_suspend_modules(struct isp_device *isp)

This marks the respective functions as __maybe_unused as an easy
workaround.

Fixes: 243131134be4 ("media: omap3isp: Allow it to build with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/omap3isp/isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index f22cf351e3ee..a658c12eead1 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -971,7 +971,7 @@ static void isp_resume_module_pipeline(struct media_entity *me)
  * Returns 0 if suspend left in idle state all the submodules properly,
  * or returns 1 if a general Reset is required to suspend the submodules.
  */
-static int isp_suspend_modules(struct isp_device *isp)
+static int __maybe_unused isp_suspend_modules(struct isp_device *isp)
 {
 	unsigned long timeout;
 
@@ -1005,7 +1005,7 @@ static int isp_suspend_modules(struct isp_device *isp)
  * isp_resume_modules - Resume ISP submodules.
  * @isp: OMAP3 ISP device
  */
-static void isp_resume_modules(struct isp_device *isp)
+static void __maybe_unused isp_resume_modules(struct isp_device *isp)
 {
 	omap3isp_stat_resume(&isp->isp_aewb);
 	omap3isp_stat_resume(&isp->isp_af);
-- 
2.9.0
