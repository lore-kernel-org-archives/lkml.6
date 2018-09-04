Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24272086D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7lmPDw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24272086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeIDJFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeIDJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so1019649pgo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vO6vUbYhv4WiabBeA6VrqCZcZrhO0Ydiz+QqaKsa/Xw=;
        b=h7lmPDw+XvuDYzQ7LN428IYgLjpo5OZXM2tjQqJQvudOT3TAG/HzJyaCXnYH6eyaAk
         KmS5nuUAv2o/GbYRKuVYfE1u2tV9CyUVpAtLCYPZGCAc6LozAlQgMtPwCbVyZnbC8BCW
         BlWyynJYYPWmlgfZL7Kobnb0OMgJ6tv/PfDgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vO6vUbYhv4WiabBeA6VrqCZcZrhO0Ydiz+QqaKsa/Xw=;
        b=C1sS7ipVS5pffQbJPSSQYR8cdgsmZJ+4vIl2bWhL7LJ3qweY8o5o5VxwJQKDR4GK0K
         knMwvGCWmO1FV00uX1iAN2KNIgktjQoX6m6vXjuj/UXYyGWNsD44R1+VZvoVWHubdcO6
         rngekHSGr21wiQDf7RQVfzoCHN+xTxg73g5wsJU3xIA8orCXDmcgjPkwS/r9UAVE+JBx
         J0K/AHRyZwcw+9y3Z6m2AZm7kOzaXfOukz4skKV4SDGl6eEAxOC2jx7r+v4C5jpSo65D
         LtAW/V/P0iTODFR6aBIUWJ+8iQ3RVgeTciVknbywJBzRc3zXqe4qTlRG6URVo5uPlCjL
         ZNLg==
X-Gm-Message-State: APzg51BDdoyLlVIu9FBfScAcofjo2x+GtW5jC4QoQIPOwmmXOIstoSFd
        r1rcqEl+p3YUjw4d9FlotKF4CQ==
X-Google-Smtp-Source: ANB0VdYO2YaL6sBVkkJu2sQLu7GCWz0O7worRtzi8IVSouMzeAP6qZUlSIF7NFxdrOvpWKONd4LrQg==
X-Received: by 2002:a63:1618:: with SMTP id w24-v6mr30119073pgl.43.1536036126523;
        Mon, 03 Sep 2018 21:42:06 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id w12-v6sm10280372pfd.110.2018.09.03.21.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 21:42:06 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/4] System call table generation support
Date:   Tue,  4 Sep 2018 10:11:23 +0530
Message-Id: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is:
1. We can easily add/modify/delete system call by changing entry 
in syscall.tbl file. No need to manually edit many files.

2. It is easy to unify the system call implementation across all 
the architectures. 

The system call tables are in different format in all architecture 
and it will be difficult to manually add or modify the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify them across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
        - Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, m68k, microblaze, 
mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

I started working system call table generation on 4.17-rc1. I used 
marcin's script - https://github.com/hrw/syscalls-table to generate 
the syscall.tbl file. And this will be the input to the system call 
table generation script. But there are couple system call got add 
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file - 
syscall.tbl and once all review got over I'll update syscall.tbl 
alone w.r.to the tip of the kernel. The impact of this thing, few 
of the system call won't work.

Firoz Khan (4):
  sparc: Move __IGNORE* entries to non uapi header
  sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
  sparc: Add system call table generation support
  sparc: uapi header and system call table file generation

 arch/sparc/Makefile                       |   3 +
 arch/sparc/include/asm/Kbuild             |   5 +-
 arch/sparc/include/asm/unistd.h           |  27 ++
 arch/sparc/include/uapi/asm/Kbuild        |   3 +
 arch/sparc/include/uapi/asm/unistd.h      | 434 +-----------------------------
 arch/sparc/kernel/Makefile                |   2 +-
 arch/sparc/kernel/head_64.S               |   2 +-
 arch/sparc/kernel/syscall_table_32.S      |  12 +
 arch/sparc/kernel/syscall_table_64.S      |  22 ++
 arch/sparc/kernel/syscalls/Makefile       |  50 ++++
 arch/sparc/kernel/syscalls/syscall_32.tbl | 365 +++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscall_64.tbl | 349 ++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh  |  33 +++
 arch/sparc/kernel/syscalls/syscalltbl.sh  |  38 +++
 arch/sparc/kernel/systbls_32.S            |  93 -------
 arch/sparc/kernel/systbls_64.S            | 176 ------------
 16 files changed, 912 insertions(+), 702 deletions(-)
 create mode 100644 arch/sparc/kernel/syscall_table_32.S
 create mode 100644 arch/sparc/kernel/syscall_table_64.S
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/sparc/kernel/systbls_32.S
 delete mode 100644 arch/sparc/kernel/systbls_64.S

-- 
1.9.1

