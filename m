Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD434218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="E+ay9z6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfABPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:51:14 -0500
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:50846 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbfABPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1546444272;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=QrUfP2uIZHKXzgqGsLcs1smTdC8d+WI0qnJh55aBLBQ=;
        b=E+ay9z6r2ElMB3D6TaKMceeFTQChZVSdJ/tI015jziOWfgTHqD8pIvknKXq8bhCO
        OzAN+3av/7KCiiN5Ms+prXwen9ym67IxOnCFTJDogUhCVKdgPN6nSpFyCZSNbUWeVxF
        wQl+HZo6yvoqyQx5pu0jR4MFs4/N5YaPY/Rfulac=
Date:   Wed, 2 Jan 2019 15:51:12 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     syzbot <syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net,
        Linux-MM <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 setup_kmem_cache_node
In-Reply-To: <CACT4Y+ZECp8Ymq=0QUNfwmfpQvWkBpoMgyUCuz0M=peehEeCHw@mail.gmail.com>
Message-ID: <010001680f42f192-82b4e12e-1565-4ee0-ae1f-1e98974906aa-000000@email.amazonses.com>
References: <0000000000000f35c6057e780d36@google.com> <CACT4Y+ZECp8Ymq=0QUNfwmfpQvWkBpoMgyUCuz0M=peehEeCHw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.02-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019, Dmitry Vyukov wrote:

> Am I missing something or __alloc_alien_cache misses check for
> kmalloc_node result?
>
> static struct alien_cache *__alloc_alien_cache(int node, int entries,
>                                                 int batch, gfp_t gfp)
> {
>         size_t memsize = sizeof(void *) * entries + sizeof(struct alien_cache);
>         struct alien_cache *alc = NULL;
>
>         alc = kmalloc_node(memsize, gfp, node);
>         init_arraycache(&alc->ac, entries, batch);
>         spin_lock_init(&alc->lock);
>         return alc;
> }
>


True _alloc_alien_cache() needs to check for NULL


From: Christoph Lameter <cl@linux.com>
Subject: slab: Alien caches must not be initialized if the allocation of the alien cache failed

Callers of __alloc_alien() check for NULL.
We must do the same check in __alloc_alien_cache to avoid NULL pointer dereferences
on allocation failures.

Signed-off-by: Christoph Lameter <cl@linux.com>


Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -666,8 +666,10 @@ static struct alien_cache *__alloc_alien
 	struct alien_cache *alc = NULL;

 	alc = kmalloc_node(memsize, gfp, node);
-	init_arraycache(&alc->ac, entries, batch);
-	spin_lock_init(&alc->lock);
+	if (alc) {
+		init_arraycache(&alc->ac, entries, batch);
+		spin_lock_init(&alc->lock);
+	}
 	return alc;
 }

