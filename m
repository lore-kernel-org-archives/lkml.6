Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDPGrq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:47:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeDPGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:47:43 -0400
Date: Sun, 15 Apr 2018 23:47:35 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-4f75f1cbf95e2f0853cd229d042b203931b899af@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        tmricht@linux.ibm.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, schwidefsky@de.ibm.com
Reply-To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        tmricht@linux.ibm.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de
In-Reply-To: <20180412133246.92801-1-tmricht@linux.ibm.com>
References: <20180412133246.92801-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Change warning for missing sysfs
 entry to debug
Git-Commit-ID: 4f75f1cbf95e2f0853cd229d042b203931b899af
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

Commit-ID:  4f75f1cbf95e2f0853cd229d042b203931b899af
Gitweb:     https://git.kernel.org/tip/4f75f1cbf95e2f0853cd229d042b203931b899af
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 12 Apr 2018 15:32:46 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 13 Apr 2018 09:59:56 -0300

perf record: Change warning for missing sysfs entry to debug

Using perf on 4.16.0 kernel on s390 shows this warning:

   failed: can't open node sysfs data

each time I run command perf record ... for example:

  [root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  failed: can't open node sysfs data
  [ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
  [root@s35lp76 perf]#

It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY feature
to perf data file") tries to open directory named /sys/devices/system/node/
which does not exist on s390.

This is the call stack:
 __cmd_record
 +---> perf_session__write_header
       +---> perf_header__adds_write
             +---> do_write_feat
	           +---> write_mem_topology
		         +---> build_mem_topology
			       prints warning

The issue starts in do_write_feat() which unconditionally loops over all
features and now includes HEADER_MEM_TOPOLOGY and calls write_mem_topology().

Function record__init_features() at the beginning of __cmd_record() sets
all features and then turns off some of them.

Fix this by changing the warning to a level 2 debug output statement.

So it is only shown when debug level 2 or higher is set.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180412133246.92801-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 121df1683c36..a8bff2178fbc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1320,7 +1320,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: can't open node sysfs data\n");
+		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
+			  __func__, path);
 		return -1;
 	}
 
