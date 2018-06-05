Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeFEQnt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:43:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46825 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeFEQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:43:46 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: Jonathan Corbet <corbet@lwn.net>, Michal Suchanek <msuchanek@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/5] lib/cmdline.c: Add backslash support to kernel commandline parsing.
Date: Tue,  5 Jun 2018 18:43:08 +0200
Message-Id: <0005cec6acaf7ef629a64a1a72b09f68f84aae4c.1528215659.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - add \ as quoting character in kernel parameters
 - generalize quoting character removal to be able to remove quoting
 character at any position in kernel parameter rather than start and end
 only

This allows passing quotes in kernel arguments.

It is also useful to have quoting grammar more similar to shells and
bootloaders.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
- more verbose commit message
- optimize final quote removal
---
 lib/cmdline.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 192848d880ea..aa0086dbb082 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -191,32 +191,43 @@ bool parse_option_str(const char *str, const char *option)
 	return false;
 }
 
+#define break_arg_end(i) { \
+	if (isspace(args[i]) && !in_quote && !backslash) \
+		break; \
+	}
+
 /*
  * Parse a string to get a param value pair.
- * You can use " around spaces, but can't escape ".
+ * You can use " around spaces, and you can escape with \
  * Hyphens and underscores equivalent in parameter names.
  */
 char *next_arg(char *args, char **param, char **val, int *state_flags)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0, quoted = 0;
+	int in_quote = 0, backslash = 0;
 	char *next;
 
-	if (*args == '"') {
-		args++;
-		in_quote = 1;
-		quoted = 1;
-	}
-
 	for (i = 0; args[i]; i++) {
-		if (isspace(args[i]) && !in_quote)
-			break;
-		if (equals == 0) {
-			if (args[i] == '=')
-				equals = i;
+		break_arg_end(i);
+
+		if ((equals == 0) && (args[i] == '='))
+			equals = i;
+
+		if (!backslash) {
+			if ((args[i] == '"') || (args[i] == '\\')) {
+				if (args[i] == '"')
+					in_quote = !in_quote;
+				if (args[i] == '\\')
+					backslash = 1;
+
+				break_arg_end(i + 1);
+				memmove(args + 1, args, i);
+				args++;
+				i--;
+			}
+		} else {
+			backslash = 0;
 		}
-		if (args[i] == '"')
-			in_quote = !in_quote;
 	}
 
 	if (state_flags)
@@ -231,16 +242,7 @@ char *next_arg(char *args, char **param, char **val, int *state_flags)
 	else {
 		args[equals] = '\0';
 		*val = args + equals + 1;
-
-		/* Don't include quotes in value. */
-		if (**val == '"') {
-			(*val)++;
-			if (args[i-1] == '"')
-				args[i-1] = '\0';
-		}
 	}
-	if (quoted && args[i-1] == '"')
-		args[i-1] = '\0';
 
 	if (args[i]) {
 		args[i] = '\0';
-- 
2.13.6
