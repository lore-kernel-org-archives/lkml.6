Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D937C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56582218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBGEXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:23:18 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:49144 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbfBGEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:23:15 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x174Ks2c023809;
        Thu, 7 Feb 2019 04:23:00 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qg8h81q16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Feb 2019 04:23:00 +0000
Received: from sarge.linuxathome.me (unknown [16.99.168.108])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 5FC909D;
        Thu,  7 Feb 2019 04:22:57 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org
Subject: [Patch v2 1/4] efi/x86: turn EFI runtime semaphore into a global lock
Date:   Thu,  7 Feb 2019 04:22:31 +0000
Message-Id: <20190207042234.25109-2-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207042234.25109-1-hedi.berriche@hpe.com>
References: <20190207042234.25109-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make efi_runtime_lock semaphore global so that it can be used by EFI
runtime callers that may be defined outside efi/runtime-wrappers.c.

Also now that efi_runtime_lock semaphore is no longer static, rename it
to efi_runtime_sem so it doesn't clash with the efi_runtime_lock spinlock
defined in arch/x86/platform/efi/efi_64.c when CONFIG_EFI_MIXED is
enabled.

The immediate motivation of this change is to serialise UV platform BIOS
calls using the efi_runtime_sem semaphore.

No functional changes.

Cc: Russ Anderson <rja@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
---
 drivers/firmware/efi/runtime-wrappers.c | 60 ++++++++++++-------------
 include/linux/efi.h                     |  3 ++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9ccfc2b..ec60d6227925 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -53,7 +53,7 @@ struct efi_runtime_work efi_rts_work;
  * @rts_arg<1-5>:	efi_runtime_service() function arguments
  *
  * Accesses to efi_runtime_services() are serialized by a binary
- * semaphore (efi_runtime_lock) and caller waits until the work is
+ * semaphore (efi_runtime_sem) and caller waits until the work is
  * finished, hence _only_ one work is queued at a time and the caller
  * thread waits for completion.
  */
@@ -144,7 +144,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
  * none of the remaining functions are actually ever called at runtime.
  * So let's just use a single lock to serialize all Runtime Services calls.
  */
-static DEFINE_SEMAPHORE(efi_runtime_lock);
+DEFINE_SEMAPHORE(efi_runtime_sem);
 
 /*
  * Calls the appropriate efi_runtime_service() with the appropriate
@@ -233,10 +233,10 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(GET_TIME, tm, tc, NULL, NULL, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -244,10 +244,10 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(SET_TIME, tm, NULL, NULL, NULL, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -257,11 +257,11 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm, NULL,
 				NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -269,11 +269,11 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
 				NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -285,11 +285,11 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
 				data);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -299,11 +299,11 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -315,11 +315,11 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(SET_VARIABLE, name, vendor, &attr, &data_size,
 				data);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -330,12 +330,12 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 {
 	efi_status_t status;
 
-	if (down_trylock(&efi_runtime_lock))
+	if (down_trylock(&efi_runtime_sem))
 		return EFI_NOT_READY;
 
 	status = efi_call_virt(set_variable, name, vendor, attr, data_size,
 			       data);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -350,11 +350,11 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(QUERY_VARIABLE_INFO, &attr, storage_space,
 				remaining_space, max_variable_size, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -369,12 +369,12 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_trylock(&efi_runtime_lock))
+	if (down_trylock(&efi_runtime_sem))
 		return EFI_NOT_READY;
 
 	status = efi_call_virt(query_variable_info, attr, storage_space,
 			       remaining_space, max_variable_size);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -382,11 +382,11 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 {
 	efi_status_t status;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -395,14 +395,14 @@ static void virt_efi_reset_system(int reset_type,
 				  unsigned long data_size,
 				  efi_char16_t *data)
 {
-	if (down_interruptible(&efi_runtime_lock)) {
+	if (down_interruptible(&efi_runtime_sem)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
 	efi_rts_work.efi_rts_id = RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 }
 
 static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
@@ -414,11 +414,11 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(UPDATE_CAPSULE, capsules, &count, &sg_list,
 				NULL, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
@@ -432,11 +432,11 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 	if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
 		return EFI_UNSUPPORTED;
 
-	if (down_interruptible(&efi_runtime_lock))
+	if (down_interruptible(&efi_runtime_sem))
 		return EFI_ABORTED;
 	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, &count,
 				max_size, reset_type, NULL);
-	up(&efi_runtime_lock);
+	up(&efi_runtime_sem);
 	return status;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..930cd20842b8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1745,6 +1745,9 @@ extern struct efi_runtime_work efi_rts_work;
 /* Workqueue to queue EFI Runtime Services */
 extern struct workqueue_struct *efi_rts_wq;
 
+/* EFI runtime semaphore */
+extern struct semaphore efi_runtime_sem;
+
 struct linux_efi_memreserve {
 	int		size;			// allocated size of the array
 	atomic_t	count;			// number of entries used
-- 
2.20.1

