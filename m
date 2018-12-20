Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AE821741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeLTKAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:00:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42568 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeLTKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:00:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so1187463edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylwzKhANp4Cl8xusWKqb85xW+2cdSkQ3nxCl1I5yYWs=;
        b=esb5Nw/9ZWrfMh60pUYIoDKbuMjWnQyHLwI964xS7Y25UIROt52WT1lJlYn5CWx51Z
         jvbIYwyz484zBWQKX7RrV0yepG1oHa4QLN1OO/0o8x6XZUEri3QSCc0Sb6Tf3c9kOrFM
         GYb5MZv1S8TSUpTE6Sp5wSbvOuF5iydFBQq4eiX9+jAXdLphKSH3ZuSAKo3H7kRT3UDR
         A4/h8Jx9UdlbNS+cOg6vqiGqVPYcNwwy4H9losy/PzuzpKchrpCjt11kZV4QKBef1pcj
         u4cchwMR9EdPjuhhZjQSp0Y4tArPqSJljVJ3tIK82HfU4F8WcDmccr+3kmYm2kX7SATw
         tbaw==
X-Gm-Message-State: AA+aEWbyq87l85iR3JZ/hBnQGsLZLqfiEwS0jvXFc2ATUMg3KCV+wIQY
        nZlVOoKG7X8pyY34cIufvgGI8uNELGw=
X-Google-Smtp-Source: AFSGD/U+z0NW0ZSR9XZ3d8SpPEG73Cd5o78YWj37ciMqJWCZXrwore7exMuiLuL3XBB9kBNGDHua7g==
X-Received: by 2002:a50:d643:: with SMTP id c3mr22291753edj.178.1545300031177;
        Thu, 20 Dec 2018 02:00:31 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s3sm6001255edm.31.2018.12.20.02.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 02:00:30 -0800 (PST)
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
Date:   Thu, 20 Dec 2018 11:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181219223341.GA998@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-12-18 23:33, Wolfram Sang wrote:
> Hi Lukas, Hans,
> 
> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 18:22, Lukas Wunner wrote:
>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>> +{
>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +}
>>>
>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>> Any reason why you can't use that?  If so, it would be good to document the
>>> reason in the commit message.
>>
>> Oh, that is a very good point and that one only gets set on system suspend
>> and not on resume suspend, working around the problems with the i2c-designware
> 
> Just to make it clear: you mean runtime suspend, not resume suspend, or?

Yes I mean runtime-suspend, sorry.

>> driver.
>>
>> I think this might be as simple as adding:
>>
>> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
>> 		return -ESHUTDOWN;
> 
> I have seen this flag but decided against it. One reason is because it
> is marked as "PM core only".

Right and we definitely should not be touching it, but reading it should
be fine.

> The other reason is that it doesn't know
> about the adapter lock. It might get set while a transfer is on going.
> Or even right after the suggested if-block above. The code from this
> series gets the mutex first which ensures that on going transfers are
> completed and no new ones are started in parallel.
> 
> Unless I am totally overlooking something...

No you are right, there is a race here, but I don't think we are likely to
hit that race. Normally there won't be any ongoing i2c-transfers during
a system suspend and more over, the goal of adding this check is to help
find problems, so even if the check sometimes does not trigger because
of the race that is not really a big deal.

I think we need to get really unlucky to have both a suspend ordering
problem in the first case (already a somewhat rare thing) combined with
hitting this race in such a way *each time* that we don't trigger the
WARN_ON.

To me this seems a case of perfect being the enemy of good. When we
first started discussing this you wanted to not have to modify the
adapter/bus drivers for the check, using adap->dev.parent->power.is_suspended
gives us that and it will also work for complex cases like
the i2c-designware case, so I believe the benefits outway the downsides.

Regards,

Hans
