Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE99C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C622085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqaWZ+qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C622085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJHM1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:27:10 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:37344 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJHM1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:27:09 -0400
Received: by mail-pl1-f180.google.com with SMTP id az3-v6so9494212plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Q9rrLwgEobAJCZ02BoF9JDexezs2dmUJFswowYQcnpo=;
        b=CqaWZ+qnjYsH/T2LTACiKQE7WJLUcKNWOXnsZsSmQG/FuZDc1d9h7K4ieRHSNtTKr0
         wJyySM8zbM5P8XQ5OCFL1zJ3wPslIi8VlDx5kShRB1fPtpfKSjbqkxrY4BZ2taIQFC/I
         Rnl06+h+ZVGdCvNczWJdn8hjPDMNQEhYK43DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q9rrLwgEobAJCZ02BoF9JDexezs2dmUJFswowYQcnpo=;
        b=efVJ7vzHRU9eBu1ug6MxjPg34kNXRfwys6u3lQy7QQ8Ti2JkHAty2LqPnPZwwIjYKK
         lrueneE1MdoEtS+sXxpRR1fL5gFa9IE8YGkKUiNbdagGtlFZTVMy+Q1PFRWZq2Kshb+m
         553cnvZtdTqfoSt8rIiDlIhWO5x8Pa6UfnZ3eLt1CZpqGhg+kXygBGtUU/iAROgz3I4k
         dQJvTbfUgnD3zdu7Lyf4wNJ9f5UNAXRvZKcr859hHO09dhUzriIjXAhSEepKNhizyDy5
         oJuKiXDmFGJbskseHfU4iBR52jkFvDdL67k7zgbjrvkgoVLx18fho90HJN3K1Vdxq7DI
         04dg==
X-Gm-Message-State: ABuFfoipc4dhIXvz9DmREe5yAMbK9qHZcbjUzI6SHPSmu7CtbgTAIh8+
        UCOsIdp6cBVySkBonRpYDok3sw==
X-Google-Smtp-Source: ACcGV61qt3zcXDee+/5b9WBQn+wwybxiST4LgtrRx2lBZA27VfGyjD2Fhg28Mc0cuFXXAKCItLKtxg==
X-Received: by 2002:a17:902:694c:: with SMTP id k12-v6mr22841855plt.17.1538975838398;
        Sun, 07 Oct 2018 22:17:18 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1875919pfi.137.2018.10.07.22.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 22:17:17 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 0/6] System call table generation support
Date:   Mon,  8 Oct 2018 10:46:35 +0530
Message-Id: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for alpha, microblaze, sparc,
m68k, mips, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Added an ignore entry for nfsservctl in script/checksyscalls.sh.
Wired up rseq system call.

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (6):
  parisc: move __IGNORE* entries to non uapi header
  parisc: add __NR_Linux_syscalls along with __NR_syscalls
  parisc: add system call table generation support
  parisc: uapi header and system call table file generation
  parisc: wire up rseq system call
  parisc: syscalls: Ignore nfsservctl for other architectures

 arch/parisc/Makefile                      |   4 +
 arch/parisc/include/asm/Kbuild            |   3 +
 arch/parisc/include/asm/unistd.h          |   8 +
 arch/parisc/include/uapi/asm/Kbuild       |   2 +
 arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
 arch/parisc/kernel/syscall.S              |  12 +-
 arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
 arch/parisc/kernel/syscall_table_32.S     |  13 +
 arch/parisc/kernel/syscall_table_64.S     |  20 ++
 arch/parisc/kernel/syscalls/Makefile      |  55 ++++
 arch/parisc/kernel/syscalls/syscall.tbl   | 353 +++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh |  35 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh |  41 +++
 scripts/checksyscalls.sh                  |   1 +
 14 files changed, 545 insertions(+), 843 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscall_table_32.S
 create mode 100644 arch/parisc/kernel/syscall_table_64.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

