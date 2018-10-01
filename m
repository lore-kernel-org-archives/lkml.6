Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3D520684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQhNOq80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3D520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeJATVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38605 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeJATVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so9409735pgr.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YNyhvQyzZl0nz/gSYbWbb9j+GBvRbJE/NeE4hac8Ats=;
        b=WQhNOq80ijMikUQnkqm0E1rbbiQJxnJS/RGuWFiYv75ypSLYVYC4zU1SV3kodxt76S
         XTvqStp1PUEOWnVGwYRj+UXL/wAA07db2jsV6LxG3rdI/i75FsPNrWbuD4Q+wBqbNiQu
         osrva7bvSDPBUhXSZhXBz2uMH/Hcqp2Dc86uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YNyhvQyzZl0nz/gSYbWbb9j+GBvRbJE/NeE4hac8Ats=;
        b=GPvE7dkgR3MeYWyfmXzRiWpfn/KeZ77b4FBSWJsxG/JJi1xSjPHCmC9J7Vj/5qybIj
         g1BZjFsgImfJXuc37KRj7j3e+ChoAWlxrbpV7g7z123RYTrpW3TWmopZQMJqg8uAxCQO
         BzpaRlG7a35st3VZoYumfI1zfK+rJD23uXXk8q6vP1K3RL0pUym2dNBWF8LEnNZjFA4I
         HCRL2Kbm3jVFsWBKdXsjN93PqGGBQZS9Nz5gIGz5U9uzlvXga2g0KbMYp0z6GXoL6mBv
         hYhn3gCgR+AWSH1lxxQ1UEGXIhj8PIBLx49TjYDKyV5s9Za6EBTmI0n82+gKLkuHsijA
         bHDw==
X-Gm-Message-State: ABuFfohW46RljLPNRkHWulMlsojsr3NbJs7T0L79wQkKngUis3ZtPDi1
        rjG1ENWPI2LTOcG3EHD+1Piv/Q==
X-Google-Smtp-Source: ACcGV62ZpgXMKp8qLblsFtI+KKxa2rkY/Fnx0CzVFa0il+olCjOp7p94E4ID95MOBsJD5VYac0DgZQ==
X-Received: by 2002:a62:5c03:: with SMTP id q3-v6mr11430323pfb.182.1538397825311;
        Mon, 01 Oct 2018 05:43:45 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id x17-v6sm5522450pfn.59.2018.10.01.05.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:43:44 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 0/3] System call table generation support
Date:   Mon,  1 Oct 2018 18:13:01 +0530
Message-Id: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
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

I have done the same support for work for alpha, ia64, sparc, mips, 
parisc, powerpc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

Firoz Khan (3):
  microblaze: replace __NR_syscalls macro from asm/unistd.h
  microblaze: add system call table generation support
  microblaze: uapi header and system call table file generation

 arch/microblaze/Makefile                      |   3 +
 arch/microblaze/include/asm/Kbuild            |   1 +
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   1 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407 +-------------------------
 arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  38 +++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 405 +++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  35 +++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  34 +++
 10 files changed, 522 insertions(+), 810 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

