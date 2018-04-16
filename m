Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeDPXNz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:13:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43914 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeDPXNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:13:50 -0400
From: Maran Wilson <maran.wilson@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, jgross@suse.com
Cc: JBeulich@suse.com, roger.pau@citrix.com, boris.ostrovsky@oracle.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v7 6/7] xen/pvh: Add memory map pointer to hvm_start_info struct
Date: Mon, 16 Apr 2018 16:13:16 -0700
Message-Id: <1523920396-27855-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=530
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The start info structure that is defined as part of the x86/HVM direct boot
ABI and used for starting Xen PVH guests would be more versatile if it also
included a way to pass information about the memory map to the guest. This
would allow KVM guests to share the same entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 include/xen/interface/hvm/start_info.h | 63 +++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/xen/interface/hvm/start_info.h b/include/xen/interface/hvm/start_info.h
index 648415976ead..50af9ea2ff1e 100644
--- a/include/xen/interface/hvm/start_info.h
+++ b/include/xen/interface/hvm/start_info.h
@@ -33,7 +33,7 @@
  *    | magic          | Contains the magic value XEN_HVM_START_MAGIC_VALUE
  *    |                | ("xEn3" with the 0x80 bit of the "E" set).
  *  4 +----------------+
- *    | version        | Version of this structure. Current version is 0. New
+ *    | version        | Version of this structure. Current version is 1. New
  *    |                | versions are guaranteed to be backwards-compatible.
  *  8 +----------------+
  *    | flags          | SIF_xxx flags.
@@ -48,6 +48,15 @@
  * 32 +----------------+
  *    | rsdp_paddr     | Physical address of the RSDP ACPI data structure.
  * 40 +----------------+
+ *    | memmap_paddr   | Physical address of the (optional) memory map. Only
+ *    |                | present in version 1 and newer of the structure.
+ * 48 +----------------+
+ *    | memmap_entries | Number of entries in the memory map table. Zero
+ *    |                | if there is no memory map being provided. Only
+ *    |                | present in version 1 and newer of the structure.
+ * 52 +----------------+
+ *    | reserved       | Version 1 and newer only.
+ * 56 +----------------+
  *
  * The layout of each entry in the module structure is the following:
  *
@@ -62,13 +71,51 @@
  *    | reserved       |
  * 32 +----------------+
  *
+ * The layout of each entry in the memory map table is as follows:
+ *
+ *  0 +----------------+
+ *    | addr           | Base address
+ *  8 +----------------+
+ *    | size           | Size of mapping in bytes
+ * 16 +----------------+
+ *    | type           | Type of mapping as defined between the hypervisor
+ *    |                | and guest. See XEN_HVM_MEMMAP_TYPE_* values below.
+ * 20 +----------------|
+ *    | reserved       |
+ * 24 +----------------+
+ *
  * The address and sizes are always a 64bit little endian unsigned integer.
  *
  * NB: Xen on x86 will always try to place all the data below the 4GiB
  * boundary.
+ *
+ * Version numbers of the hvm_start_info structure have evolved like this:
+ *
+ * Version 0:  Initial implementation.
+ *
+ * Version 1:  Added the memmap_paddr/memmap_entries fields (plus 4 bytes of
+ *             padding) to the end of the hvm_start_info struct. These new
+ *             fields can be used to pass a memory map to the guest. The
+ *             memory map is optional and so guests that understand version 1
+ *             of the structure must check that memmap_entries is non-zero
+ *             before trying to read the memory map.
  */
 #define XEN_HVM_START_MAGIC_VALUE 0x336ec578
 
+/*
+ * The values used in the type field of the memory map table entries are
+ * defined below and match the Address Range Types as defined in the "System
+ * Address Map Interfaces" section of the ACPI Specification. Please refer to
+ * section 15 in version 6.2 of the ACPI spec: http://uefi.org/specifications
+ */
+#define XEN_HVM_MEMMAP_TYPE_RAM       1
+#define XEN_HVM_MEMMAP_TYPE_RESERVED  2
+#define XEN_HVM_MEMMAP_TYPE_ACPI      3
+#define XEN_HVM_MEMMAP_TYPE_NVS       4
+#define XEN_HVM_MEMMAP_TYPE_UNUSABLE  5
+#define XEN_HVM_MEMMAP_TYPE_DISABLED  6
+#define XEN_HVM_MEMMAP_TYPE_PMEM      7
+
 /*
  * C representation of the x86/HVM start info layout.
  *
@@ -86,6 +133,13 @@ struct hvm_start_info {
     uint64_t cmdline_paddr;     /* Physical address of the command line.     */
     uint64_t rsdp_paddr;        /* Physical address of the RSDP ACPI data    */
                                 /* structure.                                */
+    /* All following fields only present in version 1 and newer */
+    uint64_t memmap_paddr;      /* Physical address of an array of           */
+                                /* hvm_memmap_table_entry.                   */
+    uint32_t memmap_entries;    /* Number of entries in the memmap table.    */
+                                /* Value will be zero if there is no memory  */
+                                /* map being provided.                       */
+    uint32_t reserved;          /* Must be zero.                             */
 };
 
 struct hvm_modlist_entry {
@@ -95,4 +149,11 @@ struct hvm_modlist_entry {
     uint64_t reserved;
 };
 
+struct hvm_memmap_table_entry {
+    uint64_t addr;              /* Base address of the memory region         */
+    uint64_t size;              /* Size of the memory region in bytes        */
+    uint32_t type;              /* Mapping type                              */
+    uint32_t reserved;          /* Must be zero for Version 1.               */
+};
+
 #endif /* __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__ */
-- 
2.16.1
