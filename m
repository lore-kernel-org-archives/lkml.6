Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeCPHhp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:37:45 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:20643 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeCPHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:37:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2G7bOa4029139
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 1/7] kbuild: clear LDFLAGS in the top Makefile
Date: Fri, 16 Mar 2018 16:37:09 +0900
Message-Id: <1521185836-19120-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently LDFLAGS is not cleared, so same flags are accumulated in
LDFLAGS when the top Makefile is recursively invoked.

I found unneeded rebuild for ARCH=arm64 when CONFIG_TRIM_UNUSED_KSYMS
is enabled.  If include/generated/autoksyms.h is updated, the top
Makefile is recursively invoked, then arch/arm64/Makefile adds one
more '-maarch64linux'.  Due to the command line change, modules are
rebuilt needlessly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d9bb6dd6..ac8755d 100644
--- a/Makefile
+++ b/Makefile
@@ -437,6 +437,7 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
+LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
-- 
2.7.4
