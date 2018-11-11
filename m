Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E298C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD9D20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD9D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbeKLGWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50202 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730293AbeKLFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:17 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsd-0000tu-U9; Sun, 11 Nov 2018 19:58:47 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsb-0001tt-0o; Sun, 11 Nov 2018 19:58:45 +0000
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
Message-ID: <lsq.1541965745.610208314@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 365/366] perf thread_map: Correctly size buffer used
 with dirent->dt_name
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

commit bdf23a9a190d7ecea092fd5c4aabb7d4bd0a9980 upstream.

The size of dirent->dt_name is NAME_MAX + 1, but the size for the 'path'
buffer is hard coded at 256, which may truncate it because we also
prepend "/proc/", so that all that into account and thank gcc 7 for this
warning:

  /git/linux/tools/perf/util/thread_map.c: In function 'thread_map__new_by_uid':
  /git/linux/tools/perf/util/thread_map.c:119:39: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 250 [-Werror=format-truncation=]
     snprintf(path, sizeof(path), "/proc/%s", dirent->d_name);
                                         ^~
  In file included from /usr/include/stdio.h:939:0,
                   from /git/linux/tools/perf/util/thread_map.c:5:
  /usr/include/bits/stdio2.h:64:10: note: '__builtin___snprintf_chk' output between 7 and 262 bytes into a destination of size 256
     return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          __bos (__s), __fmt, __va_arg_pack ());
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-csy0r8zrvz5efccgd4k12c82@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/thread_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -63,7 +63,7 @@ struct thread_map *thread_map__new_by_ui
 {
 	DIR *proc;
 	int max_threads = 32, items, i;
-	char path[256];
+	char path[NAME_MAX + 1 + 6];
 	struct dirent *dirent, **namelist = NULL;
 	struct thread_map *threads = malloc(sizeof(*threads) +
 					    max_threads * sizeof(pid_t));

