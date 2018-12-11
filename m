Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D381C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeLKFqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:46:14 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:43296 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLKFqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:46:12 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gWarp-0004jY-5U; Tue, 11 Dec 2018 13:46:01 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gWarg-0002Z5-H4; Tue, 11 Dec 2018 13:45:52 +0800
Date:   Tue, 11 Dec 2018 13:45:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Graf <tgraf@suug.ch>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>, Tom Herbert <tom@quantonium.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Blakey <paulb@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH] test_rhashtable: remove semaphore usage
Message-ID: <20181211054552.peone47xl5czpfar@gondor.apana.org.au>
References: <20181210211957.210189-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210211957.210189-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:17:20PM +0100, Arnd Bergmann wrote:
> This is one of only two files that initialize a semaphore to a negative
> value. We don't really need the two semaphores here at all, but can do
> the same thing in more conventional and more effient way, by using a
> single waitqueue and an atomic thread counter.
> 
> This gets us a little bit closer to eliminating classic semaphores from
> the kernel. It also fixes a corner case where we fail to continue after
> one of the threads fails to start up.
> 
> An alternative would be to use a split kthread_create()+wake_up_process()
> and completely eliminate the separate synchronization.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is part of a longer, untested, series to remove semaphores
> from the kernel, please review as such before applying.
> ---
>  lib/test_rhashtable.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)

This was created by Phil Sutter so I am adding him to the cc list.

> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index 18de5ff1255b..12bdea4f6c20 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
> @@ -20,11 +20,11 @@
>  #include <linux/module.h>
>  #include <linux/rcupdate.h>
>  #include <linux/rhashtable.h>
> -#include <linux/semaphore.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/random.h>
>  #include <linux/vmalloc.h>
> +#include <linux/wait.h>
>  
>  #define MAX_ENTRIES	1000000
>  #define TEST_INSERT_FAIL INT_MAX
> @@ -112,7 +112,8 @@ static struct rhashtable_params test_rht_params_dup = {
>  	.automatic_shrinking = false,
>  };
>  
> -static struct semaphore prestart_sem, startup_sem;
> +static atomic_t startup_count;
> +static DECLARE_WAIT_QUEUE_HEAD(startup_wait);
>  
>  static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
>                          const struct rhashtable_params params)
> @@ -635,8 +636,9 @@ static int threadfunc(void *data)
>  	int i, step, err = 0, insert_retries = 0;
>  	struct thread_data *tdata = data;
>  
> -	up(&prestart_sem);
> -	if (down_interruptible(&startup_sem))
> +	if (atomic_dec_and_test(&startup_count))
> +		wake_up(&startup_wait);
> +	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == -1))
>  		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);
>  
>  	for (i = 0; i < tdata->entries; i++) {
> @@ -756,8 +758,7 @@ static int __init test_rht_init(void)
>  
>  	pr_info("Testing concurrent rhashtable access from %d threads\n",
>  	        tcount);
> -	sema_init(&prestart_sem, 1 - tcount);
> -	sema_init(&startup_sem, 0);
> +	atomic_set(&startup_count, tcount);
>  	tdata = vzalloc(array_size(tcount, sizeof(struct thread_data)));
>  	if (!tdata)
>  		return -ENOMEM;
> @@ -783,15 +784,18 @@ static int __init test_rht_init(void)
>  		tdata[i].objs = objs + i * entries;
>  		tdata[i].task = kthread_run(threadfunc, &tdata[i],
>  		                            "rhashtable_thrad[%d]", i);
> -		if (IS_ERR(tdata[i].task))
> +		if (IS_ERR(tdata[i].task)) {
>  			pr_err(" kthread_run failed for thread %d\n", i);
> -		else
> +			atomic_dec(&startup_count);
> +		} else {
>  			started_threads++;
> +		}
>  	}
> -	if (down_interruptible(&prestart_sem))
> -		pr_err("  down interruptible failed\n");
> -	for (i = 0; i < tcount; i++)
> -		up(&startup_sem);
> +	if (wait_event_interruptible(startup_wait, atomic_read(&startup_count) == 0))
> +		pr_err("  wait_event interruptible failed\n");
> +	/* count is 0 now, set it to -1 and wake up all threads together */
> +	atomic_dec(&startup_count);
> +	wake_up_all(&startup_wait);
>  	for (i = 0; i < tcount; i++) {
>  		if (IS_ERR(tdata[i].task))
>  			continue;
> -- 
> 2.20.0
> 

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
