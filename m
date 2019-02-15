Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06551C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B526A222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aLXato9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfBOVyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:54:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbfBOVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:54:12 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1FLpnoE028315
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:54:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=MZdKgmhdh+j9IJAcpE1C9fdjz6h+tWFco/7DEOaYmoU=;
 b=aLXato9n/4oGIQ4DvRwxNvxQ+ks//yScxVS5SStlG6XPzU4W7cChtWhk0cF+SuWj+C6t
 dH3B+ED/Zm0VRnfup4TqnSn9hSgE1/YL9fSjwzqyaw7cIEieAtbl25gZoxv8PEQlg5F7
 ywou3F1yUfPy4E9vvBNgoW4tT++a+TZ99To= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2qp47vr8ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:54:10 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 15 Feb 2019 13:54:07 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 8F7C162E20EE; Fri, 15 Feb 2019 13:54:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 perf,bpf 00/11] perf annotation of BPF programs
Date:   Fri, 15 Feb 2019 13:53:43 -0800
Message-ID: <20190215215354.3114006-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2 to v3:
1. Remove unnecessary include in header files;
2. Improved error handling;
3. Better naming of functions, variables, etc.;
4. Enable bpf events by default for perf-top.

Changes v1 to v2:
1. Fix compilation error with different feature-disassembler-four-args;
2. Fix a segfault in perf-record;
3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
   are in separate patches.

This series enables annotation of BPF programs in perf.

perf tool gathers information via sys_bpf and (optionally) stores them in
perf.data as headers.

Patch 1/11 fixes a minor issue in kernel;
Patch 2/11 to 4/11 introduce new helper functions and use them in perf and
     bpftool;
Patch 5/11 to 8/11 saves information of bpf program in perf_env;
Patch 9/11 adds --bpf-event options to perf-top;
Patch 10/11 enables annotation of bpf programs based on information
     gathered in 5/11 to 8/11;
Patch 11/11 handles information of short living BPF program that are loaded
     during perf-record or perf-top.

Commands tested during developments are perf-top, perf-record, perf-report,
and perf-annotate.

===================== Note on patch dependency  ========================
This set has dependency in both bpf-next tree and tip/perf/core. Current
version is developed on bpf-next tree with the following commits
cherry-picked from tip/perf/core:

(from 1/10 to 10/10)
commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
========================================================================

This set is also available at:

https://github.com/liu-song-6/linux/tree/bpf-annotation

Thanks!!

Song Liu (11):
  perf, bpf: consider events with attr.bpf_event as side-band events
  bpf: libbpf: introduce bpf_program__get_prog_info_linear()
  bpf: bpftool: use bpf_program__get_prog_info_linear() in
    prog.c:do_dump()
  perf, bpf: synthesize bpf events with
    bpf_program__get_prog_info_linear()
  perf, bpf: save bpf_prog_info in a rbtree in perf_env
  perf, bpf: save bpf_prog_info information as headers to perf.data
  perf, bpf: save btf in a rbtree in perf_env
  perf, bpf: save btf information as headers to perf.data
  perf-top: add option --no-bpf-event
  perf, bpf: enable annotation of bpf program
  perf, bpf: save information about short living bpf programs

 kernel/events/core.c        |   3 +-
 tools/bpf/bpftool/prog.c    | 266 ++++++--------------------
 tools/lib/bpf/libbpf.c      | 251 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h      |  63 +++++++
 tools/lib/bpf/libbpf.map    |   3 +
 tools/perf/Makefile.config  |   6 +-
 tools/perf/builtin-record.c |  15 +-
 tools/perf/builtin-top.c    |  18 +-
 tools/perf/util/annotate.c  | 149 ++++++++++++++-
 tools/perf/util/bpf-event.c | 364 ++++++++++++++++++++++++++++--------
 tools/perf/util/bpf-event.h |  44 ++++-
 tools/perf/util/dso.c       |   1 +
 tools/perf/util/dso.h       |  33 ++--
 tools/perf/util/env.c       | 150 +++++++++++++++
 tools/perf/util/env.h       |  21 +++
 tools/perf/util/evlist.c    |  20 ++
 tools/perf/util/evlist.h    |   2 +
 tools/perf/util/header.c    | 233 ++++++++++++++++++++++-
 tools/perf/util/header.h    |   2 +
 tools/perf/util/symbol.c    |   1 +
 tools/perf/util/top.h       |   1 +
 21 files changed, 1337 insertions(+), 309 deletions(-)

--
2.17.1
