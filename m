Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1C02186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUk1ImZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfBZW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:27:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42379 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfBZW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:27:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id v11so1493577plg.9;
        Tue, 26 Feb 2019 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hAsU8UQX3DVaACmBeu4EA5s08dMiJ4hFaMZIG7ClyoI=;
        b=PUk1ImZMGFyrzGO9Q9fC2P4YK/ffSpKobD2kp21P2hlr3b0rdCWcOcZdOxee3YWaY/
         6/3vx/vdlRLtXU+MCfKSQhM5AsWDERIJQoiuOq7UJMUWcik3WpbiLOBAI8dVTV5GO9K2
         Lc+rJ941tawXhzmtU4+wQI1QnvAMf/KURiQUjpokp9+sSMLBTEnyrHqrqvmw2+hjmuQ0
         LfIQDk91P4d/bj5cm4X3E0O+DwUuquSMubSJ2Va14xUPwCiteiCycrBwhhiI1tnco9J6
         AbVkwf0zOD36mLBUKNFDvCO86Ezo9xFRrs7qMhkX9s3zziso0TFBUa7RiTIECd0PFKxz
         y0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hAsU8UQX3DVaACmBeu4EA5s08dMiJ4hFaMZIG7ClyoI=;
        b=tHGTgfiesHQL16jh+8iQLQnB9h2Q/OppzqUaiMfzrdL3R6FOuFxhu6CcHxNtGmPzNm
         GX27Fh+Rtq1p6SbxGm1LGD9GB6SaZEf0uUqSetVLA45CgsyF5y8P+HCMDEs9IPXY7Iz3
         8rnkmXLGERARi5VmTvePBa9uGT9pABGBg6wkUi9aPq8gZzTIutVKrquqvzuHD7iZtnEL
         /Wym1DYCOVp591xqDsOfQ8z5bVL+6o0jat5Ybuhs8t0wUZnNNEa9VaDMYfRNKwAQAgV8
         zn0U7Zw8K+7XG8iEadVJ6ck87R0xgzlpwrRU/36JE1SlEOxATeFX52abR27+VRhAKSlY
         BF3g==
X-Gm-Message-State: AHQUAuY6axk4gIWssAd8IofCr/egOJXorlmYxuhbg+BEihnTzCU/j7/U
        OMPl0YupUCGhEOLJxfqn/5Y=
X-Google-Smtp-Source: AHgI3IbTwiFnak3M1I2Lg0X0HrBlCqoWaO/sbk+A5KICHveP7e3Fwu1zQ6GbGDJTk693fFrKto+XdA==
X-Received: by 2002:a17:902:1009:: with SMTP id b9mr27573080pla.42.1551220072536;
        Tue, 26 Feb 2019 14:27:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c18sm4706425pfo.44.2019.02.26.14.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 14:27:51 -0800 (PST)
Date:   Tue, 26 Feb 2019 14:27:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Message-ID: <20190226222750.GA30985@roeck-us.net>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:34:12PM -0600, Rob Herring wrote:
> > >
> > > I think Rob suggested that the SCU parent driver should instantiate the
> > > watchdog without explicit watchdog node. That would be possible, but it
> > > currently uses
> > > devm_of_platform_populate() to do the instantiation, and changing that
> > > would be a mess. Besides, it does sem to me that your suggested node would
> > > describe the hardware, so I am not sure I understand the reasoning.
> 
> It would just be a call to create a platform device instead. How is that a mess?
> 
> It's describing firmware. We have DT for describing h/w we've failed
> to make discoverable. We should not repeat that and just describe
> firmware in DT. Make the firmware discoverable! Though there are cases
> like firmware provided clocks where we still need something in DT, but
> this is not one of them.
> 

It requires extra code where an added DT node would accomplish the same.
It requires a mix of DT nodes for existing devices plus extra code for
newly added devices. To me that looks like a revert to old platform code,
which was replaced with DT descriptions over the last several years.

But then if that is where things are going, who am I to argue.

Guenter
