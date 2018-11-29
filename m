Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE999C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67952146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWsIMz6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67952146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbeK3BiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbeK3BiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3538F2146F;
        Thu, 29 Nov 2018 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501962;
        bh=iERJZl8erxsoOb5QrADOcWxsjUhv/ZYYLUNX68IO/MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWsIMz6BZNUM8QlEX6BzvNx6yNkbsRzftCp0V51gGcMSSh3QjinGqWDIZqB11Wl1y
         bOHQVbXRNvJ+PGGN8tMOSGbUHXjCOV4C04sM+4s9+7E2gyu/ne7jQ3ZtlH4BreZRFI
         /V+x3TAvTHu/SfkhXMlZ7wpOi3NIG2kEC6xfA6DM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/110] efi/arm: Revert deferred unmap of early memmap mapping
Date:   Thu, 29 Nov 2018 15:13:05 +0100
Message-Id: <20181129135925.049500254@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 33412b8673135b18ea42beb7f5117ed0091798b6 ]

Commit:

  3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory map longer for BGRT")

deferred the unmap of the early mapping of the UEFI memory map to
accommodate the ACPI BGRT code, which looks up the memory type that
backs the BGRT table to validate it against the requirements of the UEFI spec.

Unfortunately, this causes problems on ARM, which does not permit
early mappings to persist after paging_init() is called, resulting
in a WARN() splat. Since we don't support the BGRT table on ARM anway,
let's revert ARM to the old behaviour, which is to take down the
early mapping at the end of efi_init().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")
Link: http://lkml.kernel.org/r/20181114175544.12860-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/arm-init.c    | 4 ++++
 drivers/firmware/efi/arm-runtime.c | 2 +-
 drivers/firmware/efi/memmap.c      | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 388a929baf95..1a6a77df8a5e 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -265,6 +265,10 @@ void __init efi_init(void)
 				    (params.mmap & ~PAGE_MASK)));
 
 	init_screen_info();
+
+	/* ARM does not permit early mappings to persist across paging_init() */
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_memmap_unmap();
 }
 
 static int __init register_gop_device(void)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..a00934d263c5 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -110,7 +110,7 @@ static int __init arm_enable_runtime_services(void)
 {
 	u64 mapsize;
 
-	if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
+	if (!efi_enabled(EFI_BOOT)) {
 		pr_info("EFI services will not be available.\n");
 		return 0;
 	}
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 5fc70520e04c..1907db2b38d8 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -118,6 +118,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
 
 void __init efi_memmap_unmap(void)
 {
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
 	if (!efi.memmap.late) {
 		unsigned long size;
 
-- 
2.17.1



