Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14CCC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856F621C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYIeY4dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856F621C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeHIH2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:28:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45605 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:28:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so2010419pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=on8oydEnWTBAUMeevZt0b87C3CQBBZzPxeY29fC4H6I=;
        b=AYIeY4dpsZD5LO1YspO3ds2M+GLyHIM0HFOmTJ18MOAV0CLickNZTTpRh9i0Gm+FeM
         HYakMysXGAbziiUP0qm1GLLFYZGB8jrbX5D41yNel7d0c7UBVvP+hW1T6xHMonjsFq2r
         inYI5gP94HTGoVdMAcWGiY0erK5y3quqEuhU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=on8oydEnWTBAUMeevZt0b87C3CQBBZzPxeY29fC4H6I=;
        b=BPgKeHMDjMZ1efKYNsMmvF9FvpZ9Lt8KNIzDy1pAYfycWjYaQrUlpT6udOnOBuYkC/
         7sZWHAi2uIiB2/kMDpL6y8I4c7IggswSBk7DwdhX/Ug9NrHqNc0GHbaHEV27AOoiJ8yT
         WG391l3UVTGjvtUjlGl7EirZkdmfMzl4LzYY9W5xCzHCNwOHslKcONaEuT8r1FeTy5nS
         RPX1UnAvBTWADzzJsC1LHoBLJOuGdppyAPHse1xXi5ahOdVUnz9Eza1zYfSTz1SgS0Ct
         MME7g++5oWVRZ9fAxmSgFyFWpieTVOz1ifCMKZJN0PqwDgl5g0dio0EfyE3929N/bOtn
         EtRw==
X-Gm-Message-State: AOUpUlG6gbkp7wjqQ7v5UJ+GmEEHUEljueIhemNXnCzV12aaL5vSADKZ
        P2LW5nOfRdMSSMq6Nve26U5ryw==
X-Google-Smtp-Source: AA+uWPzCIKGcr5pmN3P5Dam8nSc2f4gH2uhVrtX56zqZJQApWdG7EckSeCQjAb51nN2U3lvsZL7r+Q==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr603719plk.338.1533791144130;
        Wed, 08 Aug 2018 22:05:44 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c1-v6sm6919419pfi.142.2018.08.08.22.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:05:43 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/5] System call table generation support
Date:   Thu,  9 Aug 2018 10:35:10 +0530
Message-Id: <1533791115-3681-1-git-send-email-firoz.khan@linaro.org>
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
it will generate a different syscall.tbl. But I still use the old 
file - syscall.tbl and once all review got over I'll update 
syscall.tbl alone w.r.to the tip of the kernel. The impact of this
is, few of the system call won't work.

Firoz Khan (5):
  ia64: Replace NR_syscalls macro from asm/unistd.h
  ia64: Added an offset for system call number
  ia64: Replaced the system call table entry from entry.S
  ia64: Added system call table generation support
  ia64: uapi header and system call table file generation

 arch/ia64/Makefile                      |   3 +
 arch/ia64/include/asm/Kbuild            |   2 +
 arch/ia64/include/asm/unistd.h          |   4 -
 arch/ia64/include/uapi/asm/Kbuild       |   2 +
 arch/ia64/include/uapi/asm/unistd.h     | 331 +------------------------------
 arch/ia64/kernel/entry.S                | 335 +-------------------------------
 arch/ia64/kernel/fsys.S                 |   2 +-
 arch/ia64/kernel/gate.S                 |   4 +-
 arch/ia64/kernel/ivt.S                  |   2 +-
 arch/ia64/kernel/patch.c                |   2 +-
 arch/ia64/kernel/syscall.S              |  13 ++
 arch/ia64/kernel/syscalls/Makefile      |  40 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 334 +++++++++++++++++++++++++++++++
 arch/ia64/kernel/syscalls/syscallhdr.sh |  33 ++++
 arch/ia64/kernel/syscalls/syscalltbl.sh |  34 ++++
 arch/ia64/mm/init.c                     |   6 +-
 16 files changed, 474 insertions(+), 673 deletions(-)
 create mode 100644 arch/ia64/kernel/syscall.S
 create mode 100644 arch/ia64/kernel/syscalls/Makefile
 create mode 100644 arch/ia64/kernel/syscalls/syscall.tbl
 create mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

