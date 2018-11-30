Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E52C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7894C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJ0DH4bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7894C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLAJ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:58:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38307 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeLAJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:58:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so3104510pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uVZk7SQtJFMjv/lN3VwlZWHCXAo4mLpLSkWXzOfkMkQ=;
        b=CJ0DH4bfo305cnNREq0f2pxk3CxhFJt1q2AUDktCfqezV6vYxT6g9l2ZqYxXg1AaD2
         rmmJCsRe2kFhDeUTU8wi27OFYI+5Z116wLJR79F87fVVPFEGw1sBmQoQcZeUyEWA7mPm
         UL3MGARlAfewuLkTkUS0eClzEoEEuxnVeRC20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uVZk7SQtJFMjv/lN3VwlZWHCXAo4mLpLSkWXzOfkMkQ=;
        b=r6yCpLPZk3XIfcpX1lFm+h+VAo/Y5FNGygOPfEw8uWf0FMtVh8aBQpJ/t4RnJBKPlz
         PadIWArW5H5B7Q23b7pUpoBBhbZXe+YFmh1y4jnHswvc03toGvAgPj8DdekpGmI9mGYY
         CnA/drUCkrqAJLdR1TTs04XrYvgo3LFqEyWfCbmYuSeXpcsfxA7g/BkiCG9dgD/HJbKj
         nviMgFOZvgFLeC0UpsDzzL9yoFYQbe82D5psc3bU79qcaO5ROpwSGwjo1TF+5g3XEB+V
         91TueuNyU8hhE4b+IArFWstAzeLNX5RYaKSgTil8JP8//Lj0FlNJEf3rVF4vUzOh2g7f
         7R4A==
X-Gm-Message-State: AA+aEWbEAaYq07/fuH7LzE7lrqigG9l5XhXLgUuUvu8VjP6lXqbaEIpw
        7OS9b80JXiPUunv9doIToUYpwA==
X-Google-Smtp-Source: AFSGD/W49GhfIf6WvPc2xB7Bx4/iRXcrU+8+ynXwljMQjH1e2VF7FhRPNZ2DPDD9DQdODKe/kY8UEQ==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr6224934pge.437.1543618058229;
        Fri, 30 Nov 2018 14:47:38 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l3sm7548988pga.92.2018.11.30.14.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:47:37 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:47:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Convert buf_lock to semaphore
Message-ID: <20181130224736.GA38485@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of running with interrupts disabled, use a semaphore. This should
make it easier for backends that may need to sleep (e.g. EFI) when
performing a write:

|BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
|in_atomic(): 1, irqs_disabled(): 1, pid: 2236, name: sig-xstate-bum
|Preemption disabled at:
|[<ffffffff99d60512>] pstore_dump+0x72/0x330
|CPU: 26 PID: 2236 Comm: sig-xstate-bum Tainted: G      D           4.20.0-rc3 #45
|Call Trace:
| dump_stack+0x4f/0x6a
| ___might_sleep.cold.91+0xd3/0xe4
| __might_sleep+0x50/0x90
| wait_for_completion+0x32/0x130
| virt_efi_query_variable_info+0x14e/0x160
| efi_query_variable_store+0x51/0x1a0
| efivar_entry_set_safe+0xa3/0x1b0
| efi_pstore_write+0x109/0x140
| pstore_dump+0x11c/0x330
| kmsg_dump+0xa4/0xd0
| oops_exit+0x22/0x30
...

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 21b3ddd39fee ("efi: Don't use spinlocks for efi vars")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/nvram_64.c    |  2 --
 drivers/acpi/apei/erst.c          |  1 -
 drivers/firmware/efi/efi-pstore.c |  4 +--
 fs/pstore/platform.c              | 41 +++++++++++++++----------------
 fs/pstore/ram.c                   |  1 -
 include/linux/pstore.h            |  7 +++---
 6 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 22e9d281324d..e7d4ce6964ae 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -563,8 +563,6 @@ static int nvram_pstore_init(void)
 	nvram_pstore_info.buf = oops_data;
 	nvram_pstore_info.bufsize = oops_data_sz;
 
-	spin_lock_init(&nvram_pstore_info.buf_lock);
-
 	rc = pstore_register(&nvram_pstore_info);
 	if (rc && (rc != -EPERM))
 		/* Print error only when pstore.backend == nvram */
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index a5e1d963208e..9953e50667ec 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1176,7 +1176,6 @@ static int __init erst_init(void)
 	"Error Record Serialization Table (ERST) support is initialized.\n");
 
 	buf = kmalloc(erst_erange.size, GFP_KERNEL);
-	spin_lock_init(&erst_info.buf_lock);
 	if (buf) {
 		erst_info.buf = buf + sizeof(struct cper_pstore_record);
 		erst_info.bufsize = erst_erange.size -
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index cfe87b465819..0f7d97917197 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -259,8 +259,7 @@ static int efi_pstore_write(struct pstore_record *record)
 		efi_name[i] = name[i];
 
 	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
-			      !pstore_cannot_block_path(record->reason),
-			      record->size, record->psi->buf);
+			      preemptible(), record->size, record->psi->buf);
 
 	if (record->reason == KMSG_DUMP_OOPS)
 		efivar_run_worker();
@@ -369,7 +368,6 @@ static __init int efivars_pstore_init(void)
 		return -ENOMEM;
 
 	efi_pstore_info.bufsize = 1024;
-	spin_lock_init(&efi_pstore_info.buf_lock);
 
 	if (pstore_register(&efi_pstore_info)) {
 		kfree(efi_pstore_info.buf);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 2387cb74f729..afdfd3687f94 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -161,26 +161,27 @@ static const char *get_reason_str(enum kmsg_dump_reason reason)
 	}
 }
 
-bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
+/*
+ * Should pstore_dump() wait for a concurrent pstore_dump()? If
+ * not, the current pstore_dump() will report a failure to dump
+ * and return.
+ */
+static bool pstore_cannot_wait(enum kmsg_dump_reason reason)
 {
-	/*
-	 * In case of NMI path, pstore shouldn't be blocked
-	 * regardless of reason.
-	 */
+	/* In NMI path, pstore shouldn't block regardless of reason. */
 	if (in_nmi())
 		return true;
 
 	switch (reason) {
 	/* In panic case, other cpus are stopped by smp_send_stop(). */
 	case KMSG_DUMP_PANIC:
-	/* Emergency restart shouldn't be blocked by spin lock. */
+	/* Emergency restart shouldn't be blocked. */
 	case KMSG_DUMP_EMERG:
 		return true;
 	default:
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(pstore_cannot_block_path);
 
 #if IS_ENABLED(CONFIG_PSTORE_DEFLATE_COMPRESS)
 static int zbufsize_deflate(size_t size)
@@ -400,23 +401,20 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	unsigned long	total = 0;
 	const char	*why;
 	unsigned int	part = 1;
-	unsigned long	flags = 0;
-	int		is_locked;
 	int		ret;
 
 	why = get_reason_str(reason);
 
-	if (pstore_cannot_block_path(reason)) {
-		is_locked = spin_trylock_irqsave(&psinfo->buf_lock, flags);
-		if (!is_locked) {
-			pr_err("pstore dump routine blocked in %s path, may corrupt error record\n"
-				       , in_nmi() ? "NMI" : why);
+	if (down_trylock(&psinfo->buf_lock)) {
+		/* Failed to acquire lock: give up if we cannot wait. */
+		if (pstore_cannot_wait(reason)) {
+			pr_err("dump skipped in %s path: may corrupt error record\n",
+				in_nmi() ? "NMI" : why);
 			return;
 		}
-	} else {
-		spin_lock_irqsave(&psinfo->buf_lock, flags);
-		is_locked = 1;
+		down_interruptible(&psinfo->buf_lock);
 	}
+
 	oopscount++;
 	while (total < kmsg_bytes) {
 		char *dst;
@@ -433,7 +431,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.part = part;
 		record.buf = psinfo->buf;
 
-		if (big_oops_buf && is_locked) {
+		if (big_oops_buf) {
 			dst = big_oops_buf;
 			dst_size = big_oops_buf_sz;
 		} else {
@@ -451,7 +449,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 					  dst_size, &dump_size))
 			break;
 
-		if (big_oops_buf && is_locked) {
+		if (big_oops_buf) {
 			zipped_len = pstore_compress(dst, psinfo->buf,
 						header_size + dump_size,
 						psinfo->bufsize);
@@ -474,8 +472,8 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		total += record.size;
 		part++;
 	}
-	if (is_locked)
-		spin_unlock_irqrestore(&psinfo->buf_lock, flags);
+
+	up(&psinfo->buf_lock);
 }
 
 static struct kmsg_dumper pstore_dumper = {
@@ -594,6 +592,7 @@ int pstore_register(struct pstore_info *psi)
 		psi->write_user = pstore_write_user_compat;
 	psinfo = psi;
 	mutex_init(&psinfo->read_mutex);
+	sema_init(&psinfo->buf_lock, 1);
 	spin_unlock(&pstore_lock);
 
 	if (owner && !try_module_get(owner)) {
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 202eaa82bcc6..e6d9560ea455 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -815,7 +815,6 @@ static int ramoops_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto fail_clear;
 	}
-	spin_lock_init(&cxt->pstore.buf_lock);
 
 	cxt->pstore.flags = PSTORE_FLAGS_DMESG;
 	if (cxt->console_size)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index a9ec285d85d1..b146181e8709 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -26,7 +26,7 @@
 #include <linux/errno.h>
 #include <linux/kmsg_dump.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/semaphore.h>
 #include <linux/time.h>
 #include <linux/types.h>
 
@@ -99,7 +99,7 @@ struct pstore_record {
  * @owner:	module which is responsible for this backend driver
  * @name:	name of the backend driver
  *
- * @buf_lock:	spinlock to serialize access to @buf
+ * @buf_lock:	semaphore to serialize access to @buf
  * @buf:	preallocated crash dump buffer
  * @bufsize:	size of @buf available for crash dump bytes (must match
  *		smallest number of bytes available for writing to a
@@ -184,7 +184,7 @@ struct pstore_info {
 	struct module	*owner;
 	char		*name;
 
-	spinlock_t	buf_lock;
+	struct semaphore buf_lock;
 	char		*buf;
 	size_t		bufsize;
 
@@ -210,7 +210,6 @@ struct pstore_info {
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
-extern bool pstore_cannot_block_path(enum kmsg_dump_reason reason);
 
 struct pstore_ftrace_record {
 	unsigned long ip;
-- 
2.17.1


-- 
Kees Cook
