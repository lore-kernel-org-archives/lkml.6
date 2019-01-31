Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E8220857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfAaPeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:34:13 -0500
Received: from relay.sw.ru ([185.231.240.75]:50226 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfAaPeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:34:12 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gpELu-000392-Kq; Thu, 31 Jan 2019 18:34:06 +0300
Subject: Re: [PATCH] net: check negative value for signed refcnt
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        alexandre.besnard@softathome.com, davem@davemloft.net,
        ecree@solarflare.com, jiri@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190131132008.23161-1-alexandre.besnard@softathome.com>
 <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
 <7bc31b61-8852-88a7-12bf-494c0e54574b@gmail.com>
 <31736d5e-8e14-67f2-9780-9ba6a6f10f4d@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <859d2649-31a0-0fae-7768-97bc9d754ccc@virtuozzo.com>
Date:   Thu, 31 Jan 2019 18:34:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <31736d5e-8e14-67f2-9780-9ba6a6f10f4d@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2019 18:21, Eric Dumazet wrote:
> 
> 
> On 01/31/2019 07:15 AM, Eric Dumazet wrote:
>>
>>
>> On 01/31/2019 05:49 AM, Kirill Tkhai wrote:
>>>
>>> 2)Not related to your patch -- it looks like we have problem in existing
>>> code with this netdev_refcnt_read(). It does not imply a memory ordering
>>> or some guarantees about reading percpu values. For example, in generic
>>> code struct percpu_ref switches a counter into atomic mode before it checks
>>> for the last reference. But there is nothing in netdev_refcnt_read().
>>
>> Well, if we read an old value here, after a full and expensive synchronize_net(),
>> then we would have lot more problems than simply having a second round in
>> netdev_wait_allrefs()
>>  
>>
> 
> percpu_ref was added more recently than the netdev_refcnt stuff, and is
> interesting for users wanting a synchronous wait for the refcnt reaching 0.
> 
> netdev_wait_allrefs() was designed to be asynchronous, so that we at least release
> RTNL (and current cpu) when something is wrong and a device can not be dismantled.

Yeah, they are different, and I think we can't add more synchronize_rcu()-dependent
synchronizations in this code, since network namespaces are already destroyed very slow.
