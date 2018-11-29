Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2134EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4422081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2jOAxnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4422081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeK2Tsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:48:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39715 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeK2Tsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:48:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so670957pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D6YuGSB6Fh2DrVbL5PpLfO9xayiHVR6qYfrJzW71lDI=;
        b=e2jOAxnXsqVwLTnZ6Y9AbfLTHNUz5iKONcBISTlyW70cCYZCOutlkQJKwEI/erONZw
         eTUqUEnYAyFjrNQWWPD06+YNDSpquA+qNnCVgvvRXZbEF8CAsy9I4yDvaVcqDiVASC4x
         XU1n7Gyw4WjaLQ15R9z+04WDDf9hamNFDX+Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D6YuGSB6Fh2DrVbL5PpLfO9xayiHVR6qYfrJzW71lDI=;
        b=ogf940ZA7KdKQ/SLpm3LknweURLO3tX9hZDmFEpQ27LC+tkRXA0H/NaEzIqxoVj43s
         wU9cl2Hc8pTwrKCvEn1bmjVd6ipbcqvBYcbI0+WfQqYcyAYdauFOBGlqtrT78wwCH2Ot
         9ZlHE7HsOiN5q1d4GEexv/XukHHKAws+tzIKnBxRsx/RP4AvdKVrlRZBLSEOirMuOQXk
         LE5S3rV3hw0bMVabITNThdSl0hb6wajF9nlxumZWC2v0K9mz0wx1PcpTWuG2MoCYaVS1
         KaLAE72CcCS4elce42dfk066ofFJ8H9SVzAjJUzeg8CK7e3XODyF1n+zTAc+5oeLbAJ4
         OTrQ==
X-Gm-Message-State: AA+aEWZLOa+k4X4VNThAJ7lRCJRzsKAGhh1m4UhwLeIfGF9GvVAk15v9
        cK8Nz/KmQ1xCe/idV9V27Sa3jQ==
X-Google-Smtp-Source: AFSGD/VCsliaiheK4Nt8mTihLe1fRMJdMTesfM5ztVlfU2mqixDDZmZX2rIlLYpJFt9tIQj9bEWGIA==
X-Received: by 2002:a62:4181:: with SMTP id g1mr543604pfd.45.1543481053199;
        Thu, 29 Nov 2018 00:44:13 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:12 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 0/6] mips: system call table generation support
Date:   Thu, 29 Nov 2018 14:13:30 +0530
Message-Id: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
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

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, parisc, powerpc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

Changes since v2:
 - fixed __NR_syscalls assign issue.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (6):
  mips: add __NR_syscalls along with __NR_Linux_syscalls
  mips: remove unused macros
  mips: add +1 to __NR_syscalls in uapi header
  mips: remove syscall table entries
  mips: add system call table generation support
  mips: generate uapi header and system call table files

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/asm/unistd.h            |    8 -
 arch/mips/include/uapi/asm/Kbuild         |    6 +
 arch/mips/include/uapi/asm/unistd.h       | 1065 +----------------------------
 arch/mips/kernel/Makefile                 |    2 +-
 arch/mips/kernel/ftrace.c                 |    8 +-
 arch/mips/kernel/scall32-o32.S            |  391 +----------
 arch/mips/kernel/scall64-64.S             |  444 ------------
 arch/mips/kernel/scall64-n32.S            |  341 +--------
 arch/mips/kernel/scall64-n64.S            |  117 ++++
 arch/mips/kernel/scall64-o32.S            |  379 +---------
 arch/mips/kernel/syscalls/Makefile        |   96 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  343 ++++++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl |  382 +++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   36 +
 arch/mips/kernel/syscalls/syscallnr.sh    |   30 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
 19 files changed, 1430 insertions(+), 2600 deletions(-)
 delete mode 100644 arch/mips/kernel/scall64-64.S
 create mode 100644 arch/mips/kernel/scall64-n64.S
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

