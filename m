Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A3C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49B21990
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F49B21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeHEWi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:38:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:38:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75KVtWH590214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:31:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75KVteL590211;
        Sun, 5 Aug 2018 13:31:55 -0700
Date:   Sun, 5 Aug 2018 13:31:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1@git.kernel.org>
Cc:     hpa@zytor.com, aarcange@redhat.com, keescook@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, luto@kernel.org, hughd@google.com,
        torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        peterz@infradead.org, jgross@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, ak@linux.intel.com, bp@alien8.de
Reply-To: keescook@google.com, hpa@zytor.com, aarcange@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hughd@google.com,
          luto@kernel.org, gregkh@linuxfoundation.org,
          torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
          peterz@infradead.org, jgross@suse.com, jpoimboe@redhat.com,
          tglx@linutronix.de, bp@alien8.de, ak@linux.intel.com
In-Reply-To: <20180802225828.89B2D0E2@viggo.jf.intel.com>
References: <20180802225828.89B2D0E2@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/init: Pass unconverted symbol addresses to
 free_init_pages()
Git-Commit-ID: 9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1
Gitweb:     https://git.kernel.org/tip/9f515cdb411ef34f1aaf4c40bb0c932cf6db5de1
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Thu, 2 Aug 2018 15:58:28 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 22:21:02 +0200

x86/mm/init: Pass unconverted symbol addresses to free_init_pages()

The x86 code has several places where it frees parts of kernel image:

 1. Unused SMP alternative
 2. __init code
 3. The hole between text and rodata
 4. The hole between rodata and data

We call free_init_pages() to do this.  Strangely, we convert the symbol
addresses to kernel direct map addresses in some cases (#3, #4) but not
others (#1, #2).

The virt_to_page() and the other code in free_reserved_area() now works
fine for for symbol addresses on x86, so don't bother converting the
addresses to direct map addresses before freeing them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@google.com
Cc: aarcange@redhat.com
Cc: jgross@suse.com
Cc: jpoimboe@redhat.com
Cc: gregkh@linuxfoundation.org
Cc: peterz@infradead.org
Cc: hughd@google.com
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: ak@linux.intel.com
Cc: Kees Cook <keescook@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20180802225828.89B2D0E2@viggo.jf.intel.com

---
 arch/x86/mm/init_64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a688617c727e..73158655c4a7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1283,12 +1283,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_init_pages("unused kernel",
-			(unsigned long) __va(__pa_symbol(text_end)),
-			(unsigned long) __va(__pa_symbol(rodata_start)));
-	free_init_pages("unused kernel",
-			(unsigned long) __va(__pa_symbol(rodata_end)),
-			(unsigned long) __va(__pa_symbol(_sdata)));
+	free_init_pages("unused kernel", text_end, rodata_start);
+	free_init_pages("unused kernel", rodata_end, _sdata);
 
 	debug_checkwx();
 
