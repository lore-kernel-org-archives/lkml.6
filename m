Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966572AbeEYP0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:26:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965710AbeEYP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:26:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Brad Love <brad@nextdimension.cc>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hans.verkuil@cisco.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] media: cx231xx: fix RC_CORE dependency
Date: Fri, 25 May 2018 17:25:10 +0200
Message-Id: <20180525152523.2821369-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525152523.2821369-1-arnd@arndb.de>
References: <20180525152523.2821369-1-arnd@arndb.de>
X-Provags-ID: V03:K1:88JGFdRo9RXsChw5Spmkf7mu/yotBmE9TqYOV0LsZehGmehGT+B
 ErpC6dspbuIlo4cxGTUJ0VfjVHl5MuXpVOCvt5m7wmWmI7Wna3me2nL5yDDRKz3irgv0gi5
 JMYsB2M+zLr4eB2/+l4oBenORcKjixJwI4/0GAhSXj3A/VR7yAxAUBOxjvDGC2R9yE/8c/E
 GwYlZSYUb1LCYA28CTEwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSRIubGSrUE=:zrmKC7XpdoR2EE77TNQj0w
 a+DQ2Pris2XPZKhM4QVCqM7Y9cQpckqVDKJJ32BzwFxQ0m5LIx3P5SbA2hS5oOYplx7DzcnEc
 PCvlufVF4pY0XbVtHTG9L8ThoNkrlS6x3ArzEjJhn++Kq8bj68ZggethZnRyH/qijZ+S/Q1Uu
 8KkRf7BeSL19Tw67AnKIvq72oyEVjqHrPMHtUneBi6DA3px7C6eya5l7FXwrnyGV2qUpXkZMp
 Ds9dv2hA+8iezMuSEV7/1jPwF/IXF8mS/bbNrXLZ35YCbPckvd8794O3H5ECONmvzVcBAEBYf
 HdxGxQ7s3AMBGhi59TEevhEcSXF1l/qk8k5pp7wAnI+GzSIIhv3pdclToZLwLULcHeVaZhKKH
 XWnVXUhhQhMu2RjvYe4DBKtOpHCv2xgIOMAt0Rh9tmclfTU2MKh1IjygvgEb4mLygyaptzozS
 GgGNL9HO0UaS94auTO02kgrkitQlaRHRDhjTiwVMfVjzzFGKsgVn9BNTEbAJW1lBvfC15mYR/
 KVbMk81l47LcIQ+tHbC39C3GMPfBp9VZJsJK1ZTmBjZKR+3ld0NNAO5gXaxbMrKoa6w6g2dki
 IkaIj31953a/aVrUFcF+AC4souvEZ6XuUVs760QwVZW/8+81G8jin06LdJIHnO25YoJHW6/Qj
 8fEZ/RbtPOgA0elj1BaTZ45ZhMYMLGQAgo4K1OVW7vVoNP4V7W4/WYVhxvnGYvBYum/c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_RC_CORE=m and VIDEO_CX231XX=y, we get a link failure:

drivers/media/usb/cx231xx/cx231xx-input.o: In function `cx231xx_ir_init':
cx231xx-input.c:(.text+0xd4): undefined reference to `rc_allocate_device'

This narrows down the dependency so that only valid configurations
are allowed.

Fixes: 84545d2a1436 ("media: cx231xx: Remove RC_CORE dependency")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/usb/cx231xx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/Kconfig b/drivers/media/usb/cx231xx/Kconfig
index 0f13192634c7..9e5b3e7c3ef5 100644
--- a/drivers/media/usb/cx231xx/Kconfig
+++ b/drivers/media/usb/cx231xx/Kconfig
@@ -15,7 +15,7 @@ config VIDEO_CX231XX
 
 config VIDEO_CX231XX_RC
 	bool "Conexant cx231xx Remote Controller additional support"
-	depends on RC_CORE
+	depends on RC_CORE=y || RC_CORE=VIDEO_CX231XX
 	depends on VIDEO_CX231XX
 	default y
 	---help---
-- 
2.9.0
