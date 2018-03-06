Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeCFKXa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:23:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41864 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeCFKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:23:26 -0500
X-Google-Smtp-Source: AG47ELvnUHq253JdSW7ftrh8XbI5oGlt1/Ay8iD+rfS4nXSvNBCMikicyu/LQNDuuKtWUGJBcoMmkA==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 3/7] x86: kexec_file: purge system-ram walking from prepare_elf64_headers()
Date: Tue,  6 Mar 2018 19:22:59 +0900
Message-Id: <20180306102303.9063-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While prepare_elf64_headers() in x86 looks pretty generic for other
architectures' use, it contains some code which tries to list crash memory
regions by walking through system resources, which is not always
architecture agnostic.
To make this function more generic, the related code should be purged.

In this patch, prepare_elf64_headers() simply scans crash_mem buffer passed
and add all the listed regions to elf header as a PT_LOAD segment.
So walk_system_ram_res(prepare_elf64_headers_callback) have been moved
forward before prepare_elf64_headers() where the callback,
prepare_elf64_headers_callback(), is now responsible for filling up
crash_mem buffer.

Meanwhile exclude_elf_header_ranges() used to be called every time in
this callback it is rather redundant and now called only once in
prepare_elf_headers() as well.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 121 +++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 10e74d4778a1..2123fa0efc17 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -316,18 +316,11 @@ static int exclude_mem_range(struct crash_mem *mem,
  * Look for any unwanted ranges between mstart, mend and remove them. This
  * might lead to split and split ranges are put in ced->mem.ranges[] array
  */
-static int elf_header_exclude_ranges(struct crash_elf_data *ced,
-		unsigned long long mstart, unsigned long long mend)
+static int elf_header_exclude_ranges(struct crash_elf_data *ced)
 {
 	struct crash_mem *cmem = &ced->mem;
 	int ret = 0;
 
-	memset(cmem->ranges, 0, sizeof(cmem->ranges));
-
-	cmem->ranges[0].start = mstart;
-	cmem->ranges[0].end = mend;
-	cmem->nr_ranges = 1;
-
 	/* Exclude crashkernel region */
 	ret = exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (ret)
@@ -345,53 +338,13 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced,
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_elf_data *ced = arg;
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long mstart, mend;
-	struct kimage *image = ced->image;
-	struct crash_mem *cmem;
-	int ret, i;
-
-	ehdr = ced->ehdr;
-
-	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(ced, res->start, res->end);
-	if (ret)
-		return ret;
-
-	/* Go through all the ranges in ced->mem.ranges[] and prepare phdr */
-	cmem = &ced->mem;
-
-	for (i = 0; i < cmem->nr_ranges; i++) {
-		mstart = cmem->ranges[i].start;
-		mend = cmem->ranges[i].end;
-
-		phdr = ced->bufp;
-		ced->bufp += sizeof(Elf64_Phdr);
+	struct crash_mem *cmem = &ced->mem;
 
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
+	cmem->ranges[cmem->nr_ranges].start = res->start;
+	cmem->ranges[cmem->nr_ranges].end = res->end;
+	cmem->nr_ranges++;
 
-		/*
-		 * If a range matches backup region, adjust offset to backup
-		 * segment.
-		 */
-		if (mstart == image->arch.backup_src_start &&
-		    (mend - mstart + 1) == image->arch.backup_src_sz)
-			phdr->p_offset = image->arch.backup_load_addr;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int prepare_elf64_headers(struct crash_elf_data *ced,
@@ -401,9 +354,10 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
 	Elf64_Phdr *phdr;
 	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
 	unsigned char *buf, *bufp;
-	unsigned int cpu;
+	unsigned int cpu, i;
 	unsigned long long notes_addr;
-	int ret;
+	struct crash_mem *cmem = &ced->mem;
+	unsigned long mstart, mend;
 
 	/* extra phdr for vmcoreinfo elf note */
 	nr_phdr = nr_cpus + 1;
@@ -472,13 +426,25 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
 	(ehdr->e_phnum)++;
 #endif
 
-	/* Prepare PT_LOAD headers for system ram chunks. */
-	ced->ehdr = ehdr;
-	ced->bufp = bufp;
-	ret = walk_system_ram_res(0, -1, ced,
-			prepare_elf64_ram_headers_callback);
-	if (ret < 0)
-		return ret;
+	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
+	for (i = 0; i < cmem->nr_ranges; i++) {
+		mstart = cmem->ranges[i].start;
+		mend = cmem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		phdr++;
+		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+	}
 
 	*addr = buf;
 	*sz = elf_sz;
@@ -490,7 +456,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 					unsigned long *sz)
 {
 	struct crash_elf_data *ced;
-	int ret;
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	int ret, i;
 
 	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
 	if (!ced)
@@ -498,8 +466,35 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 
 	fill_up_crash_elf_data(ced, image);
 
+	ret = walk_system_ram_res(0, -1, ced,
+				prepare_elf64_ram_headers_callback);
+	if (ret)
+		goto out;
+
+	/* Exclude unwanted mem ranges */
+	ret = elf_header_exclude_ranges(ced);
+	if (ret)
+		goto out;
+
 	/* By default prepare 64bit headers */
 	ret =  prepare_elf64_headers(ced, addr, sz);
+	if (ret)
+		goto out;
+
+	/*
+	 * If a range matches backup region, adjust offset to backup
+	 * segment.
+	 */
+	ehdr = (Elf64_Ehdr *)*addr;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	for (i = 0; i < ehdr->e_phnum; phdr++, i++)
+		if (phdr->p_type == PT_LOAD &&
+				phdr->p_paddr == image->arch.backup_src_start &&
+				phdr->p_memsz == image->arch.backup_src_sz) {
+			phdr->p_offset = image->arch.backup_load_addr;
+			break;
+		}
+out:
 	kfree(ced);
 	return ret;
 }
-- 
2.16.2
