Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAAAC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A099208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A099208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbeGaDGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:06:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731288AbeGaDGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:06:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CCDB6E57524DB;
        Tue, 31 Jul 2018 09:28:26 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Tue, 31 Jul 2018
 09:28:25 +0800
Subject: Re: [V9fs-developer] [PATCH 1/2] net/9p: embed fcall in req to round
 down buffer allocs
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <5B5FB380.1000208@huawei.com> <20180731011256.GA30388@nautica>
CC:     <v9fs-developer@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, Greg Kurz <groug@kaod.org>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B5FBB2B.8030008@huawei.com>
Date:   Tue, 31 Jul 2018 09:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180731011256.GA30388@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/31 9:12, Dominique Martinet wrote:
> piaojun wrote on Tue, Jul 31, 2018:
>> This is really a *big* patch, but the modification seems no harm. And I
>> suggest running testcases to cover this. Please see my comments below.
> 
> I'm always running tests, but more never hurt - please help ;)

I'm glad to help testing, and actually I'm going to run some testcases in
xfs-test for 9p.

> 
> For reference I'm running a subset of cthon04[1], ltp[2] and some custom
> tests like these[3][4]
> 
> [1] https://fedorapeople.org/cgit/steved/public_git/cthon04.git/
> [2] https://github.com/linux-test-project/ltp
> [3] https://github.com/phdeniel/sigmund/blob/master/modules/allfs.inc#L208
> [4] https://github.com/phdeniel/sigmund/blob/master/modules/allfs.inc#L251
> 
>>> [...]
>>> @@ -263,13 +261,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>>>  	if (!req)
>>>  		return NULL;
>>>  
>>> -	req->tc = p9_fcall_alloc(alloc_msize);
>>> -	req->rc = p9_fcall_alloc(alloc_msize);
>>> -	if (!req->tc || !req->rc)
>>> +	if (p9_fcall_alloc(&req->tc, alloc_msize))
>>> +		goto free;
>>> +	if (p9_fcall_alloc(&req->rc, alloc_msize))
>>>  		goto free;
>>>  
>>> -	p9pdu_reset(req->tc);
>>> -	p9pdu_reset(req->rc);
>>> +	p9pdu_reset(&req->tc);
>>> +	p9pdu_reset(&req->rc);
>>>  	req->status = REQ_STATUS_ALLOC;
>>>  	init_waitqueue_head(&req->wq);
>>>  	INIT_LIST_HEAD(&req->req_list);
>>> @@ -281,7 +279,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>>>  				GFP_NOWAIT);
>>>  	else
>>>  		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
>>> -	req->tc->tag = tag;
>>> +	req->tc.tag = tag;
>>>  	spin_unlock_irq(&c->lock);
>>>  	idr_preload_end();
>>>  	if (tag < 0)
>>> @@ -290,8 +288,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>>>  	return req;
>>>  
>>>  free:
>>> -	kfree(req->tc);
>>> -	kfree(req->rc);
>>> +	kfree(req->tc.sdata);
>>> +	kfree(req->rc.sdata);
>>
>> I wonder if we will free a wild pointer as 'sdata' has not been initialized NULL.
> 
> Good point, it's possible to jump here if the first fcall_alloc failed
> since this declustered the two allocations.
> 
> Please consider this added to the previous patch (I'll send a v2 after
> this has had more time for review, you can find the amended commit in my
> 9p-test tree meanwhile):
> -----8<-----------------------------
> diff --git a/net/9p/client.c b/net/9p/client.c
> index ba99a94a12c9..fe030ef1c076 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -262,7 +262,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  		return NULL;
>  
>  	if (p9_fcall_alloc(&req->tc, alloc_msize))
> -		goto free;
> +		goto free_req;
>  	if (p9_fcall_alloc(&req->rc, alloc_msize))
>  		goto free;
>  
> @@ -290,6 +290,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  free:
>  	kfree(req->tc.sdata);
>  	kfree(req->rc.sdata);
> +free_req:
>  	kmem_cache_free(p9_req_cache, req);
>  	return ERR_PTR(-ENOMEM);
>  }
> -----8<-----------------------------
> 
> The second goto doesn't need changing because rc.sdata will be set to
> NULL if the allocation failed
> 
