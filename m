Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeCSL10 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:27:26 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30214 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:27:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2JBQHQs023258
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/7] net: liquidio: clean up Makefile for simpler composite object handling
Date: Mon, 19 Mar 2018 20:26:10 +0900
Message-Id: <1521458773-14224-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521458773-14224-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, Kbuild nicely handles composite objects to avoid multiple
definition.

Makefiles can simply add the same objects multiple times across
composite objects.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The is clean-up from build system point of view.

I will apply this for the Kbuild tree.


 drivers/net/ethernet/cavium/liquidio/Makefile | 51 +++++++++------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/Makefile b/drivers/net/ethernet/cavium/liquidio/Makefile
index e3fc464..bc99375 100644
--- a/drivers/net/ethernet/cavium/liquidio/Makefile
+++ b/drivers/net/ethernet/cavium/liquidio/Makefile
@@ -2,42 +2,23 @@
 #
 # Cavium Liquidio ethernet device driver
 #
-obj-$(CONFIG_LIQUIDIO) += liquidio.o
 
-liquidio-$(CONFIG_LIQUIDIO) += lio_ethtool.o \
-			lio_core.o         \
-			request_manager.o  \
-			response_manager.o \
-			octeon_device.o    \
-			cn66xx_device.o    \
-			cn68xx_device.o    \
-			cn23xx_pf_device.o \
-			cn23xx_vf_device.o \
-			octeon_mailbox.o   \
-			octeon_mem_ops.o   \
-			octeon_droq.o      \
-			octeon_nic.o
+common-objs :=	lio_ethtool.o		\
+		lio_core.o		\
+		request_manager.o	\
+		response_manager.o	\
+		octeon_device.o		\
+		cn66xx_device.o		\
+		cn68xx_device.o		\
+		cn23xx_pf_device.o	\
+		cn23xx_vf_device.o	\
+		octeon_mailbox.o	\
+		octeon_mem_ops.o	\
+		octeon_droq.o		\
+		octeon_nic.o
 
-liquidio-objs := lio_main.o octeon_console.o lio_vf_rep.o $(liquidio-y)
+obj-$(CONFIG_LIQUIDIO) += liquidio.o
+liquidio-y := lio_main.o octeon_console.o lio_vf_rep.o $(common-objs)
 
 obj-$(CONFIG_LIQUIDIO_VF) += liquidio_vf.o
-
-ifeq ($(CONFIG_LIQUIDIO)$(CONFIG_LIQUIDIO_VF), yy)
-	liquidio_vf-objs := lio_vf_main.o
-else
-liquidio_vf-$(CONFIG_LIQUIDIO_VF) += lio_ethtool.o \
-			lio_core.o         \
-			request_manager.o  \
-			response_manager.o \
-			octeon_device.o    \
-			cn66xx_device.o    \
-			cn68xx_device.o    \
-			cn23xx_pf_device.o \
-			cn23xx_vf_device.o \
-			octeon_mailbox.o   \
-			octeon_mem_ops.o   \
-			octeon_droq.o      \
-			octeon_nic.o
-
-liquidio_vf-objs := lio_vf_main.o $(liquidio_vf-y)
-endif
+liquidio_vf-y := lio_vf_main.o $(common-objs)
-- 
2.7.4
