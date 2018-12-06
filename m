Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820BE2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g56Z+fgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820BE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeLFFTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44234 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFFTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:19:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so10080798pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C1Xuh2535Fa+RWnxEWVBxpaOqkUrCktk81TUOrBNUiE=;
        b=g56Z+fgrdwc5a/V5GCGCotdt29XzXk0250SVjfk44SqA1OxghyAu1VSQScxzYtS86y
         TCEaaJ0Y/fZRouJ/th1J8lDm5rUYr1NazhQCUdVJTgFAidKFv3yhdX+gASZS9BBgVoAg
         /my9xCV21nRT0VRfgxScU0c8y1DXG93zp92Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C1Xuh2535Fa+RWnxEWVBxpaOqkUrCktk81TUOrBNUiE=;
        b=YZg6Q4A4szbm/4g+3T6UrEakYwA0fZI8394HHB4jtEa8rjO60OZsO0S4Eh2YJaaK/J
         YW47EtXQ1GWcrX6UYrnavMurk5AULF4NrOZx1b1UP4FW8ZdrcxHOCvLtL+LWWi90G4yS
         KCD0CwsA7k1HgqMW1+t0AFZb3oKH04mcHXGbf0ywMUU2znLFRyO5S+WmaTeGDXUm5rUJ
         Gp1wtMXFoJA/AB0L3pCO3IxbcFaKCTzTnqX8es7KJv3rx9JTzotUapWV/R4+fq2PDzYo
         TsRXwsZxEpl/r0wBe2J31g9inIwIvDQj3y+CmqsiXgX5wwSwj1k1oFycgtLRi1GYgzDd
         cXYQ==
X-Gm-Message-State: AA+aEWbZkpcao0iRMb2HS448A1BeW/cY38jrWw/STJD437oPWs19t1Cn
        m4BLicgw4T9+aIbiMsV9mWYV8g==
X-Google-Smtp-Source: AFSGD/VcLOaTuSQEV8WNTy5Xu1iWyTuD1fWrj24OVcrFbcQRT4uKhBRHpD3WCeUmwfJBU8nOKhAGxA==
X-Received: by 2002:a62:710a:: with SMTP id m10mr26507241pfc.69.1544073558804;
        Wed, 05 Dec 2018 21:19:18 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:18 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 0/7] mips: system call table generation support
Date:   Thu,  6 Dec 2018 10:48:21 +0530
Message-Id: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
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

Changes since v3:
 - rearranged the patches for '64' to 'n64' conver-
   sion.
 - moved the unistd_nr_*.h files to asm/unistd.h
 - modified the *.sh files.

Changes since v2:
 - fixed __NR_syscalls assign issue.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (7):
  mips: add __NR_syscalls along with __NR_Linux_syscalls
  mips: remove unused macros
  mips: rename macros and files from '64' to 'n64'
  mips: add +1 to __NR_syscalls in uapi header
  mips: remove syscall table entries
  mips: add system call table generation support
  mips: generate uapi header and system call table files

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/asm/asm.h               |    6 +-
 arch/mips/include/asm/fpregdef.h          |    4 +-
 arch/mips/include/asm/fw/arc/hinv.h       |    2 +-
 arch/mips/include/asm/regdef.h            |    4 +-
 arch/mips/include/asm/sigcontext.h        |    4 +-
 arch/mips/include/asm/unistd.h            |   11 +-
 arch/mips/include/uapi/asm/Kbuild         |    6 +
 arch/mips/include/uapi/asm/fcntl.h        |    2 +-
 arch/mips/include/uapi/asm/reg.h          |    4 +-
 arch/mips/include/uapi/asm/sgidefs.h      |    2 +-
 arch/mips/include/uapi/asm/sigcontext.h   |    4 +-
 arch/mips/include/uapi/asm/stat.h         |    4 +-
 arch/mips/include/uapi/asm/statfs.h       |    4 +-
 arch/mips/include/uapi/asm/unistd.h       | 1069 +----------------------------
 arch/mips/kernel/Makefile                 |    2 +-
 arch/mips/kernel/ftrace.c                 |    8 +-
 arch/mips/kernel/scall32-o32.S            |  391 +----------
 arch/mips/kernel/scall64-64.S             |  444 ------------
 arch/mips/kernel/scall64-n32.S            |  341 +--------
 arch/mips/kernel/scall64-n64.S            |  117 ++++
 arch/mips/kernel/scall64-o32.S            |  379 +---------
 arch/mips/kernel/syscalls/Makefile        |   96 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  343 +++++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl |  382 +++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
 arch/mips/kernel/syscalls/syscallnr.sh    |   28 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
 arch/mips/kvm/entry.c                     |    4 +-
 arch/mips/vdso/vdso.h                     |    2 +-
 arch/mips/vdso/vdso.lds.S                 |    2 +-
 33 files changed, 1450 insertions(+), 2634 deletions(-)
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

