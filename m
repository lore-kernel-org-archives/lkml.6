Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC75820651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eLvAt7Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394407AbfAPQ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:59:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17345 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfAPQ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:59:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ftjB4Kcjz9vBmN;
        Wed, 16 Jan 2019 17:59:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eLvAt7Bq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1y33t7ubUemJ; Wed, 16 Jan 2019 17:59:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ftjB3GBBz9vBmJ;
        Wed, 16 Jan 2019 17:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1547657966; bh=VClA1koYN/8UB1kz/FeELweQ5cMzF1pBl+1hJ48rHrs=;
        h=From:Subject:To:Cc:Date:From;
        b=eLvAt7BqtYsxN7kNzsTn3yCzQeJgXW/pvrjCRLWQQ+Rx6by4eR4OaEJxaMf4xrbET
         FQPUhr3MjsHuIZLRxf2Pz0xRhQ1V3U3082He6sRkmK9YzwfMpNOArgKFNnb2OSCtzl
         KimuUtlrI8GCG37yM7y6uPutILgDbNlGXG28AO5Q=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E9D68B84C;
        Wed, 16 Jan 2019 17:59:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2W1rUcGyGM6V; Wed, 16 Jan 2019 17:59:27 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C98BD8B848;
        Wed, 16 Jan 2019 17:59:27 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6A6F37187C; Wed, 16 Jan 2019 16:59:27 +0000 (UTC)
Message-Id: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] mm: add probe_user_read()
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Wed, 16 Jan 2019 16:59:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In powerpc code, there are several places implementing safe
access to user data. This is sometimes implemented using
probe_kernel_address() with additional access_ok() verification,
sometimes with get_user() enclosed in a pagefault_disable()/enable()
pair, etc. :
    show_user_instructions()
    bad_stack_expansion()
    p9_hmi_special_emu()
    fsl_pci_mcheck_exception()
    read_user_stack_64()
    read_user_stack_32() on PPC64
    read_user_stack_32() on PPC32
    power_pmu_bhrb_to()

In the same spirit as probe_kernel_read(), this patch adds
probe_user_read().

probe_user_read() does the same as probe_kernel_read() but
first checks that it is really a user address.

The patch defines this function as a static inline so the "size"
variable can be examined for const-ness by the check_object_size()
in __copy_from_user_inatomic()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: Moved 'Returns:" comment after description.
     Explained in the commit log why the function is defined static inline

 v2: Added "Returns:" comment and removed probe_user_address()

 include/linux/uaccess.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e8df13..ef99edd63da3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
+/**
+ * probe_user_read(): safely attempt to read from a user location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from
+ * @size: size of the data chunk
+ *
+ * Safely read from address @src to the buffer at @dst.  If a kernel fault
+ * happens, handle that and return -EFAULT.
+ *
+ * We ensure that the copy_from_user is executed in atomic context so that
+ * do_page_fault() doesn't attempt to take mmap_sem.  This makes
+ * probe_user_read() suitable for use within regions where the caller
+ * already holds mmap_sem, or other locks which nest inside mmap_sem.
+ *
+ * Returns: 0 on success, -EFAULT on error.
+ */
+
+#ifndef probe_user_read
+static __always_inline long probe_user_read(void *dst, const void __user *src,
+					    size_t size)
+{
+	long ret;
+
+	if (!access_ok(src, size))
+		return -EFAULT;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+#endif
+
 #ifndef user_access_begin
 #define user_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
-- 
2.13.3

