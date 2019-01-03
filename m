Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD92C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB62217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkip1umk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfACOcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:32:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbfACOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:32:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so16067355pgp.13;
        Thu, 03 Jan 2019 06:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPJumJ/ohwlthM0jS0UnPH6ZGUkW7vBJmnCc4y48ckw=;
        b=mkip1umkG9dZrIPl+GdCUoYYoeKzf7AE1ZORUc3EQRjPgnGXVpdM0l/N13+D2Q8Czc
         29kSYL3CLtCllzwSIH85lwgsnXDMOQT1M8TcD+x6JsL7cUNv/yikAnCmHvQUDcw5L88r
         HlLwsRd9ai248MOdq1uVkvZf9HNoj0BQJY5RmBAuVN0U370uWm6fSS2YQUdqS/n+JzrL
         hQRwZhtGQgncU2VKVbDvRcRcWBlk2CvnaqPG2/gMcMqHaBHBE3X1d+jU4QvdVZ8/ZwzU
         CqWH9IDKlL78zF4XEnmfKlT6j3G0prKM0cm7VWAlegjxt1aPf6GZXDXWWRbfFqEGNInI
         1FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPJumJ/ohwlthM0jS0UnPH6ZGUkW7vBJmnCc4y48ckw=;
        b=YWHXdUybQ44jx0fCR89h3+SpCl0nWXgD/zpwTYoliXhGWxuSuNc393ZdNtmXQ2wWQz
         +rDMFkO9XLNvBJm9BpFF5VxwXyc+cBm9ISPq/M3WTkZpfjfiN/eEcsJTpNShnkrEcpc2
         32wqH86Uul1i6P2Cszrd1MCeiL0oX5sfPZBsEOGMRozk04BydaoK3pVHiob7CMALzGiP
         n4u01uIe/WPm5dNUWE335v5q9qYzK6G+SYm1LvSUpb/WwX+eh2BsXNZOZItCpaS2N/oF
         +q/HrEckZbZYKjiZAn5M98Mqo0AgIoNkPTqYClolmR2i8tqV+eFy3XNYRp06AUgsZ8/f
         W3Nw==
X-Gm-Message-State: AJcUukfj6TvVlUQUPYm5MUe8ZglGHwpvvAuTV0VIVeYmD4Ot603V5WZh
        y7rogYHXqqSuXXgBH3NG2Tg=
X-Google-Smtp-Source: ALg8bN7DMu3txA46sQrVoCo77Y3E/12yPYWg3fG1H4acZLPeBhKB4M9sR0Fyzvenx4EEc6CpFM7DPA==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr16515176pgm.1.1546525969653;
        Thu, 03 Jan 2019 06:32:49 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x3sm184403100pgt.45.2019.01.03.06.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 06:32:48 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/5] PM / hibernate: Generate and verify signature for snapshot image
Date:   Thu,  3 Jan 2019 22:32:24 +0800
Message-Id: <20190103143227.9138-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190103143227.9138-1-jlee@suse.com>
References: <20190103143227.9138-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When producing memory snapshot image, hibernation uses HMAC-SHA512
with snapshot key (from TPM trusted key) to calculate the hash of
all data pages in snapshot image. The hash result will be kept in the
snapshot header as the image signature. Before hibernation restores
image, kernel executes HMAC-SHA512 again and compares the result with
the signature in the header to verify the integrity of snapshot image.

If the verification failed, the resume process will be stopped. Then
the snapshot image will be discarded and system will boot as normal.

On the other hand, a trampoline page be created in snapshot image
when hibernation. This trampoline page be used to forward the state of
snapshot key and the result of snapshot image verification from boot
kernel to image kernel when resuming. The trampoline page will also be
used to forward the snapshot key in the later patch.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 kernel/power/hibernate.c |  18 ++-
 kernel/power/power.h     |  26 ++++
 kernel/power/snapshot.c  | 387 +++++++++++++++++++++++++++++++++++++++++++++--
 kernel/power/swap.c      |   6 +
 kernel/power/user.c      |  12 ++
 5 files changed, 432 insertions(+), 17 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index ecc31e8e40d0..0dda6a9f0af1 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -271,10 +271,14 @@ static int create_image(int platform_mode)
 {
 	int error;
 
+	error = snapshot_prepare_hash(false);
+	if (error)
+		return error;
+
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
 		pr_err("Some devices failed to power down, aborting hibernation\n");
-		return error;
+		goto finish_hash;
 	}
 
 	error = platform_pre_snapshot(platform_mode);
@@ -331,6 +335,9 @@ static int create_image(int platform_mode)
 	dpm_resume_start(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
+ finish_hash:
+	snapshot_finish_hash();
+
 	return error;
 }
 
@@ -694,6 +701,14 @@ int hibernate(void)
 		return -EPERM;
 	}
 
+	error = snapshot_key_init();
+	if (error)
+		return error;
+
+	error = snapshot_create_trampoline();
+	if (error)
+		return error;
+
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
@@ -750,6 +765,7 @@ int hibernate(void)
 		pm_restore_gfp_mask();
 	} else {
 		pm_pr_dbg("Image restored successfully.\n");
+		snapshot_restore_trampoline();
 	}
 
  Free_bitmaps:
diff --git a/kernel/power/power.h b/kernel/power/power.h
index fe2dfa0d4d36..c614b0a294e3 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -11,6 +11,10 @@
 #define SNAPSHOT_KEY_SIZE SHA512_DIGEST_SIZE
 #define DERIVED_KEY_SIZE SHA512_DIGEST_SIZE
 
+/* HMAC algorithm for hibernate snapshot signature */
+#define SNAPSHOT_HMAC	"hmac(sha512)"
+#define SNAPSHOT_DIGEST_SIZE	SHA512_DIGEST_SIZE
+
 struct swsusp_info {
 	struct new_utsname	uts;
 	u32			version_code;
@@ -19,6 +23,17 @@ struct swsusp_info {
 	unsigned long		image_pages;
 	unsigned long		pages;
 	unsigned long		size;
+	unsigned long		trampoline_pfn;
+	u8			signature[SNAPSHOT_DIGEST_SIZE];
+} __aligned(PAGE_SIZE);
+
+/*
+ * The trampoline page is used to forward information
+ * from boot kernel to image kernel in restore stage.
+ */
+struct trampoline {
+	bool snapshot_key_valid;
+	int sig_verify_ret;
 } __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_HIBERNATION
@@ -27,12 +42,19 @@ extern void __init hibernate_reserved_size_init(void);
 extern void __init hibernate_image_size_init(void);
 
 #ifdef CONFIG_HIBERNATION_ENC_AUTH
+/* kernel/power/snapshot.c */
+extern int snapshot_image_verify_decrypt(void);
+extern int snapshot_prepare_hash(bool may_sleep);
+extern void snapshot_finish_hash(void);
 /* kernel/power/snapshot_key.c */
 extern int snapshot_key_init(void);
 extern bool snapshot_key_initialized(void);
 extern int snapshot_get_auth_key(u8 *auth_key, bool may_sleep);
 extern int snapshot_get_enc_key(u8 *enc_key, bool may_sleep);
 #else
+static inline int snapshot_image_verify_decrypt(void) { return 0; }
+static inline int snapshot_prepare_hash(bool may_sleep) { return 0; }
+static inline void snapshot_finish_hash(void) {}
 static inline int snapshot_key_init(void) { return 0; }
 #endif	/* !CONFIG_HIBERNATION_ENC_AUTH */
 
@@ -171,6 +193,10 @@ extern int snapshot_read_next(struct snapshot_handle *handle);
 extern int snapshot_write_next(struct snapshot_handle *handle);
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
+extern int snapshot_create_trampoline(void);
+extern void snapshot_init_trampoline(void);
+extern void snapshot_restore_trampoline(void);
+extern void snapshot_free_trampoline(void);
 
 /* If unset, the snapshot device cannot be open. */
 extern atomic_t snapshot_device_available;
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 640b2034edd6..e817c035f378 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -33,12 +33,16 @@
 #include <linux/compiler.h>
 #include <linux/ktime.h>
 #include <linux/set_memory.h>
+#include <linux/vmalloc.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#ifdef CONFIG_HIBERNATION_ENC_AUTH
+#include <crypto/hash.h>
+#endif
 
 #include "power.h"
 
@@ -79,6 +83,15 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
 static inline void hibernate_restore_unprotect_page(void *page_address) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
+/* the trampoline is used by image kernel */
+static void *trampoline_virt;
+
+/* trampoline pfn from swsusp_info in snapshot for snapshot_write_next() */
+static unsigned long trampoline_pfn;
+
+/* Keep the buffer for foward page in snapshot_write_next() */
+static void *trampoline_buff;
+
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
@@ -1393,8 +1406,246 @@ static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 }
 #endif /* CONFIG_HIGHMEM */
 
-static void copy_data_pages(struct memory_bitmap *copy_bm,
-			    struct memory_bitmap *orig_bm)
+/* Total number of image pages */
+static unsigned int nr_copy_pages;
+
+/* Point array for collecting buffers' address in snapshot_write_next() */
+static void **h_buf;
+
+#ifdef CONFIG_HIBERNATION_ENC_AUTH
+/*
+ * Signature of snapshot image
+ */
+static u8 signature[SNAPSHOT_DIGEST_SIZE];
+
+/* Keep the signature verification result for trampoline */
+static int sig_verify_ret;
+
+/* keep the snapshot key status for trampoline */
+static bool snapshot_key_valid;
+
+static u8 *s4_verify_digest;
+static struct shash_desc *s4_verify_desc;
+
+int snapshot_prepare_hash(bool may_sleep)
+{
+	char auth_key[DERIVED_KEY_SIZE];
+	struct crypto_shash *tfm;
+	size_t digest_size, desc_size;
+	int ret;
+
+	ret = snapshot_get_auth_key(auth_key, may_sleep);
+	if (ret) {
+		pr_warn_once("auth key is invalid: %d\n", ret);
+		return -EINVAL;
+	}
+	snapshot_key_valid = true;
+
+	tfm = crypto_alloc_shash(SNAPSHOT_HMAC, 0, 0);
+	if (IS_ERR(tfm)) {
+		pr_err("Allocate HMAC failed: %ld\n", PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	ret = crypto_shash_setkey(tfm, auth_key, DERIVED_KEY_SIZE);
+	if (ret) {
+		pr_err("Set HMAC key failed\n");
+		goto error;
+	}
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*s4_verify_desc);
+	digest_size = crypto_shash_digestsize(tfm);
+	s4_verify_digest = kzalloc(digest_size + desc_size,
+				   may_sleep ? GFP_KERNEL : GFP_ATOMIC);
+	if (!s4_verify_digest) {
+		pr_err("Allocate digest failed\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	s4_verify_desc = (void *) s4_verify_digest + digest_size;
+	s4_verify_desc->tfm = tfm;
+	if (may_sleep)
+		s4_verify_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	ret = crypto_shash_init(s4_verify_desc);
+	if (ret < 0)
+		goto free_shash;
+
+	return 0;
+
+ free_shash:
+	kfree(s4_verify_digest);
+ error:
+	crypto_free_shash(tfm);
+	s4_verify_digest = NULL;
+	s4_verify_desc = NULL;
+	return ret;
+}
+
+void snapshot_finish_hash(void)
+{
+	if (s4_verify_desc)
+		crypto_free_shash(s4_verify_desc->tfm);
+	kfree(s4_verify_digest);
+	s4_verify_desc = NULL;
+	s4_verify_digest = NULL;
+}
+
+int snapshot_image_verify_decrypt(void)
+{
+	int ret, i;
+
+	if (!h_buf) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = snapshot_key_init();
+	if (ret)
+		goto error_prep;
+
+	ret = snapshot_prepare_hash(true);
+	if (ret || !s4_verify_desc)
+		goto error_prep;
+
+	for (i = 0; i < nr_copy_pages; i++) {
+		ret = crypto_shash_update(s4_verify_desc, *(h_buf + i), PAGE_SIZE);
+		if (ret)
+			goto error_shash;
+	}
+
+	ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
+	if (ret)
+		goto error_shash;
+
+	pr_debug("Signature %*phN\n", SNAPSHOT_DIGEST_SIZE, signature);
+	pr_debug("Digest    %*phN\n", SNAPSHOT_DIGEST_SIZE, s4_verify_digest);
+	if (memcmp(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE))
+		ret = -EKEYREJECTED;
+
+ error_shash:
+	snapshot_finish_hash();
+
+ error_prep:
+	vfree(h_buf);
+	if (ret)
+		pr_warn("Signature verification failed: %d\n", ret);
+ error:
+	sig_verify_ret = ret;
+	return ret;
+}
+
+static int
+__copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
+{
+	unsigned long pfn, dst_pfn;
+	struct page *d_page;
+	void *crypto_buffer = NULL;
+	int ret = 0;
+
+	memory_bm_position_reset(orig_bm);
+	memory_bm_position_reset(copy_bm);
+	for (;;) {
+		pfn = memory_bm_next_pfn(orig_bm);
+		if (unlikely(pfn == BM_END_OF_MAP))
+			break;
+		dst_pfn = memory_bm_next_pfn(copy_bm);
+		copy_data_page(dst_pfn, pfn);
+
+		/* Setup buffer */
+		d_page = pfn_to_page(dst_pfn);
+		if (PageHighMem(d_page)) {
+			void *kaddr = kmap_atomic(d_page);
+
+			copy_page(buffer, kaddr);
+			kunmap_atomic(kaddr);
+			crypto_buffer = buffer;
+		} else {
+			crypto_buffer = page_address(d_page);
+		}
+
+		/* Generate digest */
+		if (!s4_verify_desc)
+			continue;
+		ret = crypto_shash_update(s4_verify_desc, crypto_buffer,
+					  PAGE_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	if (s4_verify_desc) {
+		ret = crypto_shash_final(s4_verify_desc, s4_verify_digest);
+		if (ret)
+			return ret;
+
+		memset(signature, 0, SNAPSHOT_DIGEST_SIZE);
+		memcpy(signature, s4_verify_digest, SNAPSHOT_DIGEST_SIZE);
+	}
+
+	return 0;
+}
+
+static void alloc_h_buf(void)
+{
+	h_buf = vmalloc(sizeof(void *) * nr_copy_pages);
+	if (!h_buf)
+		pr_err("Allocate buffer point array failed\n");
+}
+
+static void init_signature(struct swsusp_info *info)
+{
+	memcpy(info->signature, signature, SNAPSHOT_DIGEST_SIZE);
+}
+
+static void load_signature(struct swsusp_info *info)
+{
+	memset(signature, 0, SNAPSHOT_DIGEST_SIZE);
+	memcpy(signature, info->signature, SNAPSHOT_DIGEST_SIZE);
+}
+
+static void init_sig_verify(struct trampoline *t)
+{
+	t->sig_verify_ret = sig_verify_ret;
+	t->snapshot_key_valid = snapshot_key_valid;
+	sig_verify_ret = 0;
+	snapshot_key_valid = 0;
+}
+
+static void handle_sig_verify(struct trampoline *t)
+{
+	if (t->sig_verify_ret)
+		pr_warn("Signature verification failed: %d\n",
+			t->sig_verify_ret);
+	else if (t->snapshot_key_valid)
+		pr_info("Signature verification passed.\n");
+}
+#else
+static int
+__copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
+{
+	unsigned long pfn;
+
+	memory_bm_position_reset(orig_bm);
+	memory_bm_position_reset(copy_bm);
+	for (;;) {
+		pfn = memory_bm_next_pfn(orig_bm);
+		if (unlikely(pfn == BM_END_OF_MAP))
+			break;
+		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
+	}
+
+	return 0;
+}
+
+static inline void alloc_h_buf(void) {}
+static inline void init_signature(struct swsusp_info *info) {}
+static inline void load_signature(struct swsusp_info *info) {}
+static inline void init_sig_verify(struct trampoline *t) {}
+static inline void handle_sig_verify(struct trampoline *t) {}
+#endif /* !CONFIG_HIBERNATION_ENC_AUTH */
+
+static int copy_data_pages(struct memory_bitmap *copy_bm,
+			   struct memory_bitmap *orig_bm)
 {
 	struct zone *zone;
 	unsigned long pfn;
@@ -1408,18 +1659,9 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
 			if (page_is_saveable(zone, pfn))
 				memory_bm_set_bit(orig_bm, pfn);
 	}
-	memory_bm_position_reset(orig_bm);
-	memory_bm_position_reset(copy_bm);
-	for(;;) {
-		pfn = memory_bm_next_pfn(orig_bm);
-		if (unlikely(pfn == BM_END_OF_MAP))
-			break;
-		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
-	}
+	return __copy_data_pages(copy_bm, orig_bm);
 }
 
-/* Total number of image pages */
-static unsigned int nr_copy_pages;
 /* Number of pages needed for saving the original pfns of the image pages */
 static unsigned int nr_meta_pages;
 /*
@@ -1961,6 +2203,7 @@ static int swsusp_alloc(struct memory_bitmap *copy_bm,
 asmlinkage __visible int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
+	int ret;
 
 	pr_info("Creating hibernation image:\n");
 
@@ -1984,7 +2227,11 @@ asmlinkage __visible int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
-	copy_data_pages(&copy_bm, &orig_bm);
+	ret = copy_data_pages(&copy_bm, &orig_bm);
+	if (ret) {
+		pr_err("Copy data pages failed\n");
+		return ret;
+	}
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -2038,10 +2285,98 @@ static int init_header(struct swsusp_info *info)
 	info->pages = snapshot_get_image_size();
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
+	info->trampoline_pfn = page_to_pfn(virt_to_page(trampoline_virt));
+	init_signature(info);
 	return init_header_complete(info);
 }
 
 /**
+ * create trampoline - Create a trampoline page before snapshot be created
+ * In hibernation process, this routine will be called by kernel before
+ * the snapshot image be created. It can be used in resuming process.
+ */
+int snapshot_create_trampoline(void)
+{
+	if (trampoline_virt) {
+		pr_warn("Tried to create trampoline again\n");
+		return 0;
+	}
+
+	trampoline_virt = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!trampoline_virt) {
+		pr_err("Allocate trampoline page failed\n");
+		return -ENOMEM;
+	}
+	trampoline_pfn = 0;
+	trampoline_buff = NULL;
+
+	return 0;
+}
+
+/**
+ * initial trampoline - Put data to trampoline buffer for target kernel
+ *
+ * In resuming process, this routine will be called by boot kernel before
+ * the target kernel be restored. The boot kernel uses trampoline buffer
+ * to transfer information to target kernel.
+ */
+void snapshot_init_trampoline(void)
+{
+	struct trampoline *t;
+
+	if (!trampoline_pfn || !trampoline_buff) {
+		pr_err("Did not find trampoline buffer, pfn: %ld\n",
+			trampoline_pfn);
+		return;
+	}
+
+	hibernate_restore_unprotect_page(trampoline_buff);
+	memset(trampoline_buff, 0, PAGE_SIZE);
+	t = (struct trampoline *)trampoline_buff;
+
+	init_sig_verify(t);
+
+	pr_info("Hibernation trampoline page prepared\n");
+}
+
+/**
+ * restore trampoline - Handle the data from boot kernel and free.
+ *
+ * In resuming process, this routine will be called by target kernel
+ * after target kernel is restored. The target kernel handles
+ * the data in trampoline that it is transferred from boot kernel.
+ */
+void snapshot_restore_trampoline(void)
+{
+	struct trampoline *t;
+
+	if (!trampoline_virt) {
+		pr_err("Doesn't have trampoline page\n");
+		return;
+	}
+
+	t = (struct trampoline *)trampoline_virt;
+
+	handle_sig_verify(t);
+	snapshot_free_trampoline();
+}
+
+void snapshot_free_trampoline(void)
+{
+	if (!trampoline_virt) {
+		pr_err("No trampoline page can be freed\n");
+		return;
+	}
+
+	trampoline_pfn = 0;
+	trampoline_buff = NULL;
+	memset(trampoline_virt, 0, PAGE_SIZE);
+	free_page((unsigned long)trampoline_virt);
+	trampoline_virt = NULL;
+	pr_info("Trampoline freed\n");
+}
+
+/**
  * pack_pfns - Prepare PFNs for saving.
  * @bm: Memory bitmap.
  * @buf: Memory buffer to store the PFNs in.
@@ -2188,6 +2523,8 @@ static int load_header(struct swsusp_info *info)
 	if (!error) {
 		nr_copy_pages = info->image_pages;
 		nr_meta_pages = info->pages - info->image_pages - 1;
+		trampoline_pfn = info->trampoline_pfn;
+		load_signature(info);
 	}
 	return error;
 }
@@ -2521,7 +2858,8 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
  * Get the address that snapshot_write_next() should return to its caller to
  * write to.
  */
-static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
+static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca,
+			unsigned long *pfn_out)
 {
 	struct pbe *pbe;
 	struct page *page;
@@ -2530,6 +2868,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 	if (pfn == BM_END_OF_MAP)
 		return ERR_PTR(-EFAULT);
 
+	if (pfn_out)
+		*pfn_out = pfn;
+
 	page = pfn_to_page(pfn);
 	if (PageHighMem(page))
 		return get_highmem_page_buffer(page, ca);
@@ -2577,6 +2918,7 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 int snapshot_write_next(struct snapshot_handle *handle)
 {
 	static struct chain_allocator ca;
+	unsigned long pfn;
 	int error = 0;
 
 	/* Check if we have already loaded the entire image */
@@ -2601,6 +2943,12 @@ int snapshot_write_next(struct snapshot_handle *handle)
 
 		safe_pages_list = NULL;
 
+		/* Allocate buffer point array for generating
+		 * digest to compare with signature.
+		 * h_buf will freed in snapshot_image_verify_decrypt().
+		 */
+		alloc_h_buf();
+
 		error = memory_bm_create(&copy_bm, GFP_ATOMIC, PG_ANY);
 		if (error)
 			return error;
@@ -2624,21 +2972,28 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			chain_init(&ca, GFP_ATOMIC, PG_SAFE);
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
-			handle->buffer = get_buffer(&orig_bm, &ca);
+			handle->buffer = get_buffer(&orig_bm, &ca, &pfn);
 			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
+			if (h_buf)
+				*h_buf = handle->buffer;
 		}
 	} else {
 		copy_last_highmem_page();
 		/* Restore page key for data page (s390 only). */
 		page_key_write(handle->buffer);
 		hibernate_restore_protect_page(handle->buffer);
-		handle->buffer = get_buffer(&orig_bm, &ca);
+		handle->buffer = get_buffer(&orig_bm, &ca, &pfn);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
 		if (handle->buffer != buffer)
 			handle->sync_read = 0;
+		/* Capture the trampoline for transfer data */
+		if (pfn == trampoline_pfn && trampoline_pfn)
+			trampoline_buff = handle->buffer;
+		if (h_buf)
+			*(h_buf + (handle->cur - nr_meta_pages - 1)) = handle->buffer;
 	}
 	handle->cur++;
 	return PAGE_SIZE;
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index d7f6c1a288d3..2e669f589830 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1095,6 +1095,9 @@ static int load_image(struct swap_map_handle *handle,
 		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
+		if (!ret)
+			ret = snapshot_image_verify_decrypt();
+		snapshot_init_trampoline();
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
 	return ret;
@@ -1447,6 +1450,9 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				}
 			}
 		}
+		if (!ret)
+			ret = snapshot_image_verify_decrypt();
+		snapshot_init_trampoline();
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
 out_clean:
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..d5c8f777e8d8 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -248,6 +248,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (!data->frozen || data->ready)
 			break;
 		pm_restore_gfp_mask();
+		snapshot_restore_trampoline();
 		free_basic_memory_bitmaps();
 		data->free_bitmaps = false;
 		thaw_processes();
@@ -259,6 +260,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		error = snapshot_key_init();
+		if (error)
+			return error;
+		error = snapshot_create_trampoline();
+		if (error)
+			return error;
 		pm_restore_gfp_mask();
 		error = hibernation_snapshot(data->platform_support);
 		if (!error) {
@@ -275,6 +282,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		if (snapshot_image_verify_decrypt()) {
+			error = -EPERM;
+			break;
+		}
+		snapshot_init_trampoline();
 		error = hibernation_restore(data->platform_support);
 		break;
 
-- 
2.13.6

