Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeBBQRH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:17:07 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:16:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/7] [HACK] lto: make config.gz symbol visible
Date: Fri,  2 Feb 2018 17:15:39 +0100
Message-Id: <20180202161550.2106846-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202161550.2106846-1-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
X-Provags-ID: V03:K0:1tkGLNEY/roAnh6B7UqTAMJPkDW3vKN2aKLhqSwgFI1PGEh87I1
 bWksHtxO+0wP8Gg1Jo3DbTbx5Rh0EboLiE2h9P973e3f+ozSNfezlXHHkqezqpNDWmHsEtL
 va6ovSP7lCKLTdI2PYZz8/VI4jC5enu+fotd4chUogtwf/rzwJLeSkYSU1fQj7idfKzEbxz
 ofr3LO1fdaAlpjHxOLquQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IYZmf6V764Y=:k679xQ/aEfI1gAq7nroLit
 KG9qjH+wd56+15iTD9qo0GZHbKOXW2v68EY5u4FFSiAMjVEq54+s8oITSrLLwz5J3/dxJTjmg
 l58ikoJlPcmpxaHAxVPKvaZxW6YcS9Nhlx43wiq9tRr/vWmnrdw06ehTKMjq8/xkiICHrOOC5
 xznnv0WVTZb3vdcd9A+iD3gXt7uBKFrgtjV8bvDAtiSibCJloDYyJnja8It/bIjCgQX9uOmeD
 KQPYgZoLkNBBPFC0SAKgiQ/c93KHAtolWFTKGhb71HOPOKFjKlP3k0xnvJelWszfgOXnBgRwE
 hVHuJoWZ5Un4jTDmV1HjAzKQIEu277kWrTfCYajnSu9nrJL7zSpFU9rAqaDzScWgG9lR4De1n
 S5NtjizWJuGntkPnRfLQoMa6i5gc/XVwA/JhwJ5zFDWpnrozzNyKIo23YVEhfod9hYPDYhHZR
 AtyPoigsOzZ8s4F1H/WoLvp4t8B9UI+5HMnvkmxQ1VhXDnMVitpQj6CaU8Bz/wpvFEzak355F
 X7bN+TJ1IR443IvCi62Xz3kWLWFOgGStu9keRumrPQd2QCckFaIO9/DACAsBkX+CLAOs/h48w
 Jo2dfKjowchIJRslLYbaDwh2cpsq0o22Nj/LiHP2NLgDFSNxOWLwDve1ynz5kaqsla5DyxF+T
 8A6pTxMgy1Fxq3vcZOQCMhsbDdVJnHbinrQ2cOAzZKcoMQJYe+EmkYdn7vDt8bVU4w2GNNhkL
 tV0u9iQ64hFb8uVQGs2v09qROFtu8zY7gu//QA==
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

building with LTO enabled, I often get warnings about kernel/configs.c
being empty when CONFIG_IKCONFIG is disabled:

x86_64-linux/bin/nm: kernel/configs.o: no symbols

Making the symbol visible is probably not the right solution, but
it does get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 7666ee88e237..40b48e3e87a2 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -120,7 +120,7 @@ targets += config_data.gz
 $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
 	$(call if_changed,gzip)
 
-      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/basic/bin2c; echo "MAGIC_END;")
+      filechk_ikconfiggz = (echo "const char kernel_config_data[] __used __visible = MAGIC_START"; cat $< | scripts/basic/bin2c; echo "MAGIC_END;")
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call filechk,ikconfiggz)
-- 
2.9.0
