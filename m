Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2212145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gknSrr6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2212145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeKURuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:50:03 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36476 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeKURuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:50:02 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 905DD24E108D;
        Tue, 20 Nov 2018 23:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542784603; bh=Bt8r1GN/ifO2yroBZvvbW3JblDi4fSVwNHfa5lI4bVQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=gknSrr6D11HkvbdjHOjaDyPEvwtkOmJTc0KRsRP+4p0217+yTqmUTh1kRPlwSJNl/
         zAaFA70TtH31fIvv0aQLdrMIYfITHKCxxWMOwNg2Mv2KQ/zQuo/xBlzG5/uB19AO7H
         bettciqyxvfSuPEFd3EtmiA7IRvhanWqzmkXp/6C4kM22ue80M/TCTUWPdh2XmXxd3
         XT9r4HUvCYdGZ1yhyYzrY+zx88wYXYbD1TwTZj8ibPNUV4GQRnS29YV2q7OLfrPM80
         KiV77Z9yqiXKj6Am42IeagPtDLd+5ecbpiWOGH5OfcQwu+85/6GsIHe/vBZaG+u8Va
         5i09PcXD6amtw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 74C0258CC;
        Tue, 20 Nov 2018 23:16:43 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 20 Nov 2018 23:16:43 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 21 Nov 2018 11:16:40 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Doug Anderson <dianders@chromium.org>,
        Terin Stock <terin@terinstock.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        "Minas Harutyunyan" <minas.harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
Thread-Topic: [PATCH v2] usb: dwc2: host: use hrtimer for NAK retries
Thread-Index: AQHUSL4wspCdYjVV40WMJtnEsOwxHQ==
Date:   Wed, 21 Nov 2018 07:16:39 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7A9610@am04wembxa.internal.synopsys.com>
References: <153655347149.19910.4781444209586693527.stgit@Rincon.localdomain>
 <CAD=FV=Vau3KL=hqbu-jx19VvGZ5FZug+C-sxxdw2hiAtCXgBtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2018 3:30 AM, Doug Anderson wrote:=0A=
> Hi,=0A=
> =0A=
> On Sun, Sep 9, 2018 at 9:24 PM Terin Stock <terin@terinstock.com> wrote:=
=0A=
>>=0A=
>> Modify the wait delay utilize the high resolution timer API to allow for=
=0A=
>> more precisely scheduled callbacks.=0A=
>>=0A=
>> A previous commit added a 1ms retry delay after multiple consecutive=0A=
>> NAKed transactions using jiffies. On systems with a low timer interrupt=
=0A=
>> frequency, this delay may be significantly longer than specified,=0A=
>> resulting in misbehavior with some USB devices.=0A=
>>=0A=
>> This scenario was reached on a Raspberry Pi 3B with a Macally FDD-USB=0A=
>> floppy drive (identified as 0424:0fdc Standard Microsystems Corp.=0A=
>> Floppy, based on the USB97CFDC USB FDC). With the relay delay, the drive=
=0A=
>> would be unable to mount a disk, replying with NAKs until the device was=
=0A=
>> reset.=0A=
>>=0A=
>> Using ktime, the delta between starting the timer (in dwc2_hcd_qh_add)=
=0A=
>> and the callback function can be determined. With the original delay=0A=
>> implementation, this value was consistently approximately 12ms. (output=
=0A=
>> in us).=0A=
>>=0A=
>>      <idle>-0     [000] ..s.  1600.559974: dwc2_wait_timer_fn: wait_time=
r delta: 11976=0A=
>>      <idle>-0     [000] ..s.  1600.571974: dwc2_wait_timer_fn: wait_time=
r delta: 11977=0A=
>>      <idle>-0     [000] ..s.  1600.583974: dwc2_wait_timer_fn: wait_time=
r delta: 11976=0A=
>>      <idle>-0     [000] ..s.  1600.595974: dwc2_wait_timer_fn: wait_time=
r delta: 11977=0A=
>>=0A=
>> After converting the relay delay to using a higher resolution timer, the=
=0A=
>> delay was much closer to 1ms.=0A=
>>=0A=
>>      <idle>-0     [000] d.h.  1956.553017: dwc2_wait_timer_fn: wait_time=
r delta: 1002=0A=
>>      <idle>-0     [000] d.h.  1956.554114: dwc2_wait_timer_fn: wait_time=
r delta: 1002=0A=
>>      <idle>-0     [000] d.h.  1957.542660: dwc2_wait_timer_fn: wait_time=
r delta: 1004=0A=
>>      <idle>-0     [000] d.h.  1957.543701: dwc2_wait_timer_fn: wait_time=
r delta: 1002=0A=
>>=0A=
>> The floppy drive operates properly with delays up to approximately 5ms,=
=0A=
>> and sends NAKs for any delays that are longer.=0A=
>>=0A=
>> Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions ri=
ght away")=0A=
>> Signed-off-by: Terin Stock <terin@terinstock.com>=0A=
>> ---=0A=
>>   drivers/usb/dwc2/hcd.h       |    2 +-=0A=
>>   drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------=0A=
>>   2 files changed, 13 insertions(+), 8 deletions(-)=0A=
> =0A=
> Reviewed-by: Douglas Anderson <dianders@chromium.org>=0A=
> Cc: stable@vger.kernel.org=0A=
> =0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
