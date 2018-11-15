Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6866DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2289E2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPah5N15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2289E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeKOQVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:21:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35539 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKOQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:21:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so8531084pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0tQIHbtWTEJXDVXezxM6VBnYKAKgJoIsp5A5yYAdlQg=;
        b=VPah5N159BVpjL349YtPuPT+YVt1gIH7iBwUW9b2mUpivzQJO1ybkSc8zqWU/dFQf6
         lXpEccUq92OsdpCrAwoeeMkXNFitNLF3NID0xMKkBro6pfzea0YscmN5LTcZET5oWXIh
         2+HtjHWrcZPayDMhW4GFty0moCf3nJ4l5bvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tQIHbtWTEJXDVXezxM6VBnYKAKgJoIsp5A5yYAdlQg=;
        b=j9+RECj7raHPIhtJSR69XKOuW2pB0pRfXCIS5nk4Z/IRAhI9JVehTd1mynfcWsPZtC
         cuWCF8KGYDwRPjhIZ1p0w17Wqx6ytjZfSU3V+OQPdUJJXUTipEi+bJNuPUt7R8j2PTRB
         vzOXF5DpQRh/S77/2OlPJKP8x1nWg10GhXPs/goHJ3u5/H+ILwKpujIjdYdshgZrnBFM
         yGC+ta4lxEaHiYWLE6inOLQBNdqc/MHagiXBL9s3g1PdF+//KOG2heKzJRyFKDUdaBIR
         dQtZW7qkWFnD1UjwiylsM9FZegpkcNJENOYMIy86fL4iM5OSAFlTZ+ns+yVWjMlIVOE/
         gnmA==
X-Gm-Message-State: AGRZ1gLlnpGV6o62QXGHRCGFSrEZxUI/26sTmj9R8Q9Fe7FZ/+I23xlc
        Ew4v/Pw1ZstETlQbMMXK/VSIIQ==
X-Google-Smtp-Source: AJdET5e2iv148bBfWIb1prGb1HZjBPhAD47bBzZRq/WMEiJ/ZeRr/L2OSDGTJZMYjZgg8qCpHkioDw==
X-Received: by 2002:a62:6881:: with SMTP id d123-v6mr5245567pfc.195.1542262489435;
        Wed, 14 Nov 2018 22:14:49 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:14:48 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 0/5] mips: system call table generation support
Date:   Thu, 15 Nov 2018 11:44:16 +0530
Message-Id: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
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
ia64, m68k, microblaze, parisc, powerpc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (5):
  mips: add __NR_syscalls along with __NR_Linux_syscalls
  mips: add +1 to __NR_syscalls in uapi header
  mips: remove syscall table entries
  mips: add system call table generation support
  mips: generate uapi header and system call table files

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/asm/unistd.h            |    6 +-
 arch/mips/include/uapi/asm/Kbuild         |    3 +
 arch/mips/include/uapi/asm/unistd.h       | 1057 +----------------------------
 arch/mips/kernel/ftrace.c                 |    6 +-
 arch/mips/kernel/scall32-o32.S            |  390 +----------
 arch/mips/kernel/scall64-64.S             |  335 +--------
 arch/mips/kernel/scall64-n32.S            |  341 +---------
 arch/mips/kernel/scall64-o32.S            |  379 +----------
 arch/mips/kernel/syscalls/Makefile        |   71 ++
 arch/mips/kernel/syscalls/syscall_64.tbl  |  339 +++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  343 ++++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl |  382 +++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   36 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
 16 files changed, 1259 insertions(+), 2472 deletions(-)
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

