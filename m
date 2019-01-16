Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD31C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDE420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J0+7GqZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfAPQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:30:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726908AbfAPQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:30:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GGU0Jp007297
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:30:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=HfBH0q7rg5csN8jbG2PRmBEPO+gBFrV8N/W1ORdpyfU=;
 b=J0+7GqZKP9iUgALGeOe7eUThjISYcqS9ik+4+0l3q0t/ACq3u/ekM4osR+SEP/TGKEE/
 EYRzGaKEYK47BPtaA5j2Ht34+vqhmqy7085T0rvESPQJTM0qOjXXz7+j3d5cO1bpMYun
 JEA8XAvmsD+aQe+9PpA/F7elCKMW1/o+OeA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q23b80xyg-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:30:04 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 16 Jan 2019 08:29:54 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D1B0162E1D0D; Wed, 16 Jan 2019 08:29:49 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 perf, bpf-next 0/9] reveal invisible bpf programs
Date:   Wed, 16 Jan 2019 08:29:22 -0800
Message-ID: <20190116162931.1542429-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set catches symbol for all bpf programs loaded/unloaded
before/during/after perf-record run PERF_RECORD_KSYMBOL and
PERF_RECORD_BPF_EVENT.

PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT includes key information
of a bpf program load and unload. They are sent through perf ringbuffer,
and stored in perf.data. PERF_RECORD_KSYMBOL includes basic information
for simple profiling. It is ON by default. PERF_RECORD_BPF_EVENT is
used to gather more information of the bpf program. It is necessary for
perf-annotate of bpf programs.

Before this patch, perf-report will not be able to recover symbols of
bpf programs once the programs are unloaded.

This is to follow up Alexei's early effort [2] to show bpf programs via
mmap events.

Thanks,
Song

Changes v9 -> v10:
1. Added pr_debug() to show issue while synthesize BPF events;
2. Fixed code style to match existing code.

Changes v8 -> PATCH v9:
1. Per suggestion by Arnaldo, recorded checks in perf_missing_features.

Changes v7 -> PATCH v8:

1. Fixed perf dump_stack to use stdout instead of stderr;
2. Added module name [bpf] to /proc/kallsyms (9/9);
3. Do not show warning "Couldn't synthesize bpf events." when the kernel
   does not support proper sys_bpf call;
4. Added Arnaldo's patch that synthesizes BPF events in perf-top.

Changes v6 -> PATCH v7:
1. Split "[3/7] introduce PERF_RECORD_BPF_EVENT" into two commits:
     [3/8] introduce PERF_RECORD_BPF_EVENT
     [5/8] emit PERF_RECORD_KSYMBOL for BPF program load/unload

Changes v5 -> PATCH v6:
1. Reduce len in PERF_RECORD_KSYMBOL from u64 to u32. Use the 32 free bits
   for ksym_type (u16) and flags (u16).

Changes v4 -> PATCH v5:
1. Fixed build error reported by kbuild test bot.

Changes v3 -> PATCH v4:
1. Split information about bpf program  into PERF_RECORD_KSYMBOL (with
   name, addr, len); and PERF_RECORD_BPF_EVENT PERF_RECORD_BPF_EVENT
   (with id, tag);
2. Split the implementation in kernel and user space.

Changes v2 -> PATCH v3:
1. Rebase on bpf-next tree, and on top of BPF sub program tag patches [1]
   for latest information in bpf_prog_info.
2. Complete handling and synthesizing PERF_RECORD_BPF_EVENT in perf.

Changes v1 -> PATCH v2:
1. Only 3 of the 5 patches in v1, to focus on ABI first;
2. Generate PERF_RECORD_BPF_EVENT per bpf sub program instead of per prog;
3. Modify PERF_RECORD_BPF_EVENT with more details (addr, len, name),
   so that it can be used for basic profiling without calling sys_bpf.

Changes RFC -> PATCH v1:
1. In perf-record, poll vip events in a separate thread;
2. Add tag to bpf prog name;
3. Small refactorings.

[1] https://patchwork.ozlabs.org/project/netdev/list/?series=81037
[2] https://www.spinics.net/lists/netdev/msg524232.html

Arnaldo Carvalho de Melo (1):
  perf top: Synthesize BPF events for pre-existing loaded BPF programs

Song Liu (8):
  perf, bpf: Introduce PERF_RECORD_KSYMBOL
  sync tools/include/uapi/linux/perf_event.h
  perf, bpf: introduce PERF_RECORD_BPF_EVENT
  sync tools/include/uapi/linux/perf_event.h
  perf util: handle PERF_RECORD_KSYMBOL
  perf util: handle PERF_RECORD_BPF_EVENT
  perf tools: synthesize PERF_RECORD_* for loaded BPF programs
  bpf: add module name [bpf] to ksymbols for bpf programs

 include/linux/filter.h                |   7 +
 include/linux/perf_event.h            |  19 ++
 include/uapi/linux/perf_event.h       |  53 +++++-
 kernel/bpf/core.c                     |   2 +-
 kernel/bpf/syscall.c                  |   2 +
 kernel/events/core.c                  | 218 +++++++++++++++++++++-
 kernel/kallsyms.c                     |   2 +-
 tools/include/uapi/linux/perf_event.h |  53 +++++-
 tools/perf/builtin-record.c           |   7 +
 tools/perf/builtin-top.c              |   7 +
 tools/perf/perf.h                     |   1 +
 tools/perf/util/Build                 |   2 +
 tools/perf/util/bpf-event.c           | 256 ++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h           |  16 ++
 tools/perf/util/event.c               |  41 +++++
 tools/perf/util/event.h               |  36 ++++
 tools/perf/util/evsel.c               |  19 +-
 tools/perf/util/evsel.h               |   2 +
 tools/perf/util/machine.c             |  58 ++++++
 tools/perf/util/machine.h             |   3 +
 tools/perf/util/session.c             |   8 +
 tools/perf/util/tool.h                |   5 +-
 22 files changed, 810 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

--
2.17.1
