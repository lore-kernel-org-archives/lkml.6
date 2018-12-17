Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6936AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1A02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBSMYnJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeLQKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:41:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeLQKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:41:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so6177377pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uqk1/P8yEyz3C7NDRFSRyTWKbU7qhiJXiK4A9vfqIJA=;
        b=hBSMYnJiJc6Zv1nBqQ9XvK0bxpDnIimn5fqibJdONSySgMgipdDoMAccUirRklqnBh
         MysFr9LUqmw1/cgz05UsjYUk4jQ6PMkfKrdyKpcNdbFTfNBM19A6HNcSBT+6337HubL2
         f4vEcDJjpXryQeffah4NY/7WCZqDJwC3ADWoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uqk1/P8yEyz3C7NDRFSRyTWKbU7qhiJXiK4A9vfqIJA=;
        b=fFy5J7wu2sujElrqCG48kbGbhPNwxsRicu0SKZvQhYjJqpOciwjmCF3+2fPZt6rRss
         TVRXOnPMdNRIXbXUSJjg++1FwMwoJTO7j9rTuzO/w53+W+IKFQAbvqyeKyltvwsK+m5p
         6J3B0PC3hMXBX3qvg9Pa6rpj6mkicTU+596b45aPMKTSqlP2EQvQzi577uS02GcQEEuw
         b50CVpDJBZozWpBS4r8VpuN2dv3tiRyQUw4K8nXLQN90xwg5UUGkUev/EvTGCwCYBiSe
         5KmTINPVqGIZ0/eqw9FkoIjNCPQezOb9xD2aP1EuV/jd740+k9QPQZf1svUakhQXztRY
         jr8Q==
X-Gm-Message-State: AA+aEWah0fXoNy04o/oJnOYA/cNt6PSYf8NbYiQfdnTTgrtHejGvBQ+o
        1+JQ2LPo4xYdU2wc9madvpABvw==
X-Google-Smtp-Source: AFSGD/U3d39USqaAeD857I0a52/dsF+Omz1+zk7DRpUKP7r63aoINK1mbXZxD6dFOqHW32qeZU2Cdg==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr13030910pfj.134.1545043275551;
        Mon, 17 Dec 2018 02:41:15 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id b27sm17224826pfh.113.2018.12.17.02.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 02:41:14 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v6 0/5] powerpc: system call table generation support
Date:   Mon, 17 Dec 2018 16:10:31 +0530
Message-Id: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is, we can easily
add/modify/delete system call table support by cha-
nging entry in syscall.tbl file instead of manually
changing many files. The other goal is to unify the 
system call table generation support implementation 
across all the architectures. 

The system call tables are in different format in 
all architecture. It will be difficult to manually
add, modify or delete the system calls in the resp-
ective files manually. To make it easy by keeping a 
script and which'll generate uapi header file and 
syscall table file.

syscall.tbl contains the list of available system 
calls along with system call number and correspond-
ing entry point. Add a new system call in this arch-
itecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
	- Compat entry name, if required.
	- spu entry name, if required.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, mips, parisc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

Changes since v5:
 - rebased with 4.20-rc7.

Changes since v4:
 - DOTSYM macro removed for ppc32, which was causing
   the compilation error.

Changes since v3:
 - split compat syscall table out from native table.
 - modified the script to add new line in the generated
   file.

Changes since v2:
 - modified/optimized the syscall.tbl to avoid duplicate
   for the spu entries.
 - updated the syscalltbl.sh to meet the above point.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (5):
  powerpc: add __NR_syscalls along with NR_syscalls
  powerpc: move macro definition from asm/systbl.h
  powerpc: add system call table generation support
  powerpc: split compat syscall table out from native table
  powerpc: generate uapi header and system call table files

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   4 +
 arch/powerpc/include/asm/syscall.h          |   3 +-
 arch/powerpc/include/asm/systbl.h           | 396 --------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/entry_64.S              |   7 +-
 arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
 arch/powerpc/kernel/systbl.S                |  40 ++-
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/kernel/vdso.c                  |   7 +-
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 17 files changed, 606 insertions(+), 898 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

