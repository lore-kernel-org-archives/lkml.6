Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D017208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D017208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJPVKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:10:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:40416 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPVKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:10:18 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gCPGA-00018u-7T; Tue, 16 Oct 2018 16:19:42 +0300
Subject: Re: [PATCH] mm: Convert mem_cgroup_id::ref to refcount_t type
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
 <20181016124939.GA13278@andrea>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a990eed4-611b-8464-c2aa-56684fee0ee5@virtuozzo.com>
Date:   Tue, 16 Oct 2018 16:19:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016124939.GA13278@andrea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrea,

On 16.10.2018 15:49, Andrea Parri wrote:
> Hi Kirill,
> 
> On Tue, Oct 09, 2018 at 08:46:56PM +0300, Kirill Tkhai wrote:
>> This will allow to use generic refcount_t interfaces
>> to check counters overflow instead of currently existing
>> VM_BUG_ON(). The only difference after the patch is
>> VM_BUG_ON() may cause BUG(), while refcount_t fires
>> with WARN().
> 
> refcount_{sub_and_test,inc_not_zero}() are documented to provide
> "slightly" more relaxed ordering than their atomic_* counterpart,
> c.f.,
> 
>   Documentation/core-api/refcount-vs-atomic.rst
>   lib/refcount.c (inline comments)
> 
> IIUC, this semantic change won't cause problems here (but please
> double-check? ;D ).

I just don't see a place, where we may think about using a modification
of struct mem_cgroup::id::ref as a memory barrier to order something,
and all this looks safe for me.

Kirill
 
>> But this seems not to be significant here,
>> since such the problems are usually caught by syzbot
>> with panic-on-warn enabled.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |    2 +-
>>  mm/memcontrol.c            |   10 ++++------
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 4399cc3f00e4..7ab2120155a4 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -78,7 +78,7 @@ struct mem_cgroup_reclaim_cookie {
>>  
>>  struct mem_cgroup_id {
>>  	int id;
>> -	atomic_t ref;
>> +	refcount_t ref;
>>  };
>>  
>>  /*
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 7bebe2ddec05..aa728d5b3d72 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4299,14 +4299,12 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>>  
>>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>>  {
>> -	VM_BUG_ON(atomic_read(&memcg->id.ref) <= 0);
>> -	atomic_add(n, &memcg->id.ref);
>> +	refcount_add(n, &memcg->id.ref);
>>  }
>>  
>>  static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>>  {
>> -	VM_BUG_ON(atomic_read(&memcg->id.ref) < n);
>> -	if (atomic_sub_and_test(n, &memcg->id.ref)) {
>> +	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>>  		mem_cgroup_id_remove(memcg);
>>  
>>  		/* Memcg ID pins CSS */
>> @@ -4523,7 +4521,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>  	}
>>  
>>  	/* Online state pins memcg ID, memcg ID pins CSS */
>> -	atomic_set(&memcg->id.ref, 1);
>> +	refcount_set(&memcg->id.ref, 1);
>>  	css_get(css);
>>  	return 0;
>>  }
>> @@ -6357,7 +6355,7 @@ subsys_initcall(mem_cgroup_init);
>>  #ifdef CONFIG_MEMCG_SWAP
>>  static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>>  {
>> -	while (!atomic_inc_not_zero(&memcg->id.ref)) {
>> +	while (!refcount_inc_not_zero(&memcg->id.ref)) {
>>  		/*
>>  		 * The root cgroup cannot be destroyed, so it's refcount must
>>  		 * always be >= 1.
>>
