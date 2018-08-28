Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7256EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AC3208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AC3208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeH1E4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:56:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbeH1E4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:56:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F10AADC584141;
        Tue, 28 Aug 2018 09:07:34 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Tue, 28 Aug 2018
 09:07:33 +0800
Subject: Re: [V9fs-developer] [PATCH v2 2/2] 9p: Add refcount to p9_req_t
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>
References: <20180814174342.11068-1-tomasbortoli@gmail.com>
 <20180814174342.11068-2-tomasbortoli@gmail.com>
 <20180827230954.GA21513@nautica>
CC:     <lucho@ionkov.net>, Dominique Martinet <dominique.martinet@cea.fr>,
        <ericvh@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <rminnich@sandia.gov>,
        <davem@davemloft.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B84A051.6070903@huawei.com>
Date:   Tue, 28 Aug 2018 09:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180827230954.GA21513@nautica>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/8/28 7:09, Dominique Martinet wrote:
> Tomas Bortoli wrote on Tue, Aug 14, 2018:
>> To avoid use-after-free(s), use a refcount to keep track of the
>> usable references to any instantiated struct p9_req_t.
>>
>> This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
>> wrappers to kref_put(), kref_get() and kref_get_unless_zero().
>> These are used by the client and the transports to keep track of
>> valid requests' references.
>>
>> p9_free_req() is added back and used as callback by kref_put().
>>
>> Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
>> kmem_cache_free() will not be reused for another type until the rcu
>> synchronisation period is over, so an address gotten under rcu read
>> lock is safe to inc_ref() without corrupting random memory while
>> the lock is held.
> 
> 
> FWIW, since 4.19-rc1 has been tagged I was going to push this and all
> the perrequesites to linux-next, but I've managed to leak some requests
> by interrupting them in trans_virtio.
> I think I've found why (see below), so I'll push a fixed version after
> some more testing and another thorough read -- at some point today, but
> this hasn't been 'approved' explicitely so please review! :)
> 
> (Jun, I think you'll need to ask again to rename 'req' to 'rreq' if you
> think it's important -- I think such a rename should go in a separate
> patch anyway, there's plenty of time until the 4.20 merge window)
> 

I still think such a rename is necessary, and as you said, it will be
better go in another patch.

Thanks,
Jun

> 
> By "all the prerequesites" I mean this patch "serie":
> * 9p: Use a slab for allocating requests
> * 9p: Remove p9_idpool
> * net/9p: embed fcall in req to round down buffer allocs
> * net/9p: add a per-client fcall kmem_cache
> * 9p: rename p9_free_req() function
> * 9p: Add refcount to p9_req_t
> 
> All the other patchs have had some review though, I was just waiting for
> the start of this cycle, but if someone has any issue with the above
> patches now is a good time to say.
> 
> 
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 7942c0bfcc5b..c9bb5d41afa4 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>>  
>>  	err = c->trans_mod->request(c, req);
>>  	if (err < 0) {
>> +		/* write won't happen */
>> +		p9_req_put(req);
>>  		if (err != -ERESTARTSYS && err != -EFAULT)
>>  			c->status = Disconnected;
>>  		goto recalc_sigpending;
> 
> p9_client_zc_rpc needs the same put if zc_request failed, I'm not sure
> why it wasn't here in my draft
> 
