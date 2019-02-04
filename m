Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6EC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8272082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJsYf7z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfBDSPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:15:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfBDSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so251798pgp.13;
        Mon, 04 Feb 2019 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zqElbD91wN7xrII3yrqdT2po60YKbiGuJ5EuHOboq08=;
        b=oJsYf7z38AP8TbCH80dOcCkJYlGDdhpEscQ3nBiPGAezSpQoznfn6yaatFIh56rLa3
         WQTC59TkQ38+viuHQYO8ZTHXdI+ikg6haVJUBIfi65J1jh7YFOQScPeFfZn5FdLIwwV1
         HQBqxVYcgT/LNtaebjn1fviZ+IgZBpZybIhLxGWy4QMZkk8/ERcgCeCm1h0Ahhp0HBSL
         ojLR6pytSqLpez0vfIpiHCesbcI1La8NGXWRe7x6NeiEsm8412Xo098elaZawQ0pGk05
         5ytGec+2Ioqy0lGzOd4BXBHFOLC6p+IG7quU66Y9Uh+PJMntM5b7DnSKxSFW0Y1aRGXF
         smjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zqElbD91wN7xrII3yrqdT2po60YKbiGuJ5EuHOboq08=;
        b=LXuOcFISuwC4gze3TDCTShTZFrOZVU+ZnCy1aNK0848sPWlZ0p9TPUr3/K/rVIEGTi
         tdL+kvNTZDkQ7xSxEb0oHB4u3A1fzfeoOjYzWv9lGW/1BeLXLqKdFnnCPbb1MxL79izm
         X5MxJTiMEh+ba+MjAcje2Kefr3f5V0Iy3mOVEnXfn9xR6A8rPSlMffYsNdSpe9J5O29H
         m35G0X2kuFkdC+YZFA+NavsjAhYFB+i7tuOErHgdGQIQRfiufp7+IApoEuoPQNctesCl
         dxjqIi0UzIH8ayYW4x2Qt7gWmMYl4as4cmgkclEHcjboS7HXhaVsAosJmBEmMrsyiQgS
         6X8w==
X-Gm-Message-State: AHQUAuaBssMwK/TvsA8m8S+hEizStvF1qetiRYuqZ1JKvh64FsM5HofK
        LpwZFW3/LUVdDGOCeDSIoHk=
X-Google-Smtp-Source: AHgI3Ia491NQopE8fziC0IJZOVG35rTaJ4DGuP8qMsPV/GoMoreeKpaQJ7srkoR5qCHTRvCiosG1aw==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr615506pgr.306.1549304141567;
        Mon, 04 Feb 2019 10:15:41 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id v89sm1323954pfk.12.2019.02.04.10.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:15:41 -0800 (PST)
Subject: [RFC PATCH 1/4] madvise: Expose ability to set dontneed from kernel
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 04 Feb 2019 10:15:40 -0800
Message-ID: <20190204181540.12095.87973.stgit@localhost.localdomain>
In-Reply-To: <20190204181118.12095.38300.stgit@localhost.localdomain>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In order to enable a KVM hypervisor to notify the host that a guest has
freed its pages we will need to have a mechanism to update the virtual
memory associated with the guest. In order to expose this functionality I
am adding a new function do_madvise_dontneed that can be used to indicate
a region that a given VM is done with.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/mm.h |    2 ++
 mm/madvise.c       |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e04396375cf9..eb668a5b4b4f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2840,5 +2840,7 @@ static inline bool page_is_guard(struct page *page)
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+int do_madvise_dontneed(unsigned long start, size_t len_in);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 21a7881a2db4..8730f7e0081a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -799,7 +799,7 @@ static int madvise_inject_error(int behavior,
  *  -EBADF  - map exists, but area maps something that isn't a file.
  *  -EAGAIN - a kernel resource was temporarily unavailable.
  */
-SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
+static int do_madvise(unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -894,3 +894,14 @@ static int madvise_inject_error(int behavior,
 
 	return error;
 }
+
+SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
+{
+	return do_madvise(start, len_in, behavior);
+}
+
+int do_madvise_dontneed(unsigned long start, size_t len_in)
+{
+	return do_madvise(start, len_in, MADV_DONTNEED);
+}
+EXPORT_SYMBOL_GPL(do_madvise_dontneed);

