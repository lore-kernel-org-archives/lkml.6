Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1664A2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1mvFI/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLDS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:57:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42148 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:57:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so15930705lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wbry1vAtwQoQni0nW/CjPanigsxOs4bM0fWbB931q8=;
        b=g1mvFI/9EuLZyhJfujUUAkxvSupb1qTzMigfwziKVaHJcg0akDHSLvLAWq9f1A3Zi5
         /hXBrPSy+wzGa1Cik01wckNDlUREvpQoNysruZEkjWU9xq4XL9JwYFwq7XGNC2eY2PzI
         vf/OX/Rc7TEW/lsmuR1TnAlTwy8Rv1mKCoGq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3wbry1vAtwQoQni0nW/CjPanigsxOs4bM0fWbB931q8=;
        b=Ofuqr6n6X26cKjUoSeF77hwtfC+pkmGlVpq/zTaB5rCYrKwX+InOQUoa8pI0kyzqyu
         QZSeF1wJpwgTpNoac0MDGJ81TVOP1YKUFsSCRufbjuNn05nDBsiPFrTON5lJtBKnf1sx
         b5mNVwRAWxI2SmzY8NjVyoWxQOpP/Tta8Ssxjsf5vA0zXg7U8pslS+7pPo2sGlIbH9Nl
         to1IUReJf8vhNdDbwmO63yMdbS0DKGUhaIeoF4+R021pZ/+IMXVyjmbgrVD9CgQlo4+r
         N2ORXQXtDnkBWSYGyTr5+XjzFN+UWIOx6LH9+NRGZRbXr/a4mYj0gIG6uy9Hr/x3cx2Q
         2Gcw==
X-Gm-Message-State: AA+aEWaLbtaAQMXYnoQsSy44C3HZyzyJ09Dyz2dRbB3qrzb/rAD5fyk0
        HTQ4mQniqU05e6MpO1KatWS4iw==
X-Google-Smtp-Source: AFSGD/XLeQnB66LBZmvCAh5YfQRK3B7oR0wI7xWzT5cbY4VOy6EEtAI1GtYInrtSgZodJUjD1BTuUw==
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr14783467ljj.102.1543949845129;
        Tue, 04 Dec 2018 10:57:25 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id g17sm3115960lfg.78.2018.12.04.10.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 10:57:24 -0800 (PST)
Date:   Tue, 4 Dec 2018 20:57:22 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20181204185720.GI23230@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>> Update vlan mc and uc addresses with VID tag while propagating address
>>>> set to lower devices, do this only if address is not synched. It allows
>>>> on end driver level to distinguish address belonging to vlans.
>>>
>>> Underlying driver for the real device would be able to properly identify
>>> that you are attempting to add an address to a virtual device, which
>>> happens to be of VLAN kind so I am really not sure this is the right
>>> approach here.
>>>
>>> From there, it seems to me that we have two situations:
>>>
>>> - each of your network devices expose VLAN devices directly on top of
>>> the real device, in which case your driver should support
>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>>> are create and maintain a VLAN device to VID correspondence if it needs
>>> to when being called while setting the addresses
>>>
>>> - you are setting up a bridge that is VLAN aware on one of your bridge
>>> ports, and there you can use switchdev to learn about such events and
>>> know about both addresses as well as VIDs that must be programmed into
>>> your real device
>> No limits to have any "middle" device between real end device and
>> virtual one, not only a bridge, but also other kind. And as it's generic
>> change, it should cover all such cases, the simplest example is:
>> real_dev/macvlan/vlan.
>
>It is not generic if the additional information is a VLAN ID, that
>construct does not apply to all types of virtual devices, that is part
>of my issue with the extra VID that is being added. If this was a void *
>priv and any virtual device could pass up/down information that might be
>more acceptable.

You mean to create smth like common struct pinned to "an address" and
pass information not only like vid, but in parallel what ever user wanted.
Even if pass vlan device pointer it still considered like an address
continuation and same sync method is used w/o modification. And here vid
is considered as part of address, by a big account address+vid it's a
separate address, same happens with the pointer, address+pointer it's
still separate address.

I was thinking also about pinned list of vlans to the address, but in
this case this information also has to be synced by members of device chain,
because it can be modified on any device level and it looks not very friendly,
and at the end address space has addresses with pinned lists of vlans with
their pointers. But keeping this stuff in sync is not simplest decision.


-- 
Regards,
Ivan Khoronzhuk
