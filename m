Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCNQpT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:19 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38070 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdQ001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] kbuild: clear LDFLAGS in the top Makefile
Date: Thu, 15 Mar 2018 01:44:15 +0900
Message-Id: <1521045861-22418-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
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

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index e02d092..5eb5d9d 100644
--- a/Makefile
+++ b/Makefile
@@ -426,6 +426,7 @@ KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
+LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=
 
 export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
-- 
2.7.4
