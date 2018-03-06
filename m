Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeCFKXi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:23:38 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35338 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeCFKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:23:34 -0500
X-Google-Smtp-Source: AG47ELsFTr0nmL+EF79d5kD2h4RfAWvH5G11e8DdB2at1k4uSsy7Y920ynDd2jJ+XcKHjyIrtQX2VQ==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 5/7] x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer
Date: Tue,  6 Mar 2018 19:23:01 +0900
Message-Id: <20180306102303.9063-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306102303.9063-1-takahiro.akashi@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While CRASH_MAX_RANGES (== 16) seems to be good enough, fixed-number
array is not a good idea in general.

In this patch, size of crash_mem buffer is calculated as before and
the buffer is now dynamically allocated. This change also allows removing
crash_elf_data structure.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 82 +++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b328153cee65..0f20a6330bd6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -41,32 +41,14 @@
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-/* This primarily represents number of split ranges due to exclusion */
-#define CRASH_MAX_RANGES	16
-
 struct crash_mem_range {
 	u64 start, end;
 };
 
 struct crash_mem {
-	unsigned int nr_ranges;
-	struct crash_mem_range ranges[CRASH_MAX_RANGES];
-};
-
-/* Misc data about ram ranges needed to prepare elf headers */
-struct crash_elf_data {
-	struct kimage *image;
-	/*
-	 * Total number of ram ranges we have after various adjustments for
-	 * crash reserved region, etc.
-	 */
 	unsigned int max_nr_ranges;
-
-	/* Pointer to elf header */
-	void *ehdr;
-	/* Pointer to next phdr */
-	void *bufp;
-	struct crash_mem mem;
+	unsigned int nr_ranges;
+	struct crash_mem_range ranges[0];
 };
 
 /* Used while preparing memory map entries for second kernel */
@@ -217,26 +199,31 @@ static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-
 /* Gather all the required information to prepare elf headers for ram regions */
-static void fill_up_crash_elf_data(struct crash_elf_data *ced,
-				   struct kimage *image)
+static struct crash_mem *fill_up_crash_elf_data(void)
 {
 	unsigned int nr_ranges = 0;
-
-	ced->image = image;
+	struct crash_mem *cmem;
 
 	walk_system_ram_res(0, -1, &nr_ranges,
 				get_nr_ram_ranges_callback);
+	if (!nr_ranges)
+		return NULL;
 
-	ced->max_nr_ranges = nr_ranges;
+	/*
+	 * Exclusion of crash region and/or crashk_low_res may cause
+	 * another range split. So add extra two slots here.
+	 */
+	nr_ranges += 2;
+	cmem = vzalloc(sizeof(struct crash_mem) +
+			sizeof(struct crash_mem_range) * nr_ranges);
+	if (!cmem)
+		return NULL;
 
-	/* Exclusion of crash region could split memory ranges */
-	ced->max_nr_ranges++;
+	cmem->max_nr_ranges = nr_ranges;
+	cmem->nr_ranges = 0;
 
-	/* If crashk_low_res is not 0, another range split possible */
-	if (crashk_low_res.end)
-		ced->max_nr_ranges++;
+	return cmem;
 }
 
 static int exclude_mem_range(struct crash_mem *mem,
@@ -293,10 +280,8 @@ static int exclude_mem_range(struct crash_mem *mem,
 		return 0;
 
 	/* Split happened */
-	if (i == CRASH_MAX_RANGES - 1) {
-		pr_err("Too many crash ranges after split\n");
+	if (i == mem->max_nr_ranges - 1)
 		return -ENOMEM;
-	}
 
 	/* Location where new range should go */
 	j = i + 1;
@@ -314,11 +299,10 @@ static int exclude_mem_range(struct crash_mem *mem,
 
 /*
  * Look for any unwanted ranges between mstart, mend and remove them. This
- * might lead to split and split ranges are put in ced->mem.ranges[] array
+ * might lead to split and split ranges are put in cmem->ranges[] array
  */
-static int elf_header_exclude_ranges(struct crash_elf_data *ced)
+static int elf_header_exclude_ranges(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem = &ced->mem;
 	int ret = 0;
 
 	/* Exclude crashkernel region */
@@ -337,8 +321,7 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced)
 
 static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
-	struct crash_elf_data *ced = arg;
-	struct crash_mem *cmem = &ced->mem;
+	struct crash_mem *cmem = arg;
 
 	cmem->ranges[cmem->nr_ranges].start = res->start;
 	cmem->ranges[cmem->nr_ranges].end = res->end;
@@ -347,7 +330,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf64_headers(struct crash_elf_data *ced, bool kernel_map,
+static int prepare_elf64_headers(struct crash_mem *cmem, bool kernel_map,
 		void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
@@ -356,12 +339,11 @@ static int prepare_elf64_headers(struct crash_elf_data *ced, bool kernel_map,
 	unsigned char *buf, *bufp;
 	unsigned int cpu, i;
 	unsigned long long notes_addr;
-	struct crash_mem *cmem = &ced->mem;
 	unsigned long mstart, mend;
 
 	/* extra phdr for vmcoreinfo elf note */
 	nr_phdr = nr_cpus + 1;
-	nr_phdr += ced->max_nr_ranges;
+	nr_phdr += cmem->nr_ranges;
 
 	/*
 	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
@@ -455,29 +437,27 @@ static int prepare_elf64_headers(struct crash_elf_data *ced, bool kernel_map,
 static int prepare_elf_headers(struct kimage *image, void **addr,
 					unsigned long *sz)
 {
-	struct crash_elf_data *ced;
+	struct crash_mem *cmem;
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
 	int ret, i;
 
-	ced = kzalloc(sizeof(*ced), GFP_KERNEL);
-	if (!ced)
+	cmem = fill_up_crash_elf_data();
+	if (!cmem)
 		return -ENOMEM;
 
-	fill_up_crash_elf_data(ced, image);
-
-	ret = walk_system_ram_res(0, -1, ced,
+	ret = walk_system_ram_res(0, -1, cmem,
 				prepare_elf64_ram_headers_callback);
 	if (ret)
 		goto out;
 
 	/* Exclude unwanted mem ranges */
-	ret = elf_header_exclude_ranges(ced);
+	ret = elf_header_exclude_ranges(cmem);
 	if (ret)
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  prepare_elf64_headers(ced, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 	if (ret)
 		goto out;
 
@@ -495,7 +475,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 			break;
 		}
 out:
-	kfree(ced);
+	vfree(cmem);
 	return ret;
 }
 
-- 
2.16.2
