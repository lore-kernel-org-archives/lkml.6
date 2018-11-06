Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BAA2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="auTS5jxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BAA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbeKGGVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:21:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388626AbeKGGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:21:53 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6KrAmt005635
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 12:54:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=cTzFXq2K3ix5ZX7cRxj9mAQi2QOcLu+0CTZ/lUtQMS4=;
 b=auTS5jxmnfSkK6EDXT4F3hPOIiFoscn+vRByNY+CakGFgx/ds5e4G6zr5RdU/VuhRKCT
 NTcin3bmQnTpDZf1rjto2C2WirDC3roCHE4QFN5SgSFPJx/Gpr7MH10AGTPutXy5HdlC
 Q647ldv+rRHH3HbfgAwXIedta6qauDp0R/s= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkf4f0ng3-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 12:54:48 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 6 Nov 2018 12:53:29 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D824062E1CAE; Tue,  6 Nov 2018 12:53:24 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <peterz@infradead.org>,
        <acme@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC perf,bpf 0/5] reveal invisible bpf programs
Date:   Tue, 6 Nov 2018 12:52:41 -0800
Message-ID: <20181106205246.567448-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
   17.02%     0.40%  test  bpf_prog            [k] bpf_prog_F
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
 kernel/events/core.c                  |  82 +++++++-
 tools/include/uapi/linux/perf_event.h |  27 ++-
 tools/perf/builtin-record.c           |  55 +++++
 tools/perf/builtin-report.c           |   2 +
 tools/perf/util/Build                 |   2 +
 tools/perf/util/bpf-info.c            | 287 ++++++++++++++++++++++++++
 tools/perf/util/bpf-info.h            |  29 +++
 tools/perf/util/event.c               |  20 ++
 tools/perf/util/event.h               |  29 +++
 tools/perf/util/evlist.c              |  42 +++-
 tools/perf/util/evlist.h              |   4 +
 tools/perf/util/evsel.c               |   9 +
 tools/perf/util/evsel.h               |   3 +
 tools/perf/util/machine.c             |  10 +
 tools/perf/util/machine.h             |   2 +
 tools/perf/util/session.c             |   8 +
 tools/perf/util/tool.h                |   7 +-
 20 files changed, 646 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/util/bpf-info.c
 create mode 100644 tools/perf/util/bpf-info.h

--
2.17.1
