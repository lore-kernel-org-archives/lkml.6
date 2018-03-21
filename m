Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeCUL2j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:28:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751731AbeCUL2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:17 -0400
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 10/11] kexec_file: Allow archs to set purgatory load address
Date: Wed, 21 Mar 2018 12:27:50 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0012-0000-0000-000005C1B40A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0013-0000-0000-0000193DD668
Message-Id: <20180321112751.22196-11-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For s390 new kernels are loaded to fixed addresses in memory before they
are booted. With the current code this is a problem as it assumes the
kernel will be loaded to an 'arbitrary' address. In particular,
kexec_locate_mem_hole searches for a large enough memory region and sets
the load address (kexec_bufer->mem) to it.

Luckily there is a simple workaround for this problem. By returning 1 in
arch_kexec_walk_mem, kexec_locate_mem_hole is turned off. This allows the
architecture to set kbuf->mem by hand. While the trick works fine for the
kernel it does not for the purgatory as here the architectures don't have
access to its kexec_buffer.

Give architectures access to the purgatories kexec_buffer by changing
kexec_load_purgatory to take a pointer to it. With this change
architectures have access to the buffer and can edit it as they need.

A nice side effect of this change is that we can get rid of the
purgatory_info->purgatory_load_address field. As now the information stored
there can directly be accessed from kbuf->mem.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/powerpc/kernel/kexec_elf_64.c |  9 +++++----
 arch/x86/kernel/kexec-bzimage64.c  |  8 ++++----
 include/linux/kexec.h              | 17 ++++++-----------
 kernel/kexec_file.c                | 29 ++++++++++++++++-------------
 4 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 9a42309b091a..82448c03502d 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -572,7 +572,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 {
 	int ret;
 	unsigned int fdt_size;
-	unsigned long kernel_load_addr, purgatory_load_addr;
+	unsigned long kernel_load_addr;
 	unsigned long initrd_load_addr = 0, fdt_load_addr;
 	void *fdt;
 	const void *slave_code;
@@ -580,6 +580,8 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	struct elf_info elf_info;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ppc64_rma_size };
+	struct kexec_buf pbuf = { .image = image, .buf_min = 0,
+				  .buf_max = ppc64_rma_size, .top_down = true };
 
 	ret = build_elf_exec_info(kernel_buf, kernel_len, &ehdr, &elf_info);
 	if (ret)
@@ -591,14 +593,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 	pr_debug("Loaded the kernel at 0x%lx\n", kernel_load_addr);
 
-	ret = kexec_load_purgatory(image, 0, ppc64_rma_size, true,
-				   &purgatory_load_addr);
+	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
 		pr_err("Loading purgatory failed.\n");
 		goto out;
 	}
 
-	pr_debug("Loaded purgatory at 0x%lx\n", purgatory_load_addr);
+	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
 
 	if (initrd != NULL) {
 		kbuf.buffer = initrd;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index fb095ba0c02f..df183585928f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -334,7 +334,6 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	unsigned long setup_header_size, params_cmdline_sz;
 	struct boot_params *params;
 	unsigned long bootparam_load_addr, kernel_load_addr, initrd_load_addr;
-	unsigned long purgatory_load_addr;
 	struct bzimage64_data *ldata;
 	struct kexec_entry64_regs regs64;
 	void *stack;
@@ -342,6 +341,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
 				  .top_down = true };
+	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
+				  .buf_max = ULONG_MAX, .top_down = true };
 
 	header = (struct setup_header *)(kernel + setup_hdr_offset);
 	setup_sects = header->setup_sects;
@@ -379,14 +380,13 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
 	 * anywhere.
 	 */
-	ret = kexec_load_purgatory(image, MIN_PURGATORY_ADDR, ULONG_MAX, 1,
-				   &purgatory_load_addr);
+	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
 		pr_err("Loading purgatory failed\n");
 		return ERR_PTR(ret);
 	}
 
-	pr_debug("Loaded purgatory at 0x%lx\n", purgatory_load_addr);
+	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
 
 
 	/*
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a757ec37775f..381362eb0f61 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -114,9 +114,6 @@ struct purgatory_info {
 	 * relocation. This memory can be freed post image load.
 	 */
 	void *purgatory_buf;
-
-	/* Address where purgatory is finally loaded and is executed from */
-	unsigned long purgatory_load_addr;
 };
 
 struct kimage;
@@ -166,6 +163,12 @@ struct kexec_buf {
 	bool top_down;
 };
 
+int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
+int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
+				   void *buf, unsigned int size,
+				   bool get_value);
+void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
+
 int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 					    Elf_Shdr *section,
 					    const Elf_Shdr *relsec,
@@ -246,14 +249,6 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
-extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
-				unsigned long max, int top_down,
-				unsigned long *load_addr);
-extern int kexec_purgatory_get_set_symbol(struct kimage *image,
-					  const char *name, void *buf,
-					  unsigned int size, bool get_value);
-extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
-					     const char *name);
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 1478766c7754..97d5c946fa36 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -669,8 +669,8 @@ static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
 	int i, ret;
 
 	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-	bss_align = 1;
-	bss_sz = 0;
+	kbuf->buf_align = bss_align = 1;
+	kbuf->bufsz = bss_sz = 0;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
@@ -702,7 +702,6 @@ static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
 	ret = kexec_add_buffer(kbuf);
 	if (ret)
 		goto out;
-	pi->purgatory_load_addr = kbuf->mem;
 
 	return 0;
 out:
@@ -840,27 +839,32 @@ static int kexec_apply_relocations(struct kimage *image)
 	return 0;
 }
 
-/* Load relocatable purgatory object and relocate it appropriately */
-int kexec_load_purgatory(struct kimage *image, unsigned long min,
-			 unsigned long max, int top_down,
-			 unsigned long *load_addr)
+/*
+ * kexec_load_purgatory - Load and relocate the purgatory object.
+ * @image:	Image to add the purgatory to.
+ * @kbuf:	Memory parameters to use.
+ *
+ * Allocates the memory needed for image->purgatory_info.sechdrs and
+ * image->purgatory_info.purgatory_buf/kbuf->buffer. Caller is responsible
+ * to free the memory after use.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
 	int ret;
-	struct kexec_buf kbuf = { .image = image, .bufsz = 0, .buf_align = 1,
-				  .buf_min = min, .buf_max = max,
-				  .top_down = top_down };
 
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
 	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
-	ret = kexec_purgatory_setup_kbuf(pi, &kbuf);
+	ret = kexec_purgatory_setup_kbuf(pi, kbuf);
 	if (ret)
 		return ret;
 
-	ret = kexec_purgatory_setup_sechdrs(pi, &kbuf);
+	ret = kexec_purgatory_setup_sechdrs(pi, kbuf);
 	if (ret)
 		goto out_free_kbuf;
 
@@ -868,7 +872,6 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (ret)
 		goto out;
 
-	*load_addr = pi->purgatory_load_addr;
 	return 0;
 out:
 	vfree(pi->sechdrs);
-- 
2.13.5
