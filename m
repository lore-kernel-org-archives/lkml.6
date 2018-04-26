Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeDZFz4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:55:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeDZFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:55:51 -0400
Date: Wed, 25 Apr 2018 22:55:43 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-5d9946c3e5e38e07ab7019db9413a96807a325f2@git.kernel.org>
Cc: brueckner@linux.vnet.ibm.com, tmricht@linux.ibm.com,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        tglx@linutronix.de, heiko.carstens@de.ibm.com, mingo@kernel.org,
        hpa@zytor.com, acme@redhat.com
Reply-To: mingo@kernel.org, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com
In-Reply-To: <20180423142940.21143-1-tmricht@linux.ibm.com>
References: <20180423142940.21143-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Fix s390 undefined
 record__auxtrace_init() return value
Git-Commit-ID: 5d9946c3e5e38e07ab7019db9413a96807a325f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5d9946c3e5e38e07ab7019db9413a96807a325f2
Gitweb:     https://git.kernel.org/tip/5d9946c3e5e38e07ab7019db9413a96807a325f2
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Mon, 23 Apr 2018 16:29:40 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 12:05:02 -0300

perf record: Fix s390 undefined record__auxtrace_init() return value

Command 'perf record' calls:

  cmd_report()
    record__auxtrace_init()
       auxtrace_record__init()

On s390 function auxtrace_record__init() returns random return value due
to missing initialization.

This sometime causes 'perf record' to exit immediately without error
message and creating a perf.data file.

Fix this by setting error the return code to zero before returning from
platform specific functions which may not set the error code in call
cases.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180423142940.21143-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/auxtrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 6cb48e4cffd9..3afe8256eff2 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -87,6 +87,7 @@ struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
 	struct perf_evsel *pos;
 	int diagnose = 0;
 
+	*err = 0;
 	if (evlist->nr_entries == 0)
 		return NULL;
 
