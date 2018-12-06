Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D010C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3721520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3Zdo1XVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3721520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeLFGGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:06:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55404 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeLFGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:06:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xQDR182511;
        Thu, 6 Dec 2018 06:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=v8ElQo36acSY7SAhGGWfVQofnvhe0dm2xG42jd4iTls=;
 b=3Zdo1XVd4Ns6zLKfAwcSMFn+Fm4sJbpUah42NtSx7O3rs4qbQ+XJT6hTF5FR3PUyzDNp
 oS7ZzcOswCHiFFuz5s2nHJcHURmvOpsFEhHnppfimh/AeU296zZNAG8I9Gd/eJX5lqpe
 z7hJpt2pG4MsqLl1wS/700G2vCCBoehjK92EIw68BeHqHYl94zznpPcPOdNBG0r6EZua
 3FdbO0Of+c/nHavbqxXD1tw+hWOaGEyHT35QTNxBCstL6Fn5GGY9LfA8Za/dskalxOTO
 nIX9HYf1Mi6KorRc3//7yzsUnuvimlk4LtM+c4cC9IJaVwda0EBaBHJHnkzLwxijjGVB wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrp7yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:06:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB666Axh025214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:06:10 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6669YH007249;
        Thu, 6 Dec 2018 06:06:09 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:06:08 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, jgross@suse.com
Cc:     JBeulich@suse.com, roger.pau@citrix.com,
        boris.ostrovsky@oracle.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v8 6/7] xen/pvh: Add memory map pointer to hvm_start_info struct
Date:   Wed,  5 Dec 2018 22:06:02 -0800
Message-Id: <1544076362-22090-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=545
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The start info structure that is defined as part of the x86/HVM direct boot
ABI and used for starting Xen PVH guests would be more versatile if it also
included a way to pass information about the memory map to the guest. This
would allow KVM guests to share the same entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
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

