Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeDQOGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:06:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33061 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeDQOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:06:01 -0400
X-Google-Smtp-Source: AIpwx49Am1e1bdcrh6GXATf/ZRRRX8SEhJt5Kbw+MsbbhGW1t0Y8hM9lhoKIJ1RXE034CtL3+83JCQ==
Date: Tue, 17 Apr 2018 16:00:32 +0200
From: Vitaly Wool <vitalywool@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180417160032.46915216@seldlx21914.corpusers.net>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> [ ... ]
> > Ugh. Could you please keep that patch and apply this on top:
> > 
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index c0bca6153b95..e8a80d044d9e 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -840,6 +840,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
> >                       kref_get(&zhdr->refcount);
> >                       list_del_init(&zhdr->buddy);
> >                       zhdr->cpu = -1;
> > +                     break;
> >               }
> >               list_del_init(&page->lru);
> > 
> Much better, in a way. The system now takes much longer to crash,
> and the crash reason is a bit different. The log is too long to attach,
> so I copied it to [1].
> 
> crashdump.0002                  Latest log
> 000[12]-Fix-attempt-[12].patch  Patches applied on top of v4.17.0-rc1.

thanks for the update. Let's start from a clean sheet. I believe this patch has to be applied anyway so could you please check if it solves the problem. 

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c0bca6153b95..059fb3d5ca86 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -144,7 +144,8 @@ enum z3fold_page_flags {
 	PAGE_HEADLESS = 0,
 	MIDDLE_CHUNK_MAPPED,
 	NEEDS_COMPACTING,
-	PAGE_STALE
+	PAGE_STALE,
+	UNDER_RECLAIM
 };
 
 /*****************
@@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
+	clear_bit(UNDER_RECLAIM, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -756,6 +758,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
+	if (test_bit(UNDER_RECLAIM, &page->private)) {
+		z3fold_page_unlock(zhdr);
+		return;
+	}
 	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
@@ -840,6 +846,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
+			set_bit(UNDER_RECLAIM, &page->private);
+			break;
 		}
 
 		list_del_init(&page->lru);
@@ -888,6 +896,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 next:
 		spin_lock(&pool->lock);
+		clear_bit(UNDER_RECLAIM, &page->private);
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				spin_unlock(&pool->lock);
