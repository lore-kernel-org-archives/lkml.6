Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78269C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284952081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOiHO0AA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284952081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeKAW4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:56:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43997 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeKAW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:56:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so9054621pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kTeC/f707l2ldAme0+D1nBXrNU98i8iFLzaptPO7VgI=;
        b=UOiHO0AAwOcOTFG/XWLp3apqTquH57KYJh05RbFQYjrRJS+VLhE8GrZEXRfUBW1xJy
         Vm3P6zjRNq9E0iSZl0NCRnfO7WFc4q+pWuHOO9ovwsxO2lRNDT9lPa0157ABZsYCiQqX
         xYjylYk3U+NprLp2Kkx1YX94bglA2AIAbwZMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kTeC/f707l2ldAme0+D1nBXrNU98i8iFLzaptPO7VgI=;
        b=VSKsjx/x6pMvRZNQB0lPE391mly0Hwb4aJbhgNiaVPfy8vdtratyqB5y3YlmOONraw
         2mVOYfkw6u7s4LBGK4bCUxKNtXA0Q2TfdoqvCMQbCwXTjwt16FxJHt7vHKbwJGglZP0f
         Tb8tmet2CIHLdcrAFyTtNL+4AucquXeenGSIuSoGfo/zN1fQtBVTTbWf63Qx4VLQDjug
         m4GVAE7VD7tcYsn7ntwWwrTixgkrkuPRlhlxE/iTtIMaSxiy+o2cfVuTXFLHGfWnJwuN
         vx4fsmHVyW7X9yMlKQVrNmK/fRdGD07YilvebLyBEofIveEVtAs9aGXnwgEVpisCEnyL
         65bA==
X-Gm-Message-State: AGRZ1gKW/sGMuENM2IjnzapyewHllV15ph5pSMsbwCMTq9mm2BtjU29m
        QrzAR1j/WO5zhA/bLkXVfYA7ZQ==
X-Google-Smtp-Source: AJdET5dDaBdU2WhUEyh3YL7/qnKakimnqlHC+ekEQcs9lgx08EQFf+7wj7FDgrYpbG1X//inKxqNOQ==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr7915726pfn.78.1541080419587;
        Thu, 01 Nov 2018 06:53:39 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id 131-v6sm2224716pfa.120.2018.11.01.06.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:53:39 -0700 (PDT)
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
Subject: [PATCH v2 0/4] sparc: system call table generation support
Date:   Thu,  1 Nov 2018 19:23:07 +0530
Message-Id: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
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

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, mips, parisc, powerpc, sh 
and xtensa. Below mentioned git repository contains
more details about the workflow.

 https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.

Firoz Khan (4):
  sparc: move __IGNORE* entries to non uapi header
  sparc: add __NR_syscalls along with NR_syscalls
  sparc: add system call table generation support
  sparc: generate uapi header and system call table files

 arch/sparc/Makefile                      |   3 +
 arch/sparc/include/asm/Kbuild            |   4 +-
 arch/sparc/include/asm/unistd.h          |  18 ++
 arch/sparc/include/uapi/asm/Kbuild       |   2 +
 arch/sparc/include/uapi/asm/unistd.h     | 425 +------------------------------
 arch/sparc/kernel/syscalls/Makefile      |  55 ++++
 arch/sparc/kernel/syscalls/syscall.tbl   | 408 +++++++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
 arch/sparc/kernel/systbls_32.S           |  81 +-----
 arch/sparc/kernel/systbls_64.S           | 157 +-----------
 11 files changed, 571 insertions(+), 654 deletions(-)
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

