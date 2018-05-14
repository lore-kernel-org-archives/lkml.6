Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeENE2J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:09 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:41735 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeENE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:08 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 2/6] perf probe: Parse linerange for C++ functions
Date: Mon, 14 May 2018 12:19:36 +0800
Message-Id: <20180514041940.96126-3-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

perf probe --funcs will demangle C++ symbols by default but these
functions can not be used for listing sourcecode. Modify the scanner
to start searching for a line number only after a single ':'.

./perf probe -x ./cxx-example -L \
	"std::vector<int, std::allocator<int> >::at:1"

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/util/probe-event.c | 57 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e1dbc98..39a2d47 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1237,6 +1237,59 @@ static bool is_c_func_name(const char *name)
 	return true;
 }
 
+/* Symbols in demangled CXX function names */
+static inline bool is_cxx_symbol(const char symbol)
+{
+	switch (symbol) {
+	case '_':
+	case ' ':
+	case '&':
+	case '*':
+	case '@':
+	case ',':
+	case ':':
+	case '<':
+	case '>':
+	case '(':
+	case ')':
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Is name a C++ name? */
+static bool is_cxx_func_name(const char *name)
+{
+	/* C name or a mangled name */
+	if (is_c_func_name(name))
+		return true;
+	while (*++name != '\0') {
+		if (!isalpha(*name) && !isdigit(*name) && !is_cxx_symbol(*name))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Find the first ':' that isn't part of a C++ namespace or class
+ * name.
+ */
+static char *first_non_cxx_ns(char *name)
+{
+	while (*name) {
+		char cur = *name, nxt = *(name + 1);
+
+		if (cur == ':' && nxt == ':')
+			name += 2;
+		else if (cur == ':')
+			return name;
+
+		name += 1;
+	}
+	return NULL;
+}
+
 /*
  * Stuff 'lr' according to the line range described by 'arg'.
  * The line range syntax is described by:
@@ -1255,7 +1308,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	lr->start = 0;
 	lr->end = INT_MAX;
 
-	range = strchr(name, ':');
+	range = first_non_cxx_ns(name);
 	if (range) {
 		*range++ = '\0';
 
@@ -1309,6 +1362,8 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		lr->file = name;
 	else if (is_c_func_name(name))/* We reuse it for checking funcname */
 		lr->function = name;
+	else if (is_cxx_func_name(name))
+		lr->function = name;
 	else {	/* Invalid name */
 		semantic_error("'%s' is not a valid function name.\n", name);
 		err = -EINVAL;
-- 
2.7.4
