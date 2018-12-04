Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD481C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37CD2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f8c0h3rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37CD2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbeLDTy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:54:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbeLDTyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:54:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wB4Jk80R032470
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 11:54:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=k3vhgKNIOUqfF+ezFVZGVZ19C29Fw21QnzWMIpL4hIA=;
 b=f8c0h3rrU+8u4JFg4DL2kEkAmqRSYAo2f01wfEp3d7IABPmxDSJwraUXSCAoA2P0GojO
 zOGL3vUpFPG/QeloPYns2f3368LbWIZowInbe3ActzTVF2F0ZmDf8Ct50T4bv52glNcg
 4zk8kuPMMspmlU/5GyrvMCzw6B2TrYW7uK8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2p5xqu89s8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:54:22 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 4 Dec 2018 11:54:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 74B1262E1546; Tue,  4 Dec 2018 11:54:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 perf,bpf 0/3] reveal invisible bpf programs
Date:   Tue, 4 Dec 2018 11:53:52 -0800
Message-ID: <20181204195355.4079788-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v2 -> PATCH v1:
1. Only 3 of the 5 patches in v1, to focus on ABI first;
2. Generate PERF_RECORD_BPF_EVENT per bpf sub program instead of per prog;
3. Modify PERF_RECORD_BPF_EVENT with more details (addr, len, name),
   so that it can be used for basic profiling without calling sys_bpf.

Changes RFC -> PATCH v1:
1. In perf-record, poll vip events in a separate thread;
2. Add tag to bpf prog name;
3. Small refactorings.

This is to follow up Alexei's early effort to show bpf programs

   https://www.spinics.net/lists/netdev/msg524232.html

In this version, PERF_RECORD_BPF_EVENT is introduced to send real time BPF
load/unload events to user space.

Thanks,
Song

Song Liu (3):
  perf, bpf: Introduce PERF_RECORD_BPF_EVENT
  perf: sync tools/include/uapi/linux/perf_event.h
  perf util: basic handling of PERF_RECORD_BPF_EVENT

 include/linux/filter.h                |   1 +
 include/linux/perf_event.h            |  10 +++
 include/uapi/linux/perf_event.h       |  35 +++++++-
 kernel/bpf/core.c                     |   2 +-
 kernel/bpf/syscall.c                  |   3 +
 kernel/events/core.c                  | 123 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |  35 +++++++-
 tools/perf/util/event.c               |  22 +++++
 tools/perf/util/event.h               |  26 ++++++
 tools/perf/util/evsel.c               |   1 +
 tools/perf/util/machine.c             |  10 +++
 tools/perf/util/machine.h             |   2 +
 tools/perf/util/session.c             |   4 +
 tools/perf/util/tool.h                |   4 +-
 14 files changed, 273 insertions(+), 5 deletions(-)

--
2.17.1
