Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C7EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024DA20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlX7SFDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024DA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLMJEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:04:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45914 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLMJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:04:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so775000pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kx/v8SQuOHTsbh88Np6JyLP5jvdQm+NuUr90LMrVo8w=;
        b=YlX7SFDR9cj48oXpkjb8Bukgm61kV0HMDsIsI4L2Fb30Z0FvEYwl1mrFzqFvQdKKcc
         QSxW5pVMOBhw92lu0Fa3ZeOlrDWnL1qDZ1KFyow881D/srcc1bwF1RTcGwwK12ODmONw
         zFj7rrVQnO1zMzeeuohiRLjr0zbm3VRnnJftk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kx/v8SQuOHTsbh88Np6JyLP5jvdQm+NuUr90LMrVo8w=;
        b=soj/Yps/hnJ1lO3i6boab0ThHhpjMWLLuClNqys6fAq/o4IvNp8tIil0Wlwpe6cXWB
         4eeflEuNruJz2Xq/hahKQd+G5RWCQ1dN/ShSOpmdSkxqEyARhswEhNlWlTzicGopohBP
         LL0ws7kxsN3KE776ugYtXnG+pMXkCKml3lisuo2pAmq+N6aHeqEqH+mN18PhNVQQ2Por
         cFjqDjBGQ7o8IR/CPoaxiKzCjpmSM3ZQHPz76IsYg+LxWQSnTL2cMd3aufqN71QoSGQw
         BGnMDFkymhU8wMcOgPvQcUz5m5u2odxudlgu9W/LLjQXNPAdiubQmoJ/QyN4cXJZlahw
         nCVQ==
X-Gm-Message-State: AA+aEWbuIcynVlipVGlW0RvyYRGrvAygQ2OmiG1GfryTSC5Pgv8123wL
        YOcImbTRaCJ5OVDMz1yeuoPNXA==
X-Google-Smtp-Source: AFSGD/XUa3MDhpCNsjqrFCGouyWgWVa8l1cO2bNkMJVwhoosGiP1NCR5LgAROIywliqJWNy2/j9hSA==
X-Received: by 2002:a62:f907:: with SMTP id o7mr22862310pfh.244.1544691853295;
        Thu, 13 Dec 2018 01:04:13 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s9sm1888305pgl.88.2018.12.13.01.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:04:12 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 0/5] powerpc: system call table generation support
Date:   Thu, 13 Dec 2018 14:32:45 +0530
Message-Id: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
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

Changes since v4:
 - DOTSYM macro removed for ppc32, which was causing
   the compilation error.

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

