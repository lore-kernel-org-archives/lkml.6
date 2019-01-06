Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177EAC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4662070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZV2rRCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfAFVN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:13:26 -0500
Received: from pb-sasl20.pobox.com ([173.228.157.48]:51015 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfAFVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:13:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id 144E135ADF;
        Sun,  6 Jan 2019 16:13:18 -0500 (EST)
        (envelope-from mlord@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=kDnT+q7gCUnK
        iCwm3DzzyAxFygs=; b=jZV2rRCqTn+EXvRLyQHHItYIPVx/ad0krV29wT5iqu9z
        xel7ucWp2xM+xnTqoHxcv8B4R8DNCGvVAHHE6sJc8qWkzS/VgHb9Y6jwH+2FFu4Y
        NzemoNRr2iMbqc36imG349Asgk2oyEVCUuxifV+DB1fGd6MyPKd4beL67H9FiDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TPrVOJ
        2dWtX6PilxDd7x2M9NT33fX/Lj4R8E/opegPAdMCyeyuvdCR0O/TUShPSuBD5QFF
        wq+lupUpEx438XfBWsy7jQRLeL4V1nC4LtruZoiI+wEX5ycfaVRn+YTUGFwR68Qt
        qFLAjey3VWR9PcTAyizMOFfo4KnJnz5N95c+A=
Received: from pb-sasl20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-sasl20.pobox.com (Postfix) with ESMTP id 0C41F35ADE;
        Sun,  6 Jan 2019 16:13:18 -0500 (EST)
        (envelope-from mlord@pobox.com)
Received: from [10.0.0.9] (unknown [24.53.240.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-sasl20.pobox.com (Postfix) with ESMTPSA id DC1D435ADD;
        Sun,  6 Jan 2019 16:13:14 -0500 (EST)
        (envelope-from mlord@pobox.com)
Subject: Re: r8152: data corruption in various scenarios
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
From:   Mark Lord <mlord@pobox.com>
Message-ID: <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
Date:   Sun, 6 Jan 2019 16:13:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
X-Pobox-Relay-ID: E1F9EEFA-11F7-11E9-BB9F-80D833260776-82205200!pb-sasl20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-06 2:14 p.m., Kai Heng Feng wrote:>> On Jan 5, 2019, at 10:14 =
PM, Mark Lord
<mlord@pobox.com> wrote:
..
>> There is even now a special hack in the upstream r8152.c to attempt to=
 detect
>> a Dell TB16 dock and disable RX Aggregation in the driver to prevent s=
uch issues.
>>
>> Well.. I have a WD15 dock, not a TB16, and that same hack also catches=
 my dock
>> in its net:
>>
>>    [5.794641] usb 4-1.2: Dell TB16 Dock, disable RX aggregation
>=20
> The serial should be unique according to Dell.
>
>> So one issue is that the code is not correctly identifying the dock,
>> and the WD15 is claimed to be immune from the r8152 issues.
>=20
> The WD15 I tested didn't use that serial number though...

What info do you need from me about the WD15 so this can be corrected?

>>   xhci_hcd 0000:39:00.0: ERROR Transfer event TRB DMA ptr not part of =
current TD ep_index 13
>> comp_code 1
>=20
> This is probably an xHC bug. A similar issue is fixed by commit 9da5a10=
92b13
> ("xhci: Bad Ethernet performance plugged in ASM1042A host=E2=80=9D).=20
>=20
>> I just got that exact message above, with the r8152 in my 1-day old WD=
15 dock,
>> with the TB16 "workaround" enabled in Linux kernel 4.20.0.
>=20
> Is the xHC WD15 connected an ASMedia one?

I don't know.  I *think* it identifies as a DSL6340 (see below).

Here is lspci and lsusb:

$ lspci -vt
-[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Process=
or Host Bridge/DRAM Registers
           +-02.0  Intel Corporation UHD Graphics 620
           +-04.0  Intel Corporation Skylake Processor Thermal Subsystem
           +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Contro=
ller
           +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
           +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Contr=
oller #0
           +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Contr=
oller #1
           +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
           +-1c.0-[01-39]----00.0-[02-39]--+-00.0-[03]--
           |                               +-01.0-[04-38]--
           |                               \-02.0-[39]----00.0  Intel Cor=
poration DSL6340 USB 3.1
Controller [Alpine Ridge]
           +-1c.4-[3a]----00.0  Qualcomm Atheros QCA6174 802.11ac Wireles=
s Network Adapter
           +-1d.0-[3b]----00.0  Samsung Electronics Co Ltd Device a808
           +-1f.0  Intel Corporation Device 9d4e
           +-1f.2  Intel Corporation Sunrise Point-LP PMC
           +-1f.3  Intel Corporation Sunrise Point-LP HD Audio
           \-1f.4  Intel Corporation Sunrise Point-LP SMBus
$ lsusb -t
/:  Bus 04.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 10000M
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/7p, 5000M
        |__ Port 2: Dev 3, If 0, Class=3DVendor Specific Class, Driver=3D=
r8152, 5000M
/:  Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 480M
    |__ Port 1: Dev 2, If 0, Class=3DHub, Driver=3Dhub/7p, 480M
        |__ Port 5: Dev 3, If 1, Class=3DAudio, Driver=3Dsnd-usb-audio, 4=
80M
        |__ Port 5: Dev 3, If 2, Class=3DAudio, Driver=3Dsnd-usb-audio, 4=
80M
        |__ Port 5: Dev 3, If 0, Class=3DAudio, Driver=3Dsnd-usb-audio, 4=
80M
        |__ Port 5: Dev 3, If 3, Class=3DAudio, Driver=3Dsnd-usb-audio, 4=
80M
        |__ Port 6: Dev 4, If 0, Class=3DHuman Interface Device, Driver=3D=
usbhid, 12M
        |__ Port 6: Dev 4, If 1, Class=3DHuman Interface Device, Driver=3D=
usbhid, 12M
        |__ Port 6: Dev 4, If 2, Class=3DHuman Interface Device, Driver=3D=
usbhid, 12M
        |__ Port 7: Dev 5, If 0, Class=3DHuman Interface Device, Driver=3D=
usbhid, 1.5M
/:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/6p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/12p, 480M
    |__ Port 3: Dev 2, If 0, Class=3DWireless, Driver=3Dbtusb, 12M
    |__ Port 3: Dev 2, If 1, Class=3DWireless, Driver=3Dbtusb, 12M

Thanks for having a look.
--=20
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
