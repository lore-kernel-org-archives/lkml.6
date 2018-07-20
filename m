Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164E320671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164E320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeGTV2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:28:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbeGTV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:28:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6KKbRIj2785011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Jul 2018 13:37:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6KKbRpK2785008;
        Fri, 20 Jul 2018 13:37:27 -0700
Date:   Fri, 20 Jul 2018 13:37:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-d5e84c21dbf5ea458897f88346dc979909eed913@git.kernel.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com, David.Laight@aculab.com,
        dvlasenk@redhat.com, alexander.shishkin@linux.intel.com,
        acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jgross@suse.com, mingo@kernel.org,
        brgerst@gmail.com, bp@alien8.de, dave.hansen@intel.com,
        dhgutteridge@sympatico.ca, luto@kernel.org, hpa@zytor.com,
        jroedel@suse.de, peterz@infradead.org, pavel@ucw.cz,
        llong@redhat.com, jkosina@suse.cz, eduval@amazon.com,
        aarcange@redhat.com, will.deacon@arm.com, namhyung@kernel.org,
        torvalds@linux-foundation.org, boris.ostrovsky@oracle.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          jgross@suse.com, gregkh@linuxfoundation.org,
          alexander.shishkin@linux.intel.com, dvlasenk@redhat.com,
          acme@kernel.org, tglx@linutronix.de, David.Laight@aculab.com,
          jpoimboe@redhat.com, namhyung@kernel.org, will.deacon@arm.com,
          boris.ostrovsky@oracle.com, torvalds@linux-foundation.org,
          pavel@ucw.cz, peterz@infradead.org, eduval@amazon.com,
          aarcange@redhat.com, jkosina@suse.cz, llong@redhat.com,
          jroedel@suse.de, bp@alien8.de, brgerst@gmail.com,
          luto@kernel.org, hpa@zytor.com, dhgutteridge@sympatico.ca,
          dave.hansen@intel.com
In-Reply-To: <1532103744-31902-3-git-send-email-joro@8bytes.org>
References: <1532103744-31902-3-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Check for VM86 mode in slow-path check
Git-Commit-ID: d5e84c21dbf5ea458897f88346dc979909eed913
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

Commit-ID:  d5e84c21dbf5ea458897f88346dc979909eed913
Gitweb:     https://git.kernel.org/tip/d5e84c21dbf5ea458897f88346dc979909eed913
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 20 Jul 2018 18:22:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 22:33:41 +0200

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
