Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC120864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756717AbeFOW6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:58:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756481AbeFOW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:58:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3FF39C7A;
        Fri, 15 Jun 2018 22:58:11 +0000 (UTC)
Date:   Fri, 15 Jun 2018 15:58:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: fix failure when we delete and create a slab
 cache
Message-Id: <20180615155809.77862e1f6376d5779da9d991@linux-foundation.org>
In-Reply-To: <alpine.LRH.2.02.1806151817130.6333@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1806151817130.6333@file01.intranet.prod.int.rdu2.redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018 18:25:29 -0400 (EDT) Mikulas Patocka <mpatocka@redhat.com> wrote:

> In the kernel 4.17 I removed some code from dm-bufio that did slab cache
> merging (21bb13276768) - both slab and slub support merging caches with
> identical attributes, so dm-bufio now just calls kmem_cache_create and
> relies on implicit merging.
> 
> This uncovered a bug in the slub subsystem - if we delete a cache and
> immediatelly create another cache with the same attributes, it fails
> because of duplicate filename in /sys/kernel/slab/. The slub subsystem
> offloads freeing the cache to a workqueue - and if we create the new cache
> before the workqueue runs, it complains because of duplicate filename in
> sysfs.

Huh.  Surprised that such an obvious blooper survived this long.  I
guess a rapid del+add is uncommon.

> This patch fixes the bug by moving the call of kobject_del from 
> sysfs_slab_remove_workfn to shutdown_cache. kobject_del must be called 
> while we hold slab_mutex - so that the sysfs entry is deleted before a 
> cache with the same attributes could be created.
> 
> 
> Running device-mapper-test-suite with:

Nice changelog, btw.

> --- linux-2.6.orig/include/linux/slub_def.h
> +++ linux-2.6/include/linux/slub_def.h
> @@ -156,8 +156,12 @@ struct kmem_cache {
>  
>  #ifdef CONFIG_SYSFS
>  #define SLAB_SUPPORTS_SYSFS
> +void sysfs_slab_unlink(struct kmem_cache *);
>  void sysfs_slab_release(struct kmem_cache *);
>  #else
> +static inline void sysfs_slab_unlink(struct kmem_cache *s)
> +{
> +}
>  static inline void sysfs_slab_release(struct kmem_cache *s)
>  {
>  }

hm, that's pretty old-school.  We could replace SLAB_SUPPORTS_SYSFS
with CONFIG_SLAB_SUPPORTS_SYSFS, move the above logic into slab.h and..

> --- linux-2.6.orig/mm/slab_common.c
> +++ linux-2.6/mm/slab_common.c
> @@ -566,10 +566,14 @@ static int shutdown_cache(struct kmem_ca
>  	list_del(&s->list);
>  
>  	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
> +#ifdef SLAB_SUPPORTS_SYSFS
> +		sysfs_slab_unlink(s);
> +#endif
>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>  	} else {
>  #ifdef SLAB_SUPPORTS_SYSFS
> +		sysfs_slab_unlink(s);
>  		sysfs_slab_release(s);
>  #else
>  		slab_kmem_cache_release(s);

remove a bunch of ifdefs.  But that would be a separate thing.
