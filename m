Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4766F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="g6SIACYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfAKATp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:19:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48748 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728963AbfAKATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:19:43 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0B0HocV022390
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:19:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xrjWxjWGbYia5LnPFEkF+YNTqJ1Rj2KxQYUt1pcW25s=;
 b=g6SIACYuWhRG8vK0EU6IHX/VdkRrF59TNcaUa2tVjpRXSOgkrAAeZuetpa2Jb5XWkqIJ
 jJoiEwdQvomWj5c7RRAbmCeD9p5OdW0pKnh30GOmHVagQ4l+Z2PJSr7jaUCTFEUlmGJb
 qHmRku6//8UidK3twFvWAvK5rxizGkOdOWk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pxb7sh1pc-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:19:41 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 10 Jan 2019 16:19:39 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C035662E2079; Thu, 10 Jan 2019 16:19:37 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v7 perf, bpf-next 0/8] reveal invisible bpf programs
Date:   Thu, 10 Jan 2019 16:19:25 -0800
Message-ID: <20190111001933.4153792-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_09:,,
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

Song Liu (8):
  perf, bpf: Introduce PERF_RECORD_KSYMBOL
  sync tools/include/uapi/linux/perf_event.h
  perf, bpf: introduce PERF_RECORD_BPF_EVENT
  sync tools/include/uapi/linux/perf_event.h
  perf, bpf: emit PERF_RECORD_KSYMBOL for BPF program load/unload
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
