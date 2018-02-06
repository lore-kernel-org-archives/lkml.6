Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeBFQ5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752988AbeBFQyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8D42179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/21] perf tools: Substitute yet another strtoull()
Date: Tue,  6 Feb 2018 13:53:48 -0300
Message-Id: <20180206165350.2570-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of home grown function let's use what library provides us.

Signed-off-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180129130359.1490-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 443892dabedb..1019bbc5dbd8 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -340,35 +340,15 @@ size_t hex_width(u64 v)
 	return n;
 }
 
-static int hex(char ch)
-{
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	if ((ch >= 'A') && (ch <= 'F'))
-		return ch - 'A' + 10;
-	return -1;
-}
-
 /*
  * While we find nice hex chars, build a long_val.
  * Return number of chars processed.
  */
 int hex2u64(const char *ptr, u64 *long_val)
 {
-	const char *p = ptr;
-	*long_val = 0;
-
-	while (*p) {
-		const int hex_val = hex(*p);
+	char *p;
 
-		if (hex_val < 0)
-			break;
-
-		*long_val = (*long_val << 4) | hex_val;
-		p++;
-	}
+	*long_val = strtoull(ptr, &p, 16);
 
 	return p - ptr;
 }
-- 
2.14.3
