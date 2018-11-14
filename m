Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ED6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075392145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vh7nmonY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075392145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKNOeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:34:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36151 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:34:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so7149611plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vdye+BuNHW8Eg+iXkudWiq6lS6xa8P7cm7FkstY9enU=;
        b=Vh7nmonYCRHQonc2SkIQwGTIEwQvP+l51cew7Rd4TmtHEl4EJkYaaV+oH+we8aH1ch
         4jw/vsgjg1FouErwSBTtpY5qOoGS0EmhRDAf0e79nXyZZjN+nC1cG7T5Ickitv+eONbT
         p2t88YQGlKsz78BG2Edm2Bf1dmccvNI7v9CKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vdye+BuNHW8Eg+iXkudWiq6lS6xa8P7cm7FkstY9enU=;
        b=Y+lejV39G7sJrNb8m8+NzxL2P34F4K7pr3Q0EggjbLVMQ0xGS0qxQfkcUedwsLxsTD
         pU+l8rJONkGOgTV7JF7SWI/qplgTjuEBhEVLJdFXvJZoJiGQaEynak1wx9zF2a7Km7J+
         4PE/BxZ3y8hMs//6ScrDa1hnKTiVi0yeY42alapx5a7c0B/xJkZZb+lwR9azNG+Ih8tl
         U9zACHirpSie2l59GgR6YNVl05Ht0CVzOMkrue54L29SbCwBaj1mKcnRlbpwYKipiP2w
         S4RWi4CZL3C6VozMgY8DBZSuSZn7rkHMGWA1qUgT+nyERoUqkKUOeRDWbgWzU2tpfT21
         Atmg==
X-Gm-Message-State: AGRZ1gIbdAB1JvfQNOqkpkwFrFwcO8xe+JPYc+HIQH/J7WHhVlsmmKr1
        7YbOZupX+AaxzkgQ8+QiRHfUpImHpK4=
X-Google-Smtp-Source: AJdET5dL3IaBjPKIHl6H40uZ/K5ElfANFrmpCnQ2ewWGnefHqVvFZiYQgq/rOXMafk6USBJ7mxA7KA==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr405896plm.212.1542169958958;
        Tue, 13 Nov 2018 20:32:38 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a17sm26382842pgm.26.2018.11.13.20.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 20:32:38 -0800 (PST)
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
Subject: [PATCH v3 0/3] sh: system call table generation support
Date:   Wed, 14 Nov 2018 10:02:07 +0530
Message-Id: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
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

Please note, this support is only available for 32-bit
kernel, not 64-bit kernel. As I came across the 64-bit
kernel is not active for long time.

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
system calls easily by adding new entry in the syscall-
.tbl.

Changes since v2:
 - changed from generic-y to generated-y in Kbuild.

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

