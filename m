Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E08ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F9621531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bm4oCCbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F9621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeITUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:01:28 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49110 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeITUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:01:28 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0706410C10A6;
        Thu, 20 Sep 2018 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537453066; bh=zsBHOhLVohr7OcaQq3fOxdE6nhPN5+KuIYWWTghXlgE=;
        h=From:To:CC:Subject:Date:References:From;
        b=bm4oCCbuxDtIAMzw07qgfZj1LPDFpbRxdHJrn1wUyTPCWzORSZEJgaGBBQWZWgKlL
         LQLL2LC03EVyXztHF1P/0K7YeNxMmL4HIcedqTmA1NYn4NRKVf6Iw/+HVTUZvsENl8
         Pd5TEqRdpA4ewm3JBPAvpUl0KqfWA6xkWeXCvqDBsHu3h4ZM6SAqniOAMmBO+nGV88
         hoQPy8zxw46nyDUX2pvRgxL+9MTtP2wGrAUWNZxV5IysiuP5PlBOov6rUZT7wLQ+yi
         ismC8nHFaWZu5anHiaMPIoHDNWwikvrTw64TAsj/JZOi9bmhjLbFHtDMJEIRk5kTkP
         skxHAFgUyW3CA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id AF39A30F0;
        Thu, 20 Sep 2018 07:17:45 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 07:17:45 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 20 Sep 2018 18:17:42 +0400
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Topic: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Index: AQHT7ws4O+8B/axYs0CeMD+6l4m0jQ==
Date:   Thu, 20 Sep 2018 14:17:42 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.104.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 5/23/2018 01:57, John Stultz wrote:=0A=
> On Tue, May 22, 2018 at 7:24 AM, Minas Harutyunyan=0A=
> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>> Hi John,=0A=
>>=0A=
>> Please provide log with debug enabled configuration.=0A=
> =0A=
> Ok. Attached.=0A=
> For dmesg-broken.log:  OTG removed at 77, and OTG plugged in at 82=0A=
> For dmesg-with-patch.log: OTG removed at 31, OTG plugged in at 38.=0A=
> =0A=
> Note with the dmesg-with-patch (using my patch), things seem to be=0A=
> working ok. Though in the example above it may look odd, as usually it=0A=
> switches to to host mode, then when it detects a low speed device (a=0A=
> mouse which I had plugged in), it will reset to switch to low-speed,=0A=
> but I didn't wait long enough for the reset to complete and the mouse=0A=
> to be detected before re-plugging in the OTG port.=0A=
> =0A=
>> On 5/21/2018 11:41 PM, John Stultz wrote:=0A=
>>> On Mon, May 21, 2018 at 1:45 AM, Minas Harutyunyan=0A=
>>> <Minas.Harutyunyan@synopsys.com> wrote:=0A=
>>>> Hi John,=0A=
>>>>=0A=
>>>> On 5/19/2018 4:49 AM, John Stultz wrote:=0A=
>>>>> In 4.17-rc, commit 03ea6d6e9e1f ("usb: dwc2: Enable power down")=0A=
>>>>> caused the HiKey board to not correctly handle switching between=0A=
>>>>> usb-gadget and usb-host mode.=0A=
>>>>>=0A=
>>>>> Unplugging the OTG port would result in:=0A=
>> OTG port you mean MicroAB, Correct?=0A=
> =0A=
> Correct.=0A=
> =0A=
>> dwc2 driver loaded when some device connected to OTG port?=0A=
> =0A=
> Yes, I normally boot with the board plugged in to OTG as a=0A=
> peripheral/gadget for adb.=0A=
> =0A=
>> And below message printed after disconnect the device from OTG port?=0A=
>>=0A=
>>>>> [   42.240973] dwc2 f72c0000.usb: dwc2_restore_host_registers: no hos=
t registers to restore=0A=
>>>>> [   42.249066] dwc2 f72c0000.usb: dwc2_host_exit_hibernation: failed =
to restore host registers=0A=
> =0A=
> Correct.=0A=
> =0A=
>>>>> And the USB-host ports would not function.=0A=
>> USB-host ports - you mean 2 USB A-ports, connected to TS3USB221 HUB?=0A=
> =0A=
> Correct.=0A=
> =0A=
>> Switching ports between OTG and Host ports via TS3USB221 Switch=0A=
>> performing automatically or by some SW tool?=0A=
> =0A=
> Its done automatically, when the OTG cable is detected it the host=0A=
> ports are disabled and when the OTG port is empty the host ports are=0A=
> enabled.=0A=
> =0A=
> Let me know if you need anything else!=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
=0A=
Please apply the patch set with this cover letter "[PATCH 0/3] usb: =0A=
dwc2: Fix hibernation for switching between host and device modes."=0A=
=0A=
Enable the power down on his devices. Let me know if you still see any =0A=
issue. If there is no issue, please provide Tested-by tag.=0A=
=0A=
=0A=
Regards,=0A=
Artur=0A=
