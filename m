Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780D5C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4811920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeJNXdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:33:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36122 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cd-5N; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000ew-T1; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Hans de Goede" <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org,
        "Matt Fleming" <matt@codeblueprint.co.uk>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.263228050@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 299/366] efi: Avoid potential crashes, fix the
 'struct efi_pci_io_protocol_32' definition for mixed mode
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 0b3225ab9407f557a8e20f23f37aa7236c10a9b1 upstream.

Mixed mode allows a kernel built for x86_64 to interact with 32-bit
EFI firmware, but requires us to define all struct definitions carefully
when it comes to pointer sizes.

'struct efi_pci_io_protocol_32' currently uses a 'void *' for the
'romimage' field, which will be interpreted as a 64-bit field
on such kernels, potentially resulting in bogus memory references
and subsequent crashes.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-13-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/boot/compressed/eboot.c | 6 ++++--
 include/linux/efi.h              | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -358,7 +358,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -460,7 +461,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -368,8 +368,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -388,8 +388,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {

