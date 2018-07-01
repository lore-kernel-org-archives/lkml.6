Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A7C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0575C255E2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0575C255E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031911AbeGAQka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031881AbeGAQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 305CCACC;
        Sun,  1 Jul 2018 16:40:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 083/220] efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode
Date:   Sun,  1 Jul 2018 18:21:47 +0200
Message-Id: <20180701160911.897966940@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 52e1cf2d19c2e62e6a81b8de3f7320d033917dd5 upstream.

Commit:

  79832f0b5f71 ("efi/libstub/tpm: Initialize pointer variables to zero for mixed mode")

fixes a problem with the tpm code on mixed mode (64-bit kernel on 32-bit UEFI),
where 64-bit pointer variables are not fully initialized by the 32-bit EFI code.

A similar problem applies to the efi_physical_addr_t variables which
are written by the ->get_event_log() EFI call. Even though efi_physical_addr_t
is 64-bit everywhere, it seems that some 32-bit UEFI implementations only
fill in the lower 32 bits when passed a pointer to an efi_physical_addr_t
to fill.

This commit initializes these to 0 to, to ensure the upper 32 bits are
0 in mixed mode. This fixes recent kernels sometimes hanging during
early boot on mixed mode UEFI systems.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.16+
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180622064222.11633-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/libstub/tpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -64,7 +64,7 @@ void efi_retrieve_tpm2_eventlog_1_2(efi_
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
-	efi_physical_addr_t log_location, log_last_entry;
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;


