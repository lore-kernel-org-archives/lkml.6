Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FC9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E1A208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeFPFk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 01:40:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7617 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeFPFk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 01:40:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b24a2d50000>; Fri, 15 Jun 2018 22:40:37 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Jun 2018 22:40:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Jun 2018 22:40:55 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Sat, 16 Jun
 2018 05:40:55 +0000
Subject: Re: OpenAFS module libafs.ko uses GPL-only symbol
 '__put_devmap_managed_page'
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Joe Gorse <jhgorse@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
References: <CAFhSwD9RNcsaTNdT-4DiE_BKK6zrsdBbNbGBEkBoJuwQn1JdQA@mail.gmail.com>
 <CAPcyv4hpjNaUz6qpJ0_Wh1SAz9tS9a5HLsYSgeCh_pNZKfY74A@mail.gmail.com>
 <1970355c-ebca-7f7d-38f7-ceac1ae553fb@nvidia.com>
 <CAPcyv4j=LFY31zn7yFXUrsrvzQEz=a92VLOa=Tp46JbGHhC7Xw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a6a16c1c-3e80-2cf8-6d8d-1d0fc91008af@nvidia.com>
Date:   Fri, 15 Jun 2018 22:40:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j=LFY31zn7yFXUrsrvzQEz=a92VLOa=Tp46JbGHhC7Xw@mail.gmail.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 10:22 PM, Dan Williams wrote:
> On Fri, Jun 15, 2018 at 9:43 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 06/13/2018 12:51 PM, Dan Williams wrote:
>>> [ adding Andrew, Christoph, and linux-mm ]
>>>
>>> On Wed, Jun 13, 2018 at 12:33 PM, Joe Gorse <jhgorse@gmail.com> wrote:
[snip]
>>>>
>>>> P.S. The build failure, for the morbidly curious:
>>>>> FATAL: modpost: GPL-incompatible module libafs.ko uses GPL-only symbol
>>>>> '__put_devmap_managed_page'
>>>>> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
>>>>> make[6]: *** [__modpost] Error 1
>>>
>>> I think the right answer here is to make __put_devmap_managed_page()
>>> EXPORT_SYMBOL(), since features like devm_memremap_pages() want to
>>> change the behavior of all users of put_page(). It again holds that
>>> devm_memremap_pages() needs to become EXPORT_SYMBOL_GPL() because it,
>>> not put_page(), is the interface that is leaking control of core
>>> kernel state/infrastructure to its users.
>>>
>>
>> Hi Dan and all,
>>
>> It looks like put_page() also picks up one more GPL symbol:
>> devmap_managed_key.
>>
>> put_page
>>     put_devmap_managed_page
>>         devmap_managed_key
>>
>>     __put_devmap_managed_page
>>
>>
>> So if the goal is to restore put_page() to be effectively EXPORT_SYMBOL
>> again, then I think there would also need to be either a non-inlined
>> wrapper for devmap_managed_key (awkward for a static key), or else make
>> it EXPORT_SYMBOL, or maybe something else that's less obvious to me at the
>> moment.
> 
> Right, certainly flipping the key is a kernel internal detail since it
> is giving the dev_pagemap owner purview over all kernel page events,
> but put_page() users are silent consumers. And you're right there's
> currently no good way I see to export the 'producer' and 'consumer'
> side of the key with different export types.
> 

It's hard to imagine how anyone could end up using devmap_managed_key
in an out-of-tree driver, given that other related symbols are already
locked down with EXPORT_SYMBOL_GPL. So one easy fix might be to just
make it EXPORT_SYMBOL, with a comment that explains the intent, and just
call it a day:

/* This is intended to be EXPORT_SYMBOL_GPL, but actually doing so would
 * cause a problem for put_page().
 */
EXPORT_SYMBOL(devmap_managed_key);

...I'm sort of winging it here... :)

