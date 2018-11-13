Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900622245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOUFgIiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900622245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbeKMURW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:17:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36750 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbeKMURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:17:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so5792810plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Kc95EnGn+cj3smKpIGHS2dmfSXbmuMZVNB7X3W2m89c=;
        b=aOUFgIiCiyA4ojFKzIeq8IuxmVjbpZYJuNvoymgCG1WPzdGw51nBx6khB2Z3H3KE0n
         6HvsI0p1LM1ki2GquUWZvaTPYZ622qF8O3vAGYkWTbxjZYul2Ef9aXOgdHO256b+iQ2W
         Le6G+KTue3NHGgaOMB0JsOzRmHhipzEP9Dixg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kc95EnGn+cj3smKpIGHS2dmfSXbmuMZVNB7X3W2m89c=;
        b=NdtVBj95fFrDcFtPPe2gI0ZcnXIOFx2ibm8C7v47s91xo7LbgZmTo1OjPABWDWsUhn
         Xa+dXLyluwqMPJa4b/Cu2tCbfCypF8j/BfKTpfXbUcPsZfpYoVsCXA6fGworh3QdN1CK
         os02axkodJus3vGSNLlh59Y6rDRbG3vTP/LINTgdxrEGKlY8MImzMHO0bPrk08bsfKvU
         wK23wXsx9q6a0BlmsynNgynsG/IPVF6ymKmuReMc6CQfIN/PkFLw3f+0qLnbcnndDSOi
         z+y1KJZjg18Br+GDcwD95gYdSesQrPfYxJis+AMeS9vRK66fO32zLXLyB0J6KIGJ2O7B
         PfEQ==
X-Gm-Message-State: AGRZ1gLEF8iKNZHbjg0lAfanxA4KKZMBYrPfDgdgRpBqJ9lF+iPMc2GU
        u5fNkPIDVPwwEL2AXfkyhjIdNw==
X-Google-Smtp-Source: AJdET5coDsB+bGzm1oggGjL6pYrJrYcro2yqDMf3kp3vfDEFwzegVOXfe3rDMQCuRpztGB/1+sSjtQ==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14-v6mr4430642plo.133.1542104396370;
        Tue, 13 Nov 2018 02:19:56 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id f10-v6sm13363364pfa.188.2018.11.13.02.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 02:19:55 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 0/3] xtensa: system call table generation support
Date:   Tue, 13 Nov 2018 15:49:27 +0530
Message-Id: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
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
itecture will be possible by adding new entry in the
syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to come
up with a generic solution.

I have done the same support for work for alpha, ia64,
m68k, microblaze, mips, parisc, powerpc, sh and sparc.
Below mentioned git repository contains more details 
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to solve
Y2038 issue. So this patch series will help to add new 
system calls easily by adding new entry in the syscall.tbl.

changes since v1:
 - changed from generic-y to generated-y in Kbuild.
 - removed the patch "0001-xtensa-move-SYS_XTENSA_-
   macros-to-non-uapi-header.patch".

Firoz Khan (3):
  xtensa: add __NR_syscalls along with __NR_syscall_count
  xtensa: add system call table generation support
  xtensa: generate uapi header and syscall table header files

 arch/xtensa/Makefile                      |   3 +
 arch/xtensa/include/asm/Kbuild            |   1 +
 arch/xtensa/include/asm/unistd.h          |   2 +
 arch/xtensa/include/uapi/asm/Kbuild       |   1 +
 arch/xtensa/include/uapi/asm/unistd.h     | 781 +-----------------------------
 arch/xtensa/kernel/syscall.c              |   5 +-
 arch/xtensa/kernel/syscalls/Makefile      |  38 ++
 arch/xtensa/kernel/syscalls/syscall.tbl   | 374 ++++++++++++++
 arch/xtensa/kernel/syscalls/syscallhdr.sh |  36 ++
 arch/xtensa/kernel/syscalls/syscalltbl.sh |  32 ++
 10 files changed, 492 insertions(+), 781 deletions(-)
 create mode 100644 arch/xtensa/kernel/syscalls/Makefile
 create mode 100644 arch/xtensa/kernel/syscalls/syscall.tbl
 create mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

