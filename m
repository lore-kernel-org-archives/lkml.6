Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170B821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLRNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:50:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:50:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDnV7f2850471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:49:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDnVs22850466;
        Tue, 18 Dec 2018 05:49:31 -0800
Date:   Tue, 18 Dec 2018 05:49:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-8e80ad9983caeee09c3a0a1a37e05bff93becce4@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, jolsa@redhat.com,
        ak@linux.intel.com, davem@davemloft.net, adrian.hunter@intel.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: ak@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org, mathieu.poirier@linaro.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, leo.yan@linaro.org, davem@davemloft.net
In-Reply-To: <20181106210712.12098-2-adrian.hunter@intel.com>
References: <20181106210712.12098-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Add fallback functions for cases where
 cpumode is insufficient
Git-Commit-ID: 8e80ad9983caeee09c3a0a1a37e05bff93becce4
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

Commit-ID:  8e80ad9983caeee09c3a0a1a37e05bff93becce4
Gitweb:     https://git.kernel.org/tip/8e80ad9983caeee09c3a0a1a37e05bff93becce4
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Nov 2018 23:07:10 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:13 -0300

perf thread: Add fallback functions for cases where cpumode is insufficient

For branch stacks or branch samples, the sample cpumode might not be
correct because it applies only to the sample 'ip' and not necessary to
'addr' or branch stack addresses. Add fallback functions that can be
used to deal with those cases

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c   | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/machine.h |  2 ++
 tools/perf/util/thread.h  |  4 ++++
 4 files changed, 60 insertions(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a6b1c3..9431b20c1337 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1577,6 +1577,24 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	return al->map;
 }
 
+/*
+ * For branch stacks or branch samples, the sample cpumode might not be correct
+ * because it applies only to the sample 'ip' and not necessary to 'addr' or
+ * branch stack addresses. If possible, use a fallback to deal with those cases.
+ */
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al)
+{
+	struct map *map = thread__find_map(thread, cpumode, addr, al);
+	struct machine *machine = thread->mg->machine;
+	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
+
+	if (map || addr_cpumode == cpumode)
+		return map;
+
+	return thread__find_map(thread, addr_cpumode, addr, al);
+}
+
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
@@ -1586,6 +1604,15 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al)
+{
+	al->sym = NULL;
+	if (thread__find_map_fb(thread, cpumode, addr, al))
+		al->sym = map__find_symbol(al->map, al->addr);
+	return al->sym;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8f36ce813bc5..9397e3f2444d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2592,6 +2592,33 @@ int machine__get_kernel_start(struct machine *machine)
 	return err;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
+{
+	u8 addr_cpumode = cpumode;
+	bool kernel_ip;
+
+	if (!machine->single_address_space)
+		goto out;
+
+	kernel_ip = machine__kernel_ip(machine, addr);
+	switch (cpumode) {
+	case PERF_RECORD_MISC_KERNEL:
+	case PERF_RECORD_MISC_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_KERNEL :
+					   PERF_RECORD_MISC_USER;
+		break;
+	case PERF_RECORD_MISC_GUEST_KERNEL:
+	case PERF_RECORD_MISC_GUEST_USER:
+		addr_cpumode = kernel_ip ? PERF_RECORD_MISC_GUEST_KERNEL :
+					   PERF_RECORD_MISC_GUEST_USER;
+		break;
+	default:
+		break;
+	}
+out:
+	return addr_cpumode;
+}
+
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 {
 	return dsos__findnew(&machine->dsos, filename);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ca897a73014c..ebde3ea70225 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -100,6 +100,8 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
 	return ip >= kernel_start;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
+
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 30e2b4c165fe..5920c3bb8ffe 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -96,9 +96,13 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al);
+struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+				struct addr_location *al);
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
