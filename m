Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x224xPTl4H9ADwTQFTOxi+pFk6BOveSXgSbxbcRC+1lfR2v9AZAiRwf+Sb1pMnQNXTFaEVU2o
ARC-Seal: i=1; a=rsa-sha256; t=1518714346; cv=none;
        d=google.com; s=arc-20160816;
        b=j34ooHvs9ioS3NCwXeUuILgwFigq65T9kFSFSNthA4zCFPHXLj2h57kUMmd+lT9nzC
         jlUERir3g7YJwmGySqDVqYlioY6XtptZqOkLKdetnCoJMowfVSfG8tivYf45ZEz2DYMl
         uLQIPesJu4vM7rtbBCzXkiysF36drEZKikA17QICfzTak0ExRfXjGYjzwMrVKtMG7/1D
         DGy+BXqkdf9PiB+lYmhjmwmp8RMGteo+wfuksgeyAICb1sx2p7VbMAYFqiUvtP+SSabw
         74sITUcop7vT7fTqGkTbPMr4IgiOKoR+NIyd7y5IIO0ch0q+ngoxLjXeOt/3iNQHJP7I
         IHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=Fhs4oGeUpyLGgwXCeXxf5VcOMfI+GWRMmKatDA/2mno=;
        b=ro3sYcOa1UEoKMLzTmp7XMFUPpnp/ckWXAVJEWk926ibPzLQMOIInpiz9PhvZxrP9o
         QFn/FE59sOnwcOJT0qMQrHEaV0s12Ry7+LkE2RoOOFNUJ7HNZ+4YoVsZ9GaZRUTluh4d
         LZjTnJ1wn6sxpdPFs0si0hXokqb0tXwe6BI0lkj1PAMGhWv/rZ7iQqD8wRDvsOKHQqcw
         gAU8PIJc8OfKk4kzXUOJagCCWLBJT6P4pLWrbUuoxIBDVbpqjiOfmvYirGWuCtvFGumA
         SBqrd6kfsYorjXWjGrfUTFmc0S9K9GRS/Z47q+YIHYJ1OioQS5x1vY0jqmHv/suS8i0k
         9a9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=AhJ9k57g;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=AhJ9k57g;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v4 2/6] x86/mm/memory_hotplug: determine block size based on the end of boot memory
Date: Thu, 15 Feb 2018 11:59:16 -0500
Message-Id: <20180215165920.8570-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215165920.8570-1-pasha.tatashin@oracle.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446070110278?=
X-GMAIL-MSGID: =?utf-8?q?1592487414263528252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Memory sections are combined into "memory block" chunks.  These chunks are
the units upon which memory can be added and removed.

On x86 the new memory may be added after the end of the boot memory,
therefore, if block size does not align with end of boot memory, memory
hotplugging/hotremoving can be broken.

Currently, whenever machine is booted with more than 64G the block size
is unconditionally increased to 2G from the base 128M. This is done in
order to reduce number of memory device files in sysfs:
	/sys/devices/system/memory/memoryXXX

We must use the largest allowed block size that aligns to the next
address to be able to hotplug the next block of memory.

So, when memory is larger or equal to 64G, we check the end address and
find the largest block size that is still power of two but smaller or
equal to 2G.

Before, the fix:
Run qemu with:
-m 64G,slots=2,maxmem=66G -object memory-backend-ram,id=mem1,size=2G

(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
Block size [0x80000000] unaligned hotplug range: start 0x1040000000,
							size 0x80000000
acpi PNP0C80:00: add_memory failed
acpi PNP0C80:00: acpi_memory_enable_device() error
acpi PNP0C80:00: Enumeration failure

With the fix memory is added successfully as the block size is set to 1G,
and therefore aligns with start address 0x1040000000.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b72923f1d35..9ac776de2252 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1326,14 +1326,39 @@ int kern_addr_valid(unsigned long addr)
 	return pfn_valid(pte_pfn(*pte));
 }
 
+/*
+ * Block size is the minimum amount of memory which can be hotplugged or
+ * hotremoved. It must be power of two and must be equal or larger than
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
