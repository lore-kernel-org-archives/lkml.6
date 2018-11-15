Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F315E21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F315E21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbeKOTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:18:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKOTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:18:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAF9B5cM738786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Nov 2018 01:11:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAF9B5Jh738783;
        Thu, 15 Nov 2018 01:11:05 -0800
Date:   Thu, 15 Nov 2018 01:11:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-72a58a63a164b4e9d2d914e65caeb551846883f1@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, ard.biesheuvel@linaro.org
Reply-To: ard.biesheuvel@linaro.org, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20181114175544.12860-4-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/arm/libstub: Pack FDT after populating it
Git-Commit-ID: 72a58a63a164b4e9d2d914e65caeb551846883f1
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

Commit-ID:  72a58a63a164b4e9d2d914e65caeb551846883f1
Gitweb:     https://git.kernel.org/tip/72a58a63a164b4e9d2d914e65caeb551846883f1
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Wed, 14 Nov 2018 09:55:42 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Nov 2018 10:04:46 +0100

efi/arm/libstub: Pack FDT after populating it

Commit:

  24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping size")

increased the allocation size for the FDT image created by the stub to a
fixed value of 2 MB, to simplify the former code that made several
attempts with increasing values for the size. This is reasonable
given that the allocation is of type EFI_LOADER_DATA, which is released
to the kernel unless it is explicitly memblock_reserve()d by the early
boot code.

However, this allocation size leaked into the 'size' field of the FDT
header metadata, and so the entire allocation remains occupied by the
device tree binary, even if most of it is not used to store device tree
information.

So call fdt_pack() to shrink the FDT data structure to its minimum size
after populating all the fields, so that the remaining memory is no
longer wasted.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.12+
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping size")
Link: http://lkml.kernel.org/r/20181114175544.12860-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 8830fa601e45..0c0d2312f4a8 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -158,6 +158,10 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 			return efi_status;
 		}
 	}
+
+	/* shrink the FDT back to its minimum size */
+	fdt_pack(fdt);
+
 	return EFI_SUCCESS;
 
 fdt_set_fail:
