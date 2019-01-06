Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E289AC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8065A2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H3jzx/bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfAFVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:16:53 -0500
Received: from pb-sasl20.pobox.com ([173.228.157.48]:53941 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAFVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:16:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id 0D0DA35AF2;
        Sun,  6 Jan 2019 16:16:51 -0500 (EST)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:from
        :to:cc:references:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=0mvQHSYdFPl5
        ju8nfA3rMB4EvpE=; b=H3jzx/bcFbhK6lfZzMy6R5arpTYhmu2hGuTGB3BjT5J+
        /6OotZSiK9DC/L6Qx+ZMF/1PvjpPnJMvsGB+JdVGbhTVoUG2GZP1AKn5ZSAJ7BIi
        21bZtwtpfI0lpn0Awep4CBc9sgjKQfDHcLgv2lq5NpGb6E3lOHUEyibdbhehorQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:from:to
        :cc:references:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FsGoJU
        I9F0HlW+4jTswrXu2syjA5tHf+N/U6vBo6Lbw4cF7TZG+gU97PiVWwUC3e6Fc7MU
        Xwnh4aVULsWERQeluAmyuoPLZpZcUNxIK9tnfp0/zH3PzMi4uuwPMnQs8pI1vhtC
        KnLPd8/lvvC1vF/j7qQWSLXPiJeLINOFfUD+M=
Received: from pb-sasl20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id EA6F135AF1;
        Sun,  6 Jan 2019 16:16:50 -0500 (EST)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl20.pobox.com (Postfix) with ESMTPSA id AC3D535AF0;
        Sun,  6 Jan 2019 16:16:47 -0500 (EST)
        (envelope-from mlord@pobox.com)
Subject: Re: r8152: data corruption in various scenarios
From:   Mark Lord <mlord@pobox.com>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ansis Atteka <aatteka@nicira.com>,
        Hayes Wang <hayeswang@realtek.com>,
        David Miller <davem@davemloft.net>,
        "greg@kroah.com" <greg@kroah.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
Message-ID: <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
Date:   Sun, 6 Jan 2019 16:16:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
X-Pobox-Relay-ID: 60D19624-11F8-11E9-A6AD-80D833260776-82205200!pb-sasl20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-06 4:13 p.m., Mark Lord wrote:
> On 2019-01-06 2:14 p.m., Kai Heng Feng wrote:>> On Jan 5, 2019, at 10:1=
4 PM, Mark Lord
> <mlord@pobox.com> wrote:
> ..
>>> There is even now a special hack in the upstream r8152.c to attempt t=
o detect
>>> a Dell TB16 dock and disable RX Aggregation in the driver to prevent =
such issues.
>>>
>>> Well.. I have a WD15 dock, not a TB16, and that same hack also catche=
s my dock
>>> in its net:
>>>
>>>    [5.794641] usb 4-1.2: Dell TB16 Dock, disable RX aggregation
>>
>> The serial should be unique according to Dell.
>>
>>> So one issue is that the code is not correctly identifying the dock,
>>> and the WD15 is claimed to be immune from the r8152 issues.
>>
>> The WD15 I tested didn't use that serial number though...
>=20
> What info do you need from me about the WD15 so this can be corrected?
>=20
>>>   xhci_hcd 0000:39:00.0: ERROR Transfer event TRB DMA ptr not part of=
 current TD ep_index 13
>>> comp_code 1
>>
>> This is probably an xHC bug. A similar issue is fixed by commit 9da5a1=
092b13
>> ("xhci: Bad Ethernet performance plugged in ASM1042A host=E2=80=9D).=20
>>
>>> I just got that exact message above, with the r8152 in my 1-day old W=
D15 dock,
>>> with the TB16 "workaround" enabled in Linux kernel 4.20.0.
>>
>> Is the xHC WD15 connected an ASMedia one?
>=20
> I don't know.  I *think* it identifies as a DSL6340 (see below).
>=20
> Here is lspci and lsusb:
>=20
> $ lspci -vt
> -[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Proce=
ssor Host Bridge/DRAM Registers
>            +-02.0  Intel Corporation UHD Graphics 620
>            +-04.0  Intel Corporation Skylake Processor Thermal Subsyste=
m
>            +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Cont=
roller
>            +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
>            +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Con=
troller #0
>            +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Con=
troller #1
>            +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
>            +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
>            |                               +-01.0-[04-38]--
>            |                               \-02.0-[39]----00.0  Intel C=
orporation DSL6340 USB 3.1
> Controller [Alpine Ridge]
>            +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wirel=
ess Network Adapter
>            +-1d.0-[3b]----00.0  Samsung Electronics Co Ltd Device a808
>            +-1f.0  Intel Corporation Device 9d4e
>            +-1f.2  Intel Corporation Sunrise Point-LP PMC
>            +-1f.3  Intel Corporation Sunrise Point-LP HD Audio
>            \-1f.4  Intel Corporation Sunrise Point-LP SMBus


Mmm.. lspci -vt isn't as verbose as I thought, so here is plain lspci to =
fill in the blanks:

$ lspci
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Proce=
ssor Host Bridge/DRAM
Registers (rev 08)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (re=
v 07)

00:04.0 Signal processing controller: Intel Corporation Skylake Processor=
 Thermal Subsystem (rev 08)

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI C=
ontroller (rev 21)

00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP =
Thermal subsystem (rev 21)

00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP =
Serial IO I2C Controller #0
(rev 21)
00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP =
Serial IO I2C Controller #1
(rev 21)
00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME=
 HECI #1 (rev 21)

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root P=
ort (rev f1)

00:1c.4 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root P=
ort #5 (rev f1)

00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root P=
ort #9 (rev f1)

00:1f.0 ISA bridge: Intel Corporation Device 9d4e (rev 21)

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21=
)

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21=
)

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)

01:00.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpin=
e Ridge 2C 2015]

02:00.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpin=
e Ridge 2C 2015]

02:01.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpin=
e Ridge 2C 2015]

02:02.0 PCI bridge: Intel Corporation DSL6340 Thunderbolt 3 Bridge [Alpin=
e Ridge 2C 2015]

39:00.0 USB controller: Intel Corporation DSL6340 USB 3.1 Controller [Alp=
ine Ridge]

3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Ne=
twork Adapter (rev 32)

3b:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device=
 a808


--=20
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
