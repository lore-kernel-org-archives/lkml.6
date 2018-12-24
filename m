Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23389C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D009C2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QGNtSUF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLXHSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:18:42 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:44608 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeLXHSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:18:42 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9E7D824E242A;
        Sun, 23 Dec 2018 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545635921; bh=0huw/XRniSN/1u/8DADwlRhKafz6Ffg2P6Nygfq4EUI=;
        h=From:To:CC:Subject:Date:References:From;
        b=QGNtSUF4wDGt+PdJ52FOVa9Q6WNbP88Nn0kaNOt1/c8HRuB9d7Wge+U6aL6E5e67I
         ZjSuugijXJLgSMl7zWpTw3/TbF/BeIDsa6TOlVpfwdOEzJUvcs6cjeqJH6kMvSPJsd
         W8Fmg0DO3Bh6xFteyT0WAF9mc39r3XQJ3Y7iyQZPfBEAM7P3ymwgNuCWJlDZgea9uC
         JhcZ5XjlHkJEepELfGqxXFQR4WpsV9dBaeDU4nAAzSN2PQg584C0sJfCkSOfH0Fqzd
         FdCyJpLyekmcDh4PPLXOohxxW7kTUR2JbpK5FnqYWwpSdniBiQgI5N1OQWMdr1aVNc
         HG9aufeHj5hjg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 63E6954A8;
        Sun, 23 Dec 2018 23:18:41 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 23 Dec 2018 23:18:40 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 24 Dec 2018 11:18:37 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Thread-Topic: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Thread-Index: AQHUatZW7CBOg1jSlEOevZqXY6bG3Q==
Date:   Mon, 24 Dec 2018 07:18:36 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7C1D84@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
 <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
 <20181108173654.118f9e3e@donbot>
 <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
 <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
 <20181109184246.33cb4487@donbot>
 <410670D7E743164D87FA6160E7907A56013A7A27D7@am04wembxa.internal.synopsys.com>
 <20181112224626.6b44568a@donbot>
 <410670D7E743164D87FA6160E7907A56013A7BAB28@am04wembxa.internal.synopsys.com>
 <20181218143504.027fc53c@donbot>
 <410670D7E743164D87FA6160E7907A56013A7BECBB@am04wembxa.internal.synopsys.com>
 <20181221160504.15e93827@donbot>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 12/21/2018 8:05 PM, John Keeping wrote:=0A=
> Hi Minas,=0A=
> =0A=
> On Wed, 19 Dec 2018 14:09:01 +0000=0A=
> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:=0A=
> =0A=
>> On 12/18/2018 6:35 PM, John Keeping wrote:=0A=
>>> Hi Minas,=0A=
>>>=0A=
>>> On Fri, 14 Dec 2018 09:00:08 +0000=0A=
>>> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:=0A=
>>>> First of all, sorry for delayed answer.=0A=
>>>> Looks like similar issue seen by Andrzej Pietrasiewicz=0A=
>>>> <andrzej.p@samsung.com>: "dwc2 isochronous transfers issues". Same=0A=
>>>> feedback provided to Andrzej.=0A=
>>>>=0A=
>>>> I run tests on 4.20.0-rc4 in DDMA. By default IN ISOC traffic=0A=
>>>> failed because of BNA interrupts. It's happen because UAC2=0A=
>>>> requests count set by default to 2. Our core and driver can't work=0A=
>>>> in DDMA with descriptor list length equal to 2. It's not possible=0A=
>>>> on time prepare next descriptors to avoid BNA interrupt.=0A=
>>>>=0A=
>>>> By changing UAC2_DEF_REQ_NUM to 4 all audio gadget tests passed=0A=
>>>> smoothly. Could you please apply this patch and run tests in DDMA=0A=
>>>> mode:=0A=
>>>>=0A=
>>>> diff --git a/drivers/usb/gadget/function/u_uac2.h=0A=
>>>> b/drivers/usb/gadget/function/u_uac2.h=0A=
>>>> index 8362ee572e1e..5e649259ab76 100644=0A=
>>>> --- a/drivers/usb/gadget/function/u_uac2.h=0A=
>>>> +++ b/drivers/usb/gadget/function/u_uac2.h=0A=
>>>> @@ -21,7 +21,7 @@=0A=
>>>>     #define UAC2_DEF_CCHMASK 0x3=0A=
>>>>     #define UAC2_DEF_CSRATE 64000=0A=
>>>>     #define UAC2_DEF_CSSIZE 2=0A=
>>>> -#define UAC2_DEF_REQ_NUM 2=0A=
>>>> +#define UAC2_DEF_REQ_NUM 4=0A=
>>>>=0A=
>>>>     struct f_uac2_opts {=0A=
>>>>            struct usb_function_instance    func_inst;=0A=
>>>>=0A=
>>>>=0A=
>>>> If it will OK on your side also then will switch to BDMA mode and=0A=
>>>> debug.=0A=
>>>=0A=
>>> With DDMA enabled, I see the following error after the stream has=0A=
>>> been running for a while (anything from a few seconds to a few=0A=
>>> minutes):=0A=
>>> -- >8 --=0A=
>>> [ 1798.836322] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called for=0A=
>>> ep0 [ 1798.836329] dwc2 ff580000.usb: dwc2_hsotg_ep_disable: called=0A=
>>> for ep0 [ 1798.851092] dwc2 ff580000.usb: new device is high-speed=0A=
>>> [ 1798.924461] dwc2 ff580000.usb: new device is high-speed=0A=
>>> [ 1798.982887] dwc2 ff580000.usb: new address 25=0A=
>>> [ 1799.002463] configfs-gadget gadget: high-speed config #1: config=0A=
>>> -- 8< --=0A=
>>>=0A=
>>> On the host side (Linux 4.18.16 Intel xHCI), I see this logged at=0A=
>>> the same time:=0A=
>>>    =0A=
>>> -- >8 --=0A=
>>> [1735740.716242] retire_capture_urb: usb 1-2.2.7: frame 0 active:=0A=
>>> -71 [1735740.716990] retire_capture_urb: usb 1-2.2.7: frame 0=0A=
>>> active: -71 [1735740.717906] retire_capture_urb: usb 1-2.2.7: frame=0A=
>>> 0 active: -71 [1735740.718905] retire_capture_urb: usb 1-2.2.7:=0A=
>>> frame 0 active: -71 [1735740.719916] retire_capture_urb: usb=0A=
>>> 1-2.2.7: frame 0 active: -71 [1735740.720032] usb 1-2.2-port7:=0A=
>>> disabled by hub (EMI?), re-enabling... [1735740.720036] usb=0A=
>>> 1-2.2.7: USB disconnect, device number 28 [1735740.937500] usb=0A=
>>> 1-2.2.7: new high-speed USB device number 29 using xhci_hcd -- 8< --=0A=
>>>=0A=
>>> The device does then enumerate and works for a period of time=0A=
>>> before the same error happens again.=0A=
>>>    =0A=
>>   From logs not clear who initiate disconnect: host or device.  More=0A=
>> probably host, after some errors in retire_capture_urb initiate=0A=
>> disconnect. Do you have any idea?=0A=
>> Can't you connect device to host on same platform?=0A=
>> If root cause of disconnect by host is device issue, i.e. not able to=0A=
>> send to host data packets in time then I need device side dmesg log=0A=
>> with debug enabled. USB trace around the disconnect will help to=0A=
>> debug.=0A=
> =0A=
> I remember running a test with a hardware USB analyzer and which showed=
=0A=
> an isochronous packet with an incorrect length (much larger than it=0A=
> should have been) when the failure occurred.=0A=
> =0A=
> I don't have any logs from that test and I'm out of the office at the=0A=
> moment, but I will capture logs when I'm back in January.=0A=
=0A=
I think, if you enable debug prints, you will see BNA interrupts. So, my =
=0A=
recommendation is to increase more UAC2_DEF_REQ_NUM until BNA will =0A=
disappear. Per me value of UAC2_DEF_REQ_NUM is platform's latency dependent=
.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
> =0A=
> =0A=
> Thanks,=0A=
> John=0A=
> =0A=
=0A=
