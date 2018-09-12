Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F840C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIMBEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:04:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMBEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:04:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJvr5r2754992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:57:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJvrWv2754989;
        Wed, 12 Sep 2018 12:57:53 -0700
Date:   Wed, 12 Sep 2018 12:57:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Guenter Roeck <tipbot@zytor.com>
Message-ID: <tip-cf40361ede6cf9dc09349e4c049dc0d166ca2d8b@git.kernel.org>
Cc:     jroedel@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux@roeck-us.net, ard.biesheuvel@linaro.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        luto@amacapital.net
Reply-To: mingo@kernel.org, luto@amacapital.net,
          torvalds@linux-foundation.org, ard.biesheuvel@linaro.org,
          hpa@zytor.com, jroedel@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, linux@roeck-us.net
In-Reply-To: <1536689892-21538-1-git-send-email-linux@roeck-us.net>
References: <1536689892-21538-1-git-send-email-linux@roeck-us.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/efi: Load fixmap GDT in efi_call_phys_epilog()
 before setting %cr3
Git-Commit-ID: cf40361ede6cf9dc09349e4c049dc0d166ca2d8b
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

Commit-ID:  cf40361ede6cf9dc09349e4c049dc0d166ca2d8b
Gitweb:     https://git.kernel.org/tip/cf40361ede6cf9dc09349e4c049dc0d166ca2d8b
Author:     Guenter Roeck <linux@roeck-us.net>
AuthorDate: Tue, 11 Sep 2018 11:18:12 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Sep 2018 21:53:34 +0200

x86/efi: Load fixmap GDT in efi_call_phys_epilog() before setting %cr3

Commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in efi_call_phys_epilog()")
moved loading the fixmap in efi_call_phys_epilog() after load_cr3() since
it was assumed to be more logical.

Turns out this is incorrect: In efi_call_phys_prolog(), the gdt with its
physical address is loaded first, and when the %cr3 is reloaded in _epilog
from initial_page_table to swapper_pg_dir again the gdt is no longer
mapped.  This results in a triple fault if an interrupt occurs after
load_cr3() and before load_fixmap_gdt(0). Calling load_fixmap_gdt(0) first
restores the execution order prior to commit eeb89e2bb1ac and fixes the
problem.

Fixes: eeb89e2bb1ac ("x86/efi: Load fixmap GDT in efi_call_phys_epilog()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/1536689892-21538-1-git-send-email-linux@roeck-us.net

---
 arch/x86/platform/efi/efi_32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 05ca14222463..9959657127f4 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
+	load_fixmap_gdt(0);
 	load_cr3(save_pgd);
 	__flush_tlb_all();
-
-	load_fixmap_gdt(0);
 }
 
 void __init efi_runtime_update_mappings(void)
