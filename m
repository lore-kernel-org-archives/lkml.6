Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9672C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F6D205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H5aVCmCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F6D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeH3SAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:00:03 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:54956 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbeH3SAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:00:02 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 627D810C122B;
        Thu, 30 Aug 2018 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535637466; bh=6k1zoRLzZSG94an35JBtchiqePVUaxsoLDtDTl5MnTs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=H5aVCmCWQKMf+/L3JB7Yh1asXZ3rbiJ6nj9boLOBOUP3IkiR2Bpz9ccOSgtbupnGn
         HzesXCsT2smEq4dAI9fzj/MrI5Br3q/iN2aVhdo+IaObnAK4yW9j8KM59xHifMIRsX
         fzrgp7vwHtosthDIBgEw3PDNRQvl7F8avo54OSHiyKgzmg4VDqJjwHmonCimG6QUzj
         nl7w0bSlX2rZDYvujEBQ3wjCs1eXdN1uRvbMRbiYAtGHuXbIw8BdAtWJZ38qbtzQIr
         yRSs5/+bpHWfpeIC1SCkGFVS3Yi0cq6CqoAMF9dNMgecKYOKP7BkSxRvFMNE5KNsv+
         m/r2DsyzP1I4g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id D9BCA3ADF;
        Thu, 30 Aug 2018 06:57:42 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 06:57:42 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 15:57:40 +0200
Received: from [10.0.2.15] (10.107.25.44) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 30 Aug
 2018 15:57:39 +0200
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <Vitor.Soares@synopsys.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
From:   vitor <Vitor.Soares@synopsys.com>
Message-ID: <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
Date:   Thu, 30 Aug 2018 14:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.25.44]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Przemyslaw


On 28-08-2018 13:55, Przemyslaw Gaj wrote:
> Hi Vitor,
>
> I have already implemented Mastership request/handover but we are waiting for Boris’s patch to be accepted and merged. Anyway, my comments below.
>
> ﻿On 8/28/18, 2:02 PM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:
>
>      EXTERNAL MAIL
>      
>      
>      Hi Vitor,
>      
>      On Tue, 28 Aug 2018 12:50:12 +0100
>      vitor <Vitor.Soares@synopsys.com> wrote:
>      
>      > Hi Boris,
>      >
>      > The DT Bindings say "The node describing an I3C bus should be named
>      > i3c-master.". Do you have a field for secondary master?
>
> I think we don’t need separate field for secondary master. Main and secondary masters
> support similar functionalities. It’s enough to have this state internally and do mastership it it's needed.

Yes, you are right.

>
>      >
>      > On 24-08-2018 19:16, Boris Brezillon wrote:
>      > > Well, before even considering supporting secondary master registration,
>      > > we need to handle mastership handover. As for the DAA operation, it's
>      > > likely to be host specific, so we'll have to add a new hook to the
>      > > i3c_master_controller_ops struct.
>      > Do you mean when master try to delegate the bus ownership through
>      > GETACCMST? or to get the bus ownership with IBI-MR?
>      
>      I think we need to support both.
>
> I agree.

That's ok to me.

>      
>      >
>      > I think that could be useful to pass the ibi type on request_ibi(),
>      > there is some case where the master doesn't support IBI-MR.
>      
>      Actually, I was planning on making it completely separate from
>      regular slave IBIs. That is, the master controller driver would demux
>      the slave, MR and Hot Join IBIs, and if there's an MR request, queue a
>      mastership handover work to the workqueue (pretty much what we do for
>      Hot-Join already). Mastership handover is anyway likely to be IP
>      specific, so I don't think there's a need to make it look like a
>      regular IBI.
>
> I think it's better to have separate function to do mastership request.
>      
>      Regarding whether IBI-MR support should be exposed to the I3C framework
>      or not depends on how much will be automated on the framework side. I
>      don't the answer yet, but that's probably something will figure out
>      along the road.
>
> My current implementation is: when request_mastership field
> of i3c_master_controller_ops structure is set, master driver supports mastership requests.
> That's how I check if this is supported or not.
>      
>      Regards,
>      
>      Boris
>      
> Regards,
> Przemek
>
when you say request_mastership, do you mean the current master do the 
mastership hand-off or the secondary master request to be current master?

So, per my understanding since the Main master support the hand-off of 
the bus you accept all incoming MR, right? Or do you check all devices BCR?

Best regards,
Vitor Soares
