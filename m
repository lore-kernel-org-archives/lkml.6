Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F22C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70685206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFtX1Aih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70685206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLDXmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:42:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37899 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:42:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so16595389lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wkYtTDGTiMQxbwnwm9RDBEe7eaCq3UM3IHLcVkssWUI=;
        b=dFtX1AihWfLeoXIxLOQYilHGpMsb9k80ZclmFFXkcMlvQa0VkXNTJiIsaFvLvVUUb7
         PL0vwO0iUMAhkufHIPL+C8rLwM5EDQemxzP8hXid/F6lPbcniSIOrjZ1vPVAIWrsZi4i
         6WxFIaDKogR2MlCgKbzdq5M+UufXiZS1eNpiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wkYtTDGTiMQxbwnwm9RDBEe7eaCq3UM3IHLcVkssWUI=;
        b=pBTLISRML5rjiuwVhb5EItzCWDY45ygNdUdp1e4xJ6caCsGKDIwNV+c/ophjRkyfvW
         31jHvDxKJKuUhW4Txo2y8Cnx/9hF1Kr6w5+4keMA65P/s14bkAfPg1lyspHWzx9bGpNJ
         mdG3w/pCJMdXvcLitNDM29gBKDivxYCUjQJVaLJ6JDpgyXEndo2zQcwySm0fKBtydd6e
         6u39/r4BukBCZzYN+jeXh1NG8Sfiy2FTxH5sqJo6cwCsoF9PI0y23rOZD5UckZIOeO4A
         4oXaZ/0B/i7CrZ/n5bVS5IYo2uz+94H7XRKSE7FM0hTun+ILAyZR1knzEunRElcc+fJF
         dGVQ==
X-Gm-Message-State: AA+aEWa42MjM8KyxeVrn7DO/ivSA8lBEGnnPN/Udv1L9qNIoEolCXGi9
        A7hZ8r9kvXzP/N1u2wq1PoHRoA==
X-Google-Smtp-Source: AFSGD/WC3DGH41/+7R8j3i9Q+Zt64AlTkB5VTCFBmg28Ascw8YFLL7YMK7dgm3Dn7fHka8HdOEOhfw==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr15679259ljj.158.1543966960002;
        Tue, 04 Dec 2018 15:42:40 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id x29-v6sm3401339ljb.97.2018.12.04.15.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:42:39 -0800 (PST)
Date:   Wed, 5 Dec 2018 01:42:37 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20181204234236.GA3507@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>On 12/4/18 10:57 AM, Ivan Khoronzhuk wrote:
>> On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>>> On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>>>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>>>> Update vlan mc and uc addresses with VID tag while propagating address
>>>>>> set to lower devices, do this only if address is not synched. It
>>>>>> allows
>>>>>> on end driver level to distinguish address belonging to vlans.
>>>>>
>>>>> Underlying driver for the real device would be able to properly
>>>>> identify
>>>>> that you are attempting to add an address to a virtual device, which
>>>>> happens to be of VLAN kind so I am really not sure this is the right
>>>>> approach here.
>>>>>
>>>>> From there, it seems to me that we have two situations:
>>>>>
>>>>> - each of your network devices expose VLAN devices directly on top of
>>>>> the real device, in which case your driver should support
>>>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>>>>> are create and maintain a VLAN device to VID correspondence if it needs
>>>>> to when being called while setting the addresses
>>>>>
>>>>> - you are setting up a bridge that is VLAN aware on one of your bridge
>>>>> ports, and there you can use switchdev to learn about such events and
>>>>> know about both addresses as well as VIDs that must be programmed into
>>>>> your real device
>>>> No limits to have any "middle" device between real end device and
>>>> virtual one, not only a bridge, but also other kind. And as it's generic
>>>> change, it should cover all such cases, the simplest example is:
>>>> real_dev/macvlan/vlan.
>>>
>>> It is not generic if the additional information is a VLAN ID, that
>>> construct does not apply to all types of virtual devices, that is part
>>> of my issue with the extra VID that is being added. If this was a void *
>>> priv and any virtual device could pass up/down information that might be
>>> more acceptable.
>>
>> You mean to create smth like common struct pinned to "an address" and
>> pass information not only like vid, but in parallel what ever user wanted.
>> Even if pass vlan device pointer it still considered like an address
>> continuation and same sync method is used w/o modification. And here vid
>> is considered as part of address, by a big account address+vid it's a
>> separate address, same happens with the pointer, address+pointer it's
>> still separate address.
>
>That depends on the HW implementation, some switches do individual VLAN
>learning (IVL) and some do shared VLAN learning (SVL) so whether the VID
>becomes part of the address resolution logic is HW dependent, obviously
>the more capable, the better (IVL).

In my case IVL is only choice, as SVL is rather imitation, as each vlan
has it's own address table anyway. And I mean not only vlan configuration
above the bridge but also any simple configuration above real device.

There is proposition to add smth like additional list of entries pinned
to the each address as you proposed, but in a little bit different way.

Pin the context pointers to each address if IVL config is enabled.
Smth like

+struct ctx_entry {
+       void *info;
+       unsigned type;
+       int synced;
+       int sync_cnt;
+       int refcount;
+}

Then in hw_addr struct add a ctx_list:

 struct netdev_hw_addr {
        struct list_head        list;
+       struct list_head        ctx_list;
        unsigned char           addr[MAX_ADDR_LEN];
        unsigned char           type;
.....
}

Each ctx_entry contains pointer to some structure, in my case it could be
pointer on vlan net_dev, and it can be marked with type VLAN_DEVICE_POINTER or
else. In some other invisible cases it could be another one. Main difference
between each of them is its pointer and type.

And once each net dev calls mc/uc_sync these entires, if not synced, are synced
along with addresses. But main difference that these ctx entires are pinned to
the address, when addresses are pinned to the device.

It can allow to bring information any new abstraction can apply.
For real device the list can be empty or contain special entry to differ
it from the vlan device entries, as could happen only some vlan is address
owner.

Not sure it can be much simpler but it definitely can introduce more
capabilities, and potentially cover some other cases including your.

Probably I need rename the series on smth like:
"make addressing scheme to be IVL capable"

and send RFCv2

Thanks for your comment, it's really valuable.

>
>>
>> I was thinking also about pinned list of vlans to the address, but in
>> this case this information also has to be synced by members of device
>> chain,
>> because it can be modified on any device level and it looks not very
>> friendly,
>> and at the end address space has addresses with pinned lists of vlans with
>> their pointers. But keeping this stuff in sync is not simplest decision.
>>
>>
>
>I really think we are not communicating properly, it really seems to me
>that if you had the information about the upper device trying to add an
>address to the lower device filter's either through notification or call
>to ndo_set_rxmode, you could be solving your problems. What are we
>missing here?
>--
>Florian

-- 
Regards,
Ivan Khoronzhuk
