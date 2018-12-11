Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6739EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9ED2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Min0xPRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9ED2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLKXd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:33:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbeLKXd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:33:59 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBNUoG8019430
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:33:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=P1PcUahTBgvwx+6jCQgoGCpumV83AB5ePpQf07L5tLA=;
 b=Min0xPRMRTjqCEDRkqq/NAGo53raUkyBsxEUBO0t7Ynq0iX/jN+KPWrSLtfidtHIwRGd
 /0dp2S2Yci+KhBiwLqDrgMXjuHC9cmvp72GV2OUHj2zHE3oKI52t/2RJQIieXa3oNVcB
 8eHC4f0yistRSeICJtCWRvDTZz/9YHUcLlU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pap88g4t8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:33:58 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 11 Dec 2018 15:33:57 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 0F3B962E1B75; Tue, 11 Dec 2018 15:33:54 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 perf, bpf-next 0/4] reveal invisible bpf programs
Date:   Tue, 11 Dec 2018 15:33:46 -0800
Message-ID: <20181211233351.4036381-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set catches symbol for all BPF programs loaded/unloaded
before/during/after perf-record run in a mmap-like event,
PERF_RECORD_BPF_EVENT.

PERF_RECORD_BPF_EVENT includes key information of a BPF program load and
unload. It is sent through perf ringbuffer, and stored in perf.data.
Before this patch, perf-report will not be able to recover symbols of
BPF programs once the programs are unloaded.

Besides basic mmap-like information (name, addr, size),
PERF_RECORD_BPF_EVENT includes BPF program id, and tag. These information
can be used for detailed performance analysis like annotation.

This is to follow up Alexei's early effort [2] to show bpf programs via
mmap events.

Thanks,
Song


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

Song Liu (4):
  perf, bpf: Introduce PERF_RECORD_BPF_EVENT
  perf: sync tools/include/uapi/linux/perf_event.h
  perf util: handle PERF_RECORD_BPF_EVENT
  perf tools: synthesize bpf event for loaded BPF programs

 include/linux/filter.h                |   7 +
 include/linux/perf_event.h            |  10 +
 include/uapi/linux/perf_event.h       |  35 +++-
 kernel/bpf/core.c                     |   2 +-
 kernel/bpf/syscall.c                  |   3 +
 kernel/events/core.c                  | 123 ++++++++++++-
 tools/include/uapi/linux/perf_event.h |  35 +++-
 tools/perf/builtin-record.c           |   6 +
 tools/perf/util/Build                 |   2 +
 tools/perf/util/bpf-event.c           | 251 ++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h           |  15 ++
 tools/perf/util/event.c               |  23 +++
 tools/perf/util/event.h               |  26 +++
 tools/perf/util/evsel.c               |   9 +
 tools/perf/util/evsel.h               |   1 +
 tools/perf/util/machine.c             |   3 +
 tools/perf/util/session.c             |   4 +
 tools/perf/util/tool.h                |   4 +-
 18 files changed, 554 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

--
2.17.1
