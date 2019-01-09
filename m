Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F7C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C374D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a6RuH4UG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfAITX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:23:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59062 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728449AbfAITX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:23:27 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x09JN46A027935
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 11:23:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=R1xQPyv9JL6qBw13Di1jhEuVapxwBO0qOXzt9RVwgws=;
 b=a6RuH4UGRYOOVCFw8iRxbvR46yNIHvISrO1rN5TqTL/DxlC9lSpmpEcdVda8wBI7FB4g
 C8DsscKHGYNfnNuVtoSMLXhDoiRsEMhvGQwOpSfZlbKTURanalz+5Wb2XplfaVMOAf8C
 jCjl0ee994IgGwGKySm2VJigPU0RhpPDdik= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2pwk0r8u6v-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:23:26 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 9 Jan 2019 11:21:40 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 386E762E1B12; Wed,  9 Jan 2019 11:21:37 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 perf, bpf-next 0/7] reveal invisible bpf programs
Date:   Wed, 9 Jan 2019 11:21:04 -0800
Message-ID: <20190109192111.130995-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
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

Song Liu (7):
  perf, bpf: Introduce PERF_RECORD_KSYMBOL
  sync tools/include/uapi/linux/perf_event.h
  perf, bpf: introduce PERF_RECORD_BPF_EVENT
  sync tools/include/uapi/linux/perf_event.h
  perf util: handle PERF_RECORD_KSYMBOL
  perf util: handle PERF_RECORD_BPF_EVENT
  perf tools: synthesize PERF_RECORD_* for loaded BPF programs

 include/linux/filter.h                |   7 +
 include/linux/perf_event.h            |  19 +++
 include/uapi/linux/perf_event.h       |  53 ++++++-
 kernel/bpf/core.c                     |   2 +-
 kernel/bpf/syscall.c                  |   2 +
 kernel/events/core.c                  | 218 ++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  53 ++++++-
 tools/perf/builtin-record.c           |   7 +
 tools/perf/perf.h                     |   1 +
 tools/perf/util/Build                 |   2 +
 tools/perf/util/bpf-event.c           | 220 ++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h           |  16 ++
 tools/perf/util/event.c               |  41 +++++
 tools/perf/util/event.h               |  36 +++++
 tools/perf/util/evsel.c               |  19 +++
 tools/perf/util/evsel.h               |   2 +
 tools/perf/util/machine.c             |  60 +++++++
 tools/perf/util/machine.h             |   3 +
 tools/perf/util/session.c             |   8 +
 tools/perf/util/tool.h                |   5 +-
 20 files changed, 769 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

--
2.17.1
