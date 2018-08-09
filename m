Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80BCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9EB21C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGxJAycA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9EB21C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeHIHi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:38:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39286 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHIHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:38:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so2036333plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0iNeMDk3duuDjyKFQSXniCp5LAF4gZdgzymtBoWAum4=;
        b=fGxJAycAPN5EjDTuO3eLizcwSbb1fJHUvk9pZJRHZDBvDoAmBvo9k5Sau7a7FZAdtq
         wkfZF4XC30HFXLv4w1SNvHJLpYiR4WF/m7ZBkBqWknjq1jci5mUjuOb+TvUgbDUK4fhi
         /bFkxMVlSH0p5r9yWJMx6sprL3rhPlOcw54Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0iNeMDk3duuDjyKFQSXniCp5LAF4gZdgzymtBoWAum4=;
        b=aSlS89ABU4qXc5mCp85NGRZHDRaC3lsryW6xcvLIKiLcfRMwMBQoI6V7j7HskX9jlK
         SjVlgDZDaOT/y+MdWT6VXqsRtESil94XDO89cCgTc8yOQQx2qSzW3l8E6YR0yBw3WDFO
         TaQOfQ5dPKS3mh4XLs3Ef2eCokj68vTq1IRdsGDegcGIigJJeo0rRwiPKJmvLqY0SX8h
         XrNYHORGzLc+C85LDQMqmmliMk0mtOfyIJ/RbIf4Fevv+Q44bR17CP58DH02GRwP+0Rs
         4PPeX2neUlI5N36hvSKxQJiFxIx3vti5BAeYPrRPPoFiy96B4qGX2qvCDJ7uVa8ijA/P
         iqdg==
X-Gm-Message-State: AOUpUlFMWzESCFxiT+MJOrOaIj6SmTwvAPmUU6v+CaXqWIR7Q8HcghuV
        CIwCo3tCKszJEK1E9Ms9l97iOQ==
X-Google-Smtp-Source: AA+uWPzSixkmpmHKMFj8scRngICQyNNCyqHYDICkJ6T2j/RgOPch7ZKEMsYLZ19xqypiaoFGcH2PVw==
X-Received: by 2002:a17:902:8a97:: with SMTP id p23-v6mr636638plo.21.1533791757045;
        Wed, 08 Aug 2018 22:15:57 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z20-v6sm12863977pfd.99.2018.08.08.22.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:15:56 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/4] System call table generation support
Date:   Thu,  9 Aug 2018 10:45:19 +0530
Message-Id: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
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
manually in the respective files. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify the implementation across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, microblaze, ia64, 
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
it will generate a different syscall.tbl. But I still use the old 
file - syscall.tbl and once all review got over I'll update 
syscall.tbl alone w.r.to the tip of the kernel. The impact of this
is, few of the system call won't work.

Firoz Khan (4):
  m68k: Rename system call table file name
  m68k: Replace NR_syscalls macro from asm/unistd.h
  m68k: Added system call table generation support
  m68k: uapi header and system call table file generation

 arch/m68k/68000/entry.S                 |   4 +-
 arch/m68k/Makefile                      |   3 +
 arch/m68k/coldfire/entry.S              |   2 +-
 arch/m68k/include/asm/Kbuild            |   2 +
 arch/m68k/include/asm/unistd.h          |   3 -
 arch/m68k/include/uapi/asm/Kbuild       |   2 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/entry.S                |   4 +-
 arch/m68k/kernel/syscall_table.S        |  14 ++
 arch/m68k/kernel/syscalls/Makefile      |  37 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 386 ++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  33 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 15 files changed, 512 insertions(+), 796 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1

