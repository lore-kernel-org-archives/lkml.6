Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5551220684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfGj6/DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5551220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeJATQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:16:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeJATQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:16:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so9110181pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fVI0u1iT198yHhx4UK3N0bA9+ivAz3toURxswIBVd3I=;
        b=GfGj6/DSneL9s8vj1tn5+F7PWhojC1HCWJnPibSpQ3c3/3J5v+hvXMs9MD0wQbKYm/
         OJ8tcY0zZR2ElOy/KRpoiIGevanOg8NLhH97vRKiTPFqigDMpbxA/akjpPsFYT6VaY8E
         DvCAB/XuhplD7v326YlaI9dzTR9D76MktkdlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fVI0u1iT198yHhx4UK3N0bA9+ivAz3toURxswIBVd3I=;
        b=s1iF6r719gJNldSJEKp/uS3mtxvi1KqVnxnEf02gq3mYbcEXgHZk8qkxNiNPQIk2Ck
         vQDYobD3hNfIJZQAgBD3EA1V+cbVD6DA4Fzh66JBnzkPIz8YS9N4CLyT9BNy9q/Z/3eH
         7ytiyw1j92nqDMYR9f5ahCkeCsIagNpB9IqD+a1LmC/U07GB+MdPmMnQbCBM9rfCaGKW
         0/NwyPakjc8imnxZHTxz4xOR4w8L2WxEmL0Y/EVFTPeHUv8aGLTROp7By6IedPsz5ApC
         3igdiQ/6+O5yLALX0FqLwo/DldrznFKH32V0dvJMa13Uu1wT8qO0MIp3+Ypad9zL5JDq
         ekrw==
X-Gm-Message-State: ABuFfohuscOBSAq/2FxJXZ10NaaWBhRm/dT287gWfmlYMR/ogUCXcoyF
        qLkktUIkxlIOOCKBBN4ltlDVIw==
X-Google-Smtp-Source: ACcGV61xCb1yDKDg4usQFunESihTpcmtmZbfwnluoE/OKBRH/tYEjSsLUAA+JDYAcvLQXWBlom2r/Q==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3-v6mr11503585plo.218.1538397518257;
        Mon, 01 Oct 2018 05:38:38 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id o12-v6sm21329345pfh.20.2018.10.01.05.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:38:37 -0700 (PDT)
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
Subject: [PATCH v3 0/5] System call table generation support
Date:   Mon,  1 Oct 2018 18:07:52 +0530
Message-Id: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
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

Firoz Khan (5):
  m68k: rename system call table file name
  m68k: replace NR_syscalls macro from asm/unistd.h
  m68k: add system call table generation support
  m68k: uapi header and system call table file generation
  m68k: add __IGNORE* entries in asm/unistd.h

 arch/m68k/Makefile                      |   3 +
 arch/m68k/include/asm/Kbuild            |   1 +
 arch/m68k/include/asm/unistd.h          |  10 +-
 arch/m68k/include/uapi/asm/Kbuild       |   1 +
 arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
 arch/m68k/kernel/Makefile               |   2 +-
 arch/m68k/kernel/syscall_table.S        |  14 ++
 arch/m68k/kernel/syscalls/Makefile      |  38 +++
 arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
 arch/m68k/kernel/syscalls/syscallhdr.sh |  35 +++
 arch/m68k/kernel/syscalls/syscalltbl.sh |  34 +++
 arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
 12 files changed, 505 insertions(+), 790 deletions(-)
 create mode 100644 arch/m68k/kernel/syscall_table.S
 create mode 100644 arch/m68k/kernel/syscalls/Makefile
 create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
 create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/m68k/kernel/syscalltable.S

-- 
1.9.1

