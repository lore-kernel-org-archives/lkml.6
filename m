Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDFNDz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbeDFNBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841732183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.408206643@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [for-next][PATCH 05/18] ftrace: Drop a VLA in module_exists()
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-ftrace-Drop-a-VLA-in-module_exists.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>

Avoid a VLA by using a real constant expression instead of a variable.
The compiler should be able to optimize the original code and avoid using
an actual VLA. Anyway this change is useful because it will avoid a false
positive with -Wvla, it might also help the compiler generating better
code.

Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
Link: http://lkml.kernel.org/r/1522399988-8815-1-git-send-email-s.mesoraca16@gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eac9ce2c57a2..16bbf062018f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
 	const char this_mod[] = "__this_module";
-	const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
-	char modname[modname_size + 1];
+	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
 
-	n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
+	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
 
-	if (n > modname_size)
+	if (n > sizeof(modname) - 1)
 		return false;
 
 	val = module_kallsyms_lookup_name(modname);
-- 
2.15.1
