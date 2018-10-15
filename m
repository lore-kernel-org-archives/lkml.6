Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E87C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D39020644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D39020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeJOXD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:03:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeJOXD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:03:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9FF9tYh3671981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 08:09:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9FF9rkr3671975;
        Mon, 15 Oct 2018 08:09:53 -0700
Date:   Mon, 15 Oct 2018 08:09:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-8cad6c58c9effb59b830bcf0103d8267ad2e312d@git.kernel.org>
Cc:     jpoimboe@redhat.com, dave.hansen@intel.com,
        torvalds@linux-foundation.org, jan.kiszka@siemens.com,
        dvlasenk@redhat.com, bp@suse.de, linux-mm@kvack.org,
        David.Laight@aculab.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, jgross@suse.com, hpa@zytor.com, brgerst@gmail.com,
        eduval@amazon.com, gregkh@linuxfoundation.org, jroedel@suse.de,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        will.deacon@arm.com, x86@kernel.org, jkosina@suse.cz,
        boris.ostrovsky@oracle.com, aarcange@redhat.com
Reply-To: aarcange@redhat.com, x86@kernel.org, jkosina@suse.cz,
          boris.ostrovsky@oracle.com, mingo@kernel.org,
          peterz@infradead.org, will.deacon@arm.com,
          gregkh@linuxfoundation.org, jroedel@suse.de, tglx@linutronix.de,
          luto@kernel.org, jgross@suse.com, brgerst@gmail.com,
          eduval@amazon.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          dvlasenk@redhat.com, bp@suse.de, jan.kiszka@siemens.com,
          David.Laight@aculab.com, linux-mm@kvack.org,
          dave.hansen@intel.com, jpoimboe@redhat.com,
          torvalds@linux-foundation.org
In-Reply-To: <f271c747-1714-5a5b-a71f-ae189a093b8d@siemens.com>
References: <f271c747-1714-5a5b-a71f-ae189a093b8d@siemens.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/32: Clear the CS high bits
Git-Commit-ID: 8cad6c58c9effb59b830bcf0103d8267ad2e312d
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

Commit-ID:  8cad6c58c9effb59b830bcf0103d8267ad2e312d
Gitweb:     https://git.kernel.org/tip/8cad6c58c9effb59b830bcf0103d8267ad2e312d
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Mon, 15 Oct 2018 16:09:29 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 15 Oct 2018 16:54:28 +0200

x86/entry/32: Clear the CS high bits

Even if not on an entry stack, the CS's high bits must be
initialized because they are unconditionally evaluated in
PARANOID_EXIT_TO_KERNEL_MODE.

Failing to do so broke the boot on Galileo Gen2 and IOT2000 boards.

 [ bp: Make the commit message tone passive and impartial. ]

Fixes: b92a165df17e ("x86/entry/32: Handle Entry from Kernel-Mode on Entry-Stack")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Brian Gerst <brgerst@gmail.com>
CC: Dave Hansen <dave.hansen@intel.com>
CC: David Laight <David.Laight@aculab.com>
CC: Denys Vlasenko <dvlasenk@redhat.com>
CC: Eduardo Valentin <eduval@amazon.com>
CC: Greg KH <gregkh@linuxfoundation.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Jiri Kosina <jkosina@suse.cz>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Juergen Gross <jgross@suse.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Will Deacon <will.deacon@arm.com>
CC: aliguori@amazon.com
CC: daniel.gruss@iaik.tugraz.at
CC: hughd@google.com
CC: keescook@google.com
CC: linux-mm <linux-mm@kvack.org>
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/f271c747-1714-5a5b-a71f-ae189a093b8d@siemens.com
---
 arch/x86/entry/entry_32.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..fbbf1ba57ec6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -389,6 +389,13 @@
 	 * that register for the time this macro runs
 	 */
 
+	/*
+	 * The high bits of the CS dword (__csh) are used for
+	 * CS_FROM_ENTRY_STACK and CS_FROM_USER_CR3. Clear them in case
+	 * hardware didn't do this for us.
+	 */
+	andl	$(0x0000ffff), PT_CS(%esp)
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %ecx
 	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
@@ -407,12 +414,6 @@
 	/* Load top of task-stack into %edi */
 	movl	TSS_entry2task_stack(%edi), %edi
 
-	/*
-	 * Clear unused upper bits of the dword containing the word-sized CS
-	 * slot in pt_regs in case hardware didn't clear it for us.
-	 */
-	andl	$(0x0000ffff), PT_CS(%esp)
-
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
