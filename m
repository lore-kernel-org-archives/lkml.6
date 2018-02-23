Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeBWOXD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:23:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43594 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeBWOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:23:01 -0500
X-Google-Smtp-Source: AH8x225IlZuStT1w2j9+9agj5FYOdZiFuiQlNFFpxj7XHRHX/Zjy5aHqizHfI2G9TYUwPyGGAQzHkQ==
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] objtool: use host flags to detect if libelf is missing
Date: Fri, 23 Feb 2018 15:22:15 +0100
Message-Id: <2afbfc7911a0eb0642c33e8c2582f137a4fda2f3.1519393674.git.robin.jarry@6wind.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519393674.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
In-Reply-To: <cover.1519393674.git.robin.jarry@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When libelf headers and libs are not found and CONFIG_UNWINDER_ORC is
selected, there is a make error introduced by
commit 3dd40cb320fe ("objtool: Upgrade libelf-devel warning to error for
CONFIG_ORC_UNWINDER").

Host headers and libs may be in a non-standard location and the check is
performed without host flags. Make sure to use host flags for the check
(they will be used later when building objtool anyway).

Fixes: 3b27a0c85d70 ("objtool: Detect and warn if libelf is missing and don't break the build")
Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e9609319d2b8..4e8c667b9f3f 100644
--- a/Makefile
+++ b/Makefile
@@ -955,7 +955,7 @@ export mod_sign_cmd
 
 ifdef CONFIG_STACK_VALIDATION
   has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
+		echo "int main() {}" | $(HOSTCC) $(host_clfags) $(HOSTLDFLAGS) -xc -o /dev/null -lelf -,1,0)
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
-- 
2.11.0
