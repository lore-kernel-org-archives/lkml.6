Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A672171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694121;
	bh=tXvYIpsk6iTVFfBfP20OZTCoe0bq8fMd0bX+OyWcr/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1a6IP3Dr00xD1aPRX46xAw0L4WZ7B/pwCw87hgwKXR91gnAtJg8YcRdwjjELT5TH
	 cDyKDtSC9KuV1WnmdNi/rsrAkpVHAAwNscQsVoYWrZochZSfoy7RDDLlGZH2o0PFvo
	 bJlB9pIvAD94zIMJSI+twFt988eXCHnyhl3Dxofs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389018AbfA1Qsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388961AbfA1QVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4B82171F;
        Mon, 28 Jan 2019 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692476;
        bh=tXvYIpsk6iTVFfBfP20OZTCoe0bq8fMd0bX+OyWcr/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wix7l+HIojUCCRD75JHQgH6diMOOfR3hq8DsqqOVRsQV1kEciRLic2lKrNADsy4lp
         5wjmB86m44vEZrboRgMdktiggEHsHhDi/9SyPC82/FBimi1Z7NadVENxEfhOZPn1LI
         kE1GVnJPlfRD1OJv5rr6FE0tWMOsgVMlBxzaQEaM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 033/107] firmware/efi: Add NULL pointer checks in efivars API functions
Date:   Mon, 28 Jan 2019 11:18:33 -0500
Message-Id: <20190128161947.57405-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

[ Upstream commit ab2180a15ce54739fed381efb4cb12e78dfb1561 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/vars.c | 99 +++++++++++++++++++++++++++++--------
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
-- 
2.19.1

