Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF58C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C67420863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcqgz74B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfAaPVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:21:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39846 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfAaPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:21:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so1485707pgp.6;
        Thu, 31 Jan 2019 07:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GE7SJdNx4qLg9UnW00aQtJCxABeEsNvYYl8NJrid//I=;
        b=Xcqgz74BjfFNtJBilsGI4ETNhhrb5IDJfOGN2OZCqUnjCrbr3xBYwInyLo5skglutH
         CVChCe86oe3tHFF6El4qSZx1kl+s31A1tCYq3MIzfsAN4Ea/bXf1tE/j6t/d77GIC8Ja
         /Xko3qkRlr9RcCA+sbCdmg72TMphCk2jUX0H4KMl7d1gofKU/PPfbXITaaM6TuW/lzlQ
         joQ1yU6PAy1JoX0ej44qV5wFwVT496QTL5hpsKC86LefP1cEfnvje6FY7cIgeuGPxhA3
         v53E34BitTQS065x0lJa7PsWnYq+XC1NZIOF2dpb7FwYrqzsv8ps0GtZ5VrSGJNjfvTI
         JEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GE7SJdNx4qLg9UnW00aQtJCxABeEsNvYYl8NJrid//I=;
        b=m/TvZJaqF74J6QYeHui+ZyNtA6Y8bvDiazNgiyJar/NymdQzUF4H8LuammzaouMjcc
         9DYn/gq3kCgRxhtS2D4Suve1IPVSKnvco4aQlv9o67aVmoUQcsVyrwgLdRmWdBMt3jwO
         Znq7nZzRbWZmvIKfx+WL1wPPsKmsuZrXDwjH/mM3Q9tl5q7SwFgnnrM+xY4OiMKynAN+
         B+02SPZKl1Slh7i8LvL8rq2GntmkjuOGdEThCrGBD+1c7mn7KMpuI/AZBaNV7v9yaAhp
         bSwhH/jGH+wNxxwWNULRgvn91QQz8gNI0zlPzQXojHmDmB3GDDN//TjMc1lzzhzrik5V
         sq/w==
X-Gm-Message-State: AJcUukfLB25jPVmfpZreRzGJQjCc3dgMhyrzUxDLF8g72e99QxkiNJrF
        Xe//SoSQnc5ykEIK+dGCYsjDHp8H
X-Google-Smtp-Source: ALg8bN6iwJYSJ28jwactwtE4pyj0b4EkUgD3ER+W7+AxG9z6QHVUrZjBfV/i+49eckHtNamxQBU3/g==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr31765742pgb.417.1548948081410;
        Thu, 31 Jan 2019 07:21:21 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id t67sm7719013pfd.90.2019.01.31.07.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:21:20 -0800 (PST)
Subject: Re: [PATCH] net: check negative value for signed refcnt
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        alexandre.besnard@softathome.com, davem@davemloft.net,
        ecree@solarflare.com, jiri@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190131132008.23161-1-alexandre.besnard@softathome.com>
 <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
 <7bc31b61-8852-88a7-12bf-494c0e54574b@gmail.com>
Message-ID: <31736d5e-8e14-67f2-9780-9ba6a6f10f4d@gmail.com>
Date:   Thu, 31 Jan 2019 07:21:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7bc31b61-8852-88a7-12bf-494c0e54574b@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/31/2019 07:15 AM, Eric Dumazet wrote:
> 
> 
> On 01/31/2019 05:49 AM, Kirill Tkhai wrote:
>>
>> 2)Not related to your patch -- it looks like we have problem in existing
>> code with this netdev_refcnt_read(). It does not imply a memory ordering
>> or some guarantees about reading percpu values. For example, in generic
>> code struct percpu_ref switches a counter into atomic mode before it checks
>> for the last reference. But there is nothing in netdev_refcnt_read().
> 
> Well, if we read an old value here, after a full and expensive synchronize_net(),
> then we would have lot more problems than simply having a second round in
> netdev_wait_allrefs()
>  
> 

percpu_ref was added more recently than the netdev_refcnt stuff, and is
interesting for users wanting a synchronous wait for the refcnt reaching 0.

netdev_wait_allrefs() was designed to be asynchronous, so that we at least release
RTNL (and current cpu) when something is wrong and a device can not be dismantled.

