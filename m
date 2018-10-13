Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7206C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996BD20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996BD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJMWsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:48:03 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:42704 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeJMWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:48:02 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gBLYk-0003TZ-69 from Vladimir_Zapolskiy@mentor.com ; Sat, 13 Oct 2018 08:10:30 -0700
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 13 Oct 2018 16:10:25 +0100
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <506c03d7-7986-44dd-3290-92d16a8106ad@mentor.com>
 <4a807a53-1592-a895-f140-54e7acc473b3@ideasonboard.com>
 <3599186.afdMBtdL0k@avalon>
CC:     <kieran.bingham@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <369ef3ac-6f68-c450-713f-762b1c5cd5c9@mentor.com>
Date:   Sat, 13 Oct 2018 18:10:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <3599186.afdMBtdL0k@avalon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 10/12/2018 04:01 PM, Laurent Pinchart wrote:
> Hello Vladimir,
> 
> On Friday, 12 October 2018 14:47:52 EEST Kieran Bingham wrote:
>> On 12/10/18 11:58, Vladimir Zapolskiy wrote:

[snip]

>> Essentially they are multi purpose buses - which do not yet have a home.
>> We have used media as a home because of our use case.
>>
>> The use case whether they transfer frames from a camera or to a display
>> are of course closely related, but ultimately covered by two separate
>> subsystems at the pixel level (DRM vs V4L, or other for other data)
>>
>> Perhaps as they are buses - on a level with USB or I2C (except they can
>> of course carry I2C or Serial as well as 'bi-directional video' etc ),
>> they are looking for their own subsystem.
>>
>> Except I don't think we don't want to add a new subsystem for just one
>> (or two) devices...
> 
> I'm not sure a new subsystem is needed. As you've noted there's an overlap 
> between drivers/media/ and drivers/gpu/drm/ in terms of supported hardware.
> We even have a devices supported by two drivers, one in drivers/media/ and
> one in drivers/gpu/drm/ (I'm thinking about the adv7511 in particular).
> This is a well known issue, and so far nothing has been done in mainline
> to try and solve it.

I agree that there's an overlap between drivers/media/ and drivers/gpu/drm/,
formally a hypothetical (sic!) DS90Ux9xx video bridge cell driver should be
added into both subsystems also, and the actual driver of two should be
selected in runtime. I call such a driver 'hypothetical', because in fact
I don't have it, and I'm not so sure that its existence is justified, but
that's only because DS90Ux9xx video bridge functionality is _transparent_,
it does not have any controls literally, but it is a pure luck eventually.

So, as I've stated in my cover letter, I can misuse yours 'lvds-encoder'
driver only for the purpose of establishing a mediated link between 
an LVDS controller and a panel over a serializer-deserializer pair.

> Trying to find another home in drivers/mfd/ to escape from the problem isn't a 
> good solution in my opinion. The best option from a Linux point of view would 
> be to unify V4L2 and DRM/KMS when it comes to bridge support, but that's a 
> long way down the road (I won't complain if you want to give it a go though 
> :-)).

I return you a wider smile :)

> As your use cases are display, focused, I would propose to start with 
> drivers/gpu/drm/bridge/, and leave the problem of camera support for first 
> person who will have such a use case.

Frankly speaking I would like to start from copy-pasting your 'lvds-encoder'
driver into an 'absolutely-transparent-video-bridge' driver with no LVDS
or 'encoder' specifics, adding just a new compatible may suffice, if the
driver is renamed/redefined.

PS, I remember I owe you a reference OF snippet of data path to a panel.

--
Best wishes,
Vladimir
