Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbeCSH5N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:57:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37047 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeCSH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:57:11 -0400
X-Google-Smtp-Source: AG47ELvrs5nBOQ7+pG0W8DFhxfBWin/1ZgEcmyqQyG+MGS7sQhh9TZ3C73r3SKk7dNNtfg0NLbuHzQ==
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] include/linux/mmdebug.h: make VM_WARN* non-rvals
Date: Mon, 19 Mar 2018 08:57:02 +0100
Message-Id: <20180319075702.25645-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present the construct

	if (VM_WARN(...))

will compile OK with CONFIG_DEBUG_VM=y and will fail with
CONFIG_DEBUG_VM=n. The reason is that VM_{WARN,BUG}* have always been
special wrt. {WARN/BUG}* and never generate any code when DEBUG_VM is
disabled. So we cannot really use it in conditionals.

We considered changing things so that this construct works in both cases
but that might cause unwanted code generation with CONFIG_DEBUG_VM=n.  It
is safer and simpler to make the build fail in both cases.

Cc: Michal Hocko <mhocko@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
[akpm@linux-foundation.org: changelog]
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mmdebug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 35d77b0dae3b..14baf1d9d65b 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -37,10 +37,10 @@ void dump_mm(const struct mm_struct *mm);
 			BUG();						\
 		}							\
 	} while (0)
-#define VM_WARN_ON(cond) WARN_ON(cond)
-#define VM_WARN_ON_ONCE(cond) WARN_ON_ONCE(cond)
-#define VM_WARN_ONCE(cond, format...) WARN_ONCE(cond, format)
-#define VM_WARN(cond, format...) WARN(cond, format)
+#define VM_WARN_ON(cond) (void)WARN_ON(cond)
+#define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
+#define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
+#define VM_WARN(cond, format...) (void)WARN(cond, format)
 #else
 #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_BUG_ON_PAGE(cond, page) VM_BUG_ON(cond)
-- 
2.16.1
