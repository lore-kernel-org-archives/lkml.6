Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1C2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kelkQbCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF1C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeG0MVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:21:36 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:49826 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbeG0MVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:21:36 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EA3C210C1279;
        Fri, 27 Jul 2018 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532689212; bh=8A+8Yotd315gqgsutUcjGMuHDSSUYbNly4xfnR9r334=;
        h=From:To:CC:Subject:Date:References:From;
        b=kelkQbCCqQHMCLAH4Y4oW3oC1d84UdZdPR3NBi4z7yLdiyan2oQTwl4ggNY9z2DPA
         Qj7MicmbrnrFURxPgofJujLpahCSPc6bDqIbdFE9vAfLVqbWlTXbegvlMx8tHH98Wy
         Vx6H+iywtwLaf4oE16e+CM20scjBopapGnUbQCDnUByMhZbd2QHeebjSlV+YuL769Z
         dsWwcUA2lSRJoakiToX3gGnymPKCS93bTt8+qDzV/UuJyzBa+tMzPEqCYam1JCJpDM
         2FBgNvZ/ntB6LQ5EkPb+/iVbz7ONlDYB1dalx8hnUYV/KoZhxv863m7asTAFXAPATe
         +3M7hOOxZdOlQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20C83573D;
        Fri, 27 Jul 2018 04:00:11 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 27 Jul 2018 04:00:10 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 27 Jul 2018 15:00:08 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Douglas Anderson <dianders@chromium.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "grigor.tovmasyan@synopsys.com" <grigor.tovmasyan@synopsys.com>,
        "Bruno Herrera" <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
Thread-Topic: [REPOST PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
Thread-Index: AQHUJRxcWQJzTHhXfkeORkEblzPMGQ==
Date:   Fri, 27 Jul 2018 11:00:07 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5CBDB4@am04wembxa.internal.synopsys.com>
References: <20180726200730.18290-1-dianders@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2018 12:08 AM, Douglas Anderson wrote:=0A=
> While looking at a dwc2 recently, I noticed that some platforms still=0A=
> have the uframe scheduler off.  As far as I know, nothing good can=0A=
> come out of having the uframe scheduler off.  Let's turn it on=0A=
> everywhere.  Assuming this all works out then some time in the future=0A=
> we can gut all the old code that handles the old non-uframe scheduler=0A=
> and make everything simpler.=0A=
> =0A=
> This is a repost of the original "RFT" (request for testing) series I=0A=
> posted a few weeks ago but without the "RFT" prefix.  Two of the=0A=
> patches in the series now have "Tested-by:" tags.  Since there should=0A=
> be nothing platform specific about the uFrame scheduler presumably=0A=
> this should mean we're good to go?  Specificaly note that in at least=0A=
> one of the "Tested-by" reports this patch caused a notable=0A=
> improvement.=0A=
> =0A=
> In response to the original RFT, some notes about testing this:=0A=
> - In general, try to have lots of things plugged in.=0A=
> - Plug many different keyboards / mice in.  See if keys are=0A=
>    dropped / mouse is jerky.=0A=
> - Try USB audio (ideally full speed, not high speed).  How is=0A=
>    the audio?=0A=
> - If you're brave, try a USB webcam.  How is the video?=0A=
>    ...maybe try including patches from crbug.com/820961 too.=0A=
> =0A=
> =0A=
> Douglas Anderson (4):=0A=
>    usb: dwc2: Turn on uframe_sched on "bcm" platforms=0A=
>    usb: dwc2: Turn on uframe_sched on "his" platforms=0A=
>    usb: dwc2: Turn on uframe_sched on "amlogic" platforms=0A=
>    usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms=0A=
> =0A=
>   drivers/usb/dwc2/params.c | 4 ----=0A=
>   1 file changed, 4 deletions(-)=0A=
> =0A=
Reviewed-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
