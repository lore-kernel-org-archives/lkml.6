Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1F21945
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC1F21945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeHGJFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:05:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51501 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeHGJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:05:35 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43158019"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2018 14:52:33 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 9559F4B66A09;
        Tue,  7 Aug 2018 14:52:27 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 14:52:26 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <n-horiguchi@ah.jp.nec.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v5 0/4] x86/boot/KASLR: Parse ACPI table and limit kaslr in immovable memory.
Date:   Tue, 7 Aug 2018 14:49:56 +0800
Message-ID: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 9559F4B66A09.AA9DE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

***Background:
People reported that kaslr may randomly chooses some positions
which are located in movable memory regions. This will break memory
hotplug feature and make the memory can't be removed.

***Solutions:
There should be a method to limit kaslr to choosing immovable memory
regions, so there are 2 solutions:
1) Add a kernel parameter to specify the memory regions.
2) Get the information of memory hotremove, then kaslr will know the
   right regions.
In method 2, information about memory hot remove is in ACPI
tables, which will be parsed after 'start_kernel', kaslr can't get
the information.
In method 1, users should know the regions address and specify in
kernel parameter.

In the earliest time, I tried to dig ACPI tabls to solve this problem.
But I didn't splite the code in 'compressed/' and ACPI code, so the patch
is hard to follow so refused by community.
Somebody suggest to add a kernel parameter to specify the
immovable memory so that limit kaslr in these regions. Then I make
a patchset. After several versions, Ingo gave a suggestion:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
Follow Ingo's suggestion, imitate the ACPI code to parse the acpi
tables, so that the kaslr can get necessary memory information in
ACPI tables.
Since I think ACPI code is independent part, so copy the codes
and functions to 'compressed/' directory, so that kaslr won't
influence the initialization of ACPI.

PATCH 1/4 Reuse the head file of linux/acpi.h, and copy a fcuntion from
          ACPI code.
PATCH 2/4 Functions to parse ACPI code.
PATCH 3/4 If 'CONFIG_MEMORY_HOTREMOVE' specified, walk all nodes and
          store the information of immovable memory regions.
PATCH 4/4 According to the immovable memory regions, filter the
          immovable regions which KASLR can choose.

***Test results:
 - I did a very simple test, and it can get the memory information in
   bios and efi KVM guest machine, and put it by early printk. But no
   more tests, so it's with RFC tag.

v1->v2:
 -  Simplify some code.
Follow Baoquan He's suggestion:
 - Reuse the head file of acpi code.

v2->v3:
 - Test in more conditions, so remove the 'RFC' tag.
 - Change some comments.

v3->v4:
Follow Thomas Gleixner's suggetsion:
 - Put the whole efi related function into #define CONFIG_EFI and return
   false in the other stub.
 - Simplify two functions in head file.

v4->v5:
Follow Dou Liyang's suggestion:
 - Add more comments about some functions based on kernel code.
 - Change some typo in comments.
 - Clean useless variable.
 - Add check for the boundary of array.
 - Add check for 'movable_node' parameter

Any comments will be welcome.


Chao Fan (4):
  x86/boot: Add acpitb.h to help parse acpi tables
  x86/boot: Add acpitb.c to parse acpi tables
  x86/boot/KASLR: Walk srat tables to filter immovable memory
  x86/boot/KASLR: Limit kaslr to choosing the immovable memory

 arch/x86/boot/compressed/Makefile |   4 +
 arch/x86/boot/compressed/acpitb.c | 272 ++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/acpitb.h |   7 +
 arch/x86/boot/compressed/kaslr.c  | 125 ++++++++++++--
 4 files changed, 397 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/acpitb.c
 create mode 100644 arch/x86/boot/compressed/acpitb.h

-- 
2.17.1



