Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79867C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D57A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH4rihhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeLTLTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:19:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37353 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:19:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so1037334lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pHtTs6KHm6BdZnSGv7rSta30oEewrBNdyzWeLYp8VgQ=;
        b=oH4rihhjXRvpjkbHslN4NNN7t0zffwxOHXLSSHNRRogsWF8lFMTmPIm+v/eQS5bzlz
         oCHdZmC8ZfGIPYyyW5VFtyLQqFfX4KnWAwCb28Z8QiXiDRsFYYDiGFycfLDkBxvzjgEx
         SiiHA4beFKDro9FmVCXkO9VVx1r8Cckj4BJ0RQzVagh3fQjV2a35/oCSstoictFOHnEa
         IasppzEFTZvEhZQtSqtxA1QF/VkqWncdM0B+6XLJ/6xd7x3pdy3PUh1tIYJLaq/Ge+z3
         lYCqNenP3qrgqGspOB3FElUpXLtsKvRUVwviIi7x9JHjAOXkCkIL1QjHccld7TlALcys
         hdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pHtTs6KHm6BdZnSGv7rSta30oEewrBNdyzWeLYp8VgQ=;
        b=c2Y7vFWe12Ze96TXb1Kz4DO4vqtzsJ3NnTa10ryl8cW+FVbUPsYsR9h3vAxRUeC/0n
         UStScGVhqZqw5CjS43SdpJE+cza5bjr3ZoxTYZtM535INB9AlpyCEgYiKai67JELhoXq
         UtqgrpgckQB7UFlmgd5yESSniXxGF2IWc2+QOqTq43SHQWHoYlnWM4Q52/GyKvqrvHeu
         SoesPkjn+EHawkCS7S+Nst0v/Ppqm5EX2pGHRwKhUzT3cUWijko1dE1phnGrF/xQzIa6
         8IF0B80gy7XTFElDasYLrNpkboUpYlJoslhE05utCDzgA3KCzpeHoo+Uio4DDeiKWKSq
         c6Fw==
X-Gm-Message-State: AA+aEWZkcG5VM8A1TKqBozZhGr3A5xX92DlFRAjLH0efR1QLucTf5Y9G
        dB5grCvGRv6DCXC2wprDvwM=
X-Google-Smtp-Source: AFSGD/VpyaYh2hHNtYaZL//eQc5zIVs6oSObD3+8Xb5hmDGKqhlxxtdH3Qyx06/0WPyrR71nAlXNyw==
X-Received: by 2002:a19:e601:: with SMTP id d1mr15455353lfh.71.1545304746233;
        Thu, 20 Dec 2018 03:19:06 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id u26-v6sm3949241lji.22.2018.12.20.03.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 03:19:05 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Gerd Hoffmann <kraxel@redhat.com>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
 <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
 <dd166576-6771-a03f-bdee-ef798f789aed@gmail.com>
 <20181219141000.k426c7o6ncsdzrn5@sirius.home.kraxel.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3e24ecc5-25e1-3d5e-2092-daa95ae36cba@gmail.com>
Date:   Thu, 20 Dec 2018 13:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219141000.k426c7o6ncsdzrn5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 4:10 PM, Gerd Hoffmann wrote:
>    Hi,
>
>>> Sure this actually helps?  It's below 4G in guest physical address
>>> space, so it can be backed by pages which are actually above 4G in host
>>> physical address space ...
>> Yes, you are right here. This is why I wrote about the IOMMU
>> and other conditions. E.g. you can have a device which only
>> expects 32-bit, but thanks to IOMMU it can access pages above
>> 4GiB seamlessly. So, this is why I *hope* that this code *may* help
>> such devices. Do you think I don't need that and have to remove?
> I would try without that, and maybe add a runtime option (module
> parameter) later if it turns out some hardware actually needs that.
> Devices which can do 32bit DMA only become less and less common these
> days.
Good point, will remove then
>>>>>> +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>>>>> +            DMA_BIDIRECTIONAL)) {
>>>>> Are you using the DMA streaming API as a way to flush the caches?
>>>> Yes
>>>>> Does this mean that GFP_USER isn't making the buffer coherent?
>>>> No, it didn't help. I had a question [1] if there are any other better way
>>>> to achieve the same, but didn't have any response yet. So, I implemented
>>>> it via DMA API which helped.
>>> set_pages_array_*() ?
>>>
>>> See arch/x86/include/asm/set_memory.h
>> Well, x86... I am on arm which doesn't define that...
> Oh, arm.  Maybe ask on a arm list then.  I know on arm you have to care
> about caching a lot more, but that also is where my knowledge ends ...
>
> Using dma_map_sg for cache flushing looks like a sledge hammer approach
> to me.
It is. This is why I am so unsure this is way to go
>    But maybe it is needed to make xen flush the caches (xen guests
> have their own dma mapping implementation, right?  Or is this different
> on arm than on x86?).
I'll try to figure out
> cheers,
>    Gerd
>
Thank you,
Oleksandr
