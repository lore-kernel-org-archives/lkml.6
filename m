Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A57A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A57A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeKPH5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:57:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41938 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:57:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so10315463pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 13:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5lAnJ4Odmi3MOIXfrC7f3waSSM1TNTIQKK1l8SjDyk4=;
        b=H96Thg7b2D6GFOqK7yFr2EJT/+iZeKKbN6xuiFE/HcVp4DLm91aB8bE9oaPEvBuMw5
         3zpxpRxSjk8V3kQOeZ7upKkFO8heiIBdrIKO6CJybnWs47A8EaZTrNrTbBw8agTehYfL
         tUiEnVpT6rLd93FLvuqE09MRlGbtmrpxiddTWVYepMZ1bj35eYFqe+X6YJEEmPqUDoBG
         xk1TSXwvwE6IXkdFxMBWIs4P5XewOAN6N5Bj9UxTDrQv3zyvQC5HDIOWbSZ7XSp/tMzI
         t7DojOGOpREGx501JNOhp/xWLjc63V46FUH8afON1rf1Ttzg+l2g60nXozCORK25ie9W
         Wslw==
X-Gm-Message-State: AGRZ1gKB+oQNhFk/3vw1Yr6tA6zGzMfvMVEehwNntRbgDxy/NgHm5bS3
        7kg5F89pNx1gs5AR8bR1RAaf616x6A0=
X-Google-Smtp-Source: AJdET5fEUFYsOrWhggAIBt5LpnTwfSWI4BpkgRXA8eV3TdOGoYjbhoMyKq8WcjAiYnztQIGPRxPX7Q==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr8169321pfe.11.1542318483718;
        Thu, 15 Nov 2018 13:48:03 -0800 (PST)
Received: from localhost ([122.177.154.119])
        by smtp.gmail.com with ESMTPSA id z7sm17940256pga.6.2018.11.15.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 13:48:02 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, bhsharma@redhat.com,
        Boris Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
Date:   Fri, 16 Nov 2018 03:17:49 +0530
Message-Id: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 kernel uses 'page_offset_base' variable to point to the
start of direct mapping of all physical memory. This variable
is also updated for KASLR boot cases, so this can be exported
via vmcoreinfo as a standard ABI between kernel and user-space,
to allow user-space utilities to use the same for calculating
the start of direct mapping of all physical memory.

'arch/x86/kernel/head64.c' sets the same as:
   unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;

and also uses the same to indicate the base of KASLR regions on x86_64:
   static __initdata struct kaslr_memory_region {
	    unsigned long *base;
	        unsigned long size_tb;
   } kaslr_regions[] = {
	    { &page_offset_base, 0 },
   .. snip ..

Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
live-debugging of a running kernel via user-space utilities
like makedumpfile (see [1]).

Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
details), whose live debugging feature is broken with newer kernels
(I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
added to kcore, thus leading to an additional sections in the same, and
makedumpfile is not longer able to determine the start of direct
mapping of all physical memory, as it relies on traversing the PT_LOAD
segments inside kcore and using the last PT_LOAD segment
to determine the start of direct mapping.

Such user-space issues can be resolved if the user-space code instead
uses a standard ABI to read the kernel exposed machine specific
variables. With the kernel commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"]), it is
now possible to use the vmcoreinfo present inside kcore as the standard
ABI which can be used by the user-space utilities for reading
the machine specific information (and hence for debugging a
live kernel).

User-space utilities like makedumpfile, kexec-tools and crash
are either already using this ABI or are discussing patches
which look to add the same feature. This helps in simplifying the
overall code and also in reducing code-rewrite across the
user-space utilities for getting values of these kernel
symbols/variables.

Accordingly this patch allows appending 'page_offset_base' for
x86_64 platforms to vmcoreinfo, so that user-space tools can use the
same as a standard interface to determine the start of direct mapping
of all physical memory.

Testing:
-------
 - I tested this patch (rebased on 'linux-next') on a x86_64 machine
   using the modified 'makedumpfile' user-space code (see [3] for my
   github tree which contains the same) for determining how many pages
   are dumpable when different dump_level is specified (which is
   one use-case of live-debugging via 'makedumpfile').
 - I tested both the KASLR and non-KASLR boot cases with this patch.
 - Here is one sample log (for KASLR boot case) on my x86_64 machine:

   < snip..>
   The kernel doesn't support mmap(),read() will be used instead.

   TYPE		PAGES			EXCLUDABLE	DESCRIPTION
   ----------------------------------------------------------------------
   ZERO		21299           	yes		Pages filled
   with zero
   NON_PRI_CACHE	91785           	yes		Cache
   pages without private flag
   PRI_CACHE	1               	yes		Cache pages with
   private flag
   USER		14057           	yes		User process
   pages
   FREE		740346          	yes		Free pages
   KERN_DATA	58152           	no		Dumpable kernel
   data

   page size:		4096
   Total pages on system:	925640
   Total size on system:	3791421440       Byte

[1]. MAN pages -> MAKEDUMPFILE(8) and CRASH(8)
[2]. makedumpfile issue with latest kernels -> http://lists.infradead.org/pipermail/kexec/2018-October/021769.html
[3]. https://github.com/bhupesh-sharma/makedumpfile/tree/add-page-offset-base-to-vmcore-v1

Cc: Boris Petkov <bp@alien8.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Dave Anderson <anderson@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: x86@kernel.org
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - Fixed the build issue reported by build bot and tested this version
   with 'make allmodconfig'.
 - Reworded most of the commit log to explain the intent behind the
   patch.

 arch/x86/kernel/machine_kexec_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..6161d77c5bfb 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+#ifdef CONFIG_RANDOMIZE_BASE
+	VMCOREINFO_NUMBER(page_offset_base);
+#endif
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.7.4

