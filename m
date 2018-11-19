Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF798224B3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxoxkq5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF798224B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405948AbeKTD0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405038AbeKTD0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:26:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C8452243B;
        Mon, 19 Nov 2018 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646945;
        bh=SxIJT9cWqRF8nZICSdOrFpokMOLztAKi6+SnKv2HeaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxoxkq5R6CDR5p+68nbryUHPqJZkLSkaGeT+Ue1/uv2bOfAEldIvFd+K569+GJ13J
         bDPpeyNAJZTLusI2erpUSOQoVyRZJbPyeT4IMF2P7DEMu9rPQqIhMy2y136yibS8ts
         AqMDnYOo5CNfh0TTVdEGanxXVaatz0Vq+4FKIQek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Chen Gang <gang.chen.5i5j@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 113/160] binfmt_elf: fix calculations for bss padding
Date:   Mon, 19 Nov 2018 17:29:12 +0100
Message-Id: <20181119162641.731743738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 70ea4b9c6dd9..2963a23f7a80 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -604,28 +604,30 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
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
+		goto out;
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
-			goto out;
-		}
-
-		/* What we have mapped so far */
-		elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);
-
-		/* Map the last of the bss segment */
 		error = vm_brk(elf_bss, last_bss - elf_bss);
 		if (BAD_ADDR(error))
 			goto out;
-- 
2.17.1



