Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32714C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B22222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfBPLW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 06:22:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 06:22:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1GBMZrk1624041
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 16 Feb 2019 03:22:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1GBMZ841624038;
        Sat, 16 Feb 2019 03:22:35 -0800
Date:   Sat, 16 Feb 2019 03:22:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anders Roxell <tipbot@zytor.com>
Message-ID: <tip-5c418dc789a3898717ebf2caa5716ba91a7150b2@git.kernel.org>
Cc:     peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        anders.roxell@linaro.org, torvalds@linux-foundation.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: ard.biesheuvel@linaro.org, peterz@infradead.org,
          tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
          mingo@kernel.org, anders.roxell@linaro.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190215165551.12220-2-ard.biesheuvel@linaro.org>
References: <20190215165551.12220-2-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Fix build error due to enum collision between
 efi.h and ima.h
Git-Commit-ID: 5c418dc789a3898717ebf2caa5716ba91a7150b2
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

Commit-ID:  5c418dc789a3898717ebf2caa5716ba91a7150b2
Gitweb:     https://git.kernel.org/tip/5c418dc789a3898717ebf2caa5716ba91a7150b2
Author:     Anders Roxell <anders.roxell@linaro.org>
AuthorDate: Fri, 15 Feb 2019 17:55:51 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 16 Feb 2019 12:18:55 +0100

efi: Fix build error due to enum collision between efi.h and ima.h

The following commit:

  a893ea15d764 ("tpm: move tpm_chip definition to include/linux/tpm.h")

introduced a build error when both IMA and EFI are enabled:

    In file included from ../security/integrity/ima/ima_fs.c:30:
    ../security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator "NONE"

What happens is that both headers (ima.h and efi.h) defines the same
'NONE' constant, and it broke when they started getting included from
the same file:

Rework to prefix the EFI enum with 'EFI_*'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190215165551.12220-2-ard.biesheuvel@linaro.org
[ Cleaned up the changelog a bit. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c          |  4 +--
 drivers/firmware/efi/runtime-wrappers.c | 48 ++++++++++++++++-----------------
 include/linux/efi.h                     | 26 +++++++++---------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 9ce85e605052..458a0e2bcc57 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -717,7 +717,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * "efi_mm" cannot be used to check if the page fault had occurred
 	 * in the firmware context because efi=old_map doesn't use efi_pgd.
 	 */
-	if (efi_rts_work.efi_rts_id == NONE)
+	if (efi_rts_work.efi_rts_id == EFI_NONE)
 		return;
 
 	/*
@@ -742,7 +742,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * because this case occurs *very* rarely and hence could be improved
 	 * on a need by basis.
 	 */
-	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
+	if (efi_rts_work.efi_rts_id == EFI_RESET_SYSTEM) {
 		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
 		machine_real_restart(MRR_BIOS);
 		return;
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9ccfc2b..8bbbbf160d05 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -85,7 +85,7 @@ struct efi_runtime_work efi_rts_work;
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
 exit:									\
-	efi_rts_work.efi_rts_id = NONE;					\
+	efi_rts_work.efi_rts_id = EFI_NONE;				\
 	efi_rts_work.status;						\
 })
 
@@ -168,50 +168,50 @@ static void efi_call_rts(struct work_struct *work)
 	arg5 = efi_rts_work.arg5;
 
 	switch (efi_rts_work.efi_rts_id) {
-	case GET_TIME:
+	case EFI_GET_TIME:
 		status = efi_call_virt(get_time, (efi_time_t *)arg1,
 				       (efi_time_cap_t *)arg2);
 		break;
-	case SET_TIME:
+	case EFI_SET_TIME:
 		status = efi_call_virt(set_time, (efi_time_t *)arg1);
 		break;
-	case GET_WAKEUP_TIME:
+	case EFI_GET_WAKEUP_TIME:
 		status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
 				       (efi_bool_t *)arg2, (efi_time_t *)arg3);
 		break;
-	case SET_WAKEUP_TIME:
+	case EFI_SET_WAKEUP_TIME:
 		status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
 				       (efi_time_t *)arg2);
 		break;
-	case GET_VARIABLE:
+	case EFI_GET_VARIABLE:
 		status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, (u32 *)arg3,
 				       (unsigned long *)arg4, (void *)arg5);
 		break;
-	case GET_NEXT_VARIABLE:
+	case EFI_GET_NEXT_VARIABLE:
 		status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
 				       (efi_char16_t *)arg2,
 				       (efi_guid_t *)arg3);
 		break;
-	case SET_VARIABLE:
+	case EFI_SET_VARIABLE:
 		status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
 				       (efi_guid_t *)arg2, *(u32 *)arg3,
 				       *(unsigned long *)arg4, (void *)arg5);
 		break;
-	case QUERY_VARIABLE_INFO:
+	case EFI_QUERY_VARIABLE_INFO:
 		status = efi_call_virt(query_variable_info, *(u32 *)arg1,
 				       (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
 		break;
-	case GET_NEXT_HIGH_MONO_COUNT:
+	case EFI_GET_NEXT_HIGH_MONO_COUNT:
 		status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
 		break;
-	case UPDATE_CAPSULE:
+	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2,
 				       *(unsigned long *)arg3);
 		break;
-	case QUERY_CAPSULE_CAPS:
+	case EFI_QUERY_CAPSULE_CAPS:
 		status = efi_call_virt(query_capsule_caps,
 				       (efi_capsule_header_t **)arg1,
 				       *(unsigned long *)arg2, (u64 *)arg3,
@@ -235,7 +235,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -246,7 +246,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
+	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -259,7 +259,7 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
+	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -271,7 +271,7 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
+	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
 				NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -287,7 +287,7 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
+	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -301,7 +301,7 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
+	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -317,7 +317,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
+	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -352,7 +352,7 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
+	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
 				remaining_space, max_variable_size, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -384,7 +384,7 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
+	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -400,7 +400,7 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
-	efi_rts_work.efi_rts_id = RESET_SYSTEM;
+	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
 	up(&efi_runtime_lock);
 }
@@ -416,7 +416,7 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
+	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
 				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
@@ -434,7 +434,7 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
+	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
 				max_size, reset_type, NULL);
 	up(&efi_runtime_lock);
 	return status;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index be08518c2553..eecd1079617a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1719,19 +1719,19 @@ extern int efi_tpm_eventlog_init(void);
  * fault happened while executing an efi runtime service.
  */
 enum efi_rts_ids {
-	NONE,
-	GET_TIME,
-	SET_TIME,
-	GET_WAKEUP_TIME,
-	SET_WAKEUP_TIME,
-	GET_VARIABLE,
-	GET_NEXT_VARIABLE,
-	SET_VARIABLE,
-	QUERY_VARIABLE_INFO,
-	GET_NEXT_HIGH_MONO_COUNT,
-	RESET_SYSTEM,
-	UPDATE_CAPSULE,
-	QUERY_CAPSULE_CAPS,
+	EFI_NONE,
+	EFI_GET_TIME,
+	EFI_SET_TIME,
+	EFI_GET_WAKEUP_TIME,
+	EFI_SET_WAKEUP_TIME,
+	EFI_GET_VARIABLE,
+	EFI_GET_NEXT_VARIABLE,
+	EFI_SET_VARIABLE,
+	EFI_QUERY_VARIABLE_INFO,
+	EFI_GET_NEXT_HIGH_MONO_COUNT,
+	EFI_RESET_SYSTEM,
+	EFI_UPDATE_CAPSULE,
+	EFI_QUERY_CAPSULE_CAPS,
 };
 
 /*
