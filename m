Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeECEgJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:36:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35962 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751058AbeECEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:36:05 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <luto@amacapital.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH v2 net-next 0/4] bpfilter
Date: Wed, 2 May 2018 21:36:00 -0700
Message-ID: <20180503043604.1604587-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

v1->v2:
this patch set is almost a full rewrite of the earlier umh modules approach
The v1 of patches and follow up discussion was covered by LWN:
https://lwn.net/Articles/749108/

I believe the v2 addresses all issues brought up by Andy and others.
Mainly there are zero changes to kernel/module.c
Instead of teaching module loading logic to recognize special
umh module, let normal kernel modules execute part of its own
.init.rodata as a new user space process (Andy's idea)
Patch 1 introduces this new helper:
int fork_usermode_blob(void *data, size_t len, struct umh_info *info);
Input:
  data + len == executable file
Output:
  struct umh_info {
       struct file *pipe_to_umh;
       struct file *pipe_from_umh;
       pid_t pid;
  };

Advantages vs v1:
- the embedded user mode executable is stored as .init.rodata inside
  normal kernel module. These pages are freed when .ko finishes loading
- the elf file is copied into tmpfs file. The user mode process is swappable.
- the communication between user mode process and 'parent' kernel module
  is done via two unix pipes, hence protocol is not exposed to
  user space
- impossible to launch umh on its own (that was the main issue of v1)
  and impossible to be man-in-the-middle due to pipes
- bpfilter.ko consists of tiny kernel part that passes the data
  between kernel and umh via pipes and much bigger umh part that
  doing all the work
- 'lsmod' shows bpfilter.ko as usual.
  'rmmod bpfilter' removes kernel module and kills corresponding umh
- signed bpfilter.ko covers the whole image including umh code

Few issues:
- architecturally bpfilter.ko can be builtin, but doesn't work yet.
  Still debugging. Kinda cool to have user mode executables
  to be part of vmlinux
- the user can still attach to the process and debug it with
  'gdb /proc/pid/exe pid', but 'gdb -p pid' doesn't work.
  (a bit worse comparing to v1)
- tinyconfig will notice a small increase in .text
  +766 | TEXT | 7c8b94806bec umh: introduce fork_usermode_blob() helper

More details in patches 1 and 2 that are ready to land.
Patches 3 and 4 are still rough. They were mainly used for
testing and to demonstrate how bpfilter is building on top.
The patch 4 approach of converting one iptable rule to few bpf
instructions will certainly change in the future, since it doesn't
scale to thousands of rules.

Alexei Starovoitov (2):
  umh: introduce fork_usermode_blob() helper
  net: add skeleton of bpfilter kernel module

Daniel Borkmann (1):
  bpfilter: rough bpfilter codegen example hack

David S. Miller (1):
  bpfilter: add iptable get/set parsing

 fs/exec.c                     |  38 ++++-
 include/linux/binfmts.h       |   1 +
 include/linux/bpfilter.h      |  15 ++
 include/linux/umh.h           |  12 ++
 include/uapi/linux/bpfilter.h | 200 ++++++++++++++++++++++
 kernel/umh.c                  | 176 +++++++++++++++++++-
 net/Kconfig                   |   2 +
 net/Makefile                  |   1 +
 net/bpfilter/Kconfig          |  17 ++
 net/bpfilter/Makefile         |  24 +++
 net/bpfilter/bpfilter_kern.c  |  93 +++++++++++
 net/bpfilter/bpfilter_mod.h   | 373 ++++++++++++++++++++++++++++++++++++++++++
 net/bpfilter/ctor.c           |  91 +++++++++++
 net/bpfilter/gen.c            | 290 ++++++++++++++++++++++++++++++++
 net/bpfilter/init.c           |  36 ++++
 net/bpfilter/main.c           | 117 +++++++++++++
 net/bpfilter/msgfmt.h         |  17 ++
 net/bpfilter/sockopt.c        | 236 ++++++++++++++++++++++++++
 net/bpfilter/tables.c         |  73 +++++++++
 net/bpfilter/targets.c        |  51 ++++++
 net/bpfilter/tgts.c           |  26 +++
 net/ipv4/Makefile             |   2 +
 net/ipv4/bpfilter/Makefile    |   2 +
 net/ipv4/bpfilter/sockopt.c   |  42 +++++
 net/ipv4/ip_sockglue.c        |  17 ++
 25 files changed, 1940 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/bpfilter.h
 create mode 100644 include/uapi/linux/bpfilter.h
 create mode 100644 net/bpfilter/Kconfig
 create mode 100644 net/bpfilter/Makefile
 create mode 100644 net/bpfilter/bpfilter_kern.c
 create mode 100644 net/bpfilter/bpfilter_mod.h
 create mode 100644 net/bpfilter/ctor.c
 create mode 100644 net/bpfilter/gen.c
 create mode 100644 net/bpfilter/init.c
 create mode 100644 net/bpfilter/main.c
 create mode 100644 net/bpfilter/msgfmt.h
 create mode 100644 net/bpfilter/sockopt.c
 create mode 100644 net/bpfilter/tables.c
 create mode 100644 net/bpfilter/targets.c
 create mode 100644 net/bpfilter/tgts.c
 create mode 100644 net/ipv4/bpfilter/Makefile
 create mode 100644 net/ipv4/bpfilter/sockopt.c

-- 
2.9.5
