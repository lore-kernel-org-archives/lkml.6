Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB28BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E83A21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e3WRCoDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E83A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeIXL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:58:26 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:41020 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeIXL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:58:26 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CB1F324E10CA;
        Sun, 23 Sep 2018 22:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537768679; bh=vkuTdtqMKbQcrNoAqIXpm5OyOnS7rPBhDs1WXOtnXo4=;
        h=From:To:CC:Subject:Date:References:From;
        b=e3WRCoDK5Wzt4JHisvf8+m+BF3GbepZ08XWJhwGn0EnLlTsiqs92Ogo3r70Pg2BzQ
         lk1T2T9gbIt0YOkAB85Bjru8PwP0EHnu5llH/C246U3mC/j/UYjKAIdMoanYJUH4ht
         +iLai07X2C/XWs1uugCzxvooRvBjTtQihGo1DMdCIhQ99fHV+iOaAC1izj7NwpsBmZ
         xjjIe4fnPnkO7KfHq5lJ60NS64Ufls5NSdhT1VJSfZQKiktTpaTivZOyt4fPb4Qzre
         70KUNzfOzgPxXkzVpp4PBVjLxVill/sZv62iMSf/XnfB5QWQu7V81sgf+o6iOwdzZG
         cR3mldrWRL2ew==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8DFFA538E;
        Sun, 23 Sep 2018 22:57:59 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sun, 23 Sep 2018 22:57:59 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 24 Sep 2018 09:57:56 +0400
From:   Artur Petrosyan <arthur.petrosyan@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Topic: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Index: AQHT7ws4O+8B/axYs0CeMD+6l4m0jQ==
Date:   Mon, 24 Sep 2018 05:57:56 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.160]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 9/21/2018 05:05, John Stultz wrote:=0A=
> On Thu, Sep 20, 2018 at 7:17 AM, Artur Petrosyan=0A=
> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>> On 5/23/2018 01:57, John Stultz wrote:=0A=
>>> Its done automatically, when the OTG cable is detected it the host=0A=
>>> ports are disabled and when the OTG port is empty the host ports are=0A=
>>> enabled.=0A=
>>>=0A=
>>> Let me know if you need anything else!=0A=
>>>=0A=
>>=0A=
>> Please apply the patch set with this cover letter "[PATCH 0/3] usb:=0A=
>> dwc2: Fix hibernation for switching between host and device modes."=0A=
> =0A=
> Sorry, can you send the patches to me, or point me to a git tree? I'm=0A=
> not seeing that thread in my mailbox or on google.=0A=
> =0A=
>> Enable the power down on his devices. Let me know if you still see any=
=0A=
>> issue. If there is no issue, please provide Tested-by tag.=0A=
> =0A=
> Would be happy to test it, thought I'm traveling tomorrow, so I may=0A=
> not be able to validate till monday.=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
=0A=
You can find the patch set following to this link.=0A=
=0A=
https://marc.info/?l=3Dlinux-usb&m=3D153745139408236&w=3D2=0A=
=0A=
Regards,=0A=
Artur=0A=
=0A=
