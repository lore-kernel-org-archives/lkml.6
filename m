Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79497C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33037208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33037208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965872AbeFOTRT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:17:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936269AbeFOTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:17:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9344DC7A;
        Fri, 15 Jun 2018 19:17:17 +0000 (UTC)
Date:   Fri, 15 Jun 2018 12:17:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
Message-Id: <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
In-Reply-To: <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
References: <20180606194144.16990-1-malat@debian.org>
        <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 11:59:10 -0700 Tony Luck <tony.luck@gmail.com> wrote:

> On Wed, Jun 6, 2018 at 12:41 PM, Mathieu Malaterre <malat@debian.org> wrote:
> > Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > introduced two new function definitions:
> >   ‘memblock_virt_alloc_try_nid_nopanic’
> > and
> >   ‘memblock_virt_alloc_try_nid’.
> > Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
> > introduced the following function definition:
> >   ‘memblock_virt_alloc_try_nid_raw’
> >
> > This commit adds an includeof header file <linux/bootmem.h> to provide the
> > missing function prototypes. Silence the following gcc warning (W=1):
> >
> >   mm/memblock.c:1334:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid_raw’ [-Wmissing-prototypes]
> >   mm/memblock.c:1371:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid_nopanic’ [-Wmissing-prototypes]
> >   mm/memblock.c:1407:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid’ [-Wmissing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> 
> Sadly that breaks ia64 build:
> 
>   CC      mm/memblock.o
> mm/memblock.c:1340: error: redefinition of ‘memblock_virt_alloc_try_nid_raw’
> ./include/linux/bootmem.h:335: error: previous definition of
> ‘memblock_virt_alloc_try_nid_raw’ was here
> mm/memblock.c:1377: error: redefinition of ‘memblock_virt_alloc_try_nid_nopanic’
> ./include/linux/bootmem.h:343: error: previous definition of
> ‘memblock_virt_alloc_try_nid_nopanic’ was here
> mm/memblock.c:1413: error: redefinition of ‘memblock_virt_alloc_try_nid’
> ./include/linux/bootmem.h:327: error: previous definition of
> ‘memblock_virt_alloc_try_nid’ was here
> make[1]: *** [mm/memblock.o] Error 1
> make: *** [mm/memblock.o] Error 2

Huh.  How did that ever work.  I guess it's either this:

--- a/mm/Makefile~a
+++ a/mm/Makefile
@@ -45,6 +45,7 @@ obj-y += init-mm.o
 
 ifdef CONFIG_NO_BOOTMEM
 	obj-y		+= nobootmem.o
+	obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
 else
 	obj-y		+= bootmem.o
 endif
@@ -53,7 +54,6 @@ obj-$(CONFIG_ADVISE_SYSCALLS)	+= fadvise
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
-obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
 obj-$(CONFIG_FRONTSWAP)	+= frontswap.o


or this:

--- a/include/linux/bootmem.h~a
+++ a/include/linux/bootmem.h
@@ -154,7 +154,7 @@ extern void *__alloc_bootmem_low_node(pg
 	__alloc_bootmem_low_node(pgdat, x, PAGE_SIZE, 0)
 
 
-#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
+#if defined(CONFIG_HAVE_MEMBLOCK)
 
 /* FIXME: use MEMBLOCK_ALLOC_* variants here */
 #define BOOTMEM_ALLOC_ACCESSIBLE	0


and I'm not sure which.  I think I'll just revert $subject for now.
