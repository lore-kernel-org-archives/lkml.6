Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC2C214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GvLtOU1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC2C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbeKVGbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:31:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60784 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732576AbeKVGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:31:24 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALJpRVF002473
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=RiHwm2h8NVbXXPTiYyLmwjF8A6ju8lwMsd5VnZdgrt4=;
 b=GvLtOU1Z2OUeN/nMcY5i3cNifmIA3xqRIGpUS3X4f+qMvv/hukrYn8AzA40X6YMv+AqN
 mMvxOvdNYBrkRNVAvN4m0635fCps5Rgc+EhrQ0ekc6/PHnyPtrldiurhhtZv3zRBgAOp
 6DiAHUHaOOyjqC8xK7FhjDRtKzPLbsiYGH0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2nwdmtr27f-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:40 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 21 Nov 2018 11:55:38 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1484062E19DA; Wed, 21 Nov 2018 11:55:31 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <acme@kernel.org>, <peterz@infradead.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Date:   Wed, 21 Nov 2018 11:54:57 -0800
Message-ID: <20181121195502.3259930-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes RFC -> PATCH v1:

1. In perf-record, poll vip events in a separate thread;
2. Add tag to bpf prog name;
3. Small refactorings.

Original cover letter (with minor revisions):

This is to follow up Alexei's early effort to show bpf programs

   https://www.spinics.net/lists/netdev/msg524232.html

In this version, PERF_RECORD_BPF_EVENT is introduced to send real time BPF
load/unload events to user space. In user space, perf-record is modified
to listen to these events (through a dedicated ring buffer) and generate
detailed information about the program (struct bpf_prog_info_event). Then,
perf-report translates these events into proper symbols.

With this set, perf-report will show bpf program as:

   18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
   18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
   17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80df72b_
   16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
   16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
   16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read

Note that, the program name is still work in progress, it will be cleaner
with function types in BTF.

Please share your comments on this.

Thanks,
Song

Song Liu (5):
  perf, bpf: Introduce PERF_RECORD_BPF_EVENT
  perf: sync tools/include/uapi/linux/perf_event.h
  perf util: basic handling of PERF_RECORD_BPF_EVENT
  perf util: introduce bpf_prog_info_event
  perf util: generate bpf_prog_info_event for short living bpf programs

 include/linux/perf_event.h            |   5 +
 include/uapi/linux/perf_event.h       |  27 ++-
 kernel/bpf/syscall.c                  |   4 +
 kernel/events/core.c                  |  82 ++++++-
 tools/include/uapi/linux/perf_event.h |  27 ++-
 tools/perf/builtin-record.c           |  91 +++++++-
 tools/perf/builtin-report.c           |   2 +
 tools/perf/util/Build                 |   2 +
 tools/perf/util/bpf-info.c            | 305 ++++++++++++++++++++++++++
 tools/perf/util/bpf-info.h            |  29 +++
 tools/perf/util/event.c               |  21 ++
 tools/perf/util/event.h               |  29 +++
 tools/perf/util/evlist.c              |  58 ++++-
 tools/perf/util/evlist.h              |   6 +
 tools/perf/util/evsel.c               |   9 +
 tools/perf/util/evsel.h               |   3 +
 tools/perf/util/machine.c             |  10 +
 tools/perf/util/machine.h             |   2 +
 tools/perf/util/session.c             |   8 +
 tools/perf/util/tool.h                |   7 +-
 20 files changed, 714 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/util/bpf-info.c
 create mode 100644 tools/perf/util/bpf-info.h

--
2.17.1
