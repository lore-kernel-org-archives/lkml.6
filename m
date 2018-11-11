Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B1214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B1214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeKLGUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50416 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730410AbeKLFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000l8-G7; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001tB-Q1; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Namhyung Kim" <namhyung@kernel.org>,
        "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Wang Nan" <wangnan0@huawei.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.396460268@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 356/366] perf tools: Use readdir() instead of
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

commit 7093b4c963cc4e344e490c774924a180602a7092 upstream.

The readdir() function is thread safe as long as just one thread uses a
DIR, which is the case when synthesizing events for pre-existing threads
by traversing /proc, so, to avoid breaking the build with glibc-2.23.90
(upcoming 2.24), use it instead of readdir_r().

See: http://man7.org/linux/man-pages/man3/readdir.3.html

"However, in modern implementations (including the glibc implementation),
concurrent calls to readdir() that specify different directory streams
are thread-safe.  In cases where multiple threads must read from the
same directory stream, using readdir() with external synchronization is
still preferable to the use of the deprecated readdir_r(3) function."

Noticed while building on a Fedora Rawhide docker container.

   CC       /tmp/build/perf/util/event.o
  util/event.c: In function '__event__synthesize_thread':
  util/event.c:466:2: error: 'readdir_r' is deprecated [-Werror=deprecated-declarations]
    while (!readdir_r(tasks, &dirent, &next) && next) {
    ^~~~~
  In file included from /usr/include/features.h:368:0,
                   from /usr/include/stdint.h:25,
                   from /usr/lib/gcc/x86_64-redhat-linux/6.0.0/include/stdint.h:9,
                   from /git/linux/tools/include/linux/types.h:6,
                   from util/event.c:1:
  /usr/include/dirent.h:189:12: note: declared here

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-i1vj7nyjp2p750rirxgrfd3c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/event.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -331,7 +331,7 @@ static int __event__synthesize_thread(un
 {
 	char filename[PATH_MAX];
 	DIR *tasks;
-	struct dirent dirent, *next;
+	struct dirent *dirent;
 	pid_t tgid;
 
 	/* special case: only send one comm event using passed in pid */
@@ -358,12 +358,12 @@ static int __event__synthesize_thread(un
 		return 0;
 	}
 
-	while (!readdir_r(tasks, &dirent, &next) && next) {
+	while ((dirent = readdir(tasks)) != NULL) {
 		char *end;
 		int rc = 0;
 		pid_t _pid;
 
-		_pid = strtol(dirent.d_name, &end, 10);
+		_pid = strtol(dirent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -464,7 +464,7 @@ int perf_event__synthesize_threads(struc
 {
 	DIR *proc;
 	char proc_path[PATH_MAX];
-	struct dirent dirent, *next;
+	struct dirent *dirent;
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	int err = -1;
 
@@ -489,9 +489,9 @@ int perf_event__synthesize_threads(struc
 	if (proc == NULL)
 		goto out_free_fork;
 
-	while (!readdir_r(proc, &dirent, &next) && next) {
+	while ((dirent = readdir(proc)) != NULL) {
 		char *end;
-		pid_t pid = strtol(dirent.d_name, &end, 10);
+		pid_t pid = strtol(dirent->d_name, &end, 10);
 
 		if (*end) /* only interested in proper numerical dirents */
 			continue;

