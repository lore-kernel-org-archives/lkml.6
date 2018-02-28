Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvFzhhQppjNqWneOLvxGeciVQcDB9e7cLo6kK7+JJXmBpxPaCGD4SZGrXU6j4z3qCjApu/k
ARC-Seal: i=1; a=rsa-sha256; t=1519787012; cv=none;
        d=google.com; s=arc-20160816;
        b=vVGF+TVSng6pfaAiJ81MBPe/YhAEoyvniyHT7ok6UF9HJ+LSHSjbMN8SDzOk/OSgGI
         +ncez0zyhLfLatlcnq8FGm+EakLvNxlR/lZN4yOMUEQMkq5Vl/tuf2JN28ZW7VLf3jDt
         oIKGWe7mFWSkhttcHDf2qTiK1XR8qfdLdjwaasDvyM3BTlimfG1IESSXJlrzX+E8/KYL
         IUXP6Ujxl0DHUPHLRRZMcvOGjKubhU3lOp7MwKfz+nl5wcZRHQ9FEe0kfV+HrPxjm5WR
         9b6DqEfgBdCM+Z6ymXCl+8g9a1BsfQ6ChXAYmtFVhyEgYATUP88xbIs88dUo0yvVtiON
         eMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=zdyut/Vq0NWJNvMBWmWdNo5UbXRamuhBw8dywZarfUQ=;
        b=RePaqsSpBgugEpi5KYnElB2eUjBoLmJa/bVoGKkIyrrdwJ5jja4imhfhzh0MCw70y/
         6/VChMHlB3idx7DlBml3m4dvlgd1mqJmb74nSRcRh2Ptr8QUHUo64EXtGpdOQpEUH/F1
         HmZh8Yr48MFwCd3jmjy8T+XflisbwrP9DLw73THW7AOvHoJzEU/OP+aWHw4WCCwvIc+s
         MtRSbCbDppVz6yWugRbuOaF9DrZrOG+dOCKtzj5H8q0HQuKXw7BRY1xFDwwq+TNHS/+O
         lqvYnsuqxIgAskGN/udL1P5YATBNg+fWWgT4WlrEJpvLV4XoulfQzmsdpvxLHgyBy4Q+
         //xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iR6qYtJj;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iR6qYtJj;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v5 2/6] x86/mm/memory_hotplug: determine block size based on the end of boot memory
Date: Tue, 27 Feb 2018 22:03:04 -0500
Message-Id: <20180228030308.1116-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228030308.1116-1-pasha.tatashin@oracle.com>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612185458736716?=
X-GMAIL-MSGID: =?utf-8?q?1593612185458736716?=
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
2.16.2
