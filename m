Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24469C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521A21722
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E521A21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbeKLGYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49938 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730204AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000oP-9R; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001j3-Ec; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ismael Ripoll Ripoll" <iripoll@upv.es>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Chen Gang" <gang.chen.5i5j@gmail.com>,
        "Hector Marco-Gisbert" <hecmargi@upv.es>,
        "Michal Hocko" <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Konstantin Khlebnikov" <koct9i@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.527131203@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 251/366] binfmt_elf: fix calculations for bss padding
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 0036d1f7eb95bcc52977f15507f00dd07018e7e2 upstream.

A double-bug exists in the bss calculation code, where an overflow can
happen in the "last_bss - elf_bss" calculation, but vm_brk internally
aligns the argument, underflowing it, wrapping back around safe.  We
shouldn't depend on these bugs staying in sync, so this cleans up the
bss padding handling to avoid the overflow.

This moves the bss padzero() before the last_bss > elf_bss case, since
the zero-filling of the ELF_PAGE should have nothing to do with the
relationship of last_bss and elf_bss: any trailing portion should be
zeroed, and a zero size is already handled by padzero().

Then it handles the math on elf_bss vs last_bss correctly.  These need
to both be ELF_PAGE aligned to get the comparison correct, since that's
the expected granularity of the mappings.  Since elf_bss already had
alignment-based padding happen in padzero(), the "start" of the new
vm_brk() should be moved forward as done in the original code.  However,
since the "end" of the vm_brk() area will already become PAGE_ALIGNed in
vm_brk() then last_bss should get aligned here to avoid hiding it as a
side-effect.

Additionally makes a cosmetic change to the initial last_bss calculation
so it's easier to read in comparison to the load_addr calculation above
it (i.e.  the only difference is p_filesz vs p_memsz).

Link: http://lkml.kernel.org/r/1468014494-25291-2-git-send-email-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reported-by: Hector Marco-Gisbert <hecmargi@upv.es>
Cc: Ismael Ripoll Ripoll <iripoll@upv.es>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/binfmt_elf.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -508,28 +508,30 @@ static unsigned long load_elf_interp(str
 			 * Do the same thing for the memory mapping - between
 			 * elf_bss and last_bss is the bss section.
 			 */
-			k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
+			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
 			if (k > last_bss)
 				last_bss = k;
 		}
 	}
 
+	/*
+	 * Now fill out the bss section: first pad the last page from
+	 * the file up to the page boundary, and zero it from elf_bss
+	 * up to the end of the page.
+	 */
+	if (padzero(elf_bss)) {
+		error = -EFAULT;
+		goto out_close;
+	}
+	/*
+	 * Next, align both the file and mem bss up to the page size,
+	 * since this is where elf_bss was just zeroed up to, and where
+	 * last_bss will end after the vm_brk() below.
+	 */
+	elf_bss = ELF_PAGEALIGN(elf_bss);
+	last_bss = ELF_PAGEALIGN(last_bss);
+	/* Finally, if there is still more bss to allocate, do it. */
 	if (last_bss > elf_bss) {
-		/*
-		 * Now fill out the bss section.  First pad the last page up
-		 * to the page boundary, and then perform a mmap to make sure
-		 * that there are zero-mapped pages up to and including the
-		 * last bss page.
-		 */
-		if (padzero(elf_bss)) {
-			error = -EFAULT;
-			goto out_close;
-		}
-
-		/* What we have mapped so far */
-		elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);
-
-		/* Map the last of the bss segment */
 		error = vm_brk(elf_bss, last_bss - elf_bss);
 		if (BAD_ADDR(error))
 			goto out_close;

