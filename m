Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAE820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAE820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeGTAR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:17:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeGTAR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:17:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNV4lM2453829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:31:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNV4nG2453824;
        Thu, 19 Jul 2018 16:31:04 -0700
Date:   Thu, 19 Jul 2018 16:31:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-935232ce28dfabff1171e5a7113b2d865fa9ee63@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bp@alien8.de, dave.hansen@intel.com, boris.ostrovsky@oracle.com,
        jpoimboe@redhat.com, brgerst@gmail.com, David.Laight@aculab.com,
        jkosina@suse.cz, pavel@ucw.cz, tglx@linutronix.de,
        dvlasenk@redhat.com, dhgutteridge@sympatico.ca, jroedel@suse.de,
        hpa@zytor.com, llong@redhat.com, peterz@infradead.org,
        aarcange@redhat.com, eduval@amazon.com, jgross@suse.com,
        mingo@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org,
        luto@kernel.org
Reply-To: hpa@zytor.com, jroedel@suse.de, eduval@amazon.com,
          llong@redhat.com, aarcange@redhat.com, peterz@infradead.org,
          jgross@suse.com, will.deacon@arm.com, luto@kernel.org,
          gregkh@linuxfoundation.org, mingo@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          bp@alien8.de, dave.hansen@intel.com, boris.ostrovsky@oracle.com,
          David.Laight@aculab.com, jkosina@suse.cz, jpoimboe@redhat.com,
          brgerst@gmail.com, tglx@linutronix.de, pavel@ucw.cz,
          dhgutteridge@sympatico.ca, dvlasenk@redhat.com
In-Reply-To: <1531906876-13451-25-git-send-email-joro@8bytes.org>
References: <1531906876-13451-25-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Git-Commit-ID: 935232ce28dfabff1171e5a7113b2d865fa9ee63
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

Commit-ID:  935232ce28dfabff1171e5a7113b2d865fa9ee63
Gitweb:     https://git.kernel.org/tip/935232ce28dfabff1171e5a7113b2d865fa9ee63
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:43 +0200

x86/mm/pti: Add an overflow check to pti_clone_pmds()

The addr counter will overflow if the last PMD of the address space is
cloned, resulting in an endless loop.

Check for that and bail out of the loop when it happens.

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
Link: https://lkml.kernel.org/r/1531906876-13451-25-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 71fba17c9d7c..79217868dd13 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -297,6 +297,10 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		p4d_t *p4d;
 		pud_t *pud;
 
+		/* Overflow check */
+		if (addr < start)
+			break;
+
 		pgd = pgd_offset_k(addr);
 		if (WARN_ON(pgd_none(*pgd)))
 			return;
