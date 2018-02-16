Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932954AbeBPJwl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:52:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeBPJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:52:38 -0500
Date: Fri, 16 Feb 2018 01:42:33 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-6677d26c8befa462eab9be6c5335a939011e7e65@git.kernel.org>
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        andriy.shevchenko@linux.intel.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com
In-Reply-To: <20180129130359.1490-1-andriy.shevchenko@linux.intel.com>
References: <20180129130359.1490-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Substitute yet another strtoull()
Git-Commit-ID: 6677d26c8befa462eab9be6c5335a939011e7e65
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6677d26c8befa462eab9be6c5335a939011e7e65
Gitweb:     https://git.kernel.org/tip/6677d26c8befa462eab9be6c5335a939011e7e65
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Mon, 29 Jan 2018 15:03:59 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:57:19 -0300

perf tools: Substitute yet another strtoull()

Instead of home grown function let's use what library provides us.

Signed-off-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180129130359.1490-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 443892d..1019bbc 100644
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
