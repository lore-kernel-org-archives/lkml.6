Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeCTVb5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:31:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54766 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751557AbeCTVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:31:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [RFC PATCH 8/8] x86: vma: pass atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:26 +0800
Message-Id: <1521581486-99134-9-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds unnecessary to release mmap_sem in the middle of unmmaping
vdso map.

This is API change only.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/vdso/vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556..6359ae5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -192,7 +192,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-		do_munmap(mm, text_start, image->size, NULL);
+		do_munmap(mm, text_start, image->size, NULL, true);
 	} else {
 		current->mm->context.vdso = (void __user *)text_start;
 		current->mm->context.vdso_image = image;
-- 
1.8.3.1
