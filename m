Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8952145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUZt+y2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8952145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbeKNUGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:06:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeKNUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:06:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so839031pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6xSUduzYKVvcq6cKNxLgEZlOBjfKb9+Sl/B0AVBfewM=;
        b=kUZt+y2F4HCJ1gdP5ksaWADRNQR3bwh5UXsvOksbzStyAnQxEtkYqcrZf/0ZQ7lAjk
         0rRKG5HvZbqa3jUip5uZQKQZc+waBzUqUw4k+nv4s8FlJ3k+jpWHGT2bRbNTq4lzqMOo
         UrByBjnFBLWEKSiUhDPD1Dyi4SIZyN6uxQiB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6xSUduzYKVvcq6cKNxLgEZlOBjfKb9+Sl/B0AVBfewM=;
        b=YA7Wx49fyLMnKx52z8DdFUJkDvUY7W8ec9hfCq22LAYu4CBR0S5HU5DgpdVSFlXu7R
         D1Mce1mtxmWjf/NuIzpB9OGOPsHbrO/au3WmsCod0Q6z6t1Qeh9msYPvk6FzxRVhWC9/
         jc8o7U3AZX83kTnOc/kAWRajoJpyMytI6BHgocln8IZ+j997fdXuEIJ7ClvUmvXFncfV
         fzYsA6FejNG/Enl9X3YExvjEuizKr/pZjH/6eC0oOsaKUxPyD/X3tg2nr/I8kZ57oxAH
         vG/V5oJRNsPvwHxmZTh0sraO2YwnCknZ3G9ZJ7qdcoQQxUgRXUXSbLLsVzJJoyeB1ZuJ
         isdg==
X-Gm-Message-State: AGRZ1gJZ/9Cu4t49eo8YrDJM4Mi9QZF9gSpZCaWK/Nc23PwbAZwFzcYX
        E2A1k+s1v95Wrv0Vzg3aZdqZZg==
X-Google-Smtp-Source: AJdET5eW5H8R9aWNqk+6t3OR1fmogCNSbaFCW8JfFB0rj0pQVznTeaKdkLF6j+6zF12dj8UjMTMFOQ==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr1177088pgv.438.1542189826546;
        Wed, 14 Nov 2018 02:03:46 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id g15sm21633873pfj.131.2018.11.14.02.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 02:03:45 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Ram Pai <linuxram@us.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 0/4] powerpc: system call table generation support
Date:   Wed, 14 Nov 2018 15:33:14 +0530
Message-Id: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
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
	- Compat entry name.
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

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (4):
  powerpc: add __NR_syscalls along with NR_syscalls
  powerpc: move macro definition from asm/systbl.h
  powerpc: add system call table generation support
  powerpc: generate uapi header and system call table files

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   4 +
 arch/powerpc/include/asm/systbl.h           | 396 ---------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +-------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/syscalls/Makefile       |  61 +++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 408 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  36 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  41 +++
 arch/powerpc/kernel/systbl.S                |  37 +--
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 14 files changed, 575 insertions(+), 892 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

