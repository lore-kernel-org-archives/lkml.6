Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1298CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBFB20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 03:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBFB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbeLLDLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:11:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52699 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbeLLDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 22:11:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="49566317"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Dec 2018 11:11:28 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id AD86D4B734CC;
        Wed, 12 Dec 2018 11:11:23 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 11:11:27 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v13 0/6] x86/boot/KASLR: Parse ACPI table and limit KASLR to choosing immovable memory
Date:   Wed, 12 Dec 2018 11:10:47 +0800
Message-ID: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: AD86D4B734CC.A9EF5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***Background:
People reported that KASLR may randomly choose some positions
which are located in movable memory regions. This will break memory
hotplug feature and make the movable memory chosen by KASLR can't be
removed.

***Solutions:
Get the information of memory hot-remove, then KASLR will know the
right regions. Information about memory hot-remove is in ACPI
tables, which will be parsed after start_kernel(), so that KASLR
can't get the information.

Somebody suggest to add a kernel parameter to specify the
immovable memory so that limit KASLR in these regions. Then I make
a PATCHSET. After several versions, Ingo gave a suggestion:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
Follow Ingo's suggestion, imitate the ACPI code to parse the ACPI
tables, so that the kaslr can get necessary memory information in
ACPI tables.
I think ACPI code is an independent part, so imitate the codes
and functions to 'compressed/' directory, so that kaslr won't
influence the initialization of ACPI.

PATCH 1/6 Copy kstrtoull() to boot/string.c
PATCH 2/6 Add get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
PATCH 3/6 Add efi_get_rsdp_addr() to find RSDP from EFI table when
          booting from EFI.
PATCH 4/6 Add bios_get_rsdp_addr() to search RSDP in memory when EFI
          table not found.
PATCH 5/6 Compute SRAT from RSDP and walk SRAT to store the immovable
          memory regions.
PATCH 6/6 Calculate the intersection between memory regions from e820/efi
          memory table and immovable memory regions. Limit KASLR to
          choosing these regions for randomization.

v1->v2:
 -  Simplify some code.
Follow Baoquan He's suggestion:
 - Reuse the head file of acpi code.

v2->v3:
 - Test in more conditions, so remove the 'RFC' tag.
 - Change some comments.

v3->v4:
Follow Thomas Gleixner's suggestion:
 - Put the whole efi related function into #define CONFIG_EFI and return
   false in the other stub.

v4->v5:
Follow Dou Liyang's suggestion:
 - Add more comments about some functions based on kernel code.
 - Change some typo in comments.
 - Clean useless variable.
 - Add check for the boundary of array.
 - Add check for 'movable_node' parameter

v5->v6:
Follow Baoquan He's suggestion:
 - Change some log.
 - Add the check for acpi_rsdp
 - Change some code logical to make code clear

v6->v7:
Follow Rafael's suggestion:
 - Add more comments and patch log.
Follow test robot's suggestion:
 - Add "static" tag for function

v7-v8:
Follow Kees Cook's suggestion:
 - Use mem_overlaps() to check memory region.
 - Use #ifdef in the definition of function.

v8-v9:
Follow Boris' suggestion:
 - Change code style.
 - Splite PATCH 1/3 to more path.
 - Introduce some new function
 - Use existing function to rework some code
Follow Masayoshi's suggetion:
 - Make code more readable

v9->v10:
Follow Baoquan's suggestion:
 - Change some log
 - Merge last two patch together.

v10->v11:
Follow Boris' suggestion:
 - Link kstrtoull() instead of copying it.
 - Drop the useless wrapped function.

v11->v12:
Follow Boris' suggestion:
 - Change patch log and code comments.
 - Add 'CONFIG_EARLY_PARSE_RSDP' to make code easy to read
 - Put strtoull() to misc.c
Follow Masa's suggestion:
 - Remove the detection for 'movable_node'
 - Change the code logical about cmdline_find_option()

v12->v13:
Follow Boris' suggestion:
 - Copy kstrtoull() to boot/string.c 
Follow Masa's suggestion:
 - Change some code logical
Follow Baoquan's suggestion:
 - Add tag to disable export symbol

Any comments will be welcome.

Chao Fan (6):
  x86/boot: Introduce kstrtoull() to boot directory instead of
    simple_strtoull()
  x86/boot: Introduce get_acpi_rsdp() to parse RSDP in cmdline from
    KEXEC
  x86/boot: Introduce efi_get_rsdp_addr() to find RSDP from EFI table
  x86/boot: Introduce bios_get_rsdp_addr() to search RSDP in memory
  x86/boot: Parse SRAT from RSDP and store immovable memory
  x86/boot/KASLR: Limit KASLR to extracting kernel in immovable memory

 arch/x86/Kconfig                  |  10 +
 arch/x86/boot/compressed/Makefile |   2 +
 arch/x86/boot/compressed/acpi.c   | 322 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c  |  79 ++++++--
 arch/x86/boot/compressed/misc.h   |  21 ++
 arch/x86/boot/string.c            | 137 +++++++++++++
 arch/x86/boot/string.h            |   2 +
 7 files changed, 558 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/boot/compressed/acpi.c

-- 
2.19.2



