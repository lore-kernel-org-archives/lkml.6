Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDLSXk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeDLSXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:23:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1287C2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 1/2] kexec: Remove "weak" from kexec_file function
 declarations
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2018 13:23:36 -0500
Message-ID: <152355741673.36693.13178321454821440236.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

For the following functions:

  arch_kexec_kernel_image_probe()
  arch_kexec_kernel_image_load()
  arch_kimage_file_post_load_cleanup()
  arch_kexec_kernel_verify_sig()
  arch_kexec_apply_relocations_add()
  arch_kexec_apply_relocations()

kernel/kexec_file.c contains weak definitions, and x86 and powerpc arch
code contains definitions intended to be non-weak.  But the annotations in
the header file make *all* the definitions weak, so it's unclear which ones
will be used.

Remove the "weak" attribute from the declarations so we always prefer
non-weak definitions over the weak ones.

Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org      # v4.3+
---
 include/linux/kexec.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..8bf0ff90885c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -277,16 +277,16 @@ int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
 
-int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
-					 unsigned long buf_len);
-void * __weak arch_kexec_kernel_image_load(struct kimage *image);
-int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len);
-int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
-					Elf_Shdr *sechdrs, unsigned int relsec);
-int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
-					unsigned int relsec);
+int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+				  unsigned long buf_len);
+void *arch_kexec_kernel_image_load(struct kimage *image);
+int arch_kimage_file_post_load_cleanup(struct kimage *image);
+int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
+				 unsigned long buf_len);
+int arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+				     unsigned int relsec);
+int arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+				 unsigned int relsec);
 void arch_kexec_protect_crashkres(void);
 void arch_kexec_unprotect_crashkres(void);
 
