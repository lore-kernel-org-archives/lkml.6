Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E8A21A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E8A21A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeHHXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:43:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730151AbeHHXnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 501A08198B00;
        Wed,  8 Aug 2018 21:22:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 231882027047;
        Wed,  8 Aug 2018 21:22:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w78LMHff025295;
        Wed, 8 Aug 2018 17:22:17 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w78LMGZh025291;
        Wed, 8 Aug 2018 17:22:16 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Aug 2018 17:22:16 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ingo Molnar <mingo@kernel.org>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND] x86: optimize memcpy_flushcache
In-Reply-To: <20180622013049.GA12505@gmail.com>
Message-ID: <alpine.LRH.2.02.1808081720460.24747@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180519052503.325953342@debian.vm> <20180519052631.730455475@debian.vm> <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com> <20180524182013.GA59755@redhat.com> <20180618132306.GA25431@redhat.com> <20180621143140.GA14095@gmail.com>
 <alpine.LRH.2.02.1806211224470.19940@file01.intranet.prod.int.rdu2.redhat.com> <20180622013049.GA12505@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 08 Aug 2018 21:22:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 08 Aug 2018 21:22:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2018, Ingo Molnar wrote:

> 
> * Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > On Thu, 21 Jun 2018, Ingo Molnar wrote:
> > 
> > > 
> > > * Mike Snitzer <snitzer@redhat.com> wrote:
> > > 
> > > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > > Subject: [PATCH v2] x86: optimize memcpy_flushcache
> > > > 
> > > > In the context of constant short length stores to persistent memory,
> > > > memcpy_flushcache suffers from a 2% performance degradation compared to
> > > > explicitly using the "movnti" instruction.
> > > > 
> > > > Optimize 4, 8, and 16 byte memcpy_flushcache calls to explicitly use the
> > > > movnti instruction with inline assembler.
> > > 
> > > Linus requested asm optimizations to include actual benchmarks, so it would be 
> > > nice to describe how this was tested, on what hardware, and what the before/after 
> > > numbers are.
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > 
> > It was tested on 4-core skylake machine with persistent memory being 
> > emulated using the memmap kernel option. The dm-writecache target used the 
> > emulated persistent memory as a cache and sata SSD as a backing device. 
> > The patch results in 2% improved throughput when writing data using dd.
> > 
> > I don't have access to the machine anymore.
> 
> I think this information is enough, but do we know how well memmap emulation 
> represents true persistent memory speed and cache management characteristics?
> It might be representative - but I don't know for sure, nor probably most
> readers of the changelog.
> 
> So could you please put all this into an updated changelog, and also add a short 
> description that outlines exactly which codepaths end up using this method in a 
> typical persistent memory setup? All filesystem ops - or only reads, etc?
> 
> Thanks,
> 
> 	Ingo

Here I resend it:


From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] x86: optimize memcpy_flushcache

I use memcpy_flushcache in my persistent memory driver for metadata
updates, there are many 8-byte and 16-byte updates and it turns out that
the overhead of memcpy_flushcache causes 2% performance degradation
compared to "movnti" instruction explicitly coded using inline assembler.

The tests were done on a Skylake processor with persistent memory emulated
using the "memmap" kernel parameter. dd was used to copy data to the
dm-writecache target.

This patch recognizes memcpy_flushcache calls with constant short length
and turns them into inline assembler - so that I don't have to use inline
assembler in the driver.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/x86/include/asm/string_64.h |   20 +++++++++++++++++++-
 arch/x86/lib/usercopy_64.c       |    4 ++--
 2 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/include/asm/string_64.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/string_64.h
+++ linux-2.6/arch/x86/include/asm/string_64.h
@@ -149,7 +149,25 @@ memcpy_mcsafe(void *dst, const void *src
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
-void memcpy_flushcache(void *dst, const void *src, size_t cnt);
+void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
+static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+{
+	if (__builtin_constant_p(cnt)) {
+		switch (cnt) {
+			case 4:
+				asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
+				return;
+			case 8:
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
+				return;
+			case 16:
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
+				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
+				return;
+		}
+	}
+	__memcpy_flushcache(dst, src, cnt);
+}
 #endif
 
 #endif /* __KERNEL__ */
Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c
+++ linux-2.6/arch/x86/lib/usercopy_64.c
@@ -153,7 +153,7 @@ long __copy_user_flushcache(void *dst, c
 	return rc;
 }
 
-void memcpy_flushcache(void *_dst, const void *_src, size_t size)
+void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 {
 	unsigned long dest = (unsigned long) _dst;
 	unsigned long source = (unsigned long) _src;
@@ -216,7 +216,7 @@ void memcpy_flushcache(void *_dst, const
 		clean_cache_range((void *) dest, size);
 	}
 }
-EXPORT_SYMBOL_GPL(memcpy_flushcache);
+EXPORT_SYMBOL_GPL(__memcpy_flushcache);
 
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 		size_t len)
