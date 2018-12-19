Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F93C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4033821873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWMhxdW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeLSNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:21:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36462 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:21:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so17392179ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nVLY4n/0PV2xXg8jVcVqjI9na0lD5yGDU1orL7RgDTs=;
        b=IWMhxdW0GIk6wDZHD57VakpBFXR1doXDGbPu8xjiV02SQOEHgtRVYucb3T1zjlILiw
         2mhuc6b4aBxSTihVVPbNYPIq9vG0hQuLSuGgS1I3NoxuLHsukD6sUKwT+2GnC6cs6Otd
         JBwg9Qpq4UgjUyDwsK3173UNKQb2HLhmelkA0DoyLTN4gooOTHQBqelzawscRBjndr58
         Z5SgPswN7mw+torabpUJV9RIHijKR9cX53a6Mq3yRb9j2ddJgqsDNKNgul0Zv+gl4LgZ
         Byr604zoRR35YRTtGjhC+TMgRAU4LEW8/j/zDnqccE8avs+RQQrJKMNT/39pGM9ddXOD
         Nd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nVLY4n/0PV2xXg8jVcVqjI9na0lD5yGDU1orL7RgDTs=;
        b=Hm+ak4SSgrk0uuk42cbMcJnAzp/VgDC2m+OjkHgjvabFoJagRHH80v3AbdHr3scI9U
         utaD63npwwQuzHOSsY82M/il4/rk3PpXT1Zdx8Te6D+z1gI96/CO3oz4n+gd6XEHESkq
         uJ5V0jpIkgiYwI1m6m4VAsIyc0YNOFwltjBKurh8wllm6xSa4cqmqRUx+Pm4N7awTAkW
         I9W2UFxj/mO+72sx2HcgnybJ31Sz3+ZgjkhWjhTdo+xFomnxITtuPgW+c5KcWVJntxLI
         CkHg+IxlzGqA0Cvv7oCICKSDafccpgdSx9Sygise83HL3mmXh2n4z9e8piqmX7dYofcv
         G3Hw==
X-Gm-Message-State: AA+aEWYJV102FNRcvQDq2uYARLLwmt9+AXmt4HdrcGqw//ipaEY/LFSH
        0NqqqHIV1bl0DkpaqNWPMKI=
X-Google-Smtp-Source: AFSGD/XDrfKqp9G+JCNk2C7luYlyle6eB/bs0htlwMspdpGNjQEKOAVUOXuorxXANZzk777/Zu6wSQ==
X-Received: by 2002:a2e:2b11:: with SMTP id q17-v6mr12411966lje.25.1545225708179;
        Wed, 19 Dec 2018 05:21:48 -0800 (PST)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id w9sm3819992lfc.66.2018.12.19.05.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 05:21:47 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <c5fa494c-2ead-e190-6e8c-43478275f789@gmail.com>
 <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <dd166576-6771-a03f-bdee-ef798f789aed@gmail.com>
Date:   Wed, 19 Dec 2018 15:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219131452.cehks3kabcwuuk7i@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 3:14 PM, Gerd Hoffmann wrote:
>    Hi,
>
>>>> +    mapping = xen_obj->base.filp->f_mapping;
>>>> +    mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
>>> Let's see if I understand what you're doing:
>>>
>>> Here you say that the pages should be DMA accessible for devices that can
>>> only see 4GB.
>> Yes, your understanding is correct. As we are a para-virtualized device we
>> do not have strict requirements for 32-bit DMA. But, via dma-buf export,
>> the buffer we create can be used by real HW, e.g. one can pass-through
>> real HW devices into a guest domain and they can import our buffer (yes,
>> they can be IOMMU backed and other conditions may apply).
>> So, this is why we are limiting to DMA32 here, just to allow more possible
>> use-cases
> Sure this actually helps?  It's below 4G in guest physical address
> space, so it can be backed by pages which are actually above 4G in host
> physical address space ...

Yes, you are right here. This is why I wrote about the IOMMU

and other conditions. E.g. you can have a device which only

expects 32-bit, but thanks to IOMMU it can access pages above

4GiB seamlessly. So, this is why I *hope* that this code *may* help

such devices. Do you think I don't need that and have to remove?

>>>> +    if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
>>>> +            DMA_BIDIRECTIONAL)) {
>>>
>>> Are you using the DMA streaming API as a way to flush the caches?
>> Yes
>>> Does this mean that GFP_USER isn't making the buffer coherent?
>> No, it didn't help. I had a question [1] if there are any other better way
>> to achieve the same, but didn't have any response yet. So, I implemented
>> it via DMA API which helped.
> set_pages_array_*() ?
>
> See arch/x86/include/asm/set_memory.h
Well, x86... I am on arm which doesn't define that...
> HTH,
>    Gerd
>
Thank you,

Oleksandr

