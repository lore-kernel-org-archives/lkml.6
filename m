Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AFAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240F2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfAGDYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 22:24:03 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15467 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbfAGDYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 22:24:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,449,1539619200"; 
   d="scan'208";a="51438978"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 11:23:58 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9A6154B7D698;
        Mon,  7 Jan 2019 11:23:32 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 11:23:37 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v15 0/6] x86/boot/KASLR: Parse ACPI table and limit KASLR to choosing immovable memory
Date:   Mon, 7 Jan 2019 11:22:37 +0800
Message-ID: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9A6154B7D698.A69A9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***Background:
People reported that KASLR may randomly choose some positions
which are located in movable memory regions. This will make the
movable memory chosen by KASLR can't be removed.

***Solutions:
Get the information of memory hot-remove, then KASLR knows the
right regions. Information about memory-hotremove is in ACPI
SRAT, which will be parsed after start_kernel(), so KASLR
can't get the information.

Someone suggested to add a kernel parameter to specify the
immovable memory then limit KASLR in these regions. Then I make
a PATCHSET. After several versions, Ingo gave a suggestion:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
Follow Ingo's suggestion, imitate the ACPI code to parse the ACPI
tables, so that the KASLR can get necessary memory information in
ACPI tables.
ACPI code is an independent part, so imitate the codes and functions
to 'compressed/' directory, so that KASLR won't influence the
initialization of ACPI.

PATCH 1/6 Copy kstrtoull() to boot/string.c to instead of using
          old simple_strtoull()
PATCH 2/6 Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
PATCH 3/6 Introduce efi_get_rsdp_addr() to find RSDP from EFI table when
          booting from EFI.
PATCH 4/6 Introduce bios_get_rsdp_addr() to search RSDP in memory when
          booting from BIOS
PATCH 5/6 Compute SRAT from RSDP and walk SRAT to store the immovable
          memory regions and store the immovable memory regions.
PATCH 6/6 Calculate the intersection between memory regions from e820/efi
          memory table and immovable memory regions. Limit KASLR to
          choosing these regions for randomization.

***Tests:
Test it in QEMU guest with 10 NUMA nodes, every node has 512M memory.
Use earlyprintk with debug_putaddr() to display the immovable
memory regions when KASLR walks all memory. Compare the result with
dmesg. If they are same, the parsing job works well.
Here are test cases:
 - x86_64 machine booting from EFI
 - x86_64 machine booting from BIOS
 - i386 machine booting from BIOS
 - According to '/sys/firmware/efi/systab', add 'acpi_rsdp=' to cmdline to
   imitate case for get_acpi_rsdp()
 - Add 'acpi=off' to cmdline to test the detecting for cmdline.

v14->v15:
Follow Boris' suggestion:
 - Fix the usage of kstrtoull()
 - Add more test case
Follow Ingo's suggestion:
 - Clear the typecast
 - Change some variable name
 - If no efi systab found, use error() to halt
Follow Baoquan's suggestion:
 - Rebase from tip/master to tip/x86/boot

v13->v14:
Follow Baoquan's suggestion:
 - Use simple_strtoull() for now.
Follow Boris' suggestion:
 - Put 'return 0' out of 'ifdef' to make sure function return.
Follow Masa's suggestion:
 - Change the end of string as '\0'

v12->v13:
Follow Boris' suggestion:
 - Copy kstrtoull() to boot/string.c
Follow Masa's suggestion:
 - Change some code logical
Follow Baoquan's suggestion:
 - Add tag to disable export symbol

v11->v12:
Follow Boris' suggestion:
 - Change patch log and code comments.
 - Add 'CONFIG_EARLY_PARSE_RSDP' to make code easy to read
 - Put strtoull() to misc.c
Follow Masa's suggestion:
 - Remove the detection for 'movable_node'
 - Change the code logical about cmdline_find_option()

v10->v11:
Follow Boris' suggestion:
 - Link kstrtoull() instead of copying it.
 - Drop the useless wrapped function.

v9->v10:
Follow Baoquan's suggestion:
 - Change some log
 - Merge last two patch together.

v8-v9:
Follow Boris' suggestion:
 - Change code style.
 - Splite PATCH 1/3 to more path.
 - Introduce some new function
 - Use existing function to rework some code
Follow Masayoshi's suggetion:
 - Make code more readable

v7-v8:
Follow Kees Cook's suggestion:
 - Use mem_overlaps() to check memory region.
 - Use #ifdef in the definition of function.

v6->v7:
Follow Rafael's suggestion:
 - Add more comments and patch log.
Follow test robot's suggestion:
 - Add "static" tag for function

v5->v6:
Follow Baoquan He's suggestion:
 - Change some log.
 - Add the check for acpi_rsdp
 - Change some code logical to make code clear

v4->v5:
Follow Dou Liyang's suggestion:
 - Add more comments about some functions based on kernel code.
 - Change some typo in comments.
 - Clean useless variable.
 - Add check for the boundary of array.
 - Add check for 'movable_node' parameter

v3->v4:
Follow Thomas Gleixner's suggestion:
 - Put the whole efi related function into #define CONFIG_EFI and return
   false in the other stub.

v2->v3:
 - Test in more conditions, so remove the 'RFC' tag.
 - Change some comments.

v1->v2:
 - Simplify some code.
Follow Baoquan He's suggestion:
 - Reuse the head file of acpi code.

Any comments will be welcome.


Chao Fan (6):
  x86/boot: Copy kstrtoull() to boot/string.c instead of using
    simple_strtoull()
  x86/boot: Introduce get_acpi_rsdp() to parse RSDP in cmdline from
    KEXEC
  x86/boot: Introduce efi_get_rsdp_addr() to find RSDP from EFI table
  x86/boot: Introduce bios_get_rsdp_addr() to search RSDP in memory
  x86/boot: Parse SRAT address from RSDP and store immovable memory
  x86/boot/KASLR: Limit KASLR to extracting kernel in immovable memory

 arch/x86/Kconfig                  |  12 ++
 arch/x86/boot/compressed/Makefile |   2 +
 arch/x86/boot/compressed/acpi.c   | 337 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c  |  83 ++++++--
 arch/x86/boot/compressed/misc.h   |  19 ++
 arch/x86/boot/string.c            | 137 ++++++++++++
 arch/x86/boot/string.h            |   2 +
 7 files changed, 577 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/boot/compressed/acpi.c

-- 
2.20.1



