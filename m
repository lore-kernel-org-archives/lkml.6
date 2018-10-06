Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2AC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8B521473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8B521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJFPqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 11:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJFPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 11:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15C40308A967;
        Sat,  6 Oct 2018 08:43:53 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9013C608F2;
        Sat,  6 Oct 2018 08:43:49 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] x86/doc/kaslr.txt: Create a separate part of document abourt KASLR at the end of file
Date:   Sat,  6 Oct 2018 16:43:27 +0800
Message-Id: <20181006084327.27467-4-bhe@redhat.com>
In-Reply-To: <20181006084327.27467-1-bhe@redhat.com>
References: <20181006084327.27467-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sat, 06 Oct 2018 08:43:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the original content as the first part to only list static mm
layout tables in non-KASLR case. Then add KASLR related description
at the end.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/x86/x86_64/mm.txt | 64 +++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index b4bc95c9790e..549fcae596e0 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -1,5 +1,5 @@
 
-Virtual memory map with 4 level page tables:
+MM layout in non-KASLR case:
 
 0000000000000000 - 00007fffffffffff (=47 bits,   128 TB) user space, different per mm
 				    hole caused by [47:63] sign extension
@@ -12,7 +12,6 @@ ffffea0000000000 - ffffeaffffffffff (=40 bits,     1 TB) virtual memory map (vme
 ffffeb0000000000 - ffffebffffffffff (=40 bits,     1 TB) unused hole
 ffffec0000000000 - fffffbffffffffff (=44 bits,    16 TB) kasan shadow memory
 fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
-				    vaddr_end for KASLR
 fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
 fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) LDT remap for PTI
 ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
@@ -38,7 +37,6 @@ ffd4000000000000 - ffd5ffffffffffff (=49 bits,   512 TB) virtual memory map (vme
 ffd6000000000000 - ffdeffffffffffff (~51 bits,  2304 TB) unused hole
 ffdf000000000000 - fffffdffffffffff (~53 bits,    ~8 PB) kasan shadow memory
 fffffc0000000000 - fffffdffffffffff (=41 bits,     2 TB) unused hole
-				    vaddr_end for KASLR
 fffffe0000000000 - fffffe7fffffffff (=39 bits,   512 GB) cpu_entry_area mapping
 fffffe8000000000 - fffffeffffffffff (=39 bits,   512 GB) unused hole
 ffffff0000000000 - ffffff7fffffffff (=39 bits,   512 GB) %esp fixup stacks
@@ -70,10 +68,58 @@ memory window (this size is arbitrary, it can be raised later if needed).
 The mappings are not part of any other kernel PGD and are only available
 during EFI runtime calls.
 
-Note that if CONFIG_RANDOMIZE_MEMORY is enabled, the direct mapping of all
-physical memory, vmalloc/ioremap space and virtual memory map are randomized.
-Their order is preserved but their base will be offset early at boot time.
+MM layout related to KASLR
+=========================================================================
 
-Be very careful vs. KASLR when changing anything here. The KASLR address
-range must not overlap with anything except the KASAN shadow area, which is
-correct as KASAN disables KASLR.
+Kernel Address Space Layout Randomization (KASLR) consists of two parts
+which work together to enhance the security of the Linux kernel:
+
+ - Kernel text KASLR
+ - Memory region KASLR
+
+Kernel text KASLR
+-----------------
+The physical address and virtual address of kernel text itself are
+randomized to a different position separately. The physical address of
+the kernel can be anywhere, under 64TB at most in 4-level paging mode,
+and under 4 PB in 5-level paging mode, while the virtual address of the
+kernel is restricted between [0xffffffff80000000, ffffffffbfffffff],
+the 1GB space.
+
+ffffffff80000000 - ffffffffbfffffff (1 GB)  kernel text mapping, from phys 0
+ffffffffc0000000 - fffffffffeffffff (1 GB) module mapping space
+
+Note: The kernel text KASLR uses 1 GB space to randomize the position of
+kernel image, and it's defalutly enabled. If KASLR config option
+CONFIG_RANDOMIZE_BASE is not enabled, the space for kernel image will be
+shrunk to 512 MB, accordingly increase the size of modules area to 1.5 GB.
+
+Memory region KASLR
+-------------------
+If CONFIG_RANDOMIZE_MEMORY is enabled, the below three memory regions
+are randomized. Their order is preserved but their base will be offset
+early at boot time.
+
+   - direct mapping region
+   - vmalloc region
+   - vmemmap region
+
+The KASLR address range must not overlap with anything except the KASAN
+shadow area, which is correct as KASAN disables KASLR.
+
+So if take 4-level paging mode as example, from the original starting
+address of the direct mapping region for physical RAM, to the starting
+address of the cpu_entry_area mapping region, namely
+[0xffff880000000000 - 0xfffffdffffffffff], the scope of 118 TB in all
+is the virtual address space where memory region KASLR can be allowed to
+move those memory regions around. After KASLR manipulation is done, their
+layout looks like:
+
+Name            Starting address        Size                                         Aligned
+-----------------------------------------------------------------------------------------------
+direct mapping  page_offset_base        [actual size of system RAM + 10 TB padding]  1 GB
+*guard hole     random                  random                                       1 GB
+vmalloc         vmalloc_base            32 TB                                        1 GB
+*guard hole     random                  random                                       1 GB
+vmemmap         vmemmap_base            1 TB                                         1 GB
+*guard hole     random                  random                                       1 GB
-- 
2.13.6

