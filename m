Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeFDQzS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:55:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42820 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFDQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:55:16 -0400
X-Google-Smtp-Source: ADUXVKL8zlcY/7RScmi/ICn0TqelrOv7pmpvB+FHy9FQDpA1JhYzMn8vxt+N8YRJ4eQMafY/4e04Iw==
Date: Mon, 4 Jun 2018 18:55:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/dax changes for v4.18
Message-ID: <20180604165512.GA2641@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-dax-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-dax-for-linus

   # HEAD: 8780356ef630aa577fd4daa49e49b79674711fae x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()

This tree contains x86 memcpy_mcsafe() fault handling improvements the nvdimm tree 
would like to make more use of.

  out-of-topic modifications in x86-dax-for-linus:
  --------------------------------------------------
  drivers/nvdimm/claim.c             # 60622d68227d: x86/asm/memcpy_mcsafe: Retur
  drivers/nvdimm/pmem.c              # 60622d68227d: x86/asm/memcpy_mcsafe: Retur
  include/linux/string.h             # 60622d68227d: x86/asm/memcpy_mcsafe: Retur
  include/linux/uio.h                # 8780356ef630: x86/asm/memcpy_mcsafe: Defin
  lib/iov_iter.c                     # 8780356ef630: x86/asm/memcpy_mcsafe: Defin

 Thanks,

	Ingo

------------------>
Dan Williams (5):
      x86/asm/memcpy_mcsafe: Remove loop unrolling
      x86/asm/memcpy_mcsafe: Add labels for __memcpy_mcsafe() write fault handling
      x86/asm/memcpy_mcsafe: Return bytes remaining
      x86/asm/memcpy_mcsafe: Add write-protection-fault handling
      x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()


 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/string_64.h  |  10 ++--
 arch/x86/include/asm/uaccess_64.h |  14 ++++++
 arch/x86/lib/memcpy_64.S          | 102 ++++++++++++++++----------------------
 arch/x86/lib/usercopy_64.c        |  21 ++++++++
 drivers/nvdimm/claim.c            |   3 +-
 drivers/nvdimm/pmem.c             |   6 +--
 include/linux/string.h            |   4 +-
 include/linux/uio.h               |  15 ++++++
 lib/iov_iter.c                    |  61 +++++++++++++++++++++++
 10 files changed, 169 insertions(+), 68 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..6ca22706cd64 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -60,6 +60,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_REFCOUNT
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
+	select ARCH_HAS_UACCESS_MCSAFE		if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 533f74c300c2..d33f92b9fa22 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -116,7 +116,8 @@ int strcmp(const char *cs, const char *ct);
 #endif
 
 #define __HAVE_ARCH_MEMCPY_MCSAFE 1
-__must_check int memcpy_mcsafe_unrolled(void *dst, const void *src, size_t cnt);
+__must_check unsigned long __memcpy_mcsafe(void *dst, const void *src,
+		size_t cnt);
 DECLARE_STATIC_KEY_FALSE(mcsafe_key);
 
 /**
@@ -131,14 +132,15 @@ DECLARE_STATIC_KEY_FALSE(mcsafe_key);
  * actually do machine check recovery. Everyone else can just
  * use memcpy().
  *
- * Return 0 for success, -EFAULT for fail
+ * Return 0 for success, or number of bytes not copied if there was an
+ * exception.
  */
-static __always_inline __must_check int
+static __always_inline __must_check unsigned long
 memcpy_mcsafe(void *dst, const void *src, size_t cnt)
 {
 #ifdef CONFIG_X86_MCE
 	if (static_branch_unlikely(&mcsafe_key))
-		return memcpy_mcsafe_unrolled(dst, src, cnt);
+		return __memcpy_mcsafe(dst, src, cnt);
 	else
 #endif
 		memcpy(dst, src, cnt);
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 62546b3a398e..62acb613114b 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -46,6 +46,17 @@ copy_user_generic(void *to, const void *from, unsigned len)
 	return ret;
 }
 
+static __always_inline __must_check unsigned long
+copy_to_user_mcsafe(void *to, const void *from, unsigned len)
+{
+	unsigned long ret;
+
+	__uaccess_begin();
+	ret = memcpy_mcsafe(to, from, len);
+	__uaccess_end();
+	return ret;
+}
+
 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 {
@@ -194,4 +205,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 unsigned long
 copy_user_handle_tail(char *to, char *from, unsigned len);
 
+unsigned long
+mcsafe_handle_tail(char *to, char *from, unsigned len);
+
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..c3b527a9f95d 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -184,11 +184,11 @@ ENDPROC(memcpy_orig)
 
 #ifndef CONFIG_UML
 /*
- * memcpy_mcsafe_unrolled - memory copy with machine check exception handling
+ * __memcpy_mcsafe - memory copy with machine check exception handling
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(memcpy_mcsafe_unrolled)
+ENTRY(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -204,58 +204,29 @@ ENTRY(memcpy_mcsafe_unrolled)
 	subl $8, %ecx
 	negl %ecx
 	subl %ecx, %edx
-.L_copy_leading_bytes:
+.L_read_leading_bytes:
 	movb (%rsi), %al
+.L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_leading_bytes
+	jnz .L_read_leading_bytes
 
 .L_8byte_aligned:
-	/* Figure out how many whole cache lines (64-bytes) to copy */
-	movl %edx, %ecx
-	andl $63, %edx
-	shrl $6, %ecx
-	jz .L_no_whole_cache_lines
-
-	/* Loop copying whole cache lines */
-.L_cache_w0: movq (%rsi), %r8
-.L_cache_w1: movq 1*8(%rsi), %r9
-.L_cache_w2: movq 2*8(%rsi), %r10
-.L_cache_w3: movq 3*8(%rsi), %r11
-	movq %r8, (%rdi)
-	movq %r9, 1*8(%rdi)
-	movq %r10, 2*8(%rdi)
-	movq %r11, 3*8(%rdi)
-.L_cache_w4: movq 4*8(%rsi), %r8
-.L_cache_w5: movq 5*8(%rsi), %r9
-.L_cache_w6: movq 6*8(%rsi), %r10
-.L_cache_w7: movq 7*8(%rsi), %r11
-	movq %r8, 4*8(%rdi)
-	movq %r9, 5*8(%rdi)
-	movq %r10, 6*8(%rdi)
-	movq %r11, 7*8(%rdi)
-	leaq 64(%rsi), %rsi
-	leaq 64(%rdi), %rdi
-	decl %ecx
-	jnz .L_cache_w0
-
-	/* Are there any trailing 8-byte words? */
-.L_no_whole_cache_lines:
 	movl %edx, %ecx
 	andl $7, %edx
 	shrl $3, %ecx
 	jz .L_no_whole_words
 
-	/* Copy trailing words */
-.L_copy_trailing_words:
+.L_read_words:
 	movq (%rsi), %r8
-	mov %r8, (%rdi)
-	leaq 8(%rsi), %rsi
-	leaq 8(%rdi), %rdi
+.L_write_words:
+	movq %r8, (%rdi)
+	addq $8, %rsi
+	addq $8, %rdi
 	decl %ecx
-	jnz .L_copy_trailing_words
+	jnz .L_read_words
 
 	/* Any trailing bytes? */
 .L_no_whole_words:
@@ -264,38 +235,53 @@ ENTRY(memcpy_mcsafe_unrolled)
 
 	/* Copy trailing bytes */
 	movl %edx, %ecx
-.L_copy_trailing_bytes:
+.L_read_trailing_bytes:
 	movb (%rsi), %al
+.L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
 	incq %rdi
 	decl %ecx
-	jnz .L_copy_trailing_bytes
+	jnz .L_read_trailing_bytes
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
 	xorq %rax, %rax
 	ret
-ENDPROC(memcpy_mcsafe_unrolled)
-EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
+ENDPROC(__memcpy_mcsafe)
+EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
-	/* Return -EFAULT for any failure */
-.L_memcpy_mcsafe_fail:
-	mov	$-EFAULT, %rax
+	/*
+	 * Return number of bytes not copied for any failure. Note that
+	 * there is no "tail" handling since the source buffer is 8-byte
+	 * aligned and poison is cacheline aligned.
+	 */
+.E_read_words:
+	shll	$3, %ecx
+.E_leading_bytes:
+	addl	%edx, %ecx
+.E_trailing_bytes:
+	mov	%ecx, %eax
 	ret
 
+	/*
+	 * For write fault handling, given the destination is unaligned,
+	 * we handle faults on multi-byte writes with a byte-by-byte
+	 * copy up to the write-protected page.
+	 */
+.E_write_words:
+	shll	$3, %ecx
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
-	_ASM_EXTABLE_FAULT(.L_copy_leading_bytes, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w0, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w1, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w2, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w3, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w4, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w5, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w6, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_cache_w7, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_words, .L_memcpy_mcsafe_fail)
-	_ASM_EXTABLE_FAULT(.L_copy_trailing_bytes, .L_memcpy_mcsafe_fail)
+	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
+	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_write_words, .E_write_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 75d3776123cc..7ebc9901dd05 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -75,6 +75,27 @@ copy_user_handle_tail(char *to, char *from, unsigned len)
 	return len;
 }
 
+/*
+ * Similar to copy_user_handle_tail, probe for the write fault point,
+ * but reuse __memcpy_mcsafe in case a new read error is encountered.
+ * clac() is handled in _copy_to_iter_mcsafe().
+ */
+__visible unsigned long
+mcsafe_handle_tail(char *to, char *from, unsigned len)
+{
+	for (; len; --len, to++, from++) {
+		/*
+		 * Call the assembly routine back directly since
+		 * memcpy_mcsafe() may silently fallback to memcpy.
+		 */
+		unsigned long rem = __memcpy_mcsafe(to, from, 1);
+
+		if (rem)
+			break;
+	}
+	return len;
+}
+
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 30852270484f..2e96b34bc936 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -276,7 +276,8 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	if (rw == READ) {
 		if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align)))
 			return -EIO;
-		return memcpy_mcsafe(buf, nsio->addr + offset, size);
+		if (memcpy_mcsafe(buf, nsio->addr + offset, size) != 0)
+			return -EIO;
 	}
 
 	if (unlikely(is_bad_pmem(&nsio->bb, sector, sz_align))) {
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d714926ecf5..e023d6aa22b5 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -101,15 +101,15 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 		void *pmem_addr, unsigned int len)
 {
 	unsigned int chunk;
-	int rc;
+	unsigned long rem;
 	void *mem;
 
 	while (len) {
 		mem = kmap_atomic(page);
 		chunk = min_t(unsigned int, len, PAGE_SIZE);
-		rc = memcpy_mcsafe(mem + off, pmem_addr, chunk);
+		rem = memcpy_mcsafe(mem + off, pmem_addr, chunk);
 		kunmap_atomic(mem);
-		if (rc)
+		if (rem)
 			return BLK_STS_IOERR;
 		len -= chunk;
 		off = 0;
diff --git a/include/linux/string.h b/include/linux/string.h
index dd39a690c841..4a5a0eb7df51 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -147,8 +147,8 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_MEMCPY_MCSAFE
-static inline __must_check int memcpy_mcsafe(void *dst, const void *src,
-		size_t cnt)
+static inline __must_check unsigned long memcpy_mcsafe(void *dst,
+		const void *src, size_t cnt)
 {
 	memcpy(dst, src, cnt);
 	return 0;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index e67e12adb136..f5766e853a77 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -154,6 +154,12 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
 #define _copy_from_iter_flushcache _copy_from_iter_nocache
 #endif
 
+#ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
+size_t _copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i);
+#else
+#define _copy_to_iter_mcsafe _copy_to_iter
+#endif
+
 static __always_inline __must_check
 size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -163,6 +169,15 @@ size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
+static __always_inline __must_check
+size_t copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, false)))
+		return 0;
+	else
+		return _copy_to_iter_mcsafe(addr, bytes, i);
+}
+
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 970212670b6a..70ebc8ede143 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -573,6 +573,67 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(_copy_to_iter);
 
+#ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
+static int copyout_mcsafe(void __user *to, const void *from, size_t n)
+{
+	if (access_ok(VERIFY_WRITE, to, n)) {
+		kasan_check_read(from, n);
+		n = copy_to_user_mcsafe((__force void *) to, from, n);
+	}
+	return n;
+}
+
+static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
+		const char *from, size_t len)
+{
+	unsigned long ret;
+	char *to;
+
+	to = kmap_atomic(page);
+	ret = memcpy_mcsafe(to + offset, from, len);
+	kunmap_atomic(to);
+
+	return ret;
+}
+
+size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
+
+	if (unlikely(i->type & ITER_PIPE)) {
+		WARN_ON(1);
+		return 0;
+	}
+	if (iter_is_iovec(i))
+		might_fault();
+	iterate_and_advance(i, bytes, v,
+		copyout_mcsafe(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+		({
+		rem = memcpy_mcsafe_to_page(v.bv_page, v.bv_offset,
+                               (from += v.bv_len) - v.bv_len, v.bv_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
+		}),
+		({
+		rem = memcpy_mcsafe(v.iov_base, (from += v.iov_len) - v.iov_len,
+				v.iov_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
+		})
+	)
+
+	return bytes;
+}
+EXPORT_SYMBOL_GPL(_copy_to_iter_mcsafe);
+#endif /* CONFIG_ARCH_HAS_UACCESS_MCSAFE */
+
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
