Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeCGI2k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:28:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754285AbeCGI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:28:37 -0500
Date: Wed, 7 Mar 2018 00:28:26 -0800
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-de19e5c3c51fdb1ff20d0f61d099db902ff7494b@git.kernel.org>
Cc: tglx@linutronix.de, acme@redhat.com, wangnan0@huawei.com,
        mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1519807144-30694-1-git-send-email-adrian.hunter@intel.com>
References: <1519807144-30694-1-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix trigger class trigger_on()
Git-Commit-ID: de19e5c3c51fdb1ff20d0f61d099db902ff7494b
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

Commit-ID:  de19e5c3c51fdb1ff20d0f61d099db902ff7494b
Gitweb:     https://git.kernel.org/tip/de19e5c3c51fdb1ff20d0f61d099db902ff7494b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 28 Feb 2018 10:39:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Mar 2018 11:31:14 -0300

perf tools: Fix trigger class trigger_on()

trigger_on() means that the trigger is available but not ready, however
trigger_on() was making it ready. That can segfault if the signal comes
before trigger_ready(). e.g. (USR2 signal delivery not shown)

  $ perf record -e intel_pt//u -S sleep 1
  perf: Segmentation fault
  Obtained 16 stack frames.
  /home/ahunter/bin/perf(sighandler_dump_stack+0x40) [0x4ec550]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /home/ahunter/bin/perf(perf_evsel__disable+0x26) [0x4b9dd6]
  /home/ahunter/bin/perf() [0x43a45b]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /lib/x86_64-linux-gnu/libc.so.6(__xstat64+0x15) [0x7fa7641d2cc5]
  /home/ahunter/bin/perf() [0x4ec6c9]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4eca15]
  /home/ahunter/bin/perf(machine__create_kernel_maps+0x257) [0x4f0b77]
  /home/ahunter/bin/perf(perf_session__new+0xc0) [0x4f86f0]
  /home/ahunter/bin/perf(cmd_record+0x722) [0x43c132]
  /home/ahunter/bin/perf() [0x4a11ae]
  /home/ahunter/bin/perf(main+0x5d4) [0x427fb4]

Note, for testing purposes, this is hard to hit unless you add some sleep()
in builtin-record.c before record__open().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 3dcc4436fa6f ("perf tools: Introduce trigger class")
Link: http://lkml.kernel.org/r/1519807144-30694-1-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trigger.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
index 370138e7e35c..88223bc7c82b 100644
--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -12,7 +12,7 @@
  * States and transits:
  *
  *
- *  OFF--(on)--> READY --(hit)--> HIT
+ *  OFF--> ON --> READY --(hit)--> HIT
  *                 ^               |
  *                 |            (ready)
  *                 |               |
@@ -27,8 +27,9 @@ struct trigger {
 	volatile enum {
 		TRIGGER_ERROR		= -2,
 		TRIGGER_OFF		= -1,
-		TRIGGER_READY		= 0,
-		TRIGGER_HIT		= 1,
+		TRIGGER_ON		= 0,
+		TRIGGER_READY		= 1,
+		TRIGGER_HIT		= 2,
 	} state;
 	const char *name;
 };
@@ -50,7 +51,7 @@ static inline bool trigger_is_error(struct trigger *t)
 static inline void trigger_on(struct trigger *t)
 {
 	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
-	t->state = TRIGGER_READY;
+	t->state = TRIGGER_ON;
 }
 
 static inline void trigger_ready(struct trigger *t)
