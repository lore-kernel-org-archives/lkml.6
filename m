Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14246C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98BD213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98BD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJDJtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbeJDJtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:10 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w942mrBg031859
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:57 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw8aygags-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:57 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.20) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 19:57:56 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 EF6FF760B51; Wed,  3 Oct 2018 19:57:50 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/6] bpf: introduce BPF_CGROUP_FILE_OPEN
Date:   Wed, 3 Oct 2018 19:57:44 -0700
Message-ID: <20181004025750.498303-1-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Similar to networking sandboxing programs and cgroup-v2 based hooks
(BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], etc)
introduce basic per-container sandboxing for file access via
new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
security_file_open() LSM hook and works as additional file_open filter.
The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.

Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
is only available to root.

Use cases:
- disallow certain FS types within containers (fs_magic == CGROUP2_SUPER_MAGIC)
- restrict permissions in particular mount (mnt_id == X && (flags & O_RDWR))
- disallow access to hard linked sensitive files (nlink > 1 && mode == 0700)
- disallow access to world writeable files (mode == 0..7)
- disallow access to given set of files (dev_major == X && dev_minor == Y && inode == Z)

Alexei Starovoitov (6):
  bpf: introduce BPF_PROG_TYPE_FILE_FILTER
  fs: wire in BPF_CGROUP_FILE_OPEN hook
  tools/bpf: sync uapi/bpf.h
  trace/bpf: allow %o modifier in bpf_trace_printk
  libbpf: support BPF_CGROUP_FILE_OPEN in libbpf
  selftests/bpf: add a test for BPF_CGROUP_FILE_OPEN

 fs/open.c                                     |   4 +
 include/linux/bpf-cgroup.h                    |  10 +
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  28 ++-
 kernel/bpf/cgroup.c                           | 171 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   7 +
 kernel/trace/bpf_trace.c                      |   2 +-
 tools/include/uapi/linux/bpf.h                |  28 ++-
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   2 +
 tools/testing/selftests/bpf/test_file_open.c  | 154 ++++++++++++++++
 .../selftests/bpf/test_file_open_common.h     |  13 ++
 .../selftests/bpf/test_file_open_kern.c       |  48 +++++
 15 files changed, 473 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_file_open.c
 create mode 100644 tools/testing/selftests/bpf/test_file_open_common.h
 create mode 100644 tools/testing/selftests/bpf/test_file_open_kern.c

-- 
2.17.1

