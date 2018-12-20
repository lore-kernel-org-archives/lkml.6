Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE49218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeLTSHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:07:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbeLTSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:07:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI7A8H3681355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:07:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI7ABn3681352;
        Thu, 20 Dec 2018 10:07:10 -0800
Date:   Thu, 20 Dec 2018 10:07:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5rav4ccyb0sjciysz2i4p3sx@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        tmricht@linux.ibm.com, jolsa@kernel.org, mingo@kernel.org
Reply-To: jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          tmricht@linux.ibm.com, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Cast off_t to s64 to avoid warning on
 bionic libc
Git-Commit-ID: 866053bb644f754d1a93aaa9db9998fecf7a8978
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

Commit-ID:  866053bb644f754d1a93aaa9db9998fecf7a8978
Gitweb:     https://git.kernel.org/tip/866053bb644f754d1a93aaa9db9998fecf7a8978
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 16:43:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:57 -0300

perf tools: Cast off_t to s64 to avoid warning on bionic libc

To avoid this warning:

    CC       /tmp/build/perf/util/s390-cpumsf.o
  util/s390-cpumsf.c: In function 's390_cpumsf_samples':
  util/s390-cpumsf.c:508:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'off_t' [-Wformat=]
     pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
     ^

Now the various Android cross toolchains used in the perf tools
container test builds are all clean and we can remove this:

  export EXTRA_MAKE_ARGS="WERROR=0"

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-5rav4ccyb0sjciysz2i4p3sx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index a2eeebbfb25f..68b2570304ec 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -506,7 +506,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
 	aux_ts = get_trailer_time(buf);
 	if (!aux_ts) {
 		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
-		       sfq->buffer->data_offset);
+		       (s64)sfq->buffer->data_offset);
 		aux_ts = ~0ULL;
 		goto out;
 	}
