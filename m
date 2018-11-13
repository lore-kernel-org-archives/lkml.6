Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020F022506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020F022506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeKMKeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:34:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbeKMKeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:34:16 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE79C187B4502;
        Tue, 13 Nov 2018 08:38:39 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 08:38:35 +0800
Subject: Re: [PATCH 1/3] staging: erofs: unzip_vle.c: Replace comparison to
 NULL.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
 <1542055439-24444-2-git-send-email-sicilia.cristian@gmail.com>
 <20181112224636.GA12671@kroah.com>
 <CACU=YuX3U50uVaitV1Mhn3Dn8pXhPZt-1K7HX4Bn7MUCrgE35w@mail.gmail.com>
 <20181112234603.GB16079@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <f637a545-bcbb-c0a4-e95c-26e0294d3752@huawei.com>
Date:   Tue, 13 Nov 2018 08:38:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181112234603.GB16079@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/11/13 7:46, Greg Kroah-Hartman wrote:
> On Tue, Nov 13, 2018 at 12:31:58AM +0100, Cristian Sicilia wrote:
>> On Mon, Nov 12, 2018 at 11:46 PM Greg Kroah-Hartman <
>> gregkh@linuxfoundation.org> wrote:
>>
>>> On Mon, Nov 12, 2018 at 09:43:57PM +0100, Cristian Sicilia wrote:
>>>> Replace equal to NULL with logic unary operator,
>>>> and removing not equal to NULL comparison.
>>>>
>>>> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
>>>> ---
>>>>  drivers/staging/erofs/unzip_vle.c | 86
>>> +++++++++++++++++++--------------------
>>>>  1 file changed, 43 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/erofs/unzip_vle.c
>>> b/drivers/staging/erofs/unzip_vle.c
>>>> index 79d3ba6..1ffeeaa 100644
>>>> --- a/drivers/staging/erofs/unzip_vle.c
>>>> +++ b/drivers/staging/erofs/unzip_vle.c
>>>> @@ -20,8 +20,8 @@ static struct kmem_cache *z_erofs_workgroup_cachep
>>> __read_mostly;
>>>>
>>>>  void z_erofs_exit_zip_subsystem(void)
>>>>  {
>>>> -     BUG_ON(z_erofs_workqueue == NULL);
>>>> -     BUG_ON(z_erofs_workgroup_cachep == NULL);
>>>> +     BUG_ON(!z_erofs_workqueue);
>>>> +     BUG_ON(!z_erofs_workgroup_cachep);
>>>
>>> Long-term, all of these BUG_ON need to be removed as they imply that the
>>> developer has no idea what went wrong and can not recover.  For
>>> something like this, we "know" these will be fine and odds are they can
>>> just be removed entirely.
>>>
>>>
>> Right, I'm watching how replace the BUG_ON with WARN_ON and check who call
>> this functions
> 
> No, why would WARN_ON be any better?  Systems run with "panic on warn"
> enabled and this would cause the machine to reboot.  Why are these
> things even being checked in the first place if they are impossible to
> hit?
> 
> If they really are impossible, remove the check.  If they are not, then
> properly handle the logic if they are true.

I will remove the above BUG_ON()s since it looks redundant.

> 
> Linus said the other day something like "programmers who use BUG_ON()
> don't know what their code does", and I agree.  They are a crutch that
> we need to fix up in the whole kernel, not just staging.

I agree the phrase "programmers who use BUG_ON() don't know what their code does".
and some potential race I think it cannot happen in principle, but I also want to check them
on runtime via beta users, that should be avoided case by case.

erofs has another CONFIG_EROFS_FS_DEBUG switch to make some on-disk
assertions aggressively in development/debug mode, if CONFIG_EROFS_FS_DEBUG is on,
DBG_BUGON will be a BUG_ON; otherwise, it also has error handling paths to deal with them properly.
I have no idea whether I'm doing the right thing or not... such switch can also be found in f2fs called "F2FS_CHECK_FS".

config F2FS_CHECK_FS
	bool "F2FS consistency checking feature"
	depends on F2FS_FS
	help
	  Enables BUG_ONs which check the filesystem consistency in runtime.

	  If you want to improve the performance, say N.

Could you kindly give me some suggestions? Thanks..


> 
>>>>       destroy_workqueue(z_erofs_workqueue);
>>>>       kmem_cache_destroy(z_erofs_workgroup_cachep);
>>>> @@ -39,7 +39,7 @@ static inline int init_unzip_workqueue(void)
>>>>               WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
>>>>               onlinecpus + onlinecpus / 4);
>>>>
>>>> -     return z_erofs_workqueue != NULL ? 0 : -ENOMEM;
>>>> +     return z_erofs_workqueue ? 0 : -ENOMEM;
>>>
>>> I hate ?: notation that is not in a function parameter, any way you can
>>> just change this to:
>>>         if (z_erofs_workqueue)
>>>                 return 0;
>>>         return -ENOMEM;

OK, I will avoid these unnecessary ?: notations.

>>>
>>>
>> I will replace the ?: too
>>
>>
>>> Christian, this isn't your fault at all, I'm not rejecting this patch,
>>> just providing hints on what else you can do here :)
>>>
>>
>>
>> but (if I well understand) I will send a different patch for both fix,
>> right?
> 
> Yes, nothing wrong with this one that I could see.  I'll let the erofs
> maintainers review it first before applying it in a few days to my tree
These patches look good to me, and I will avoid this BUG_ON case by case as I promised to Al
before moving out the staging tree.

Thanks,
Gao Xiang


> 
> thanks,
> 
> greg k-h
> 
