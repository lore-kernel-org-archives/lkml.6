Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeDCOjn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:39:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45696 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeDCOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:39:41 -0400
From: Daniel Kiper <daniel.kiper@oracle.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc: ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        eric.snowberg@oracle.com, hpa@zytor.com, jgross@suse.com,
        konrad.wilk@oracle.com, mingo@redhat.com, tglx@linutronix.de
Subject: [PATCH v2] x86/xen/efi: Initialize UEFI secure boot state during dom0 boot
Date: Tue,  3 Apr 2018 16:39:05 +0200
Message-Id: <1522766345-4169-1-git-send-email-daniel.kiper@oracle.com>
X-Mailer: git-send-email 1.7.10.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize UEFI secure boot state during dom0 boot. Otherwise the kernel
may not even know that it runs on secure boot enabled platform.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/xen/efi.c                        |   57 +++++++++++++++++++++++++++++
 drivers/firmware/efi/libstub/secureboot.c |    3 ++
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index a18703b..1804b27 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -115,6 +115,61 @@ static efi_system_table_t __init *xen_efi_probe(void)
 	return &efi_systab_xen;
 }
 
+/*
+ * Determine whether we're in secure boot mode.
+ *
+ * Please keep the logic in sync with
+ * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
+ */
+static enum efi_secureboot_mode xen_efi_get_secureboot(void)
+{
+	static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
+	static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
+	efi_status_t status;
+	u8 moksbstate, secboot, setupmode;
+	unsigned long size;
+
+	size = sizeof(secboot);
+	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
+				  NULL, &size, &secboot);
+
+	if (status == EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+
+	if (status != EFI_SUCCESS)
+		goto out_efi_err;
+
+	size = sizeof(setupmode);
+	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
+				  NULL, &size, &setupmode);
+
+	if (status != EFI_SUCCESS)
+		goto out_efi_err;
+
+	if (secboot == 0 || setupmode == 1)
+		return efi_secureboot_mode_disabled;
+
+	/* See if a user has put the shim into insecure mode. */
+	size = sizeof(moksbstate);
+	status = efi.get_variable(L"MokSBStateRT", &shim_guid,
+				  NULL, &size, &moksbstate);
+
+	/* If it fails, we don't care why. Default to secure. */
+	if (status != EFI_SUCCESS)
+		goto secure_boot_enabled;
+
+	if (moksbstate == 1)
+		return efi_secureboot_mode_disabled;
+
+ secure_boot_enabled:
+	pr_info("UEFI Secure Boot is enabled.\n");
+	return efi_secureboot_mode_enabled;
+
+ out_efi_err:
+	pr_err("Could not determine UEFI Secure Boot status.\n");
+	return efi_secureboot_mode_unknown;
+}
+
 void __init xen_efi_init(void)
 {
 	efi_system_table_t *efi_systab_xen;
@@ -129,6 +184,8 @@ void __init xen_efi_init(void)
 	boot_params.efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
 	boot_params.efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
 
+	boot_params.secure_boot = xen_efi_get_secureboot();
+
 	set_bit(EFI_BOOT, &efi.flags);
 	set_bit(EFI_PARAVIRT, &efi.flags);
 	set_bit(EFI_64BIT, &efi.flags);
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 8f07eb4..72d9dfb 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -30,6 +30,9 @@
 
 /*
  * Determine whether we're in secure boot mode.
+ *
+ * Please keep the logic in sync with
+ * arch/x86/xen/efi.c:xen_efi_get_secureboot().
  */
 enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table_arg)
 {
-- 
1.7.10.4
