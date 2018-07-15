Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E66ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452020840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B452020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeGPACP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:02:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeGPACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:02:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNbJ2k922635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:37:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNbJMn922624;
        Sun, 15 Jul 2018 16:37:19 -0700
Date:   Sun, 15 Jul 2018 16:37:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sai Praneeth <tipbot@zytor.com>
Message-ID: <tip-5a58bc1b1edc18a9edff606ec99e6f6b723975f4@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, tglx@linutronix.de,
        sai.praneeth.prakhya@intel.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, ard.biesheuvel@linaro.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          sai.praneeth.prakhya@intel.com, tglx@linutronix.de
In-Reply-To: <20180711094040.12506-3-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Use non-blocking SetVariable() for
 efi_delete_dummy_variable()
Git-Commit-ID: 5a58bc1b1edc18a9edff606ec99e6f6b723975f4
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

Commit-ID:  5a58bc1b1edc18a9edff606ec99e6f6b723975f4
Gitweb:     https://git.kernel.org/tip/5a58bc1b1edc18a9edff606ec99e6f6b723975f4
Author:     Sai Praneeth <sai.praneeth.prakhya@intel.com>
AuthorDate: Wed, 11 Jul 2018 11:40:34 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:43:12 +0200

efi/x86: Use non-blocking SetVariable() for efi_delete_dummy_variable()

Presently, efi_delete_dummy_variable() uses set_variable() which might
block, which the scheduler is rightfully upset about when used from
the idle thread, producing this splat:

  "bad: scheduling from the idle thread!"

So, make efi_delete_dummy_variable() use set_variable_nonblocking(),
which, as the name suggests, doesn't block.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180711094040.12506-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..6af39dc40325 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -105,12 +105,11 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 */
 void efi_delete_dummy_variable(void)
 {
-	efi.set_variable((efi_char16_t *)efi_dummy_name,
-			 &EFI_DUMMY_GUID,
-			 EFI_VARIABLE_NON_VOLATILE |
-			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			 EFI_VARIABLE_RUNTIME_ACCESS,
-			 0, NULL);
+	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
+				     &EFI_DUMMY_GUID,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
 /*
