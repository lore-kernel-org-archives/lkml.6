Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AAFC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C921884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C921884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbeHGTMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:12:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:12:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w77Gt7VI1317272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Aug 2018 09:55:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w77Gt5K01317269;
        Tue, 7 Aug 2018 09:55:05 -0700
Date:   Tue, 7 Aug 2018 09:55:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-88c6f8a3977cc35997b47e2f99f080a15559c1eb@git.kernel.org>
Cc:     dhgutteridge@sympatico.ca, bp@alien8.de, brgerst@gmail.com,
        eduval@amazon.com, torvalds@linux-foundation.org,
        boris.ostrovsky@oracle.com, mingo@kernel.org, aarcange@redhat.com,
        dave.hansen@intel.com, llong@redhat.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, jroedel@suse.de, David.Laight@aculab.com,
        peterz@infradead.org, dvlasenk@redhat.com, luto@kernel.org,
        will.deacon@arm.com, jkosina@suse.cz, pavel@ucw.cz
Reply-To: tglx@linutronix.de, jroedel@suse.de, David.Laight@aculab.com,
          peterz@infradead.org, jpoimboe@redhat.com, jkosina@suse.cz,
          pavel@ucw.cz, luto@kernel.org, dvlasenk@redhat.com,
          will.deacon@arm.com, boris.ostrovsky@oracle.com,
          mingo@kernel.org, aarcange@redhat.com, dave.hansen@intel.com,
          dhgutteridge@sympatico.ca, bp@alien8.de,
          torvalds@linux-foundation.org, brgerst@gmail.com,
          eduval@amazon.com, linux-kernel@vger.kernel.org,
          llong@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
          jgross@suse.com
In-Reply-To: <1533637471-30953-2-git-send-email-joro@8bytes.org>
References: <1533637471-30953-2-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Fix 32 bit PCID check
Git-Commit-ID: 88c6f8a3977cc35997b47e2f99f080a15559c1eb
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

Commit-ID:  88c6f8a3977cc35997b47e2f99f080a15559c1eb
Gitweb:     https://git.kernel.org/tip/88c6f8a3977cc35997b47e2f99f080a15559c1eb
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Tue, 7 Aug 2018 12:24:29 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 7 Aug 2018 18:51:22 +0200

x86/mm/pti: Fix 32 bit PCID check

The check uses the wrong operator and causes false positive
warnings in the kernel log on some systems.

Fixes: 5e8105950a8b3 ('x86/mm/pti: Add Warning when booting on a PCID capable CPU')
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
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1533637471-30953-2-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ef8db6ffc836..113ba14a03d8 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -549,7 +549,7 @@ void __init pti_init(void)
 	 * supported on 32 bit anyway. To print the warning we need to
 	 * check with cpuid directly again.
 	 */
-	if (cpuid_ecx(0x1) && BIT(17)) {
+	if (cpuid_ecx(0x1) & BIT(17)) {
 		/* Use printk to work around pr_fmt() */
 		printk(KERN_WARNING "\n");
 		printk(KERN_WARNING "************************************************************\n");
