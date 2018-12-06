Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D49C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2446F208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131623;
	bh=kB/O5dBMZcs3L5B6n5aCCc9bC8aqp9Muxrdvj9AvcLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyiHH1wyUjtVzwYje9M/xEaRKFD3Tc4kevpDVTiqfBAmZa1wrd2QVDsE0EcoUlKpB
	 OOT9ak8DowthtCfNND3kwPraklVlcGBbORDH3ypZLldtsLr6/LCHChvWN+E7JBbTPC
	 IjjUapwfK8cAyKpOT5LT3KskrlDyuxst17JNdssc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2446F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLFV1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFV1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:01 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8019C208E7;
        Thu,  6 Dec 2018 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131620;
        bh=kB/O5dBMZcs3L5B6n5aCCc9bC8aqp9Muxrdvj9AvcLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6jfmPk60xml/3ONduSjLsYRKdC7Jnjtq3V6kq/Yix1WE6SL5G52xdE+4h8kU8LtC
         vigxBrKlB2URT3nFp+ojjpkyMeyGmNmqe2PGXtWk2po3lsJcp6UKZCXJk5XfSkTGq3
         uRMEbUOZmr5kcXkGvGAo5JqUvlZhmfrq9h7SBZuw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/75] perf thread: Add fallback functions for cases where cpumode is insufficient
Date:   Thu,  6 Dec 2018 18:24:54 -0300
Message-Id: <20181206212602.20474-8-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
Cc: stable@vger.kernel.org
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
-- 
2.19.2

