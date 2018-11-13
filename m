Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93598C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579B42245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYNN1w/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579B42245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeKMP5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:57:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbeKMP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:57:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so809328pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZNZDTnvn7tIw3FL3DX98sGo/8aKILPg2Pkrl1bj/yKw=;
        b=JYNN1w/ovNR6C0MnBZupTFVuCMOTsPPqnx+ccMgR/Ydub30taGLV8whCBr2mI6R7Kq
         HADQY/yQ4O1rPPHNdIbaLLNYe14QcbKSTv0bLEltB6LlQkZZ6bT4x08pxi2G5L/+DNva
         nMb7QRxlREkz+HhZwDcZC7SbAynipWDuXAW5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZNZDTnvn7tIw3FL3DX98sGo/8aKILPg2Pkrl1bj/yKw=;
        b=D8NAE0mTB3VQHrEoatf7C+6OpLW+0papCTaaXe7MvCZKgNXaUZujH/TI8uLEnT4o/Q
         o1FK/fU7sLGCgV/GmbUgXXvxAMn3VAcPo1TobXePH6ZgCutv7tvnsUSlG0Qh9kbz9Wj4
         87jwCSDIWPNn0/YRbB+VY2DRClXynRZCkbSPepY2N4Sjr2rlnZN8Y8cFhDQ3dkJf38pa
         kpgB7/zRhB/LwJrLPH/OSh73HAPnV4hKdw+k3cvc+FH413EMtWpcfqfsXp/kwFtUpOHv
         rZtMAJ1XGRtg5HaYmcaH4GjYLccgdZUdieR/frBgyXwmPyDF3eqg4XDn2vDy8amj9X88
         rWYg==
X-Gm-Message-State: AGRZ1gKowPNzXBnTpPhz33LCWSFr7aq/TbIvD8XW/K7TWGobPlhMLfwU
        giuWUnZfSApotHjhS5jTRaaZbg==
X-Google-Smtp-Source: AJdET5dLL8261EnkuFrj3nm0Cd/unbM8Zp0rQppOt75nu9UgOOERaJZ0UpWQeF95iueuuhWNaV88KA==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr3278710pgd.97.1542088863987;
        Mon, 12 Nov 2018 22:01:03 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r6-v6sm19150204pfk.157.2018.11.12.22.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:01:03 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 0/3] m68k: system call table generation support
Date:   Tue, 13 Nov 2018 11:30:26 +0530
Message-Id: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
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
ilar support. I leverage their implementation to
come up with a generic solution.

I have done the same support for work for alpha, ia64,
microblaze, mips, parisc, powerpc, sh, sparc and xtensa.
Below mentioned git repository contains more details
about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

changes since v4:
 - changed from generic-y to generated-y in Kbuild.
 - remove the patch "0001-m68k-rename-system-call-
   table-file-name.patch".

changes since v3:
 - optimized/updated the syscall table generation
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.

changes since v2:
 - removed __IGNORE entries which was added in v2
   to suppress the warning.
 - added missing new line.

changes since v1:
 - enclosed __NR_sycalls macro with __KERNEL__.

Firoz Khan (3):
  m68k: add __NR_syscalls along with NR_syscalls
  m68k: add system call table generation support
  m68k: generate uapi header and syscall table header files

 arch/m68k/Makefile                      |   3 +
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/unistd.h          |   3 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +------------------------------
 arch/m68k/kernel/syscalls/Makefile      |  38 ++++
 arch/m68k/kernel/syscalls/syscall.tbl   | 389 ++++++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  32 +++
 arch/m68k/kernel/syscalltable.S         | 387 +------------------------------
 10 files changed, 507 insertions(+), 768 deletions(-)
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

