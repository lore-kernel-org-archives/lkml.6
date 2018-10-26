Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83888ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843120856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3843120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeJ0HW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:22:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44127 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJ0HW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:22:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so1156516pgs.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=blV1uJceTF8g3thIB+bJ4AMvV9RpGbBxHFqhV8wcVWY=;
        b=opETHjhbgt+7IgHEdLyyECtpOboQe2LB/eDSqD682lWV7p2DUgKrBQvVIUFwZ/o9qp
         ITs0HEPGdghWS6v053G86v5l9uPalZnrn9WGJaRRHvPNPd4sh4+n+yQEZbE2PrGv7saA
         y60eBGJWroNot/mH18UjF/U640PwoP2mN86B20cFADUZ23a3NRbM49GYKu+bNnEBz3Mo
         l9zEQHBkxiVaErcoIDgfs5MYlWIX2W2bCTiisD0ykg77lyntf+zvokutOXquUkJHTUJU
         FRPyuktMQf6NZtpfs+rjW8WP7plW6+qE+XIBvdJZHw/lsKWbRNVBuRn4cJZJTFTEZaFv
         SaFw==
X-Gm-Message-State: AGRZ1gJb7SdP0ONqburgmK4GR9ZkQBYDuIqF91pNuUtmxQncMifeNAX9
        RDEq0GaYbg4G2O1n2k11GkAnF8atgoon5w==
X-Google-Smtp-Source: AJdET5e/bcKInsqnrhbi4oNxCzrdVQL6r76ZUq3UwC1E3h4qD235BEcrSC8W9E+hJtUxYqjVUVZByg==
X-Received: by 2002:a62:9316:: with SMTP id b22-v6mr5756155pfe.193.1540593816503;
        Fri, 26 Oct 2018 15:43:36 -0700 (PDT)
Received: from localhost ([182.69.238.40])
        by smtp.gmail.com with ESMTPSA id c14-v6sm12860976pfc.92.2018.10.26.15.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 15:43:35 -0700 (PDT)
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
Subject: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
Date:   Sat, 27 Oct 2018 04:13:08 +0530
Message-Id: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 23c85094fe1895caefdd
["proc/kcore: add vmcoreinfo note to /proc/kcore"]), '/proc/kcore'
contains a new PT_NOTE which carries the VMCOREINFO information.

If the same is available, one can use it in user-land to
retrieve machine specific symbols or strings being appended to the
vmcoreinfo even for live-debugging of the primary kernel as a
standard interface exposed by kernel for sharing machine specific
details with the user-land.

In the past I had a discussion with James, where he suggested this
approach (please see [0]) and I really liked the idea. Since then I
have been working on unifying the implementations of
(atleast) the commonly used user-space utilities that provide
live-debugging capabilities (tools like 'makedumpfile' and
'crash-utility', see [1] for details of these tools).

For the same, when live debugging on x86_64 machines, user-space
tools currently rely on different mechanisms to determine
the 'page_offset_base' value (i.e. start of direct mapping of all
physical memory). One of the approach used by 'makedumpfile'
user-space tool for e.g. is to calculate the same from the last
PT_LOAD available in '/proc/kcore', which can be flaky as and when
new sections (for e.g. KCORE_REMAP which was added
to recent kernels) are added to kcore.

For other architectures like arm64, I have already proposed using
the vmcoreinfo note (in '/proc/kcore') in the user-space utilities to
determine machine specific details like VA_BITS, PAGE_OFFSET,
kasrl_offset() (see [2] for details), for which different user-space
tools earlier used different (and at times flaky) approaches like:

- Reading kernel CONFIGs from user-space and determining CONFIG values
   like VA_BITS from there.
 - Reading symbols from '/proc/kallsyms' and determining their values
   via '/dev/mem' interface.
 - Reading symbols from 'vmlinux' and determing their values from
   reading memory.

This patch allows appending 'page_offset_base' for x86_64 platforms
to vmcoreinfo, so that user-space tools can use the same as a standard
interface to determine the start of direct mapping of all physical
memory.

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

I understand that there might be some reservations about exporting
such machine-specific details in the vmcoreinfo, but to unify
the implementations across user-land and archs, perhaps this would be
good starting point to start a discussion.

[0]. https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html
[1]. MAN pages -> MAKEDUMPFILE(8) and CRASH(8)
[2]. https://www.spinics.net/lists/kexec/msg21608.html
     http://lists.infradead.org/pipermail/kexec/2018-October/021725.html
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
 arch/x86/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..834ccefef867 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -356,6 +356,7 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+	VMCOREINFO_NUMBER(page_offset_base);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.7.4

