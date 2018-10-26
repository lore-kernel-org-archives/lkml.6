Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F39CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7F207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6FPLJpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE7F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeJZNtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:49:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44922 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:49:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so5095694pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PYh2oM+9zU8CExfKq8duTfH7XMAOfaOBGAvLLUe6XBA=;
        b=P6FPLJpHhU0IUOJXIYO82IX6SPbs1jQmnU7BUKiu9PqUvo0n3L9PtugUhUWw/elQss
         dBfhh37F+L213tmhs/RDI2TUwbdCGE2LdCQ5bMHLt4m4URiL6DDNjNHCG+zZBOlIAmwO
         oYUkOWts4qDf4z3LKtQRsePIVy8yCX3dJerJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PYh2oM+9zU8CExfKq8duTfH7XMAOfaOBGAvLLUe6XBA=;
        b=JQ+2lN4wonuhkyjUqaSfJnZ2gGETwUww6MfbwpCKxrfT6SxZqqNz2SiOTErNWTl/hF
         HhJCxoByPAgqawxdw1wVquiQl5cAZvBlmxOnWMJwDMnxBm4f9ogCLwS+O9vHOuigY0S4
         lKFyh97TIzCcFvQ532ko1r1p51cx2OgTo87KShQL5BdtXUlBPwXjejzjU7rcxiWz9ojb
         nn/gzXCPzgO14HohJCmKtrVitCmOq3N8lv/4QvQfEtHvT2pE1rrDEnujZ+V3OUpBviLG
         c5T9yJZdSCZujVMx4J8bIBhyuXa4EuQ4Rf5cPr/v6dypmApUwSTPMdNQxNKV4FaeXMHd
         Q03w==
X-Gm-Message-State: AGRZ1gJK/kTdVhKY62Pgse4/+hVAiISVJawNg8Tbx8DP8lV5iaTG25gu
        JxpBIe/vAxNAhNKKHPsp5q8sQg==
X-Google-Smtp-Source: AJdET5dO3TSUgGr/TZIx1/AnIz1s2T1XpnjkKl9Q4hexxOh6jsSmEwFr2Qvh6qGtwVJ4wMBwIcgTAw==
X-Received: by 2002:a63:d208:: with SMTP id a8-v6mr1921853pgg.99.1540530821976;
        Thu, 25 Oct 2018 22:13:41 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m16-v6sm3329302pff.173.2018.10.25.22.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:13:41 -0700 (PDT)
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
Subject: [PATCH v6 0/5] parisc: system call table generation support
Date:   Fri, 26 Oct 2018 10:43:06 +0530
Message-Id: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
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

The system call tables are in different format in all architecture. 
It will be difficult to manually add, modify or delete the system 
calls in the respective files manually. To make it easy by keeping
a script and which'll generate uapi header file and syscall table 
file.

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

I have done the same support for work for alpha, ia64, m68k, micro-
blaze, mips, powerpc, sh, sparc, and xtensa. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038 issue. We need 
to add two dozen of system calls to solve Y2038 issue. So this patch
series will help to add new system calls easily by adding new entry 
in the syscall.tbl.

Firoz Khan (5):
  parisc: move __IGNORE* entries to non uapi header
  parisc: add __NR_syscalls along with __NR_Linux_syscalls
  parisc: add system call table generation support
  parisc: generate uapi header and system call table files
  parisc: syscalls: ignore nfsservctl for other architectures

 arch/parisc/Makefile                      |   4 +
 arch/parisc/include/asm/Kbuild            |   3 +
 arch/parisc/include/asm/unistd.h          |   8 +
 arch/parisc/include/uapi/asm/Kbuild       |   2 +
 arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
 arch/parisc/kernel/syscall.S              |  11 +-
 arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
 arch/parisc/kernel/syscalls/Makefile      |  57 ++++
 arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
 arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
 scripts/checksyscalls.sh                  |   1 +
 12 files changed, 532 insertions(+), 836 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscall_table.S
 create mode 100644 arch/parisc/kernel/syscalls/Makefile
 create mode 100644 arch/parisc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

