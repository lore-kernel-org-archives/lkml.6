Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA9C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9E2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBHPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfBHPYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D08C1B143;
        Fri,  8 Feb 2019 15:24:29 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address and value
Date:   Fri,  8 Feb 2019 16:23:10 +0100
Message-Id: <20190208152310.29531-10-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are able to detect invalid values handled by %p[iI] printk specifier.
The current error message is "invalid address". It might cause confusion
against "(efault)" reported by the generic valid_pointer_address() check.

Let's unify the style and use the more appropriate error code description
"(einval)".

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst | 1 +
 lib/vsprintf.c                            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 732943b36828..0cbd98206a20 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -56,6 +56,7 @@ might be printed instead of the unreachable information::
 
 	(null)	 data on plain NULL address
 	(efault) data on invalid address
+	(einval) invalid data on a valid address
 
 Plain Pointers
 --------------
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3a95b4d1ca2e..e51cbc2be540 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1510,7 +1510,7 @@ char *ip_addr_string(char *buf, char *end, const void *ptr,
 		case AF_INET6:
 			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 		default:
-			return string_nocheck(buf, end, "(invalid address)", spec);
+			return string_nocheck(buf, end, "(einval)", spec);
 		}}
 	}
 
-- 
2.13.7

