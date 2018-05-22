Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeEVCWl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:22:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751813AbeEVCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:22:33 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To: "David S . Miller" <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <luto@amacapital.net>,
        <mcgrof@kernel.org>, <keescook@chromium.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 net-next 0/2] bpfilter
Date: Mon, 21 May 2018 19:22:28 -0700
Message-ID: <20180522022230.2492505-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

v2->v3:
- followed Luis's suggestion and significantly simplied first patch
  with shmem_kernel_file_setup+kernel_write. Added kdoc for new helper
- fixed typos and race to access pipes with mutex
- tested with bpfilter being 'builtin'. CONFIG_BPFILTER_UMH=y|m both work.
  Interesting to see a usermode executable being embedded inside vmlinux.
- it doesn't hurt to enable bpfilter in .config.
  ip_setsockopt commands sent to usermode via pipes and -ENOPROTOOPT is
  returned from userspace, so kernel falls back to original iptables code

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
- the user can still attach to the process and debug it with
  'gdb /proc/pid/exe pid', but 'gdb -p pid' doesn't work.
  (a bit worse comparing to v1)
- tinyconfig will notice a small increase in .text
  +766 | TEXT | 7c8b94806bec umh: introduce fork_usermode_blob() helper

Alexei Starovoitov (2):
  umh: introduce fork_usermode_blob() helper
  net: add skeleton of bpfilter kernel module

 fs/exec.c                     |  38 ++++++++++---
 include/linux/binfmts.h       |   1 +
 include/linux/bpfilter.h      |  15 +++++
 include/linux/umh.h           |  12 ++++
 include/uapi/linux/bpfilter.h |  21 +++++++
 kernel/umh.c                  | 125 +++++++++++++++++++++++++++++++++++++++++-
 net/Kconfig                   |   2 +
 net/Makefile                  |   1 +
 net/bpfilter/Kconfig          |  16 ++++++
 net/bpfilter/Makefile         |  30 ++++++++++
 net/bpfilter/bpfilter_kern.c  | 111 +++++++++++++++++++++++++++++++++++++
 net/bpfilter/main.c           |  63 +++++++++++++++++++++
 net/bpfilter/msgfmt.h         |  17 ++++++
 net/ipv4/Makefile             |   2 +
 net/ipv4/bpfilter/Makefile    |   2 +
 net/ipv4/bpfilter/sockopt.c   |  42 ++++++++++++++
 net/ipv4/ip_sockglue.c        |  17 ++++++
 17 files changed, 503 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/bpfilter.h
 create mode 100644 include/uapi/linux/bpfilter.h
 create mode 100644 net/bpfilter/Kconfig
 create mode 100644 net/bpfilter/Makefile
 create mode 100644 net/bpfilter/bpfilter_kern.c
 create mode 100644 net/bpfilter/main.c
 create mode 100644 net/bpfilter/msgfmt.h
 create mode 100644 net/ipv4/bpfilter/Makefile
 create mode 100644 net/ipv4/bpfilter/sockopt.c

-- 
2.9.5
