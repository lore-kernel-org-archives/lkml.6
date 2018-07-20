Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0803E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0803E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGTU2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:28:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbeGTU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:28:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6KJbbbq2769255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Jul 2018 12:37:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6KJbbJ32769251;
        Fri, 20 Jul 2018 12:37:37 -0700
Date:   Fri, 20 Jul 2018 12:37:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-9cd342705877526f387cfcb5df8a964ab5873deb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com, bp@alien8.de,
        dhgutteridge@sympatico.ca, luto@kernel.org, aarcange@redhat.com,
        torvalds@linux-foundation.org, dvlasenk@redhat.com, pavel@ucw.cz,
        brgerst@gmail.com, jgross@suse.com, hpa@zytor.com,
        mingo@kernel.org, jroedel@suse.de, gregkh@linuxfoundation.org,
        peterz@infradead.org, David.Laight@aculab.com, jolsa@redhat.com,
        boris.ostrovsky@oracle.com, acme@kernel.org, namhyung@kernel.org,
        will.deacon@arm.com, jkosina@suse.cz,
        alexander.shishkin@linux.intel.com, eduval@amazon.com,
        tglx@linutronix.de, dave.hansen@intel.com, llong@redhat.com
Reply-To: gregkh@linuxfoundation.org, jroedel@suse.de, hpa@zytor.com,
          mingo@kernel.org, brgerst@gmail.com, jgross@suse.com,
          peterz@infradead.org, David.Laight@aculab.com,
          alexander.shishkin@linux.intel.com, will.deacon@arm.com,
          jkosina@suse.cz, acme@kernel.org, namhyung@kernel.org,
          boris.ostrovsky@oracle.com, jolsa@redhat.com,
          dave.hansen@intel.com, llong@redhat.com, tglx@linutronix.de,
          eduval@amazon.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, bp@alien8.de, luto@kernel.org,
          dhgutteridge@sympatico.ca, pavel@ucw.cz,
          torvalds@linux-foundation.org, dvlasenk@redhat.com,
          aarcange@redhat.com
In-Reply-To: <1532103744-31902-3-git-send-email-joro@8bytes.org>
References: <1532103744-31902-3-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Check for VM86 mode in slow-path check
Git-Commit-ID: 9cd342705877526f387cfcb5df8a964ab5873deb
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

Commit-ID:  9cd342705877526f387cfcb5df8a964ab5873deb
Gitweb:     https://git.kernel.org/tip/9cd342705877526f387cfcb5df8a964ab5873deb
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 20 Jul 2018 18:22:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 21:32:08 +0200

x86/entry/32: Check for VM86 mode in slow-path check

The SWITCH_TO_KERNEL_STACK macro only checks for CPL == 0 to go down the
slow and paranoid entry path. The problem is that this check also returns
true when coming from VM86 mode. This is not a problem by itself, as the
paranoid path handles VM86 stack-frames just fine, but it is not necessary
as the normal code path handles VM86 mode as well (and faster).

Extend the check to include VM86 mode. This also makes an optimization of
the paranoid path possible.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532103744-31902-3-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 010cdb41e3c7..2767c625a52c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -414,8 +414,16 @@
 	andl	$(0x0000ffff), PT_CS(%esp)
 
 	/* Special case - entry from kernel mode via entry stack */
-	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
-	jz	.Lentry_from_kernel_\@
+#ifdef CONFIG_VM86
+	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
+	movb	PT_CS(%esp), %cl
+	andl	$(X86_EFLAGS_VM | SEGMENT_RPL_MASK), %ecx
+#else
+	movl	PT_CS(%esp), %ecx
+	andl	$SEGMENT_RPL_MASK, %ecx
+#endif
+	cmpl	$USER_RPL, %ecx
+	jb	.Lentry_from_kernel_\@
 
 	/* Bytes to copy */
 	movl	$PTREGS_SIZE, %ecx
