Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8783C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE2218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeLTSGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:06:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60943 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388493AbeLTSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:06:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI621C3681078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:06:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI61ju3681060;
        Thu, 20 Dec 2018 10:06:01 -0800
Date:   Thu, 20 Dec 2018 10:06:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6bz74zp080yhmtiwb36enso9@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Fix up argument to ctime()
Git-Commit-ID: 0afcf29bab35d3785204cd9bd51693b231ad7181
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0afcf29bab35d3785204cd9bd51693b231ad7181
Gitweb:     https://git.kernel.org/tip/0afcf29bab35d3785204cd9bd51693b231ad7181
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 16:11:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:56 -0300

perf header: Fix up argument to ctime()

Reducing this noise when cross building to the Android NDK:

  util/header.c: In function 'perf_header__fprintf_info':
  util/header.c:2710:45: warning: pointer targets in passing argument 1 of 'ctime' differ in signedness [-Wpointer-sign]
    fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
                                               ^
  In file included from util/../perf.h:5:0,
                   from util/evlist.h:11,
                   from util/header.c:22:
  /opt/android-ndk-r15c/platforms/android-26/arch-arm/usr/include/time.h:81:14: note: expected 'const time_t *' but argument is of type 'long unsigned int *'
   extern char* ctime(const time_t*) __LIBC_ABI_PUBLIC__;
                ^

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6bz74zp080yhmtiwb36enso9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1171d8400bf4..dec6d218c31c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2698,6 +2698,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	struct perf_header *header = &session->header;
 	int fd = perf_data__fd(session->data);
 	struct stat st;
+	time_t stctime;
 	int ret, bit;
 
 	hd.fp = fp;
@@ -2707,7 +2708,8 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
 	if (ret == -1)
 		return -1;
 
-	fprintf(fp, "# captured on    : %s", ctime(&st.st_ctime));
+	stctime = st.st_ctime;
+	fprintf(fp, "# captured on    : %s", ctime(&stctime));
 
 	fprintf(fp, "# header version : %u\n", header->version);
 	fprintf(fp, "# data offset    : %" PRIu64 "\n", header->data_offset);
