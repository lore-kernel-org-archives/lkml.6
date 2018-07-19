Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21568ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC6520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC6520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGTATh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:19:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGTATh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:19:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNXFLk2454141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:33:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNXFIY2454138;
        Thu, 19 Jul 2018 16:33:15 -0700
Date:   Thu, 19 Jul 2018 16:33:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-1ac228a7c87f697d1d01eb6362a6b5246705b0dd@git.kernel.org>
Cc:     torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dave.hansen@intel.com, tglx@linutronix.de, peterz@infradead.org,
        pavel@ucw.cz, bp@alien8.de, luto@kernel.org, mingo@kernel.org,
        boris.ostrovsky@oracle.com, jkosina@suse.cz, aarcange@redhat.com,
        David.Laight@aculab.com, hpa@zytor.com, dvlasenk@redhat.com,
        will.deacon@arm.com, jgross@suse.com, linux-kernel@vger.kernel.org,
        dhgutteridge@sympatico.ca, llong@redhat.com, brgerst@gmail.com,
        jroedel@suse.de, eduval@amazon.com, gregkh@linuxfoundation.org
Reply-To: pavel@ucw.cz, bp@alien8.de, torvalds@linux-foundation.org,
          dave.hansen@intel.com, jpoimboe@redhat.com, tglx@linutronix.de,
          peterz@infradead.org, luto@kernel.org, mingo@kernel.org,
          jkosina@suse.cz, boris.ostrovsky@oracle.com, aarcange@redhat.com,
          jgross@suse.com, linux-kernel@vger.kernel.org,
          dhgutteridge@sympatico.ca, hpa@zytor.com,
          David.Laight@aculab.com, dvlasenk@redhat.com,
          will.deacon@arm.com, gregkh@linuxfoundation.org,
          brgerst@gmail.com, llong@redhat.com, jroedel@suse.de,
          eduval@amazon.com
In-Reply-To: <1531906876-13451-29-git-send-email-joro@8bytes.org>
References: <1531906876-13451-29-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Keep permissions when cloning kernel text
 in pti_clone_kernel_text()
Git-Commit-ID: 1ac228a7c87f697d1d01eb6362a6b5246705b0dd
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

Commit-ID:  1ac228a7c87f697d1d01eb6362a6b5246705b0dd
Gitweb:     https://git.kernel.org/tip/1ac228a7c87f697d1d01eb6362a6b5246705b0dd
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:45 +0200

x86/mm/pti: Keep permissions when cloning kernel text in pti_clone_kernel_text()

Mapping the kernel text area to user-space makes only sense if it has the
same permissions as in the kernel page-table.  If permissions are different
this will cause a TLB reload when using the kernel page-table, which is as
good as not mapping it at all.

On 64-bit kernels this patch makes no difference, as the whole range cloned
by pti_clone_kernel_text() is mapped RO anyway. On 32 bit there are
writeable mappings in the range, so just keep the permissions as they are.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
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
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-29-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 453d23760941..e41ee93c430d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -482,7 +482,7 @@ void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pmds(start, end, _PAGE_RW);
+	pti_clone_pmds(start, end, 0);
 }
 
 /*
