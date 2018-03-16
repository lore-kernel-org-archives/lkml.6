Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeCPCT5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:19:57 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44532 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCPCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:19:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2G2IoBM003525
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] kbuild: clear LDFLAGS in the top Makefile
Date: Fri, 16 Mar 2018 11:18:38 +0900
Message-Id: <1521166725-24157-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
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
---

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
