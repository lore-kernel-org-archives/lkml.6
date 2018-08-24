Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849E621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849E621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeHXIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeHXIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFB89AD3C;
        Fri, 24 Aug 2018 05:03:31 +0000 (UTC)
Subject: Re: [PATCH] xen/gntdev: fix up blockable calls to mn_invl_range_start
To:     Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, LKML <linux-kernel@vger.kernel.org>
References: <20180823120707.10998-1-mhocko@kernel.org>
 <07c7ead4-334d-9b25-f588-25e9b46bbea0@i-love.sakura.ne.jp>
 <20180823135151.GM29735@dhcp22.suse.cz>
 <9d2d11eb-7fe1-b836-056c-7886d6fc56e5@oracle.com>
 <20180823190933.GP29735@dhcp22.suse.cz>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2afe2559-78ad-2d5b-41aa-1988f941759b@suse.com>
Date:   Fri, 24 Aug 2018 07:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823190933.GP29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 21:09, Michal Hocko wrote:
> On Thu 23-08-18 10:06:53, Boris Ostrovsky wrote:
>> On 08/23/2018 09:51 AM, Michal Hocko wrote:
>>> On Thu 23-08-18 22:44:07, Tetsuo Handa wrote:
>>>> On 2018/08/23 21:07, Michal Hocko wrote:
>>>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>>>> index 57390c7666e5..e7d8bb1bee2a 100644
>>>>> --- a/drivers/xen/gntdev.c
>>>>> +++ b/drivers/xen/gntdev.c
>>>>> @@ -519,21 +519,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
>>>>>  	struct gntdev_grant_map *map;
>>>>>  	int ret = 0;
>>>>>  
>>>>> -	/* TODO do we really need a mutex here? */
>>>>>  	if (blockable)
>>>>>  		mutex_lock(&priv->lock);
>>>>>  	else if (!mutex_trylock(&priv->lock))
>>>>>  		return -EAGAIN;
>>>>>  
>>>>>  	list_for_each_entry(map, &priv->maps, next) {
>>>>> -		if (in_range(map, start, end)) {
>>>>> +		if (!blockable && in_range(map, start, end)) {
>>>> This still looks strange. Prior to 93065ac753e4, in_range() test was
>>>> inside unmap_if_in_range(). But this patch removes in_range() test
>>>> if blockable == true. That is, unmap_if_in_range() will unconditionally
>>>> unmap if blockable == true, which seems to be an unexpected change.
>>> You are right. I completely forgot I've removed in_range there. Does
>>> this look any better?
>>>
>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>> index e7d8bb1bee2a..30f81004ea63 100644
>>> --- a/drivers/xen/gntdev.c
>>> +++ b/drivers/xen/gntdev.c
>>> @@ -525,14 +525,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
>>>  		return -EAGAIN;
>>>  
>>>  	list_for_each_entry(map, &priv->maps, next) {
>>> -		if (!blockable && in_range(map, start, end)) {
>>> +		if (in_range(map, start, end)) {
>>> +			if (blockable)
>>> +				continue;
>>> +
>>>  			ret = -EAGAIN;
>>>  			goto out_unlock;
>>>  		}
>>>  		unmap_if_in_range(map, start, end);
>>
>>
>> (I obviously missed that too with my R-b).
>>
>> This will never get anything done either. How about
> 
> Yeah. I was half way out and posted a complete garbage. Sorry about
> that!
> 
> Michal repeat after me
> Never post patches when in hurry! Never post patches when in hurry!
> Never post patches when in hurry! Never post patches when in hurry!
> Never post patches when in hurry! Never post patches when in hurry!
> Never post patches when in hurry! Never post patches when in hurry!
> Never post patches when in hurry! Never post patches when in hurry! 
> 
> What I really meant was this
> 
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index e7d8bb1bee2a..6fcc5a44f29d 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -525,17 +525,25 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
>  		return -EAGAIN;
>  
>  	list_for_each_entry(map, &priv->maps, next) {
> -		if (!blockable && in_range(map, start, end)) {
> +		if (!in_range(map, start, end))
> +			continue;
> +
> +		if (!blockable) {
>  			ret = -EAGAIN;
>  			goto out_unlock;
>  		}
> +
>  		unmap_if_in_range(map, start, end);
>  	}
>  	list_for_each_entry(map, &priv->freeable_maps, next) {
> -		if (!blockable && in_range(map, start, end)) {
> +		if (!in_range(map, start, end))
> +			continue;
> +
> +		if (!blockable) {
>  			ret = -EAGAIN;
>  			goto out_unlock;
>  		}
> +
>  		unmap_if_in_range(map, start, end);
>  	}
>  
> 

I liked the general structure before 93065ac753e4 better.

Why don't you return to that, add blockable parameter to
unmap_if_in_range() and let unmap_if_in_range() return a value (0 or
-EAGAIN)? This will avoid repeating the very same code.

So:

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -479,25 +479,21 @@ static const struct vm_operations_struct
gntdev_vmops = {

 /* ------------------------------------------------------------------ */

-static bool in_range(struct gntdev_grant_map *map,
-                             unsigned long start, unsigned long end)
-{
-       if (!map->vma)
-               return false;
-       if (map->vma->vm_start >= end)
-               return false;
-       if (map->vma->vm_end <= start)
-               return false;
-
-       return true;
-}
-
-static void unmap_if_in_range(struct gntdev_grant_map *map,
-                             unsigned long start, unsigned long end)
+static int unmap_if_in_range(struct gntdev_grant_map *map,
+                            unsigned long start, unsigned long end,
+                            bool blockable)
 {
        unsigned long mstart, mend;
        int err;

+       if (!map->vma)
+               return 0;
+       if (map->vma->vm_start >= end)
+               return 0;
+       if (map->vma->vm_end <= start)
+               return 0;
+       if (!blockable)
+               return -EAGAIN;
        mstart = max(start, map->vma->vm_start);
        mend   = min(end,   map->vma->vm_end);
        pr_debug("map %d+%d (%lx %lx), range %lx %lx, mrange %lx %lx\n",
@@ -508,6 +504,8 @@ static void unmap_if_in_range(struct
gntdev_grant_map *map,
                                (mstart - map->vma->vm_start) >> PAGE_SHIFT,
                                (mend - mstart) >> PAGE_SHIFT);
        WARN_ON(err);
+
+       return 0;
 }

 static int mn_invl_range_start(struct mmu_notifier *mn,
@@ -519,25 +517,20 @@ static int mn_invl_range_start(struct mmu_notifier
*mn,
        struct gntdev_grant_map *map;
        int ret = 0;

-       /* TODO do we really need a mutex here? */
        if (blockable)
                mutex_lock(&priv->lock);
        else if (!mutex_trylock(&priv->lock))
                return -EAGAIN;

        list_for_each_entry(map, &priv->maps, next) {
-               if (in_range(map, start, end)) {
-                       ret = -EAGAIN;
+               ret = unmap_if_in_range(map, start, end, blockable);
+               if (ret)
                        goto out_unlock;
-               }
-               unmap_if_in_range(map, start, end);
        }
        list_for_each_entry(map, &priv->freeable_maps, next) {
-               if (in_range(map, start, end)) {
-                       ret = -EAGAIN;
+               ret = unmap_if_in_range(map, start, end, blockable);
+               if (ret)
                        goto out_unlock;
-               }
-               unmap_if_in_range(map, start, end);
        }

 out_unlock:


Juergen
