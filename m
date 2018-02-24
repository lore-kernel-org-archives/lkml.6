Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBXWRw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:17:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:23057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBXWRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:17:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,389,1515484800";
   d="scan'208";a="20564922"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH V1 3/3] efi: Use efi_rts_workqueue to invoke EFI Runtime Services
Date: Sat, 24 Feb 2018 14:10:49 -0800
Message-Id: <1519510249-31447-4-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519510249-31447-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1519510249-31447-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Presently, efi_runtime_services() are executed by firmware in process
context. To execute efi_runtime_service(), kernel switches the page
directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have any
user space mappings. A potential issue could be, for instance, an NMI
interrupt (like perf) trying to profile some user data while in efi_pgd.

A solution for this issue could be to use kthread to run
efi_runtime_service(). When a user/kernel thread requests to execute
efi_runtime_service(), kernel off-loads this work to kthread which in
turn uses efi_pgd. Anything that tries to touch user space addresses
while in kthread is terminally broken. This patch adds support to efi
subsystem to handle all calls to efi_runtime_services() using a work
queue (which in turn uses kthread).

Implementation summary:
-----------------------
1. When user/kernel thread requests to execute efi_runtime_service(),
enqueue work to efi_rts_workqueue.
2. Caller thread waits until the work is finished because it's dependent
on the return status of efi_runtime_service().

pstore writes could potentially be invoked in interrupt context and it
uses set_variable<>() and query_variable_info<>() to store logs. If we
invoke efi_runtime_services() through efi_rts_wq while in atomic()
kernel issues a warning ("scheduling wile in atomic") and prints stack
trace. One way to overcome this is to not make the caller process wait
for the worker thread to finish. This approach breaks pstore i.e. the
log messages aren't written to efi variables. Hence, pstore calls
efi_runtime_services() without using efi_rts_wq or in other words
efi_rts_wq will be used unconditionally for all the
efi_runtime_services() except set_variable<>() and
query_variable_info<>()

Semantics to pack arguments in efi_runtime_work (has void pointers):
1. If argument is a pointer (of any type), pass it as is.
2. If argument is a value (of any type), address of the value is
passed.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peter.zijlstra@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 86 +++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 5cdb787da5d3..531d077aac70 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -68,6 +68,16 @@
  * semaphore (efi_runtime_lock) and caller waits until the work is
  * finished, hence _only_ one work is queued at a time. So, queue_work()
  * should never fail.
+ *
+ * efi_rts_workqueue to run efi_runtime_services() shouldn't be used
+ * while in atomic, because caller thread might sleep. pstore writes
+ * could potentially be invoked in interrupt context and it uses
+ * set_variable<>() and query_variable_info<>(), so pstore code doesn't
+ * use efi_rts_workqueue.
+ *
+ * Semantics that caller function should follow while passing arguments:
+ * 1. If argument is a pointer (of any type), pass it as is.
+ * 2. If argument is a value (of any type), address of the value is passed.
  */
 #define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)		\
 ({									\
@@ -150,7 +160,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(get_time, tm, tc);
+	status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -161,7 +171,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(set_time, tm);
+	status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -174,7 +184,8 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(get_wakeup_time, enabled, pending, tm);
+	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
+				NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -185,7 +196,8 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(set_wakeup_time, enabled, tm);
+	status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
+				NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -200,8 +212,8 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(get_variable, name, vendor, attr, data_size,
-			       data);
+	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
+				data);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -214,7 +226,8 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(get_next_variable, name_size, name, vendor);
+	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
+				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -229,8 +242,15 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(set_variable, name, vendor, attr, data_size,
-			       data);
+
+	/* pstore shouldn't use efi_rts_wq while in atomic */
+	if (!in_atomic())
+		status = efi_queue_work(SET_VARIABLE, name, vendor, &attr,
+					&data_size, data);
+	else
+		status = efi_call_virt(set_variable, name, vendor, attr,
+				       data_size, data);
+
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -245,8 +265,14 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt(set_variable, name, vendor, attr, data_size,
-			       data);
+	/* pstore shouldn't use efi_rts_wq while in atomic */
+	if (!in_atomic())
+		status = efi_queue_work(SET_VARIABLE_NONBLOCKING, &name, vendor,
+					&attr,	&data_size, data);
+	else
+		status = efi_call_virt(set_variable, name, vendor, attr,
+				       data_size, data);
+
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -264,8 +290,17 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(query_variable_info, attr, storage_space,
-			       remaining_space, max_variable_size);
+
+	/* pstore shouldn't use efi_rts_wq while in atomic */
+	if (!in_atomic())
+		status = efi_queue_work(QUERY_VARIABLE_INFO, &attr,
+					storage_space, remaining_space,
+					max_variable_size, NULL);
+	else
+		status = efi_call_virt(query_variable_info, attr,
+				       storage_space, remaining_space,
+				       max_variable_size);
+
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -284,8 +319,16 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt(query_variable_info, attr, storage_space,
-			       remaining_space, max_variable_size);
+	/* pstore shouldn't use efi_rts_wq while in atomic */
+	if (!in_atomic())
+		status = efi_queue_work(QUERY_VARIABLE_INFO_NONBLOCKING, &attr,
+					storage_space, remaining_space,
+					max_variable_size, NULL);
+	else
+		status = efi_call_virt(query_variable_info, attr,
+				       storage_space, remaining_space,
+				       max_variable_size);
+
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -296,7 +339,8 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(get_next_high_mono_count, count);
+	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
+				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -311,7 +355,8 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
-	__efi_call_virt(reset_system, reset_type, status, data_size, data);
+	efi_queue_work(RESET_SYSTEM, &reset_type, &status, &data_size, data,
+		       NULL);
 	up(&efi_runtime_lock);
 }
 
@@ -326,7 +371,8 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(update_capsule, capsules, count, sg_list);
+	status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
+				NULL, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -343,8 +389,8 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_call_virt(query_capsule_caps, capsules, count, max_size,
-			       reset_type);
+	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
+				max_size, reset_type, NULL);
 	up(&efi_runtime_lock);
 	return status;
 }
-- 
2.1.4
