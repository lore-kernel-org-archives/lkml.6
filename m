Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48913214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6iwuKfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48913214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeKNP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:28:37 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:35335 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeKNP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:28:37 -0500
Received: by mail-pf1-f176.google.com with SMTP id v9-v6so7302655pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bhHMjbmFdEIeEVFRJfvKLawH8ssnIqjAwld5NlNbj0Q=;
        b=c6iwuKfMNdMl6vYVLdk9BvqyBK869h7z2jQdE8OCqKrerGvH5jH4qswvVCBTjP6DAJ
         f1M27xsN6SD6fe0Y2VhsEVG3ZNEB1oktJWT7hHL28Pob1AtChKJTu2x92+W46ObdzsI7
         hxo35JoX/9+VewllSaI3lh3mGWi7L6c7JG62Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bhHMjbmFdEIeEVFRJfvKLawH8ssnIqjAwld5NlNbj0Q=;
        b=CNa99eCWUDyShTnD5Cqgz+JyrO+KjGIy0qAahlYKcY78dM3EYPqhB1n9t8bHZvlyUN
         oOMYzt/auQ20oKR9rS6r8z+sdnGBMo/cxB8HQDYVVEPvtsa8ruGKsg81CYn+KiJImrMH
         u6pO5vZNivO0evR31tPyUZ2dQ/60kRJz9sZkEl90n+k14bWYzzdnd4QK5x611/4UcPDS
         gFvMQjzUMWabLyd/Suu+uA0BGsCIa16srlAubrOCFzILjHk0bBtvDd4YfHWtQtgSIa8i
         UUWA0j32GAxtAtn+JJBb2+I9K6gUDrjFQkjaui6tOYOPox0Si80220XKAM3ktE2yf/1d
         1OLA==
X-Gm-Message-State: AGRZ1gI9nZ3nkJ4hHrWWhqkCGhxRBRlGZ70MkGXA/5n7TzYMtNJpQEvV
        ZuAVPDGeFRzv2m/sBuaPxuY7MQ==
X-Google-Smtp-Source: AJdET5d8w4V7xWFrM2EkidqUo7iZNRw2eqR7FejZt45xQzQrIzEVQVaLPyGg80VCWCbuKxwCtOmbHQ==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr434505pgb.417.1542173217504;
        Tue, 13 Nov 2018 21:26:57 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm36331746pgp.90.2018.11.13.21.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 21:26:56 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 0/4] sparc: system call table generation support
Date:   Wed, 14 Nov 2018 10:56:27 +0530
Message-Id: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
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
ia64, m68k, microblaze, mips, parisc, powerpc, sh 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

Changes since v2:
 - changed from generic-y to generated-y in Kbuild.
 - added io_pgetevents entry in the syscall.tbl.
 - updated the compat system call table.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall.tbl.

Firoz Khan (4):
  sparc: move __IGNORE* entries to non uapi header
  sparc: add __NR_syscalls along with NR_syscalls
  sparc: add system call table generation support
  sparc: generate uapi header and system call table files

 arch/sparc/Makefile                      |   3 +
 arch/sparc/include/asm/Kbuild            |   4 +-
 arch/sparc/include/asm/unistd.h          |  18 ++
 arch/sparc/include/uapi/asm/Kbuild       |   2 +
 arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
 arch/sparc/kernel/syscalls/Makefile      |  55 ++++
 arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
 arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
 arch/sparc/kernel/systbls_32.S           |  81 +-----
 arch/sparc/kernel/systbls_64.S           | 157 +-----------
 11 files changed, 572 insertions(+), 655 deletions(-)
 create mode 100644 arch/sparc/kernel/syscalls/Makefile
 create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

