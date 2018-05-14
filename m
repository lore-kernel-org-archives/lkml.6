Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeENE2L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:11 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:62541 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:08 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 4/6] perf probe: Show variables for C++ functions
Date: Mon, 14 May 2018 12:19:38 +0800
Message-Id: <20180514041940.96126-5-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

The demangled C++ function name contains spaces and using the generic
argc_split would split the function in the middle. Create a separate
version that counts the number of opening and closing '<', '>' for
templated functions.

$ ./perf probe -x ./foo -V "std::vector<int, std::allocator<int> >::at"
Available variables at std::vector<int, std::allocator<int> >::at
        @<at+0>
                size_type       __n
                vector<int, std::allocator<int> >*      this

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/util/probe-event.c | 20 +++++++++++++--
 tools/perf/util/string.c      | 57 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/string2.h     |  1 +
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 39a2d47..97d6b6a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1407,6 +1407,22 @@ static int parse_perf_probe_event_name(char **arg, struct perf_probe_event *pev)
 	return 0;
 }
 
+/* Split the function name from  @file, :line, %return but be C++ aware */
+static char *split_func_name(char *arg)
+{
+	char *ptr = arg;
+
+	while ((ptr = strpbrk_esc(ptr, ";:+@%"))) {
+		if (ptr[0] == ':' && ptr[1] == ':') {
+			ptr += 2;
+			continue;
+		}
+		return ptr;
+	}
+
+	return NULL;
+}
+
 /* Parse probepoint definition. */
 static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 {
@@ -1486,7 +1502,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 			file_spec = true;
 	}
 
-	ptr = strpbrk_esc(arg, ";:+@%");
+	ptr = split_func_name(arg);
 	if (ptr) {
 		nc = *ptr;
 		*ptr++ = '\0';
@@ -1726,7 +1742,7 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 	char **argv;
 	int argc, i, ret = 0;
 
-	argv = argv_split(cmd, &argc);
+	argv = argv_split_cxx(cmd, &argc);
 	if (!argv) {
 		pr_debug("Failed to split arguments.\n");
 		return -ENOMEM;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index d8bfd0c..bb96fe2 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -80,6 +80,23 @@ static const char *skip_arg(const char *cp)
 	return cp;
 }
 
+static const char *skip_arg_cxx(const char *cp)
+{
+	int tmpl = 0;
+
+	while (*cp) {
+		if (tmpl == 0 && isspace(*cp))
+			break;
+		if (*cp == '<')
+			tmpl += 1;
+		if (*cp == '>')
+			tmpl -= 1;
+		cp++;
+	}
+
+	return cp;
+}
+
 static int count_argc(const char *str)
 {
 	int count = 0;
@@ -163,6 +180,46 @@ char **argv_split(const char *str, int *argcp)
 	return NULL;
 }
 
+char **argv_split_cxx(const char *str, int *argcp)
+{
+	int argc = count_argc(str);
+	char **argv = calloc(argc + 1, sizeof(*argv));
+	char **argvp;
+
+	if (argv == NULL)
+		goto out;
+
+	argvp = argv;
+
+	while (*str) {
+		str = skip_sep(str);
+
+		if (*str) {
+			const char *p = str;
+			char *t;
+
+			str = skip_arg_cxx(str);
+
+			t = strndup(p, str-p);
+			if (t == NULL)
+				goto fail;
+			*argvp++ = t;
+		}
+	}
+	if (argcp)
+		*argcp = argvp - argv;
+	*argvp = NULL;
+
+out:
+	return argv;
+
+fail:
+	if (argcp)
+		*argcp = 0;
+	argv_free(argv);
+	return NULL;
+}
+
 /* Character class matching */
 static bool __match_charclass(const char *pat, char c, const char **npat)
 {
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 4c68a09..d32de6f 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -8,6 +8,7 @@
 
 s64 perf_atoll(const char *str);
 char **argv_split(const char *str, int *argcp);
+char **argv_split_cxx(const char *str, int *argvcp);
 void argv_free(char **argv);
 bool strglobmatch(const char *str, const char *pat);
 bool strglobmatch_nocase(const char *str, const char *pat);
-- 
2.7.4
