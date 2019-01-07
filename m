Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ECB2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfAGHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:31:33 -0500
Received: from mail.windriver.com ([147.11.1.11]:61801 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAGHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:31:33 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x077VMIc020188
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 6 Jan 2019 23:31:22 -0800 (PST)
Received: from [128.224.162.180] (128.224.162.180) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sun, 6 Jan
 2019 23:31:21 -0800
Subject: Re: [PATCH] mm: kmemleak: Turn kmemleak_lock to spin lock and RCU
 primitives
To:     Catalin Marinas <catalin.marinas@arm.com>, <paulmck@linux.ibm.com>,
        <josh@joshtriplett.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1546612153-451172-1-git-send-email-zhe.he@windriver.com>
 <20190104183715.GC187360@arrakis.emea.arm.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <f923e9e9-ed73-5054-3d82-b2244c67a65e@windriver.com>
Date:   Mon, 7 Jan 2019 15:31:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104183715.GC187360@arrakis.emea.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.180]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/19 2:37 AM, Catalin Marinas wrote:
> On Fri, Jan 04, 2019 at 10:29:13PM +0800, zhe.he@windriver.com wrote:
>> It's not necessary to keep consistency between readers and writers of
>> kmemleak_lock. RCU is more proper for this case. And in order to gain better
>> performance, we turn the reader locks to RCU read locks and writer locks to
>> normal spin locks.
> This won't work.
>
>> @@ -515,9 +515,7 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>>  	struct kmemleak_object *object;
>>  
>>  	rcu_read_lock();
>> -	read_lock_irqsave(&kmemleak_lock, flags);
>>  	object = lookup_object(ptr, alias);
>> -	read_unlock_irqrestore(&kmemleak_lock, flags);
> The comment on lookup_object() states that the kmemleak_lock must be
> held. That's because we don't have an RCU-like mechanism for removing
> removing objects from the object_tree_root:
>
>>  
>>  	/* check whether the object is still available */
>>  	if (object && !get_object(object))
>> @@ -537,13 +535,13 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
>>  	unsigned long flags;
>>  	struct kmemleak_object *object;
>>  
>> -	write_lock_irqsave(&kmemleak_lock, flags);
>> +	spin_lock_irqsave(&kmemleak_lock, flags);
>>  	object = lookup_object(ptr, alias);
>>  	if (object) {
>>  		rb_erase(&object->rb_node, &object_tree_root);
>>  		list_del_rcu(&object->object_list);
>>  	}
>> -	write_unlock_irqrestore(&kmemleak_lock, flags);
>> +	spin_unlock_irqrestore(&kmemleak_lock, flags);
> So here, while list removal is RCU-safe, rb_erase() is not.
>
> If you have time to implement an rb_erase_rcu(), than we could reduce
> the locking in kmemleak.

Thanks, I really neglected that rb_erase is not RCU-safe here.

I'm not sure if it is practically possible to implement rb_erase_rcu. Here
is my concern:
In the code paths starting from rb_erase, the tree is tweaked at many
places, in both __rb_erase_augmented and ____rb_erase_color. To my
understanding, there are many intermediate versions of the tree
during the erasion. In some of the versions, the tree is incomplete, i.e.
some nodes(not the one to be deleted) are invisible to readers. I'm not
sure if this is acceptable as an RCU implementation. Does it mean we
need to form a rb_erase_rcu from scratch?

And are there any other concerns about this attempt?

Let me add RCU supporters Paul and Josh here. Your advice would be
highly appreciated.

Thanks,
Zhe


>

