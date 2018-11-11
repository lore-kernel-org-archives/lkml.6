Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CDFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B3720818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B3720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbeKLFsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50332 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730392AbeKLFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:19 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000lJ-9w; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001t6-OI; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wang Nan" <wangnan0@huawei.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.318669247@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 355/366] perf thread_map: Use readdir() instead of
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

commit 3354cf71104de49326d19d2f9bdb1f66eea52ef4 upstream.

The readdir() function is thread safe as long as just one thread uses a
DIR, which is the case in thread_map, so, to avoid breaking the build
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
Link: http://lkml.kernel.org/n/tip-del8h2a0f40z75j4r42l96l0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/thread_map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -64,7 +64,7 @@ struct thread_map *thread_map__new_by_ui
 	DIR *proc;
 	int max_threads = 32, items, i;
 	char path[256];
-	struct dirent dirent, *next, **namelist = NULL;
+	struct dirent *dirent, **namelist = NULL;
 	struct thread_map *threads = malloc(sizeof(*threads) +
 					    max_threads * sizeof(pid_t));
 	if (threads == NULL)
@@ -76,16 +76,16 @@ struct thread_map *thread_map__new_by_ui
 
 	threads->nr = 0;
 
-	while (!readdir_r(proc, &dirent, &next) && next) {
+	while ((dirent = readdir(proc)) != NULL) {
 		char *end;
 		bool grow = false;
 		struct stat st;
-		pid_t pid = strtol(dirent.d_name, &end, 10);
+		pid_t pid = strtol(dirent->d_name, &end, 10);
 
 		if (*end) /* only interested in proper numerical dirents */
 			continue;
 
-		snprintf(path, sizeof(path), "/proc/%s", dirent.d_name);
+		snprintf(path, sizeof(path), "/proc/%s", dirent->d_name);
 
 		if (stat(path, &st) != 0)
 			continue;

