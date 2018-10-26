Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E6C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0403207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPqAW76g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0403207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeJZNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:45:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45740 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeJZNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:45:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so4901535pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y2Dae4Nsi30Inr1m8D0lKfVjdCA0TnNTltWVNoY1kkY=;
        b=XPqAW76gL7rzRPlWx4ghTBqiVz/Va+q3WSB5eKvbbbCx5T4VufvL7tWKbqgIfdA3Mc
         E3lxKiCiSs7cgQuxRC0eTPPQFkygIXD1guLht6/JrIENklcm5fMYN0Y2MOaWtU7cpRSL
         Oq1Pa/byelfgPonONDPDB1w2n9IlHFp7D0ga0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y2Dae4Nsi30Inr1m8D0lKfVjdCA0TnNTltWVNoY1kkY=;
        b=VNrp1tNFibSdfT0t+z4WRDharqw/En8D9F/OXUMKjX+ra4Fe4Z3G45fmHjqcb3j94E
         RtlfzVRdwm5BXVRxb4soIl0k6ABAmUbeYsgvZeILf9ISAVw3pOlLF+1+3oeRR3gf44LU
         Bz9d4l6PVSEQzW/PoDbakLxvL0Zo1wF+mv8gA+FBmRitbGPV57f1PrTY2NXBm+rwrYBo
         6F1S8a64bfEmMYGvvFQlUhRPp2CPFM/LIjbcg85GZCChahGeU0W+Wm4fMIZpXJBua39T
         b7O6l7YTDyUzkkfDMek2jwFKB6j2QAft7mXQhVG3+pLSDsa7kbfpi12DxYLGdfysRHpT
         j4cg==
X-Gm-Message-State: AGRZ1gJmZJtN69dcISQs0g8q2XdFj1qV/Kw0L78dmPtyRQs4YWQQBXOy
        +Qpu0e0GG2ZB7j2sH5Nu4gFRxA==
X-Google-Smtp-Source: AJdET5fRbl41czbR4jrNgAQXfCiRasr5nv5dvYCyHogAtkOfnaqg/hboUtwejYsG9BX+Zk3E20q6kw==
X-Received: by 2002:a17:902:b58c:: with SMTP id a12-v6mr2038254pls.226.1540530577073;
        Thu, 25 Oct 2018 22:09:37 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id i135-v6sm3579822pfe.115.2018.10.25.22.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:09:36 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 0/3] microblaze: system call table generation support
Date:   Fri, 26 Oct 2018 10:39:09 +0530
Message-Id: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
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

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, ia64, m68k, mips, 
parisc, powerpc, sh, sparc, and xtensa. Below mentioned git repos-
itory contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038 issue. We need 
to add two dozen of system calls to solve Y2038 issue. So this patch
series will help to add new system calls easily by adding new entry 
in the syscall.tbl.

Firoz Khan (3):
  microblaze: move __NR_syscalls macro from asm/unistd.h
  microblaze: add system call table generation support
  microblaze: generate uapi header and system call table files

 arch/microblaze/Makefile                      |   3 +
 arch/microblaze/include/asm/Kbuild            |   1 +
 arch/microblaze/include/asm/unistd.h          |   2 -
 arch/microblaze/include/uapi/asm/Kbuild       |   1 +
 arch/microblaze/include/uapi/asm/unistd.h     | 407 +------------------------
 arch/microblaze/kernel/syscall_table.S        | 406 +------------------------
 arch/microblaze/kernel/syscalls/Makefile      |  38 +++
 arch/microblaze/kernel/syscalls/syscall.tbl   | 410 ++++++++++++++++++++++++++
 arch/microblaze/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/microblaze/kernel/syscalls/syscalltbl.sh |  32 ++
 10 files changed, 526 insertions(+), 810 deletions(-)
 create mode 100644 arch/microblaze/kernel/syscalls/Makefile
 create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
 create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

