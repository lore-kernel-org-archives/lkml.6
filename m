Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F406206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bKMe1fRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F406206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIFLHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:07:05 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:32978 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIFLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:07:04 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4455410C1166;
        Wed,  5 Sep 2018 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536215591; bh=f9OeV60tVDrP8ZrrbUe8JyqYAAnUEFOfk0YM2Ms5Rj4=;
        h=From:To:CC:Subject:Date:References:From;
        b=bKMe1fRm7ux7pTyBs6KW7tajqDQRdAuktLerssH9GYIJsnv118oD4lDzbVrHYTYk6
         2H6sZZemifsxsZEcA/AlHva7nntgolJGruOey0CYzrQ1Vz2PdmN2xU5ImOlaL9lLUg
         X/vOtMciyZd2YUjRb1DaDoe5ss5JLon7dJ9QRc6iP76oSL/C6aY6qnf+/XbdbJUag0
         duUA9aZY2zQe/YdHFre1WNyIXL66waNGPVMU4Cq3Gcuqv6C8aVCfvPzqu5004GLopH
         jPImq/inYxDX4GGXBJl8y54RhBCf6BXUzTI+Ugl8cXGFhzCHsrznUECwGREnHjwht4
         E59GEZ39gsspQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id DDABB4DCA;
        Wed,  5 Sep 2018 23:33:10 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 5 Sep 2018 23:33:10 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 6 Sep 2018 10:33:07 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] usb: dwc2: power off during shutdown
Thread-Topic: [PATCH RFC] usb: dwc2: power off during shutdown
Thread-Index: AQHUQdnrerw4ENQnyUeZCj/DHLE7ag==
Date:   Thu, 6 Sep 2018 06:33:07 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7646E0@am04wembxa.internal.synopsys.com>
References: <1535795683-3788-1-git-send-email-stefan.wahren@i2se.com>
 <410670D7E743164D87FA6160E7907A56013A761B2B@am04wembxa.internal.synopsys.com>
 <470783016.30183.1536172949193@email.1und1.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.57]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,=0A=
=0A=
On 9/5/2018 10:42 PM, Stefan Wahren wrote:=0A=
> Hi Minas,=0A=
> =0A=
>> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> hat am 5. September 2=
018 um 10:37 geschrieben:=0A=
>>=0A=
>>=0A=
>> Hi Stefan,=0A=
>>=0A=
>> On 9/1/2018 1:55 PM, Stefan Wahren wrote:=0A=
>>> Currently USB consumes a lot of power after shutting down a Raspberry P=
i 3=0A=
>>> (example setup with Ethernet and a keyboard connected). So power off=0A=
>>> USB on shutdown.=0A=
>>>=0A=
>>> Measured on Raspberry Pi 3B with 4.19rc1/multi_v7_defconfig (HDMI, Ethe=
rnet=0A=
>>> and a keyboard connected)=0A=
>>>=0A=
>>> Before patch: 2.450 W=0A=
>>> After patch:  2.090 W=0A=
>>>=0A=
>>=0A=
>> Could you please elaborate. Power measurements done after shutdown?=0A=
> =0A=
> I did the following:=0A=
> =0A=
> sudo halt=0A=
> wait until "System halted" appears on the screen=0A=
> "measured" the current value displayed on my PSU=0A=
> =0A=
> You are right that not the same as poweroff. But in even in poweroff the =
board consumes 0.6 W, but in this case USB is powered down.=0A=
> =0A=
>> Why=0A=
>> your setup continue consume power after shutdown?=0A=
> =0A=
> The BCM2835 SoC has a GPU and a ARM core. Linux is running only on the AR=
M core. The GPU is usually running a close source firmware, which is starte=
d at first during boot und runs all the time.=0A=
> =0A=
>> Maybe its=0A=
>> sleep/hibernation mode?=0A=
> =0A=
> There isn't much implementation of power management for BCM2835 yet. So i=
 wanted to start with USB.=0A=
> Even for sleep/hibernation the consumption is much too high. Because the =
system consumes in idle 1.6 W.=0A=
> =0A=
>>=0A=
>> dwc2 core in your platform which type of power optimization supports:=0A=
>> partial power down, hibernation or extended hibernation? Please provide=
=0A=
>> me GHWCFG4 register value of your core.=0A=
> =0A=
> AFAIK all RPis use the same USB IP core:=0A=
> =0A=
> GHWCFG4 =3D 0x1ff00020=0A=
=0A=
Ok, your core doesn't support any power optimization mode.=0A=
=0A=
=0A=
> =0A=
> Stefan=0A=
> =0A=
=0A=
1. Could you please explain what is real/physical cause of power saving =0A=
after your patch: VBUS off, PHY clock stop or any other?=0A=
2. Can USB detect remote wake-up signaling from connected =0A=
keyboard/ethernet before and after your patch?=0A=
=0A=
Thanks,=0A=
Minas=0A=
