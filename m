Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD19520837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnQaaycF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD19520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGGMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:12:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:12:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so1325384plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=33LAmMpyhxevV4eCGWL65TyyA77B75WzzLitAjcxwp0=;
        b=DnQaaycF5G0xqOpe5GhZN0oBnl7KobK66g94DjJYtagxmc1Aw6An8zhLNMJSx2Khf+
         jE8q8d3kGuNL5+9jzC9Jzy306hHOQw93tAV79jNFYEsV5AGevpxo97giomg2Ic6gr8p5
         zq2+1Hr1WdP3EjbDMC9YX/O/twmj1i6kIf7/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=33LAmMpyhxevV4eCGWL65TyyA77B75WzzLitAjcxwp0=;
        b=ldTG+J1jD4GH15X9BUDa2Qf36dvQXZoJhbTT910crzwV4Kj1ghqWrPkin/jbqGEMDo
         ajK/Mfp51uHAylzoxm6hx9TfJIMBZv8bi3L2dzaNnyv/DMeaEqr85MeHpm98oVUdwa+u
         fIZD9ehdLDU9uEiVlGk1AbQ3dr9V1VxoyHJVdPNQ5EXC30fAp0KsAKMsM2tRCK7wFIrU
         sZF1TT6cAar1dGt8IMseboBSnfamf+7mE/ZzDMMBMNUfphU6kugOANdAaL88wjnzwDrL
         0f9MS9FcASfm/SFdQ0tOQdYGF+4n+Ui1wFqUST3gZxqTYuJGbT9gCrkLWgiPCUp4bGTf
         Y6iQ==
X-Gm-Message-State: AA+aEWanqGcl3QVuYswUzKDMcj77WCz1GvlUyvGNKU9rgzrCwDPbeIXr
        Y2wYJfopMG+kPr1FFvhqlXh3uQ==
X-Google-Smtp-Source: AFSGD/WJkzGa/BQXVCA+2ena0rIkiwnI7g+Xte1HWyU1JOBP7yENZ/ORWr8tM1QeUxfPCYPeBJnIuQ==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr926202plo.123.1544163127092;
        Thu, 06 Dec 2018 22:12:07 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.25])
        by smtp.gmail.com with ESMTPSA id r4sm5719862pgn.54.2018.12.06.22.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 22:12:06 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 0/5] powerpc: system call table generation support
Date:   Fri,  7 Dec 2018 11:41:35 +0530
Message-Id: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
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
	- spu entry name, if required.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, mips, parisc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

Changes since v3:
 - split compat syscall table out from native table.
 - modified the script to add new line in the generated
   file.

Changes since v2:
 - modified/optimized the syscall.tbl to avoid duplicate
   for the spu entries.
 - updated the syscalltbl.sh to meet the above point.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (5):
  powerpc: add __NR_syscalls along with NR_syscalls
  powerpc: move macro definition from asm/systbl.h
  powerpc: add system call table generation support
  powerpc: split compat syscall table out from native table
  powerpc: generate uapi header and system call table files

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   4 +
 arch/powerpc/include/asm/syscall.h          |   3 +-
 arch/powerpc/include/asm/systbl.h           | 396 --------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/entry_64.S              |   7 +-
 arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
 arch/powerpc/kernel/systbl.S                |  40 ++-
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/kernel/vdso.c                  |   7 +-
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 17 files changed, 606 insertions(+), 898 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

