Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELsLeDumPz7MH8ifPmiydA1IgE9l8yVq300TqGuonYxWdL4GiLTBw2a2hMDeFy32dvcnEOtH
ARC-Seal: i=1; a=rsa-sha256; t=1519843163; cv=none;
        d=google.com; s=arc-20160816;
        b=Y7JhbkXOz8LQqQfzTMfnz9bcRpkNA7yho0NTRtB71MN7TXoRKsegTAFMx2WOGCHFXK
         p2FCv6ESDlPVTdLqCCAkQvFEaiuT8WUqubglGWiI7/A530ycWm5WLkFFc0zQGi52VsfP
         gOJug2h9oztEIff/SN2xEyLctjNCUp5TH85puNJVviil4WCPGIiGcNCNY/AgoGNl6WRN
         kXOWKCw+Y90fOWR2xdB9xkkV8gQ0n440qGC19OfCux/6VegQ43mSJn3EIgcNzDi/UD92
         zB/v1cen03chQTpYbkDgcEyqaBJOmxOBYHnVPGrUQbVi+TrxPAR0mPdBqXqUdBaB9Gt/
         2MXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=NKwZy7QIXdf9jOB2cu42yNxtdW0rMIf+9HvGbPGJ6RA=;
        b=Y2rmUdMYs+xZiJufOkKNMCZ1bAW5E/8H9b+EUiTrNvhutgGtXsQA44Y5c/hSAyskez
         BZHR/VYMjJbbPhgXmPp5z7aIVlURxyceKtJD+DhNOk24oQfW6gEWLWg7161q8umROBNO
         ie3/xpp1A2qsvb07rj3CzIZRnM68cah9r5MVka0vWBUiLUi/dIoTguO7rUcgI3NMHaFA
         WXo1oIM6noxDtxnqCWtVPHVfQBPkYQloKAQQzyLXmwp8pJ/xKqzBxYgYiOqhaobkVdtb
         UqQgN8ENiLqU6nbWfN5l1V/EUR2xeMOZNiZKGgVybsxX5Uznl4t4U8VuKdBm7WTJzCSO
         sxAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=th1P5pCJ;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=th1P5pCJ;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, maran.wilson@oracle.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: [RFC PATCH v4 6/7] xen/pvh: Add memory map pointer to hvm_start_info struct
Date: Wed, 28 Feb 2018 10:28:02 -0800
Message-Id: <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=386
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280226
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593671064225719544?=
X-GMAIL-MSGID: =?utf-8?q?1593671064225719544?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The start info structure that is defined as part of the x86/HVM direct boot
ABI and used for starting Xen PVH guests would be more versatile if it also
included a way to pass information about the memory map to the guest. This
would allow KVM guests to share the same entry point.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 include/xen/interface/hvm/start_info.h | 50 +++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/xen/interface/hvm/start_info.h b/include/xen/interface/hvm/start_info.h
index 648415976ead..80cfbd35c1af 100644
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
+ *    | memmap_entries | Number of entries in the memory map table. Only
+ *    |                | present in version 1 and newer of the structure.
+ *    |                | Zero if there is no memory map being provided.
+ * 52 +----------------+
+ *    | reserved       | Version 1 and newer only.
+ * 56 +----------------+
  *
  * The layout of each entry in the module structure is the following:
  *
@@ -62,10 +71,34 @@
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
+ *    |                | and guest it's starting. E820_TYPE_xxx, for example.
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
+ * Version 0:
+ *
+ * Version 1:	Added the memmap_paddr/memmap_entries fields (plus 4 bytes of
+ *		padding) to the end of the hvm_start_info struct. These new
+ *		fields can be used to pass a memory map to the guest. The
+ *		memory map is optional and so guests that understand version 1
+ *		of the structure must check that memmap_entries is non-zero
+ *		before trying to read the memory map.
  */
 #define XEN_HVM_START_MAGIC_VALUE 0x336ec578
 
@@ -86,6 +119,14 @@ struct hvm_start_info {
     uint64_t cmdline_paddr;     /* Physical address of the command line.     */
     uint64_t rsdp_paddr;        /* Physical address of the RSDP ACPI data    */
                                 /* structure.                                */
+    uint64_t memmap_paddr;	/* Physical address of an array of           */
+				/* hvm_memmap_table_entry. Only present in   */
+				/* version 1 and newer of the structure      */
+    uint32_t memmap_entries;	/* Number of entries in the memmap table.    */
+				/* Only present in version 1 and newer of    */
+				/* the structure. Value will be zero if      */
+				/* there is no memory map being provided.    */
+    uint32_t reserved;
 };
 
 struct hvm_modlist_entry {
@@ -95,4 +136,11 @@ struct hvm_modlist_entry {
     uint64_t reserved;
 };
 
+struct hvm_memmap_table_entry {
+    uint64_t addr;		/* Base address of the memory region         */
+    uint64_t size;		/* Size of the memory region in bytes        */
+    uint32_t type;		/* Mapping type                              */
+    uint32_t reserved;
+};
+
 #endif /* __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__ */
-- 
2.16.1
