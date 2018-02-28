Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELt8/Mle2t7sVrFFr6EZM8Nd3c17iLwQ0/PrDYHH3vX/KvjdvVpi4kG5FsH8kNZVx0tQ/4bG
ARC-Seal: i=1; a=rsa-sha256; t=1519787011; cv=none;
        d=google.com; s=arc-20160816;
        b=I45cTanR32lgSYsUVp8dcv2GDq579iFsKOvbRWLD5zDprbsGnyin+w5nQycPW9MxPf
         VkgvRrhJ8ezJUY35n9Z3T3EIrfKO5dr78HrHuqBsunRFliNnMANy25Ly46oEJUFkwcv4
         kIAEWgCLk1Tvrf+FSc8jLFzabD46u85Fd9cwOGA83B7KG0K3eF54Idb5B3b8lY8BNECi
         0rXGlWXeyvnMknMWD+pRUbcf6QU8luKaQe/Pkyjq3MYYtsR7ZfO7/XTVPZ+BtMQZBXZ8
         rgR2eWAvXH5rEaMyrQFp0LPHv9uYxQaRVRypUHF+052CfQevQs9rRKv9gOulZ6j0G+7L
         j0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=9nZmL5A7r3U477bbMoCUJDdLKtZNoGGG/2kFt/62ZIE=;
        b=y5CYXXSHlKal87UbPSSYW07DktQo17XespqRJeAs3P4yHNzcvgEBMA+m6wNZ8ZePkg
         B1DrqVqVwvw/d8vrdp/WEngp3MXvLaRVUVzg+WQbjv6gGscMpGdd6LbKXkY9FAvc+9Tw
         T9x2eEB2h28RXh1F0YrQNdj4M6O69WHFlF5LTsPITP7TzwJWwVvjI13TO1qd4AvaiD+/
         ac5fVt+ePRNL53ePA0W2czBAkxthXQMRCx6E5LaSqutxqijUNqGqz+qopVO3MUu4VPrl
         MBZfEBtzkftGp/RJOJpSoJFeF21nSnM4dCTUlWRlJ+rUi3Doq+B43bLFcpkOaXAL2Ypm
         fI5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HrffRE5b;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HrffRE5b;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v5 1/6] mm/memory_hotplug: enforce block size aligned range check
Date: Tue, 27 Feb 2018 22:03:03 -0500
Message-Id: <20180228030308.1116-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228030308.1116-1-pasha.tatashin@oracle.com>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612185745957174?=
X-GMAIL-MSGID: =?utf-8?q?1593612185745957174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Start qemu with the following arguments:

-m 64G,slots=2,maxmem=66G -object memory-backend-ram,id=mem1,size=2G

Which boots machine with 64G and adds a device mem1 with 2G that can be
hotplugged later.

Also make sure that .config has the following options turned on:

CONFIG_MEMORY_HOTPLUG
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
CONFIG_ACPI_HOTPLUG_MEMORY

Using the qemu monitor hotplug the memory:

(qemu) device_add pc-dimm,id=dimm1,memdev=mem1

The operation will fail with the following trace:

WARNING: CPU: 0 PID: 91 at drivers/base/memory.c:205
pages_correctly_reserved+0xe6/0x110
Modules linked in:
CPU: 0 PID: 91 Comm: systemd-udevd Not tainted 4.16.0-rc1_pt_master #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
RIP: 0010:pages_correctly_reserved+0xe6/0x110
RSP: 0018:ffffbe5086b53d98 EFLAGS: 00010246
RAX: ffff9acb3fff3180 RBX: ffff9acaf7646038 RCX: 0000000000000800
RDX: ffff9acb3fff3000 RSI: 0000000000000218 RDI: 00000000010c0000
RBP: 0000000001080000 R08: ffffe81f83000040 R09: 0000000001100000
R10: ffff9acb3fff6000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000000000000000 R14: ffffbe5086b53f08 R15: ffff9acaf7506f20
FS:  00007fd7f20da8c0(0000) GS:ffff9acb3fc00000(0000) knlGS:000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7f20f2000 CR3: 0000000ff7ac2001 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memory_subsys_online+0x44/0xa0
 device_online+0x51/0x80
 store_mem_state+0x5e/0xe0
 kernfs_fop_write+0xfa/0x170
 __vfs_write+0x2e/0x150
 ? __inode_security_revalidate+0x47/0x60
 ? selinux_file_permission+0xd5/0x130
 ? _cond_resched+0x10/0x20
 vfs_write+0xa8/0x1a0
 ? find_vma+0x54/0x60
 SyS_write+0x4d/0xb0
 do_syscall_64+0x5d/0x110
 entry_SYSCALL_64_after_hwframe+0x21/0x86
RIP: 0033:0x7fd7f0d3a840
RSP: 002b:00007fff5db77c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fd7f0d3a840
RDX: 0000000000000006 RSI: 00007fd7f20f2000 RDI: 0000000000000007
RBP: 00007fd7f20f2000 R08: 000055db265c4ab0 R09: 00007fd7f20da8c0
R10: 0000000000000006 R11: 0000000000000246 R12: 000055db265c49d0
R13: 0000000000000006 R14: 000055db265c5510 R15: 000000000000000b
Code: fe ff ff 07 00 77 24 48 89 f8 48 c1 e8 17 49 8b 14 c2 48 85 d2 74 14
40 0f b6 c6 49 81 c0 00 00 20 00 48 c1 e0 04 48 01 d0 75 93 <0f> ff 31 c0
c3 b8 01 00 00 00 c3 31 d2 48 c7 c7 b0 32 67 a6 31
---[ end trace 6203bc4f1a5d30e8 ]---

The problem is detected in: drivers/base/memory.c

static bool pages_correctly_reserved(unsigned long start_pfn)
                 if (WARN_ON_ONCE(!pfn_valid(pfn)))

This function loops through every section in the newly added memory block
and verifies that the first pfn in each section is valid, meaning section
exists, has mapping (struct page array), and is online.

The block size on x86 is usually 128M, but when machine is booted with
more than 64G of memory the block size is changed to 2G:

$ cat /sys/devices/system/memory/block_size_bytes
80000000

or

$ dmesg | grep "block size"
[    0.086469] x86/mm: Memory block size: 2048MB

During memory hotplug, and hotremove we verify that the range is section
size aligned, but we actually must verify that it is block size aligned,
because that is the proper unit for hotplug operations.  See:
Documentation/memory-hotplug.txt

So, when the start_pfn of newly added memory is not block size aligned, we
can get a memory block with partially populated sections.

In our case the start_pfn starts from the last_pfn (end of physical
memory).

$ dmesg | grep last_pfn
[    0.000000] e820: last_pfn = 0x1040000 max_arch_pfn = 0x400000000

0x1040000 == 65G, and so is not 2G aligned!

The fix is to enforce that memory that is hotplugged and hotremoved is
block size aligned.

With this fix, running the above sequence yield to the following result:

(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
Block size [0x80000000] unaligned hotplug range: start 0x1040000000,
							size 0x80000000
acpi PNP0C80:00: add_memory failed
acpi PNP0C80:00: acpi_memory_enable_device() error
acpi PNP0C80:00: Enumeration failure

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b2bd52ff7605..565048f496f7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1083,15 +1083,16 @@ int try_online_node(int nid)
 
 static int check_hotplug_memory_range(u64 start, u64 size)
 {
-	u64 start_pfn = PFN_DOWN(start);
+	unsigned long block_sz = memory_block_size_bytes();
+	u64 block_nr_pages = block_sz >> PAGE_SHIFT;
 	u64 nr_pages = size >> PAGE_SHIFT;
+	u64 start_pfn = PFN_DOWN(start);
 
-	/* Memory range must be aligned with section */
-	if ((start_pfn & ~PAGE_SECTION_MASK) ||
-	    (nr_pages % PAGES_PER_SECTION) || (!nr_pages)) {
-		pr_err("Section-unaligned hotplug range: start 0x%llx, size 0x%llx\n",
-				(unsigned long long)start,
-				(unsigned long long)size);
+	/* memory range must be block size aligned */
+	if (!nr_pages || !IS_ALIGNED(start_pfn, block_nr_pages) ||
+	    !IS_ALIGNED(nr_pages, block_nr_pages)) {
+		pr_err("Block size [%#lx] unaligned hotplug range: start %#llx, size %#llx",
+		       block_sz, start, size);
 		return -EINVAL;
 	}
 
-- 
2.16.2
