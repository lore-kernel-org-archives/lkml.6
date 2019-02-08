Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F9920855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfBHPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727411AbfBHPYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 824EEB13B;
        Fri,  8 Feb 2019 15:24:19 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 2/9] vsprintf: Consistent %pK handling for kptr_restrict == 0
Date:   Fri,  8 Feb 2019 16:23:03 +0100
Message-Id: <20190208152310.29531-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

restricted_pointer() pretends that it prints the address when kptr_restrict
is set to zero. But it is never called in this situation. Instead,
pointer() falls back to ptr_to_id() and hashes the pointer.

This patch removes the potential confusion. klp_restrict is checked only
in restricted_pointer().

It actually fixes a small race when the address might get printed unhashed:

CPU0                            CPU1

pointer()
  if (!kptr_restrict)
     /* for example set to 2 */
  restricted_pointer()
				/* echo 0 >/proc/sys/kernel/kptr_restrict */
				proc_dointvec_minmax_sysadmin()
				  klpr_restrict = 0;
    switch(kptr_restrict)
      case 0:
	break:

    number()

Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobin Harding <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e164d7b734f3..76ce12b278c3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -724,8 +724,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 {
 	switch (kptr_restrict) {
 	case 0:
-		/* Always print %pK values */
-		break;
+		/* Handle as %p, hash and do _not_ leak addresses. */
+		return ptr_to_id(buf, end, ptr, spec);
 	case 1: {
 		const struct cred *cred;
 
@@ -2041,8 +2041,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			return buf;
 		}
 	case 'K':
-		if (!kptr_restrict)
-			break;
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
 		return netdev_bits(buf, end, ptr, spec, fmt);
-- 
2.13.7

