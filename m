Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6322DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F311920817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSZHO8df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKRLVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:21:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40434 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeKRLVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:21:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so21990597edx.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6gpN3ShItAMSgPSk9+2mmeZZdcFO8BKuodfMu9Xx5cY=;
        b=RSZHO8dfMO59T5DrdFJhsn61gko4zau+aMOsWFTt6P5dg4X4n9mCwHS6XpeQyECB/g
         P0qfO0BnUvsM5Fa/Hi0CPSXGQjEDp4UFbDyLdmvitmGNGiZIn9eftyuuIeWJS+jX736j
         EGF7/jkLthfs/c+CMyB3i13FrEnnB/GPrGiaZ/30qZ+cJPct36xJc6ROd+onnWS8IhU2
         xmv0+ia8i2HFK4R5jZngLe1hjGh4gxrMx5fEONpi0/rT+2X0P6xG2gXqS7wIsl0RwS8j
         JnAt1q/IWwkB+6/Ft5oQm2Fp15ZihFytnONgJluiaf6ck6BuatPnYsPkqeWUvsRzoV71
         NNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6gpN3ShItAMSgPSk9+2mmeZZdcFO8BKuodfMu9Xx5cY=;
        b=SDEkUacPW23SCSuQ6XGJxkCPHpPbWAZeOLa+G4e9a7psVNe8sM99DSjSGu3TcnDo//
         RBx9wS0i4lMslya3Vj/zK1z+Vxui7sij4AnFnZNfVFwtf2ppUAD5kC8ySk/kccGXj0Cd
         Dr4axwXFPzA160I7sZ1TjrjfaQ/9JrnizP21c8JJ4blUNI5NR4vGOkfq8GYT5C3QtxN1
         zWGl5WuoSqz1pAGFbKOiapA0WWQVcJkMrg7l/6pQooRPd7i9D0Z5FuUHPL0B8B88oy49
         lwd+XCM9UFUVfamuvg75Hsvm7ovnq6b5qMSM7nIJIWPrmHMY+I/d0oK37RP2DjU7VD1U
         jFkQ==
X-Gm-Message-State: AGRZ1gJUTz8TQgETCPjXg7Bqdkiz7LC2RYhhpFuOwKXeXkuVWqezy8YR
        yUNJr6I0Z2kefyPxyPdwldw=
X-Google-Smtp-Source: AJdET5d1VCU2Jgb7GUSRrGAgg6W5r03FRh991GY8RzF6yiiLG6hJE4nbEm0x9Ukhwo5ynN4v3R/6uA==
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr13202326edy.81.1542502951137;
        Sat, 17 Nov 2018 17:02:31 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x58sm8174055edm.10.2018.11.17.17.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 17:02:30 -0800 (PST)
Date:   Sun, 18 Nov 2018 01:02:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wengang Wang <wen.gang.wang@oracle.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
Message-ID: <20181118010229.esa32zk5hpob67y7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181117013335.32220-1-wen.gang.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117013335.32220-1-wen.gang.wang@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:33:35PM -0800, Wengang Wang wrote:
>The this_cpu_cmpxchg makes the do-while loop pass as long as the
>s->cpu_slab->partial as the same value. It doesn't care what happened to
>that slab. Interrupt is not disabled, and new alloc/free can happen in the

Well, I seems to understand your description.

There are two slabs

   * one which put_cpu_partial() trying to free an object
   * one which is the first slab in cpu_partial list

There is some tricky case, the first slab in cpu_partial list we
reference to will change since interrupt is not disabled.

>interrupt handlers. Theoretically, after we have a reference to the it,

                                                                 ^^^
							 one more word?

>stored in _oldpage_, the first slab on the partial list on this CPU can be

                                            ^^^
One little suggestion here, mayby use cpu_partial would be more easy to
understand. I confused this with the partial list in kmem_cache_node at
the first time.  :-)

>moved to kmem_cache_node and then moved to different kmem_cache_cpu and
>then somehow can be added back as head to partial list of current
>kmem_cache_cpu, though that is a very rare case. If that rare case really

Actually, no matter what happens after the removal of the first slab in
cpu_partial, it would leads to problem.

>happened, the reading of oldpage->pobjects may get a 0xdead0000
>unexpectedly, stored in _pobjects_, if the reading happens just after
>another CPU removed the slab from kmem_cache_node, setting lru.prev to
>LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
>prevents slabs from being moved to kmem_cache_node and being finally freed.
>
>We see in a vmcore, there are 375210 slabs kept in the partial list of one
>kmem_cache_cpu, but only 305 in-use objects in the same list for
>kmalloc-2048 cache. We see negative values for page.pobjects, the last page
>with negative _pobjects_ has the value of 0xdead0004, the next page looks
>good (_pobjects is 1).
>
>For the fix, I wanted to call this_cpu_cmpxchg_double with
>oldpage->pobjects, but failed due to size difference between
>oldpage->pobjects and cpu_slab->partial. So I changed to call
>this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
>happen in between, but just want to make sure the first slab did expereince
>a remove and re-add. This patch is more to call for ideas.

Maybe not an exact solution.

I took a look into the code and change log.

_tid_ is introduced by commit 8a5ec0ba42c4 ('Lockless (and preemptless)
fastpaths for slub'), which is used to guard cpu_freelist. While we don't
modify _tid_ when cpu_partial changes.

May need another _tid_ for cpu_partial?

>
>Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
>---
> mm/slub.c | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
>diff --git a/mm/slub.c b/mm/slub.c
>index e3629cd..26539e6 100644
>--- a/mm/slub.c
>+++ b/mm/slub.c
>@@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> {
> #ifdef CONFIG_SLUB_CPU_PARTIAL
> 	struct page *oldpage;
>+	unsigned long tid;
> 	int pages;
> 	int pobjects;
> 
>@@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> 	do {
> 		pages = 0;
> 		pobjects = 0;
>-		oldpage = this_cpu_read(s->cpu_slab->partial);
> 
>+		tid = this_cpu_read(s->cpu_slab->tid);
>+		/* read tid before reading oldpage */
>+		barrier();
>+
>+		oldpage = this_cpu_read(s->cpu_slab->partial);
> 		if (oldpage) {
> 			pobjects = oldpage->pobjects;
> 			pages = oldpage->pages;
>@@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
> 		page->pobjects = pobjects;
> 		page->next = oldpage;
> 
>-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
>-								!= oldpage);
>+		/* we dont' change tid, but want to make sure it didn't change
>+		 * in between. We don't really hope alloc/free not happen on
>+		 * this CPU, but don't want the first slab be removed from and
>+		 * then re-added as head to this partial list. If that case
>+		 * happened, pobjects may read 0xdead0000 when this slab is just
>+		 * removed from kmem_cache_node by other CPU setting lru.prev
>+		 * to LIST_POISON2.
>+		 */
>+	} while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
>+					 oldpage, tid, page, tid) == 0);
>+
> 	if (unlikely(!s->cpu_partial)) {
> 		unsigned long flags;
> 
>-- 
>2.9.5

-- 
Wei Yang
Help you, Help me
