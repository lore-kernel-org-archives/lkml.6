Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E44C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E28A205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E28A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503114AbeKWUoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:44:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387971AbeKWUoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:44:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DE75DEEA67961;
        Fri, 23 Nov 2018 18:00:32 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 23 Nov
 2018 18:00:26 +0800
Subject: Re: [PATCH 05/10] staging: erofs: add a full barrier in
 erofs_workgroup_unfreeze
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-6-gaoxiang25@huawei.com>
 <20181122102230.GF3189@kroah.com>
 <1d1fd688-0cb5-cbac-9213-f56f7e356bca@huawei.com>
 <20181122185058.GA3466@andrea>
 <b2f367c5-a54c-9edf-42ad-d256bc725cf7@huawei.com>
 <20181123094739.GA3487@andrea>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5bf95ae0-cecb-c220-653b-704baee1cd8e@huawei.com>
Date:   Fri, 23 Nov 2018 18:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181123094739.GA3487@andrea>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On 2018/11/23 17:51, Andrea Parri wrote:
> Correct.  This is informally documented in Documentation/atomic_t.txt
> and formalized within tools/memory-model/.
> 
> 
>> I don't know whether my understanding is correct, If I am wrong..please correct me, or
>> I need to add more detailed code comments to explain in the code?
> Yes, please; please review the above points (including 1. and 3.) and
> try to address them with inline comments.  Maybe (if that matches the
> *behavior*/guarantee you have in mind...) something like:
> 
> [in erofs_workgroup_unfreeze()]
> 
> 	/*
> 	 * Orders the store/load to/from [???] and the store to
> 	 * ->refcount performed by the atomic_set() below.
> 	 *
> 	 * Matches the atomic_cmpxchg() in erofs_workgroup_get().
> 	 *
> 	 * Guarantees that if a successful atomic_cmpxchg() reads
> 	 * the value stored by the atomic_set() then [???].
> 	 */
> 	smp_mb();
> 	atomic_set(&grp->refcount, v);
> 
> 
> [in erofs_workgroup_get()]
> 
> 	/*
> 	 * Orders the load from ->refcount performed by the
> 	 * atomic_cmpxchg() below and the store/load [???].
> 	 *
> 	 * See the comment for the smp_mb() in
> 	 * erofs_workgroup_unfreeze().
> 	 */
> 	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
> 		goto repeat;
> 

OK, I will add these comments in the next version patchset, will be sent later.
Thanks for your suggestion. :)

Thanks,
Gao Xiang

> Thanks,
>   Andrea
> 
> 
