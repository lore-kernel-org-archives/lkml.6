Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD4B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGTANK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:13:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeGTANK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:13:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNQlgd2453195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:26:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNQkxO2453191;
        Thu, 19 Jul 2018 16:26:46 -0700
Date:   Thu, 19 Jul 2018 16:26:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-7ffcf1497c8ab59a705bfafb7401876fd2f6f71e@git.kernel.org>
Cc:     jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        will.deacon@arm.com, dhgutteridge@sympatico.ca, pavel@ucw.cz,
        torvalds@linux-foundation.org, aarcange@redhat.com,
        llong@redhat.com, linux-kernel@vger.kernel.org,
        David.Laight@aculab.com, jkosina@suse.cz, luto@kernel.org,
        bp@alien8.de, brgerst@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        dvlasenk@redhat.com, dave.hansen@intel.com, eduval@amazon.com,
        peterz@infradead.org, jroedel@suse.de
Reply-To: dave.hansen@intel.com, eduval@amazon.com, dvlasenk@redhat.com,
          peterz@infradead.org, jroedel@suse.de, bp@alien8.de,
          luto@kernel.org, brgerst@gmail.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
          torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
          pavel@ucw.cz, linux-kernel@vger.kernel.org, aarcange@redhat.com,
          llong@redhat.com, David.Laight@aculab.com, jkosina@suse.cz,
          jgross@suse.com, jpoimboe@redhat.com, will.deacon@arm.com,
          gregkh@linuxfoundation.org
In-Reply-To: <1531906876-13451-17-git-send-email-joro@8bytes.org>
References: <1531906876-13451-17-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pgtable/pae: Unshare kernel PMDs when PTI is
 enabled
Git-Commit-ID: 7ffcf1497c8ab59a705bfafb7401876fd2f6f71e
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

Commit-ID:  7ffcf1497c8ab59a705bfafb7401876fd2f6f71e
Gitweb:     https://git.kernel.org/tip/7ffcf1497c8ab59a705bfafb7401876fd2f6f71e
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:40 +0200

x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled

With PTI the per-process LDT must be mapped into the kernel address-space
for each process, which requires separate kernel PMDs per PGD.

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
Link: https://lkml.kernel.org/r/1531906876-13451-17-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable-3level_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 6a59a6d0cc50..78038e057876 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -21,9 +21,10 @@ typedef union {
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_PARAVIRT
-#define SHARED_KERNEL_PMD	(pv_info.shared_kernel_pmd)
+#define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
+				 (pv_info.shared_kernel_pmd)))
 #else
-#define SHARED_KERNEL_PMD	1
+#define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 #endif
 
 /*
