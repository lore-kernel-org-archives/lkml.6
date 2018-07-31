Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DDD20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLyAhVhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DDD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeGaS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:58:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeGaS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:58:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so6424224pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mr8SlKMMKOWqMOG5/RqK9f9XGsYcnxSMuRGnJK/CucU=;
        b=JLyAhVhGcAiy3rzm8sLZ7tPCODrsWKfLyDUpfHHgubx+5um96Xn4BBXWCzu4cLGaj8
         H+AVeHGJlw0jpCalPaScnRtvio97Af1j3O19YyYL8O18GF1v9LVE0DhWxOSMZ5Rl3Sko
         Y+B2Aayqk0hTWycVr3a1xWLR8ITWqNbKlk7JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mr8SlKMMKOWqMOG5/RqK9f9XGsYcnxSMuRGnJK/CucU=;
        b=e6wrPEGfNLvqvMLU5UGgU5EYFTNvnjYBrzEy+jUIaqdTiHr5f6Ag4YOVTe3vVrRUP2
         g5B4NxN8de4NZeBlqOxC7BooyqQSboByV66QbQq+CghhrrXImLRjSETlK6QGla37YftA
         /Gd43FF/yOTAqLUMMqj7R7jA7sT/YDExBBuBpY0TDLhT/9SwJpLvAqT+2up92Zkng0/D
         7v3nleV2MP+skc3or3BVNuLtZeFuy/+GLOFPfKDPKVAjjsKOgarZ3uIOjEMhH7ZKHTEu
         UEE32w2tAWuCPmyKWPsOKMgvmLquegbK4m0sb7OYF8IQRGQZx6jtJYTiuDKZjX8PYmt3
         mM2g==
X-Gm-Message-State: AOUpUlHtDJsCzNzVUq6I5/NqSVgKXhcUDEJEXfP3wE4mmpcan0z1i8Gr
        q6jtQk7PBZG0Wh+RTc1gE3de+xcgFxs=
X-Google-Smtp-Source: AAOMgpflYEO42li9iH5OxkY8mQuwLpEiSJXf3JUSCGAGhd5tb5739YZEvpyj3m1NyCogKdDHw6/Ukg==
X-Received: by 2002:aa7:850b:: with SMTP id v11-v6mr22763790pfn.165.1533057436022;
        Tue, 31 Jul 2018 10:17:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id y3-v6sm43577938pfi.24.2018.07.31.10.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 10:17:14 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>, aarcange@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hugh Dickins <hughd@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        youling 257 <youling257@gmail.com>
Subject: [PATCH] staging: ashmem: Fix SIGBUS crash when traversing mmaped ashmem pages
Date:   Tue, 31 Jul 2018 10:17:04 -0700
Message-Id: <1533057424-25933-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
References: <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Pundir and Youling in parallel reported crashes with recent
mainline kernels running Android:

F DEBUG   : *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
F DEBUG   : Build fingerprint:
'Android/db410c32_only/db410c32_only:Q/OC-MR1/102:userdebug/test-key
F DEBUG   : Revision: '0'
F DEBUG   : ABI: 'arm'
F DEBUG   : pid: 2261, tid: 2261, name: zygote  >>> zygote <<<
F DEBUG   : signal 7 (SIGBUS), code 2 (BUS_ADRERR), fault addr 0xec00008
... <snip> ...
F DEBUG   : backtrace:
F DEBUG   :     #00 pc 00001c04  /system/lib/libc.so (memset+48)
F DEBUG   :     #01 pc 0010c513  /system/lib/libart.so
(create_mspace_with_base+82)
F DEBUG   :     #02 pc 0015c601  /system/lib/libart.so
(art::gc::space::DlMallocSpace::CreateMspace(void*, unsigned int,
unsigned int)+40)
F DEBUG   :     #03 pc 0015c3ed  /system/lib/libart.so
(art::gc::space::DlMallocSpace::CreateFromMemMap(art::MemMap*,
std::__1::basic_string<char, std::__
1::char_traits<char>, std::__1::allocator<char>> const&, unsigned int,
unsigned int, unsigned int, unsigned int, bool)+36)
...

This was bisected back to commit bfd40eaff5ab ("mm: fix vma_is_anonymous()
false-positives").

create_mspace_with_base() in the trace above, utilizes ashmem, and
with ashmem, for shared mappings we use shmem_zero_setup(), which sets
the vma->vm_ops to &shmem_vm_ops. But for private ashmem mappings
nothing sets the vma->vm_ops.

Looking at the problematic patch, it seems to add a requirement that
one call vma_set_anonymous() on a vma, otherwise the dummy_vm_ops will
be used. Using the dummy_vm_ops seem to triggger SIGBUS when traversing
unmapped pages.

Thus, this patch adds a call to vma_set_anonymous() for ashmem private
mappings and seems to avoid the reported problem.

Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: aarcange@redhat.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Colin Cross <ccross@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: youling 257 <youling257@gmail.com>
Fixes: bfd40eaff5ab ("mm: fix vma_is_anonymous() false-positives")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Reported-by: Youling 257 <youling257@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---

Hopefully my explanation make sense here. Please let me know if it
needs corrections.
thanks
-john

---
 drivers/staging/android/ashmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index a1a0025..d5d33e1 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -402,6 +402,8 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 			fput(asma->file);
 			goto out;
 		}
+	} else {
+		vma_set_anonymous(vma);
 	}
 
 	if (vma->vm_file)
-- 
2.7.4

