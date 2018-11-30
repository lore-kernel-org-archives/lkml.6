Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F14C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50520868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E50520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK3VF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:05:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeK3VF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:05:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9thnd3260962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:55:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9tgX53260958;
        Fri, 30 Nov 2018 01:55:42 -0800
Date:   Fri, 30 Nov 2018 01:55:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YiFei Zhu <tipbot@zytor.com>
Message-ID: <tip-79c2206d369b87b19ac29cb47601059b6bf5c291@git.kernel.org>
Cc:     natechancellor@gmail.com, mingo@kernel.org, hpa@zytor.com,
        hdegoede@redhat.com, marc.zyngier@arm.com, dave.hansen@intel.com,
        bhsharma@redhat.com, zhuyifei1999@gmail.com,
        linux-kernel@vger.kernel.org, sai.praneeth.prakhya@intel.com,
        matt@codeblueprint.co.uk, peterz@infradead.org,
        jonathanh@nvidia.com, torvalds@linux-foundation.org,
        eric.snowberg@oracle.com, bp@alien8.de, luto@kernel.org,
        julien.thierry@arm.com, ard.biesheuvel@linaro.org,
        sedat.dilek@gmail.com, joe@perches.com,
        arend.vanspriel@broadcom.com, tglx@linutronix.de
Reply-To: sai.praneeth.prakhya@intel.com, linux-kernel@vger.kernel.org,
          jonathanh@nvidia.com, peterz@infradead.org,
          matt@codeblueprint.co.uk, torvalds@linux-foundation.org,
          natechancellor@gmail.com, hpa@zytor.com, mingo@kernel.org,
          hdegoede@redhat.com, marc.zyngier@arm.com, dave.hansen@intel.com,
          bhsharma@redhat.com, zhuyifei1999@gmail.com, luto@kernel.org,
          julien.thierry@arm.com, ard.biesheuvel@linaro.org,
          joe@perches.com, arend.vanspriel@broadcom.com,
          sedat.dilek@gmail.com, tglx@linutronix.de,
          eric.snowberg@oracle.com, bp@alien8.de
In-Reply-To: <20181129171230.18699-12-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-12-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] x86/earlyprintk/efi: Fix infinite loop on some
 screen widths
Git-Commit-ID: 79c2206d369b87b19ac29cb47601059b6bf5c291
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

Commit-ID:  79c2206d369b87b19ac29cb47601059b6bf5c291
Gitweb:     https://git.kernel.org/tip/79c2206d369b87b19ac29cb47601059b6bf5c291
Author:     YiFei Zhu <zhuyifei1999@gmail.com>
AuthorDate: Thu, 29 Nov 2018 18:12:30 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:05:13 +0100

x86/earlyprintk/efi: Fix infinite loop on some screen widths

An affected screen resolution is 1366 x 768, which width is not
divisible by 8, the default font width. On such screens, when longer
lines are earlyprintk'ed, overflow-to-next-line can never trigger,
due to the left-most x-coordinate of the next character always less
than the screen width. Earlyprintk will infinite loop in trying to
print the rest of the string but unable to, due to the line being
full.

This patch makes the trigger consider the right-most x-coordinate,
instead of left-most, as the value to compare against the screen
width threshold.

Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-12-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/early_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 7476b3b097e1..7138bc7a265c 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -183,7 +183,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			num--;
 		}
 
-		if (efi_x >= si->lfb_width) {
+		if (efi_x + font->width > si->lfb_width) {
 			efi_x = 0;
 			efi_y += font->height;
 		}
