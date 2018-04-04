Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDDLCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:02:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:02:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm: fix header file if/else/endif maze, again
Date: Wed,  4 Apr 2018 13:02:15 +0200
Message-Id: <20180404110236.804484-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:AjSem3M4QFj2sbyv/g/BJZ7YLu/aXJLUZxdKnTt3lE44DyQYdSb
 8JASsnboKQZd9qgVvhVWAJW2+xuozXq6G1hOKy0Wqq+EgNJNus31B42/blWxBmsLlWOJWCk
 r9jcG8D7N8HVKy0kIPQ4jD6BMsC90Kc61vhHXTZfxBxlPoqOkWl6zIG0YuRbdQePGsYvPPg
 JDp7JTwUBtTnV4g09Ip7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:coonID6VBzE=:7KKWGZ72uf01L5nG1NzW+v
 c7DgWu1HZwJ9mRPdGiPmv8VVFhpK6YFYD5/u3hHIfNWSPCcxYSHCRH//6a7chjtQXggPk449d
 WxzmHjd7NWr0Rcw9b2hZP3/jHRfghJvldX600jloEV6/9CEVn7sBssvS4VlLDRTlcqM2TPMhG
 he+5H9JM4sXevGn4lfvQvYadDq71KvIo1K5l13UnIxUYcP6Sw7v1/ceAIjDjPQB9INLsGnRx9
 /3O2n+Rjr8NCeXSYISe5JUPAsKAFTWec/qQc11HZV3z3ndsP0wtN14UPwFssxBnKdNzq/+K63
 4xnvT0lVVt/Ee75w8ds1ozn8c+w1iBNdHZj2moOCYh7wfcu9FfLvtnwHncvSAE8wG5Uhme9uU
 2yVXWrMhNZBwubZ0ath3RXLJldqg89iirkMx74/U2nIOOAZLqDRgyshW00xDCk26stvFOYjci
 kdqOjbe6AUBbgofWNutmBMFckfuOMjPvo2l/Yd9AOipzCC9lsVGvJH0hjQukuh5zyf0DOuT+R
 uFctC5paKRReXFzb0QDpavpMKVua0G0nRtCtXtkPiF00CFaDy6iIAQC3Osi1crICXp0AkKE8E
 ufPRQHaraE4TF7cua5Qe6Su5AROc+kCpXt6GgfGQ7gn/XrfBxGFrYSTLR1PICBtaVnOMCXWnm
 SEaBwWjPFiOlAG1qNCM+34aEEymDb2dol4/wuCW5M24WeVwK7XmNWZVbBHozYw1Cec0frQxgx
 Qbm87qnFWj86t2mLZQUFoCToRt/riyLTF5ea0g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last fix was still wrong, as we need the inline dummy functions
also for the case that CONFIG_HMM is enabled but CONFIG_HMM_MIRROR
is not:

kernel/fork.o: In function `__mmdrop':
fork.c:(.text+0x14f6): undefined reference to `hmm_mm_destroy'

This adds back the second copy of the dummy functions, hopefully
this time in the right place.

Fixes: 8900d06a277a ("mm/hmm: fix header file if/else/endif maze")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hmm.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 5d26e0a223d9..39988924de3a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -376,8 +376,18 @@ bool hmm_vma_range_done(struct hmm_range *range);
  * See the function description in mm/hmm.c for further documentation.
  */
 int hmm_vma_fault(struct hmm_range *range, bool block);
-#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
+/* Below are for HMM internal use only! Not to be used by device driver! */
+void hmm_mm_destroy(struct mm_struct *mm);
+
+static inline void hmm_mm_init(struct mm_struct *mm)
+{
+	mm->hmm = NULL;
+}
+#else /* IS_ENABLED(CONFIG_HMM_MIRROR) */
+static inline void hmm_mm_destroy(struct mm_struct *mm) {}
+static inline void hmm_mm_init(struct mm_struct *mm) {}
+#endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE) ||  IS_ENABLED(CONFIG_DEVICE_PUBLIC)
 struct hmm_devmem;
@@ -550,16 +560,9 @@ struct hmm_device {
 struct hmm_device *hmm_device_new(void *drvdata);
 void hmm_device_put(struct hmm_device *hmm_device);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-
-/* Below are for HMM internal use only! Not to be used by device driver! */
-void hmm_mm_destroy(struct mm_struct *mm);
-
-static inline void hmm_mm_init(struct mm_struct *mm)
-{
-	mm->hmm = NULL;
-}
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
 static inline void hmm_mm_init(struct mm_struct *mm) {}
 #endif /* IS_ENABLED(CONFIG_HMM) */
+
 #endif /* LINUX_HMM_H */
-- 
2.9.0
