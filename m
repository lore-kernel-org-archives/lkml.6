Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeDDWUo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:20:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeDDWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:20:43 -0400
Date: Wed, 4 Apr 2018 15:20:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xidong Wang <wangxidong_97@163.com>
Cc: Vitaly Wool <vitalywool@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] z3fold: fix memory leak
Message-Id: <20180404152039.aadbe5bbed5bc91da8c5fa99@linux-foundation.org>
In-Reply-To: <1522803111-29209-1-git-send-email-wangxidong_97@163.com>
References: <1522803111-29209-1-git-send-email-wangxidong_97@163.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Apr 2018 08:51:51 +0800 Xidong Wang <wangxidong_97@163.com> wrote:

> In function z3fold_create_pool(), the memory allocated by
> __alloc_percpu() is not released on the error path that pool->compact_wq
> , which holds the return value of create_singlethread_workqueue(), is NULL.
> This will result in a memory leak bug.
>
> ...
>
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -490,6 +490,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
>  out_wq:
>  	destroy_workqueue(pool->compact_wq);
>  out:
> +	free_percpu(pool->unbuddied);
>  	kfree(pool);
>  	return NULL;
>  }

That isn't right.  If the initial kzallc fails we'll goto out with
pool==NULL.

Please check:

--- a/mm/z3fold.c~z3fold-fix-memory-leak-fix
+++ a/mm/z3fold.c
@@ -479,7 +479,7 @@ static struct z3fold_pool *z3fold_create
 	pool->name = name;
 	pool->compact_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->compact_wq)
-		goto out;
+		goto out_unbuddied;
 	pool->release_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->release_wq)
 		goto out_wq;
@@ -489,9 +489,10 @@ static struct z3fold_pool *z3fold_create
 
 out_wq:
 	destroy_workqueue(pool->compact_wq);
-out:
+out_unbuddied:
 	free_percpu(pool->unbuddied);
 	kfree(pool);
+out:
 	return NULL;
 }
 
_
