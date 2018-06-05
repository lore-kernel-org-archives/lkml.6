Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeFEQor (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752025AbeFEQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:43:49 -0400
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
Subject: [PATCH v10 4/5] lib/cmdline.c: Implement single quotes in commandline argument parsing.
Date: Tue,  5 Jun 2018 18:43:11 +0200
Message-Id: <dc3f432b92d9f0679813df24de61c37f49343bdb.1528215659.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the kernel parser about on par with bourne shell, grub, and
other tools that chew the arguments before kernel does.

This should make it easier to deal with multiple levels of
nesting/quoting. With same quoting grammar on each level there is less
room for confusion.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
- optimize end quote removal
---
 lib/cmdline.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index aa0086dbb082..e699ed5aac8a 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -192,19 +192,26 @@ bool parse_option_str(const char *str, const char *option)
 }
 
 #define break_arg_end(i) { \
-	if (isspace(args[i]) && !in_quote && !backslash) \
+	if (isspace(args[i]) && !in_quote && !backslash && !in_single) \
 		break; \
 	}
 
+#define squash_char { \
+	break_arg_end(i + 1); \
+	memmove(args + 1, args, i); \
+	args++; \
+	i--; \
+}
+
 /*
  * Parse a string to get a param value pair.
- * You can use " around spaces, and you can escape with \
+ * You can use " or ' around spaces, and you can escape with \
  * Hyphens and underscores equivalent in parameter names.
  */
 char *next_arg(char *args, char **param, char **val, int *state_flags)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0, backslash = 0;
+	int in_quote = 0, backslash = 0, in_single = 0;
 	char *next;
 
 	for (i = 0; args[i]; i++) {
@@ -213,17 +220,23 @@ char *next_arg(char *args, char **param, char **val, int *state_flags)
 		if ((equals == 0) && (args[i] == '='))
 			equals = i;
 
-		if (!backslash) {
-			if ((args[i] == '"') || (args[i] == '\\')) {
+		if (in_single) {
+			if (args[i] == '\'') {
+				in_single = 0;
+
+				squash_char;
+			}
+		} else if (!backslash) {
+			if ((args[i] == '"') || (args[i] == '\\') ||
+					(args[i] == '\'')) {
 				if (args[i] == '"')
 					in_quote = !in_quote;
 				if (args[i] == '\\')
 					backslash = 1;
+				if (args[i] == '\'')
+					in_single = 1;
 
-				break_arg_end(i + 1);
-				memmove(args + 1, args, i);
-				args++;
-				i--;
+				squash_char;
 			}
 		} else {
 			backslash = 0;
-- 
2.13.6
