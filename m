Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B766BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OawJXb+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7A720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJPOxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:53:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37316 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJPOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:53:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id u6-v6so7790853plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ffx2fMYSIeCCcmgyJEPi5xzZbXkmRa4EBKemIRYpIXA=;
        b=OawJXb+RSnFgQWFFkpCMsiMDWsU5MSM9ukUDehkmPeECvKlIRV6tvSgGBWNByaXv7+
         S7mk8OuNf4xdCQQTW9fFYv2HEV4oDzgUlMsVLpUgt/LmUEzLja+qIdrx6VH5YmFM8gBx
         6IOQeQpQ46U5x1ju7SfI9sHRH6R655CNQSl2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ffx2fMYSIeCCcmgyJEPi5xzZbXkmRa4EBKemIRYpIXA=;
        b=SlXetyBCYrSS5rXL0NEbi8t9N0o+SBPHnnmc9b2i0W16aMTi5T82C/e3czE67PTc0c
         MJwp9Ha7qy7iKDeXky3CgP/w16+IqbZrRoAGPUAbjV2ElizIe3grIZsi1tepd0LCer85
         zMSx7je3HBxj+mu70vDZ09wsqn5guHbcJOQGVstOxCU0x6UXiQKQB1JN/keDbEMPU6PC
         or+h7Oi93K2lA21p3ND7DbClCz5iINr43zORrpPqAfO3PIkYxf2U3XiOePpAQAH6DBj8
         cskCLKr6GiuY4ttlNOemcpeVBYYCPJV0OX/eYTZ71l41tj1RwpF9Z8Uj7g2bsVFQbg8j
         Dl+w==
X-Gm-Message-State: ABuFfoiD3pcR7qJous46kg4aJwWMwxd2/+EwkYt1Bub3YsD/6NUq9MfI
        3TgbmrI1caX+t8otLTwt4UYmdQ==
X-Google-Smtp-Source: ACcGV6266u4+HjJaoIKRwkQV7HgJHbd/M4DmUk1Vd1f+XqpD/MsLAKkGQvN4cZLUFjGwfUM7Zh2kVw==
X-Received: by 2002:a17:902:bb07:: with SMTP id l7-v6mr9180041pls.252.1539673447265;
        Tue, 16 Oct 2018 00:04:07 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u21-v6sm21775107pfa.176.2018.10.16.00.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:04:06 -0700 (PDT)
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
Subject: [PATCH v5 0/5] parisc: system call table generation support
Date:   Tue, 16 Oct 2018 12:33:33 +0530
Message-Id: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch series is, we can easily add/modify/delete
system call table support by changing entry in syscall.tbl file 
instead of manually changing many files. The other goal is to unify 
the system call table generation support implementation across all 
the architectures. 

The system call tables are in different format in all architecture. It
will be difficult to manually add, modify or delete the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate uapi header file and syscall table file.

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

Finally, this is the ground work for solving the Y2038 issue. We 
need to add two dozen of system calls to solve Y2038 issue. So this
patch series will help to add new system calls easily by adding new
entry in the syscall.tbl.

Firoz Khan (5):
  parisc: move __IGNORE* entries to non uapi header
  parisc: add __NR_syscalls along with __NR_Linux_syscalls
  parisc: add system call table generation support
  parisc: uapi header and system call table file generation
  parisc: syscalls: ignore nfsservctl for other architectures

 arch/parisc/Makefile                      |   4 +
 arch/parisc/include/asm/Kbuild            |   3 +
 arch/parisc/include/asm/unistd.h          |   8 +
 arch/parisc/include/uapi/asm/Kbuild       |   2 +
 arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
 arch/parisc/kernel/syscall.S              |  10 +-
 arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
 arch/parisc/kernel/syscalls/Makefile      |  57 ++++
 arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh |  34 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
 scripts/checksyscalls.sh                  |   1 +
 12 files changed, 529 insertions(+), 836 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

