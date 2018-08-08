Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5138721725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5138721725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHHSnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:43:24 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:45267 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:43:24 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60358 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fnREg-0004J6-5C; Wed, 08 Aug 2018 18:22:58 +0200
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-2-sam@ravnborg.org>
 <634ea7d9-7cc1-f404-b072-0bafbc748fb7@tronnes.org>
 <20180808082431.GA29143@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <754bd65e-5fae-f4eb-66a1-e94f1e552849@tronnes.org>
Date:   Wed, 8 Aug 2018 18:22:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808082431.GA29143@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 08.08.2018 10.24, skrev Sam Ravnborg:
> Hi Noralf.
>
> On Tue, Aug 07, 2018 at 06:40:29PM +0200, Noralf Trønnes wrote:
>> Hi Sam,
>>
>> Den 02.08.2018 21.45, skrev Sam Ravnborg:
>>> The pardata supports implement a simple bus for devices
>>> that are connected using a parallel bus driven by GPIOs.
>>> The is often used in combination with simple displays
>>> that is often seen in older embedded designs.
>>> There is a demand for this support also in the linux
>>> kernel for HW designs that uses these kind of displays.
>>>
>>> The pardata bus uses a platfrom_driver that when probed
>>> creates devices for all child nodes in the DT,
>>> which are then supposed to be handled by pardata_drivers.
>>>
>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>> ---
>>  From a quick look at this I have these comments:
>> 1. There can only be one implementation of this bus, the gpio one.
>>     There are SOC's with parallel bus hardware so you need to allow for
>>     more implementations.
>> 2. The client shouldn't do the bus signaling. This should be hidden
>>     behind read and write functions in pardata.
>> 3. I would also suggest you add an address bus instead of the RS pin
>> 4. I don't think reset belongs in the bus. It's a device thing.
> Excellent feedback - I will address this in v2.
>
>> 5. You can use gpiod_set_array_value() in the gpio implementation.
>>     Some gpio drivers can set all gpios at once.
> Yes, it is already used. But only for DB0 to DB7 as there
> are timing constraings for the others.
>
>> I made an attempt at implementing a bus like this a while back:
>> https://github.com/notro/fbdbi/tree/master/i80
> Thanks, very helpfull.
>
> v2 will take a while as I plan to have something that actually works
> before posting next version.
>
> One open question. Miguel Ojeda mentioned that there is already a
> limited fbdev driver made on top of parport (part of auxdisplay).
> Is it the correct design to come up with a new bus or should this
> try to build on top of parport?
>
> I did not check in details if using parport is possible, but from a
> quick look it is doable.
> But then we use parport for something that it originally was not
> designed for and we drag with us a lot of extra functionality.
> So I like the slimmer pardata bus.

I couldn't find a parport gpio driver, so you would have to write one by
the looks of it.

I think it would be best to add a new bus type, but that's just my opinion.
I suggest you study the other bus types (spi, i2c, spmi) to get an
understanding of how it's done.

Noralf.

