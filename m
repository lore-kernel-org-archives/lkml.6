Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2EFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAB72087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693725;
	bh=cTgZSq7YM09igmDrjLSy1ExfkAoV9Df20sz6sc1jlKc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vWUreEQBZI/fHjhNDcEgnjsaydIVttG0GHzXpDIP1KH/4YfdXa5PWeR+XJM/BU4qj
	 5pD6Z7DHAD/IADUVS7Yfk03uFvuat5rDGZ/Wi73heXauoz7D+H4CnD6RlRqoQfzxFN
	 BL7Cp1eKhEIm/KGvdK07VO5jo9sJzYYdezlbecVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbfA1QmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389529AbfA1QmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:42:00 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9428120879;
        Mon, 28 Jan 2019 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548693719;
        bh=cTgZSq7YM09igmDrjLSy1ExfkAoV9Df20sz6sc1jlKc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JldJbK2vS/5o8Z9YboqYnylD3TQ/jcMM5QIgfeVPDyHL8aB/R/JCdKnSTG7cStO8V
         NdfjbCQ8YU5NSi+ah6WZ1jYapPHrAfn8iiWYWOdD2iCmzaowuwlTqgZSliaq6OcPbv
         +0VKhN9OeFbu96V7Eoojlb6nMELtdPbEiczVk2AY=
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chao Yu <yuchao0@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1eed1e6b-f95e-aa8e-c3e7-e9870401ee23@kernel.org>
Date:   Tue, 29 Jan 2019 00:41:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Xiang,

On 2019-1-28 21:48, Gao Xiang wrote:
> Hi Dan,
> 
> On 2019/1/28 21:33, Dan Carpenter wrote:
>> Hopefully, regular kmalloc() is enough.
>>
>> Do really need the erofs_kmalloc() function?  Regular kmalloc() has
>> fault injection already.  Have you tried to use it?

Yes, I think we'd better to use erofs_kmalloc(). :)

Actually, fault injection in erofs_kmalloc only affect erofs module, we can
expect that the range of fault can be limited in erofs code, rather than whole
kernel, so the test point can be aimed at more accurately.

> 
> The fault injection subsystem was introduced in the initial upstreamed
> EROFS version, which is taken from f2fs by Chao Yu.
> 
> Fault injection is important to test fs.. However, I have no more idea
> about the future plan of this feature...Follow f2fs or use the general
> fault injection...

I guess following f2fs is not bad.

Thanks,

> 
> There already exists erofs_kmalloc, thus I think it's both ok to use
> erofs_kmalloc or kmalloc for this patch at least.
> 
> Chao, any idea about this?
> 
> Thanks,
> Gao Xiang
> 
