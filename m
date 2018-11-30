Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4356FC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7532146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7532146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeK3VGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:06:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3VGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:06:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9uHxN3261037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:56:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9uHUv3261034;
        Fri, 30 Nov 2018 01:56:17 -0800
Date:   Fri, 30 Nov 2018 01:56:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arend van Spriel <tipbot@zytor.com>
Message-ID: <tip-ab2180a15ce54739fed381efb4cb12e78dfb1561@git.kernel.org>
Cc:     sedat.dilek@gmail.com, luto@kernel.org, zhuyifei1999@gmail.com,
        peterz@infradead.org, bp@alien8.de, marc.zyngier@arm.com,
        matt@codeblueprint.co.uk, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, julien.thierry@arm.com, hdegoede@redhat.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        arend.vanspriel@broadcom.com, hpa@zytor.com, joe@perches.com,
        jonathanh@nvidia.com, bhsharma@redhat.com,
        eric.snowberg@oracle.com, sai.praneeth.prakhya@intel.com,
        mingo@kernel.org, natechancellor@gmail.com,
        torvalds@linux-foundation.org
Reply-To: jonathanh@nvidia.com, joe@perches.com, bhsharma@redhat.com,
          mingo@kernel.org, natechancellor@gmail.com,
          torvalds@linux-foundation.org, eric.snowberg@oracle.com,
          sai.praneeth.prakhya@intel.com, sedat.dilek@gmail.com,
          bp@alien8.de, marc.zyngier@arm.com, matt@codeblueprint.co.uk,
          luto@kernel.org, zhuyifei1999@gmail.com, peterz@infradead.org,
          hdegoede@redhat.com, julien.thierry@arm.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          tglx@linutronix.de, arend.vanspriel@broadcom.com, hpa@zytor.com,
          ard.biesheuvel@linaro.org
In-Reply-To: <20181129171230.18699-9-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-9-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] firmware/efi: Add NULL pointer checks in efivars API
 functions
Git-Commit-ID: ab2180a15ce54739fed381efb4cb12e78dfb1561
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

Commit-ID:  ab2180a15ce54739fed381efb4cb12e78dfb1561
Gitweb:     https://git.kernel.org/tip/ab2180a15ce54739fed381efb4cb12e78dfb1561
Author:     Arend van Spriel <arend.vanspriel@broadcom.com>
AuthorDate: Thu, 29 Nov 2018 18:12:27 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:06:32 +0100

firmware/efi: Add NULL pointer checks in efivars API functions

Since commit:

   ce2e6db554fa ("brcmfmac: Add support for getting nvram contents from EFI variables")

we have a device driver accessing the efivars API. Several functions in
the efivars API assume __efivars is set, i.e., that they will be accessed
only after efivars_register() has been called. However, the following NULL
pointer access was reported calling efivar_entry_size() from the brcmfmac
device driver:

  Unable to handle kernel NULL pointer dereference at virtual address 00000008
  pgd = 60bfa5f1
  [00000008] *pgd=00000000
  Internal error: Oops: 5 [#1] SMP ARM
  ...
  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
  Workqueue: events request_firmware_work_func
  PC is at efivar_entry_size+0x28/0x90
  LR is at brcmf_fw_complete_request+0x3f8/0x8d4 [brcmfmac]
  pc : [<c0c40718>]    lr : [<bf2a3ef4>]    psr: a00d0113
  sp : ede7fe28  ip : ee983410  fp : c1787f30
  r10: 00000000  r9 : 00000000  r8 : bf2b2258
  r7 : ee983000  r6 : c1604c48  r5 : ede7fe88  r4 : edf337c0
  r3 : 00000000  r2 : 00000000  r1 : ede7fe88  r0 : c17712c8
  Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: ad16804a  DAC: 00000051

Disassembly showed that the local static variable __efivars is NULL,
which is not entirely unexpected given that it is a non-EFI platform.

So add a NULL pointer check to efivar_entry_size(), and to related
functions while at it. In efivars_register() a couple of sanity checks
are added as well.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Joe Perches <joe@perches.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-9-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/vars.c | 99 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 9336ffdf6e2c..fceaafd67ec6 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -318,7 +318,12 @@ EXPORT_SYMBOL_GPL(efivar_variable_is_removable);
 static efi_status_t
 check_var_size(u32 attributes, unsigned long size)
 {
-	const struct efivar_operations *fops = __efivars->ops;
+	const struct efivar_operations *fops;
+
+	if (!__efivars)
+		return EFI_UNSUPPORTED;
+
+	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
 		return EFI_UNSUPPORTED;
@@ -329,7 +334,12 @@ check_var_size(u32 attributes, unsigned long size)
 static efi_status_t
 check_var_size_nonblocking(u32 attributes, unsigned long size)
 {
-	const struct efivar_operations *fops = __efivars->ops;
+	const struct efivar_operations *fops;
+
+	if (!__efivars)
+		return EFI_UNSUPPORTED;
+
+	fops = __efivars->ops;
 
 	if (!fops->query_variable_store)
 		return EFI_UNSUPPORTED;
@@ -429,13 +439,18 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	unsigned long variable_name_size = 1024;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
 	int err = 0;
 
+	if (!__efivars)
+		return -EFAULT;
+
+	ops = __efivars->ops;
+
 	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
 	if (!variable_name) {
 		printk(KERN_ERR "efivars: Memory allocation failed.\n");
@@ -583,12 +598,14 @@ static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
  */
 int __efivar_entry_delete(struct efivar_entry *entry)
 {
-	const struct efivar_operations *ops = __efivars->ops;
 	efi_status_t status;
 
-	status = ops->set_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid,
-				   0, 0, NULL);
+	if (!__efivars)
+		return -EINVAL;
+
+	status = __efivars->ops->set_variable(entry->var.VariableName,
+					      &entry->var.VendorGuid,
+					      0, 0, NULL);
 
 	return efi_status_to_err(status);
 }
@@ -607,12 +624,17 @@ EXPORT_SYMBOL_GPL(__efivar_entry_delete);
  */
 int efivar_entry_delete(struct efivar_entry *entry)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_status_t status;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
+	if (!__efivars) {
+		up(&efivars_lock);
+		return -EINVAL;
+	}
+	ops = __efivars->ops;
 	status = ops->set_variable(entry->var.VariableName,
 				   &entry->var.VendorGuid,
 				   0, 0, NULL);
@@ -650,13 +672,19 @@ EXPORT_SYMBOL_GPL(efivar_entry_delete);
 int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
 		     unsigned long size, void *data, struct list_head *head)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_status_t status;
 	efi_char16_t *name = entry->var.VariableName;
 	efi_guid_t vendor = entry->var.VendorGuid;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
+
+	if (!__efivars) {
+		up(&efivars_lock);
+		return -EINVAL;
+	}
+	ops = __efivars->ops;
 	if (head && efivar_entry_find(name, vendor, head, false)) {
 		up(&efivars_lock);
 		return -EEXIST;
@@ -687,12 +715,17 @@ static int
 efivar_entry_set_nonblocking(efi_char16_t *name, efi_guid_t vendor,
 			     u32 attributes, unsigned long size, void *data)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_status_t status;
 
 	if (down_trylock(&efivars_lock))
 		return -EBUSY;
 
+	if (!__efivars) {
+		up(&efivars_lock);
+		return -EINVAL;
+	}
+
 	status = check_var_size_nonblocking(attributes,
 					    size + ucs2_strsize(name, 1024));
 	if (status != EFI_SUCCESS) {
@@ -700,6 +733,7 @@ efivar_entry_set_nonblocking(efi_char16_t *name, efi_guid_t vendor,
 		return -ENOSPC;
 	}
 
+	ops = __efivars->ops;
 	status = ops->set_variable_nonblocking(name, &vendor, attributes,
 					       size, data);
 
@@ -727,9 +761,13 @@ efivar_entry_set_nonblocking(efi_char16_t *name, efi_guid_t vendor,
 int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
 			  bool block, unsigned long size, void *data)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_status_t status;
 
+	if (!__efivars)
+		return -EINVAL;
+
+	ops = __efivars->ops;
 	if (!ops->query_variable_store)
 		return -ENOSYS;
 
@@ -829,13 +867,18 @@ EXPORT_SYMBOL_GPL(efivar_entry_find);
  */
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_status_t status;
 
 	*size = 0;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
+	if (!__efivars) {
+		up(&efivars_lock);
+		return -EINVAL;
+	}
+	ops = __efivars->ops;
 	status = ops->get_variable(entry->var.VariableName,
 				   &entry->var.VendorGuid, NULL, size, NULL);
 	up(&efivars_lock);
@@ -861,12 +904,14 @@ EXPORT_SYMBOL_GPL(efivar_entry_size);
 int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		       unsigned long *size, void *data)
 {
-	const struct efivar_operations *ops = __efivars->ops;
 	efi_status_t status;
 
-	status = ops->get_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid,
-				   attributes, size, data);
+	if (!__efivars)
+		return -EINVAL;
+
+	status = __efivars->ops->get_variable(entry->var.VariableName,
+					      &entry->var.VendorGuid,
+					      attributes, size, data);
 
 	return efi_status_to_err(status);
 }
@@ -882,14 +927,19 @@ EXPORT_SYMBOL_GPL(__efivar_entry_get);
 int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 		     unsigned long *size, void *data)
 {
-	const struct efivar_operations *ops = __efivars->ops;
 	efi_status_t status;
 
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
-	status = ops->get_variable(entry->var.VariableName,
-				   &entry->var.VendorGuid,
-				   attributes, size, data);
+
+	if (!__efivars) {
+		up(&efivars_lock);
+		return -EINVAL;
+	}
+
+	status = __efivars->ops->get_variable(entry->var.VariableName,
+					      &entry->var.VendorGuid,
+					      attributes, size, data);
 	up(&efivars_lock);
 
 	return efi_status_to_err(status);
@@ -921,7 +971,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_get);
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 			      unsigned long *size, void *data, bool *set)
 {
-	const struct efivar_operations *ops = __efivars->ops;
+	const struct efivar_operations *ops;
 	efi_char16_t *name = entry->var.VariableName;
 	efi_guid_t *vendor = &entry->var.VendorGuid;
 	efi_status_t status;
@@ -940,6 +990,11 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	if (down_interruptible(&efivars_lock))
 		return -EINTR;
 
+	if (!__efivars) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Ensure that the available space hasn't shrunk below the safe level
 	 */
@@ -956,6 +1011,8 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 		}
 	}
 
+	ops = __efivars->ops;
+
 	status = ops->set_variable(name, vendor, attributes, *size, data);
 	if (status != EFI_SUCCESS) {
 		err = efi_status_to_err(status);
