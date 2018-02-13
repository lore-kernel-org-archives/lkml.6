Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x225zidgyes5/IDrn8arUDF3X0KqhPbJUVcWG4NXTG+3FM4Ca3p5BpaGTrKOX7KjUECouND0B
ARC-Seal: i=1; a=rsa-sha256; t=1518550344; cv=none;
        d=google.com; s=arc-20160816;
        b=rRQxbO/CoiQux5YFSEQTgUGnj8bxy44HbAuiAZQlK886xoHU8m2ITBfe6n7MSN5+3E
         qhpqEBLQhWwdxC0Yc2HhjUl5dKZWaEBLPRAK3vLPsN5t58KXudShm5I+3JCDX9vjIkOl
         7nTY1sow39tIxHZR3ZNNWq1Ttf5pDFAjhItTxMUw+JxqVP6E+q+3qqCmcyAVc9s9+Vcg
         IwhzdxP3mv5WkiyLO7eUdIvNoEnq01O05H7xKWZpy3FZ1/zeZMxjBIPKiT/Vb6NT7pAB
         Z6xwRjDffq+KrYzsuOHMI5d/g3/tmJjw5Z4NwRQq+d86/Ej0hENg0HJF2S+3CbJgKy3o
         yvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=L0Z7r5zKKmlvwOSlynDEl610plFex+cd4nxct3G1PGU=;
        b=RTnv/iYwpP8Q/yMR1LA3n+2yrWG3z4xWukSg/dyTR8MBIS3T/99GhKnZ+x2yYgg1ku
         UHmPkeZMquAzzjyZ5XbrfHisQB7Ct1+dfoeyuSOt0qmZ9F28TtomnjaUl1tDAHY9Fp2L
         wfxCpbJQoyD+GeXHGo5PNjn+xjFdQXsM5B8LJAV/Jt8PgLifkz8+QON4a0ejJK81edkA
         XqnPQSBScmHGrupZgf5//J8OUZ+s1Xm8FdGhAyGunNPMrDPWwhW4CGHMT5qzo++t7xkv
         3RQ7+lKj78PJii1+isErk45+3Ck+WSN1CugAbMDYgoR0z47SvvUSYTpa51V1xwaQoQYJ
         5TYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ajfROX+8;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ajfROX+8;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [PATCH v3 2/4] x86/mm/memory_hotplug: determine block size based on the end of boot memory
Date: Tue, 13 Feb 2018 14:31:57 -0500
Message-Id: <20180213193159.14606-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213193159.14606-1-pasha.tatashin@oracle.com>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802130233
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446070110278?=
X-GMAIL-MSGID: =?utf-8?q?1592315446070110278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Memory sections are combined into "memory block" chunks. These chunks are
the units upon which memory can be added and removed.

On x86, the new memory may be added after the end of the boot memory,
therefore, if block size does not align with end of boot memory, memory
hot-plugging/hot-removing can be broken.

Currently, whenever machine is boot with more than 64G the block size
unconditionally increased to 2G from the base 128M in order to reduce
number of memory devices in sysfs:
	/sys/devices/system/memory/memoryXXX

But, we must use the largest allowed block size that aligns to the next
address to be able to hotplug the next block of memory.

So, when memory is larger than 64G, we check the end address and find the
largest block size that is still power of two but smaller or equal to 2G.

Before, the fix:
Run qemu with:
-m 64G,slots=2,maxmem=66G -object memory-backend-ram,id=mem1,size=2G

(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
Block size [0x80000000] unaligned hotplug range: start 0x1040000000,
							size 0x80000000
acpi PNP0C80:00: add_memory failed
acpi PNP0C80:00: acpi_memory_enable_device() error
acpi PNP0C80:00: Enumeration failure

With the fix memory is added successfully, as the block size is set to 1G,
and therefore aligns with start address 0x1040000000.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1ab42c852069..f7dc80364397 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1326,14 +1326,39 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(*pte));
 }
 
+/*
+ * Block size is the minimum quantum of memory which can be hot-plugged or
+ * hot-removed. It must be power of two, and must be equal or larger than
+ * MIN_MEMORY_BLOCK_SIZE.
+ */
+#define MAX_BLOCK_SIZE (2UL << 30)
+
+/* Amount of ram needed to start using large blocks */
+#define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
+
 static unsigned long probe_memory_block_size(void)
 {
-	unsigned long bz = MIN_MEMORY_BLOCK_SIZE;
+	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
+	unsigned long bz;
 
-	/* if system is UV or has 64GB of RAM or more, use large blocks */
-	if (is_uv_system() || ((max_pfn << PAGE_SHIFT) >= (64UL << 30)))
-		bz = 2UL << 30; /* 2GB */
+	/* If this is UV system, always set 2G block size */
+	if (is_uv_system()) {
+		bz = MAX_BLOCK_SIZE;
+		goto done;
+	}
 
+	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
+	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
+		bz = MIN_MEMORY_BLOCK_SIZE;
+		goto done;
+	}
+
+	/* Find the largest allowed block size that aligns to memory end */
+	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+		if (IS_ALIGNED(boot_mem_end, bz))
+			break;
+	}
+done:
 	pr_info("x86/mm: Memory block size: %ldMB\n", bz >> 20);
 
 	return bz;
-- 
2.16.1
