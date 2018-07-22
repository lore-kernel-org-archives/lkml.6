Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B1C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C7F20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C7F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbeGVQTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:19:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeGVQTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:19:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6MFLfZk3458408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Jul 2018 08:21:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6MFLfYV3458405;
        Sun, 22 Jul 2018 08:21:41 -0700
Date:   Sun, 22 Jul 2018 08:21:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-093174f52553532b9eb0e63cbbb254f6990d46d5@git.kernel.org>
Cc:     lukas@wunner.de, tglx@linutronix.de, mingo@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ard.biesheuvel@linaro.org, hdegoede@redhat.com,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          lukas@wunner.de, tglx@linutronix.de, mingo@kernel.org,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, ard.biesheuvel@linaro.org, hdegoede@redhat.com
In-Reply-To: <20180720014726.24031-6-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: Add missing NULL initialization in UGA draw
 protocol discovery
Git-Commit-ID: 093174f52553532b9eb0e63cbbb254f6990d46d5
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

Commit-ID:  093174f52553532b9eb0e63cbbb254f6990d46d5
Gitweb:     https://git.kernel.org/tip/093174f52553532b9eb0e63cbbb254f6990d46d5
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Fri, 20 Jul 2018 10:47:22 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 22 Jul 2018 14:13:43 +0200

efi/x86: Add missing NULL initialization in UGA draw protocol discovery

The UGA draw protocol discovery routine looks for a EFI handle that has
both the UGA draw protocol and the PCI I/O protocol installed. It checks
for the latter by calling handle_protocol() and pass it a PCI I/O
protocol pointer variable by reference, but fails to initialize it to
NULL, which means the non-NULL check later on in the code could produce
false positives, given that the return code of the handle_protocol() call
is ignored entirely. So add the missing initialization.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180720014726.24031-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index ac8e442db71f..92b573fd239c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -359,6 +359,7 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 		if (status != EFI_SUCCESS)
 			continue;
 
+		pciio = NULL;
 		efi_call_early(handle_protocol, handle, &pciio_proto, &pciio);
 
 		status = efi_call_proto(efi_uga_draw_protocol, get_mode, uga,
