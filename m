Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9AAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB812064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Udk5S74J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB812064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeKAWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:52:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38465 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeKAWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:52:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so9066302pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0/DkeLc7nl3D46WQ/mIxq/tnicHL4jpoWGn/tbxZ0d0=;
        b=Udk5S74J6wU22Aw6yHcj6/KL9/5K+b0/3NHPl5C+LeV8lnQ8atdyPrlurPwg7Adqhm
         uX+z045OdxSfluoho08iLPnWcBIuQ4hXYVUUQtcgnjs+3yyNRz0NqU8Sb1Cq67HJcZq3
         P+TJD8XQtbtUYZeytNwOmT8hRq+Ni9m+xmyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0/DkeLc7nl3D46WQ/mIxq/tnicHL4jpoWGn/tbxZ0d0=;
        b=COnkoDK26A/moHc9RW3MHivZ+Ed4VvcMxA3Plzi9WPhOkjHxqRIkC+67Ref9m9F0pe
         rP2hg33bM4HDBOR5u4f3JNdsdgOCAOtuIzSq8KvQL/Jqe1xcZ1P7rWnj5PLloPf0sY4d
         IMmq4oXJn/MAIxPGzV9phYfnnfXSuBzqC9RN5dLLY1+70DSw0dJTACpKcJpu59QdQ89/
         ANZlFZkY5oRpJFvN3t21hmAyUDx83UEnGWTVyn/d56bCDD/s6eOmGsr4llwGPE3m2xGu
         xAMF2rI5PxgWs3YbV/UARicoIuGQdBSjdP35vSBwo0yzm30ErgeN/ePPWMJxoIbfBxpj
         OzJQ==
X-Gm-Message-State: AGRZ1gJUIGiIqbH3VzUqkt6omniBspipDuzDuy7zCReyQQ7Z9tqV/nUz
        OanhPolcL0/Zi4Y4AVIISbLXrk0F+BE=
X-Google-Smtp-Source: AJdET5dSqijHHTq0st26mxlZajNggVYU/8lm8dBDaalV8qUS48+lOBicmslMo287uNmrf2VYEe/GlA==
X-Received: by 2002:aa7:80cd:: with SMTP id a13-v6mr7740302pfn.86.1541080158924;
        Thu, 01 Nov 2018 06:49:18 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id p11-v6sm16567307pfn.53.2018.11.01.06.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:49:18 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 0/3] sh: system call table generation support
Date:   Thu,  1 Nov 2018 19:18:47 +0530
Message-Id: <1541080130-3678-1-git-send-email-firoz.khan@linaro.org>
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

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to come
up with a generic solution.

I have done the same support for work for alpha, ia64,
m68k, microblaze, mips, parisc, powerpc, sparc, and 
xtensa. Below mentioned git repository contains more 
details about the workflow.

 https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to solve
Y2038 issue. So this patch series will help to add new 
system calls easily by adding new entry in the syscall.tbl.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.

Firoz Khan (3):
  sh: add __NR_syscalls along with NR_syscalls
  sh: add system call table generation support
  sh: generate uapi header and syscall table header files

 arch/sh/Makefile                      |   3 +
 arch/sh/include/asm/Kbuild            |   1 +
 arch/sh/include/asm/unistd.h          |   2 +
 arch/sh/include/uapi/asm/Kbuild       |   1 +
 arch/sh/include/uapi/asm/unistd_32.h  |   4 +-
 arch/sh/include/uapi/asm/unistd_64.h  |   4 +-
 arch/sh/kernel/syscalls/Makefile      |  38 ++++
 arch/sh/kernel/syscalls/syscall.tbl   | 392 ++++++++++++++++++++++++++++++++++
 arch/sh/kernel/syscalls/syscallhdr.sh |  36 ++++
 arch/sh/kernel/syscalls/syscalltbl.sh |  32 +++
 arch/sh/kernel/syscalls_32.S          | 387 +--------------------------------
 11 files changed, 514 insertions(+), 386 deletions(-)
 create mode 100644 arch/sh/kernel/syscalls/Makefile
 create mode 100644 arch/sh/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

