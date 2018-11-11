Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2C7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DB52148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB52148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbeKLGU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50376 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730405AbeKLFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000oP-DG; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001t1-Ms; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Wang Nan" <wangnan0@huawei.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.79557172@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 354/366] perf script: Use readdir() instead of
 deprecated readdir_r()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit a5e8e825bd1704c488bf6a46936aaf3b9f203d6a upstream.

The readdir() function is thread safe as long as just one thread uses a
DIR, which is the case in 'perf script', so, to avoid breaking the build
with glibc-2.23.90 (upcoming 2.24), use it instead of readdir_r().

See: http://man7.org/linux/man-pages/man3/readdir.3.html

"However, in modern implementations (including the glibc implementation),
concurrent calls to readdir() that specify different directory streams
are thread-safe.  In cases where multiple threads must read from the
same directory stream, using readdir() with external synchronization is
still preferable to the use of the deprecated readdir_r(3) function."

Noticed while building on a Fedora Rawhide docker container.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-mt3xz7n2hl49ni2vx7kuq74g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/builtin-script.c | 70 ++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1061,21 +1061,19 @@ static int is_directory(const char *base
 	return S_ISDIR(st.st_mode);
 }
 
-#define for_each_lang(scripts_path, scripts_dir, lang_dirent, lang_next)\
-	while (!readdir_r(scripts_dir, &lang_dirent, &lang_next) &&	\
-	       lang_next)						\
-		if ((lang_dirent.d_type == DT_DIR ||			\
-		     (lang_dirent.d_type == DT_UNKNOWN &&		\
-		      is_directory(scripts_path, &lang_dirent))) &&	\
-		    (strcmp(lang_dirent.d_name, ".")) &&		\
-		    (strcmp(lang_dirent.d_name, "..")))
-
-#define for_each_script(lang_path, lang_dir, script_dirent, script_next)\
-	while (!readdir_r(lang_dir, &script_dirent, &script_next) &&	\
-	       script_next)						\
-		if (script_dirent.d_type != DT_DIR &&			\
-		    (script_dirent.d_type != DT_UNKNOWN ||		\
-		     !is_directory(lang_path, &script_dirent)))
+#define for_each_lang(scripts_path, scripts_dir, lang_dirent)		\
+	while ((lang_dirent = readdir(scripts_dir)) != NULL)		\
+		if ((lang_dirent->d_type == DT_DIR ||			\
+		     (lang_dirent->d_type == DT_UNKNOWN &&		\
+		      is_directory(scripts_path, lang_dirent))) &&	\
+		    (strcmp(lang_dirent->d_name, ".")) &&		\
+		    (strcmp(lang_dirent->d_name, "..")))
+
+#define for_each_script(lang_path, lang_dir, script_dirent)		\
+	while ((script_dirent = readdir(lang_dir)) != NULL)		\
+		if (script_dirent->d_type != DT_DIR &&			\
+		    (script_dirent->d_type != DT_UNKNOWN ||		\
+		     !is_directory(lang_path, script_dirent)))
 
 
 #define RECORD_SUFFIX			"-record"
@@ -1221,7 +1219,7 @@ static int list_available_scripts(const
 				  const char *s __maybe_unused,
 				  int unset __maybe_unused)
 {
-	struct dirent *script_next, *lang_next, script_dirent, lang_dirent;
+	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN];
 	DIR *scripts_dir, *lang_dir;
 	char script_path[MAXPATHLEN];
@@ -1236,19 +1234,19 @@ static int list_available_scripts(const
 	if (!scripts_dir)
 		return -1;
 
-	for_each_lang(scripts_path, scripts_dir, lang_dirent, lang_next) {
+	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
 		snprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			 lang_dirent.d_name);
+			 lang_dirent->d_name);
 		lang_dir = opendir(lang_path);
 		if (!lang_dir)
 			continue;
 
-		for_each_script(lang_path, lang_dir, script_dirent, script_next) {
-			script_root = get_script_root(&script_dirent, REPORT_SUFFIX);
+		for_each_script(lang_path, lang_dir, script_dirent) {
+			script_root = get_script_root(script_dirent, REPORT_SUFFIX);
 			if (script_root) {
 				desc = script_desc__findnew(script_root);
 				snprintf(script_path, MAXPATHLEN, "%s/%s",
-					 lang_path, script_dirent.d_name);
+					 lang_path, script_dirent->d_name);
 				read_script_info(desc, script_path);
 				free(script_root);
 			}
@@ -1336,7 +1334,7 @@ static int check_ev_match(char *dir_name
  */
 int find_scripts(char **scripts_array, char **scripts_path_array)
 {
-	struct dirent *script_next, *lang_next, script_dirent, lang_dirent;
+	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
 	DIR *scripts_dir, *lang_dir;
 	struct perf_session *session;
@@ -1359,9 +1357,9 @@ int find_scripts(char **scripts_array, c
 		return -1;
 	}
 
-	for_each_lang(scripts_path, scripts_dir, lang_dirent, lang_next) {
+	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
 		snprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
-			 lang_dirent.d_name);
+			 lang_dirent->d_name);
 #ifdef NO_LIBPERL
 		if (strstr(lang_path, "perl"))
 			continue;
@@ -1375,16 +1373,16 @@ int find_scripts(char **scripts_array, c
 		if (!lang_dir)
 			continue;
 
-		for_each_script(lang_path, lang_dir, script_dirent, script_next) {
+		for_each_script(lang_path, lang_dir, script_dirent) {
 			/* Skip those real time scripts: xxxtop.p[yl] */
-			if (strstr(script_dirent.d_name, "top."))
+			if (strstr(script_dirent->d_name, "top."))
 				continue;
 			sprintf(scripts_path_array[i], "%s/%s", lang_path,
-				script_dirent.d_name);
-			temp = strchr(script_dirent.d_name, '.');
+				script_dirent->d_name);
+			temp = strchr(script_dirent->d_name, '.');
 			snprintf(scripts_array[i],
-				(temp - script_dirent.d_name) + 1,
-				"%s", script_dirent.d_name);
+				(temp - script_dirent->d_name) + 1,
+				"%s", script_dirent->d_name);
 
 			if (check_ev_match(lang_path,
 					scripts_array[i], session))
@@ -1402,7 +1400,7 @@ int find_scripts(char **scripts_array, c
 
 static char *get_script_path(const char *script_root, const char *suffix)
 {
-	struct dirent *script_next, *lang_next, script_dirent, lang_dirent;
+	struct dirent *script_dirent, *lang_dirent;
 	char scripts_path[MAXPATHLEN];
 	char script_path[MAXPATHLEN];
 	DIR *scripts_dir, *lang_dir;
@@ -1415,21 +1413,21 @@ static char *get_script_path(const char
 	if (!scripts_dir)
 		return NULL;
 
-	for_each_lang(scripts_path, scripts_dir, lang_dirent, lang_next) {
+	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
 		snprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			 lang_dirent.d_name);
+			 lang_dirent->d_name);
 		lang_dir = opendir(lang_path);
 		if (!lang_dir)
 			continue;
 
-		for_each_script(lang_path, lang_dir, script_dirent, script_next) {
-			__script_root = get_script_root(&script_dirent, suffix);
+		for_each_script(lang_path, lang_dir, script_dirent) {
+			__script_root = get_script_root(script_dirent, suffix);
 			if (__script_root && !strcmp(script_root, __script_root)) {
 				free(__script_root);
 				closedir(lang_dir);
 				closedir(scripts_dir);
 				snprintf(script_path, MAXPATHLEN, "%s/%s",
-					 lang_path, script_dirent.d_name);
+					 lang_path, script_dirent->d_name);
 				return strdup(script_path);
 			}
 			free(__script_root);

