Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D866C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC8F23F4B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8F23F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeFVJBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:01:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFVJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:01:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5M90sKu013631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 02:00:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5M90sFP013628;
        Fri, 22 Jun 2018 02:00:54 -0700
Date:   Fri, 22 Jun 2018 02:00:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hans de Goede <tipbot@zytor.com>
Message-ID: <tip-52e1cf2d19c2e62e6a81b8de3f7320d033917dd5@git.kernel.org>
Cc:     peterz@infradead.org, hdegoede@redhat.com, hpa@zytor.com,
        mingo@kernel.org, ard.biesheuvel@linaro.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hdegoede@redhat.com, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          ard.biesheuvel@linaro.org
In-Reply-To: <20180622064222.11633-2-ard.biesheuvel@linaro.org>
References: <20180622064222.11633-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/libstub/tpm: Initialize efi_physical_addr_t
 vars to zero for mixed mode
Git-Commit-ID: 52e1cf2d19c2e62e6a81b8de3f7320d033917dd5
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

Commit-ID:  52e1cf2d19c2e62e6a81b8de3f7320d033917dd5
Gitweb:     https://git.kernel.org/tip/52e1cf2d19c2e62e6a81b8de3f7320d033917dd5
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Fri, 22 Jun 2018 08:42:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 22 Jun 2018 10:58:27 +0200

efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode

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
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index caa37a6dd9d4..a90b0b8fc69a 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -64,7 +64,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
-	efi_physical_addr_t log_location, log_last_entry;
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
