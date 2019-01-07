Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1EA21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867145;
	bh=vIDXWmRUc/kyZxvNo2gXiMb49bMrd3D0zXLfVyrRaco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcN5GAQhuoAECFyWKB30i1fn0tqvuE4bMVtmdIK9AYbHMnuVm4Ww/4xItEVwqQIkH
	 Uvq7oyqtGBkJ/7p+IfQpZVnv8NtF/U9CMiDCF1AOGrsKZ8ulgYg0AACAMox3B6A021
	 HNoSryASr+9Grh/C4dYeZBVbGLQjqWfM79sLZcHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfAGM6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbfAGM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3987206BB;
        Mon,  7 Jan 2019 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865889;
        bh=vIDXWmRUc/kyZxvNo2gXiMb49bMrd3D0zXLfVyrRaco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmhvC5MznuP/rI69rLcbrplUHrgkAdMcX/LFyFjcHKPjeH0QW/nPnI0RlwC3ViVsW
         h2eyqyqQE6LQVI7taQruKQfnELO/NnTNGD9DaKek2voNomcB/boI7nFD/TaUagn8tC
         T8vtuqBQv40STGI8GIsNGB0IsErdBJj/2tjYYoGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 100/170] perf thread: Add fallback functions for cases where cpumode is insufficient
Date:   Mon,  7 Jan 2019 13:32:07 +0100
Message-Id: <20190107104504.812702665@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 8e80ad9983caeee09c3a0a1a37e05bff93becce4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/event.c   |   27 +++++++++++++++++++++++++++
 tools/perf/util/machine.c |   27 +++++++++++++++++++++++++++
 tools/perf/util/machine.h |    2 ++
 tools/perf/util/thread.h  |    4 ++++
 4 files changed, 60 insertions(+)

--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1576,6 +1576,24 @@ struct map *thread__find_map(struct thre
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
@@ -1584,6 +1602,15 @@ struct symbol *thread__find_symbol(struc
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
+
+struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
+				      u64 addr, struct addr_location *al)
+{
+	al->sym = NULL;
+	if (thread__find_map_fb(thread, cpumode, addr, al))
+		al->sym = map__find_symbol(al->map, al->addr);
+	return al->sym;
+}
 
 /*
  * Callers need to drop the reference to al->thread, obtained in
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2575,6 +2575,33 @@ int machine__get_kernel_start(struct mac
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
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -100,6 +100,8 @@ static inline bool machine__kernel_ip(st
 	return ip >= kernel_start;
 }
 
+u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr);
+
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -94,9 +94,13 @@ struct thread *thread__main_thread(struc
 
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


