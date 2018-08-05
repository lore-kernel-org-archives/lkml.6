Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6AC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE318217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="RBcHfTbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE318217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeHEOyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 10:54:05 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37408 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHEOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 10:54:04 -0400
Received: by mail-oi0-f44.google.com with SMTP id j205-v6so17600373oib.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zlsDgZJF1jjTaYdLErWnf7sFZ13+O4u06XK7ZUG1ewQ=;
        b=RBcHfTbuw21MBCNptWCLQuZnp8YTAnN3pY0cq0eI/E38VJyRUyBNpp8mltxyzX79hx
         X89pN8/lSXeGraeZpPJyDiYf7HzZZKkRcF1WGdHp/Mh1hoZ3bLwHWeoNQ5x7F2qEcD1O
         aS8ope4QY9d1ptCpjc/8MWY4wJzPs8yUNbZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zlsDgZJF1jjTaYdLErWnf7sFZ13+O4u06XK7ZUG1ewQ=;
        b=bHNoSzDZwAvn5SU5JPxgjPw7BuhJIu2MFE1ceqRAnPMelphylVpzOMf4nPA1bGuPyz
         dyzNJ7Kt837SXKAVxsumqwFC8qx0tiYNgv060DW47ycRAUtXbd6R9KlCtCZVBr++a63H
         5VLjGuxSlEA+Bhj9QMBU1DyS3RLpKpRYQASnuqJm9f5oeNFYLswY//KPYI/g5JqEAQAY
         Wtyq/lyETxHCJoMpM4UUH3WTCqxdU9oKXk5KvtE/VzuanBLjmbroueObGP2udbDIDu0f
         jvHExAHAmpHPCA/GyDWIvxcJyFW4sIl09zNoAQusQ+KGpAy491+ZzBPg7zphvVAtoOmj
         ibhQ==
X-Gm-Message-State: AOUpUlFqXnk/2b8Ch5C3f8BVDl65hq+YF+2xkCJN/FePyxjr5BCoNF5p
        sx+OwjyJAeK7vDdkjaOvW0R0gg==
X-Google-Smtp-Source: AA+uWPwhLvHnrI5xJJFa/4n7heVaWs73u33TnnJW0oz3AMbkB4c+gUGxcWhJQvdFRvMaLLn6t2y44Q==
X-Received: by 2002:aca:3805:: with SMTP id f5-v6mr9768063oia.310.1533473373641;
        Sun, 05 Aug 2018 05:49:33 -0700 (PDT)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id q18-v6sm7434720oic.18.2018.08.05.05.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 05:49:32 -0700 (PDT)
Received: by mail-oi0-f45.google.com with SMTP id w126-v6so17583301oie.7;
        Sun, 05 Aug 2018 05:49:32 -0700 (PDT)
X-Received: by 2002:aca:acb:: with SMTP id k72-v6mr11301374oiy.78.1533473371660;
 Sun, 05 Aug 2018 05:49:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b54c:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 05:49:31 -0700 (PDT)
In-Reply-To: <6dda350b-66ab-b5ab-41ed-319b27e4e28c@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de> <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de> <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg0uP6ddm-kjev6JAH=GrKX9bT6s2canFOjKsC4rCcVAQ@mail.gmail.com> <6dda350b-66ab-b5ab-41ed-319b27e4e28c@suse.de>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Sun, 5 Aug 2018 20:49:31 +0800
X-Gmail-Original-Message-ID: <CAC=mGzhtr0SuOmgJpcXODAzTzSb3xKSnyy9bnq37NuM8fDqBqQ@mail.gmail.com>
Message-ID: <CAC=mGzhtr0SuOmgJpcXODAzTzSb3xKSnyy9bnq37NuM8fDqBqQ@mail.gmail.com>
Subject: Re: linux-lora.git and LoRaWAN (was: [RFC net-next 00/15] net: A
 socket API for LoRa)
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <Ben.Whitten@lairdtech.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Brian Ray <brian.ray@link-labs.com>,
        "lora@globalsat.com.tw" <lora@globalsat.com.tw>,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        Daniele Comel <dcomel@mipot.com>, Powen Ko <powenk@looptek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

2018-08-03 16:44 GMT+08:00 Andreas F=C3=A4rber <afaerber@suse.de>:
> Hi Jian-Hong,
>
> Am 02.08.2018 um 09:52 schrieb Jian-Hong Pan:
>> 2018-07-18 19:28 GMT+08:00 Ben Whitten <Ben.Whitten@lairdtech.com>:
>>>> 1) PF_LORA/AF_LORA and associated identifiers are
>>>> proposed to represent
>>>>    this technology. While for an SX1276 [...] it
>>>> might work to
>>>>    layer LoRaWAN as a protocol option for PF_LORA and
>> add
>>>> LoRaWAN address
>>>>    fields to the union in my sockaddr_lora, how would that
>>>> work for devices
>>>>    that only support LoRaWAN but not pure LoRa? Do we
>>>> need both AF_LORA and
>>>>    AF_LORAWAN, or just a separate ETH_P_LORAWAN or
>>>> ARPHRD_LORAWAN?
> [...]
>>>> Meanwhile my attempt to play with netlink during SUSE
>>>> Hackweek has been
>>>> going slow and I could use some guidance or a volunteer to
>>>> contribute: I
>>>> have a bare skeleton of registration, commands, attributes
>>>> and multicast
>>>> groups, but no plan yet how to connect that to the actual
>>>> drivers to
>>>> query or apply the settings...
>>>
>>> Happy to help, I will be starting from zero on netlink but I can contri=
bute my existing work incorporating Marks comments for sx1301 etal.
>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/li
>>>> nux-lora.git/tree/net/lora/netlink.c?h=3Dlora-next
>>
>> Is this the repository used for the LoRa subsystem now?!!!
>> If it is, than great!
>
> Yes, my linux-lora.git contains this RFC patchset (modulo SX1276 fixes
> spotted by kbuild bot) plus a new serdev driver for another module and
> ongoing work by Ben and me for refactoring SX1301. It's monitored by the
> 0-day test service (kbuild bot).
>
> As this patchset was an RFC and does not have any Acked-bys from
> maintainers, the tree does not have a for-next branch integrated into
> linux-next on basis of 4.18-rc1, but instead (like my personal GitHub
> tree before) has a lora-next branch that rebases as patch queue on top
> of linux-next for now.
>
> The intent is to allow collaboration on getting things into a state that
> I can later submit a clean (squashed) RFC v2 for review, with all issues
> raised for this v1 addressed.
>
> For contributing patches to my linux-lora.git I suggest to use
> --subject-prefix=3D"PATCH lora-next" to distinguish from net-next.
> And I just realize I should add a MAINTAINERS entry in my tree to make
> sure patches CC me, too. (I do monitor netdev for patches with subject
> "lora", but chances are someone might omit that.)
>
>> As the previous mails, I am trying to implement the LoRaWAN
>> specification as the soft MAC as the MAC layer over LoRa PHY.
>> This is the the talk about LoRaWAN class module I gave in Netdev Conf
>> https://www.slideshare.net/chienhungpan/lorawan-class-module-and-subsyst=
em
>>
>> The expectation is:
>>
>> socket APIs:
>> send and receive the data
>> ------------------------------------------------------------
>> LoRaWAN class module implements MAC:
>> append the header/footer, encryption/decryption, timing slot and MAC com=
mands
>> ------------------------------------------------------------
>> LoRa device drivers:
>> send and receive the messages for MAC layer
>> ------------------------------------------------------------
>> LoRa devices
>
> Thanks for sharing your slides. We seem to be in alignment for the
> abstract concept above. The devil is in the implementation details. ^.-
>
>> Is it possible that combine the LoRaWAN class module I implemented?
>
> Yes, as stated in this cover letter, I would love if you could help
> merge your LoRaWAN implementation with my driver framework. Comparing
> 802.15.4 and 802.11, I think MAC code should go into net/maclorawan/ and
> then is a fairly independent module, with you as maintainer.
>
>> I start from the simplest class A end device's behavior, especially
>> the timing slot.
>> Also the encryption/decryption for uplink/downlink data messages.
>> I can send it as patches.
>>
>> However, I have 2 problems right now.
>> 1. Which Address and Protocol Family should we use?  PF_LORA or PF_LORAW=
AN?
>
> That was one of the questions I raised above. I now think we need both.
> I'm not yet too deep into LoRaWAN, but from the AT command interfaces
> I've seen there's confirmed and unconfirmed transmission modes that with
> PF_LORAWAN might be mapped to SOCK_STREAM and SOCK_DGRAM. Or do you see
> a way of doing both on a single PF_LORA SOCK_LORAWAN socket?
>
>> 2. To test the LoRaWAN class module, adding more procedures in LoRa
>> device drivers to register as a LoRaWAN device is needed.
>
> No, I don't think so. There are (at least) two types of devices, LoRaWAN
> and LoRa devices. The SX1276 is a pure LoRa device and thus should only
> expose a LoRa network device. It'll be the task of the maclorawan module
> to translate between the two layers, not the business of the device
> driver; SX1276 should receive a ready-to-send LoRa skb. For Ethernet,
> PF_INET and PF_INET6 don't need separate devices either, both use eth0.
>
> What I do think we need is your struct lora_hw, maybe renamed to
> lora_phy. That could be the missing piece for registration of the device
> drivers with nllora module?
> Note that similarly we'll also need an nllorawan module that needs to
> work both with your maclorawan and with some of my device drivers that
> implement the MAC in an MCU.

Let me think these twice.

> Additionally I've been looking into socket options at PF_LORA dgram
> layer for some radio options, but discarded that again for lack of
> precedence. Basically I wondered whether we could allow to choose SF,
> bandwidth, etc. on socket level and then apply those settings before
> sending one packet rather than expecting a global netlink operation that
> affects all sockets for that interface.

According to the LoRaWAN Regional Parameters, we should have the APIs
to set the SF, frequency, bandwidth ...
The idea is: LoRaWAN class module gets the region of this device and
the device's abilities.  Then LoRaWAN class module calls the callback
functions to set the related parameters: SF, frequency, bandwidth ...
And of course, the setting actions only happen in the idle, standby or
stop status.
1. Interface is being startup.
2. Requested by MAC command.

But let start from simple case and add more features and complexity in
the future.

By the way, I am rearranging the module's code and try to make it
could be patches.

Regards,
Jian-Hong Pan
