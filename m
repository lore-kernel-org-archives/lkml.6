Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeCMPPL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:15:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCMPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:15:09 -0400
Date: Tue, 13 Mar 2018 08:14:44 -0700
From: tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-79832f0b5f718e0023d9dd73e6845310609a564d@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, jeremy@jcline.org,
        ard.biesheuvel@linaro.org, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, jeremy@jcline.org,
        mingo@kernel.org, ard.biesheuvel@linaro.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180313140922.17266-2-ard.biesheuvel@linaro.org>
References: <20180313140922.17266-2-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi/libstub/tpm: Initialize pointer variables to
 zero for mixed mode
Git-Commit-ID: 79832f0b5f718e0023d9dd73e6845310609a564d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  79832f0b5f718e0023d9dd73e6845310609a564d
Gitweb:     https://git.kernel.org/tip/79832f0b5f718e0023d9dd73e6845310609a564d
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 13 Mar 2018 14:09:21 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 15:28:29 +0100

efi/libstub/tpm: Initialize pointer variables to zero for mixed mode

As reported by Jeremy Cline, running the new TPM libstub code in mixed
mode (i.e., 64-bit kernel on 32-bit UEFI) results in hangs when invoking
the TCG2 protocol, or when accessing the log_tbl pool allocation.

The reason turns out to be that in both cases, the 64-bit pointer
variables are not fully initialized by the 32-bit EFI code, and so
we should take care to zero initialize these variables beforehand,
or we'll end up dereferencing bogus pointers.

Reported-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: hdegoede@redhat.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: javierm@redhat.com
Cc: linux-efi@vger.kernel.org
Cc: tweek@google.com
Link: http://lkml.kernel.org/r/20180313140922.17266-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index da661bf8cb96..13c1edd37e96 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -68,11 +68,11 @@ void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
 	efi_physical_addr_t log_location, log_last_entry;
-	struct linux_efi_tpm_eventlog *log_tbl;
+	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
-	void *tcg2_protocol;
+	void *tcg2_protocol = NULL;
 
 	status = efi_call_early(locate_protocol, &tcg2_guid, NULL,
 				&tcg2_protocol);
