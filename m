Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFEC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD1422451
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD1422451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeGELUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:20:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754193AbeGELUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:20:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1689887928;
        Thu,  5 Jul 2018 11:20:48 +0000 (UTC)
Received: from ovpn-117-156.ams2.redhat.com (ovpn-117-156.ams2.redhat.com [10.36.117.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF4B7C3E;
        Thu,  5 Jul 2018 11:20:45 +0000 (UTC)
Message-ID: <86f305ff238d7cdac7ab20b0d6395cc6571cf4e0.camel@redhat.com>
Subject: Re: [4/4] rhashtable: improve rhashtable_walk stability when
 stop/start used.
From:   Paolo Abeni <pabeni@redhat.com>
To:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Jul 2018 13:20:44 +0200
In-Reply-To: <152452255351.1456.12384285355497513812.stgit@noble>
References: <152452255351.1456.12384285355497513812.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 05 Jul 2018 11:20:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 05 Jul 2018 11:20:48 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pabeni@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 08:29 +1000, NeilBrown wrote:
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 81edf1ab38ab..9427b5766134 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -727,6 +727,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
>  	__acquires(RCU)
>  {
>  	struct rhashtable *ht = iter->ht;
> +	bool rhlist = ht->rhlist;
>  
>  	rcu_read_lock();
>  
> @@ -735,13 +736,52 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
>  		list_del(&iter->walker.list);
>  	spin_unlock(&ht->lock);
>  
> -	if (!iter->walker.tbl && !iter->end_of_table) {
> +	if (iter->end_of_table)
> +		return 0;
> +	if (!iter->walker.tbl) {
>  		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
>  		iter->slot = 0;
>  		iter->skip = 0;
>  		return -EAGAIN;
>  	}
>  
> +	if (iter->p && !rhlist) {
> +		/*
> +		 * We need to validate that 'p' is still in the table, and
> +		 * if so, update 'skip'
> +		 */
> +		struct rhash_head *p;
> +		int skip = 0;
> +		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
> +			skip++;
> +			if (p == iter->p) {
> +				iter->skip = skip;
> +				goto found;
> +			}
> +		}
> +		iter->p = NULL;
> +	} else if (iter->p && rhlist) {
> +		/* Need to validate that 'list' is still in the table, and
> +		 * if so, update 'skip' and 'p'.
> +		 */
> +		struct rhash_head *p;
> +		struct rhlist_head *list;
> +		int skip = 0;
> +		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
> +			for (list = container_of(p, struct rhlist_head, rhead);
> +			     list;
> +			     list = rcu_dereference(list->next)) {
> +				skip++;
> +				if (list == iter->list) {
> +					iter->p = p;
> +					skip = skip;
> +					goto found;
> +				}
> +			}
> +		}
> +		iter->p = NULL;
> +	}
> +found:
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rhashtable_walk_start_check);

While testing new code that uses the rhashtable walker, I'm obeserving
an use after free, that is apparently caused by the above:

[  146.834815] ==================================================================
[  146.842933] BUG: KASAN: use-after-free in inet_frag_worker+0x9f/0x210
[  146.850120] Read of size 4 at addr ffff881b6b9342d8 by task kworker/13:1/177
[  146.857984] 
[  146.859645] CPU: 13 PID: 177 Comm: kworker/13:1 Not tainted 4.18.0-rc3.mirror_unclone_6_frag_dbg+ #1974
[  146.870128] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7 06/16/2016
[  146.878478] Workqueue: events inet_frag_worker
[  146.883433] Call Trace:
[  146.886162]  dump_stack+0x90/0xe3
[  146.889861]  print_address_description+0x6a/0x2a0
[  146.895109]  kasan_report+0x176/0x2d0
[  146.899193]  ? inet_frag_worker+0x9f/0x210
[  146.903762]  inet_frag_worker+0x9f/0x210
[  146.908142]  process_one_work+0x24f/0x6e0
[  146.912614]  ? process_one_work+0x1a6/0x6e0
[  146.917285]  worker_thread+0x4e/0x3d0
[  146.921373]  kthread+0x106/0x140
[  146.924970]  ? process_one_work+0x6e0/0x6e0
[  146.929637]  ? kthread_bind+0x10/0x10
[  146.933723]  ret_from_fork+0x3a/0x50
[  146.937717] 
[  146.939377] Allocated by task 177:
[  146.943170]  kasan_kmalloc+0x86/0xb0
[  146.947158]  __kmalloc_node+0x181/0x430
[  146.951438]  kvmalloc_node+0x4f/0x70
[  146.955427]  alloc_bucket_spinlocks+0x34/0xa0
[  146.960286]  bucket_table_alloc.isra.13+0x61/0x180
[  146.965630]  rhashtable_rehash_alloc+0x26/0x80
[  146.970585]  rht_deferred_worker+0x394/0x810
[  146.975348]  process_one_work+0x24f/0x6e0
[  146.979819]  worker_thread+0x4e/0x3d0
[  146.983902]  kthread+0x106/0x140
[  146.987502]  ret_from_fork+0x3a/0x50
[  146.991487] 
[  146.993146] Freed by task 90:
[  146.996455]  __kasan_slab_free+0x11d/0x180
[  147.001025]  kfree+0x113/0x350
[  147.004431]  bucket_table_free+0x1c/0x70
[  147.008806]  rcu_process_callbacks+0x6c8/0x880
[  147.013762]  __do_softirq+0xd5/0x505
[  147.017747] 
[  147.019407] The buggy address belongs to the object at ffff881b6b934200
[  147.019407]  which belongs to the cache kmalloc-8192 of size 8192
[  147.033574] The buggy address is located 216 bytes inside of
[  147.033574]  8192-byte region [ffff881b6b934200, ffff881b6b936200)
[  147.046773] The buggy address belongs to the page:
[  147.052116] page:ffffea006dae4c00 count:1 mapcount:0 mapping:ffff880107c0e400 index:0x0 compound_mapcount: 0
[  147.063086] flags: 0x17ffffc0008100(slab|head)
[  147.068043] raw: 0017ffffc0008100 dead000000000100 dead000000000200 ffff880107c0e400
[  147.076684] raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
[  147.085324] page dumped because: kasan: bad access detected
[  147.091540] 
[  147.093210] Memory state around the buggy address:
[  147.098553]  ffff881b6b934180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  147.106613]  ffff881b6b934200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  147.114670] >ffff881b6b934280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  147.122730]                                                     ^
[  147.129527]  ffff881b6b934300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  147.137587]  ffff881b6b934380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  147.145646] ==================================================================

Reverting the above change avoid the issue. 

I *think* that reusing iter->p after a
rcu_read_lock()/rcu_read_unlock() is unsafe:
if the table has been reashed we can still and reuse 'p', but the
related grace period could be already expired.

I can't think of any better fix than a revert. Other opinions welcome!

Paolo

