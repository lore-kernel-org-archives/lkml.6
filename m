Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E997C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUBQBA/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAB020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINNq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:46:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36574 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeINNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:46:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so3977239pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xw9O3VYKyILcFNk7g1v1ex6Kcw733SokGsK5eSOn6DE=;
        b=ZUBQBA/ijLxqvShtSFxrSq72PIvvpD6YAsei8aPSZGBUJXs/fioclzZ/VRxX9O7L8K
         k62QaibwTFxu+Sw9xWnXvjTuliFZwmcHVRzxWmBIr0cyL2jFlEtWwZNlOXlnVi+9qVef
         fBk85ek6sg3P1bpw3eFt5hz79GTHSuytQq2s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xw9O3VYKyILcFNk7g1v1ex6Kcw733SokGsK5eSOn6DE=;
        b=HkX0XHVvrf0iYru/NoZz3rHYjGUObu6a1rCtniGUeaCPJVE1z9LGedDDXUwcmd+5kw
         oOMB2eFC7o80+jgX6NV6YUX1AejOZ0Nowqj8OFrQY7LwDvpxpc3CxyGxfmxBQgArnGLw
         gkr4SH1jpkD6MRJ4V3sZFgtpzoKNpfk4rKhuGwuAPf5sQbWEUyFmOVu2kCD5hq/vrPAa
         Zy6kQp3bNfAMhGc501DAaXvlPw5bcyTkYR0lVdFgTJCprxRCTOxZn41jabbiewliG8Gj
         kAHAZYIouKT6N6S6xwq9H6XSH29dLy//McAkKYwuk5U5bGZ0VqzobbAp65pFlVooIjuR
         tNeA==
X-Gm-Message-State: APzg51A+jW1CldUBAyH5CILbJ912cwEvLS4G6uPmtHwZ+UJzYDtIpXdI
        K0VSOo2f8eFq6nBlGYzssW2xuA==
X-Google-Smtp-Source: ANB0VdYqndyO5ZvMKTe+l6HJbxxjaFFfDpNRgj+WEjIwn/x790VfYpKfp2xW4lfWBaFSG2bg1UttuQ==
X-Received: by 2002:a63:ac11:: with SMTP id v17-v6mr10649167pge.196.1536914012191;
        Fri, 14 Sep 2018 01:33:32 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id d6-v6sm12427070pgt.66.2018.09.14.01.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:33:31 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/3] System call table generation support
Date:   Fri, 14 Sep 2018 14:02:57 +0530
Message-Id: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
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
ia64, mips, parisc, sh, sparc, and xtensa. But I started sending 
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

Firoz Khan (3):
  powerpc: Replace NR_syscalls macro from asm/unistd.h
  powerpc: Add system call table generation support
  powerpc: uapi header and system call table file generation

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   3 +
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 391 +---------------------------
 arch/powerpc/kernel/Makefile                |   3 +-
 arch/powerpc/kernel/syscall_table_32.S      |   9 +
 arch/powerpc/kernel/syscall_table_64.S      |  17 ++
 arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
 arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 +++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 ++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
 arch/powerpc/kernel/systbl.S                |  50 ----
 14 files changed, 916 insertions(+), 441 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscall_table_32.S
 create mode 100644 arch/powerpc/kernel/syscall_table_64.S
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl.S

-- 
1.9.1

