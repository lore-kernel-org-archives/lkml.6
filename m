Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA977C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03820645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D03820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJQCYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:24:22 -0400
Received: from mleia.com ([178.79.152.223]:54204 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJQCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:24:21 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 9055042091A;
        Tue, 16 Oct 2018 19:32:35 +0100 (BST)
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        kieran.bingham@ideasonboard.com, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181008211205.2900-1-vz@mleia.com> <3599186.afdMBtdL0k@avalon>
 <369ef3ac-6f68-c450-713f-762b1c5cd5c9@mentor.com> <6392366.NPbusjoGUK@avalon>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <cc0100c8-1874-1d4c-6815-e4d448ab4f73@mleia.com>
Date:   Tue, 16 Oct 2018 21:32:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6392366.NPbusjoGUK@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181016_193235_611038_A3DBE96B 
X-CRM114-Status: GOOD (  17.16  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 10/16/2018 04:12 PM, Laurent Pinchart wrote:
> Hi Vladimir,
> 
> On Saturday, 13 October 2018 18:10:25 EEST Vladimir Zapolskiy wrote:
>> On 10/12/2018 04:01 PM, Laurent Pinchart wrote:
>>> On Friday, 12 October 2018 14:47:52 EEST Kieran Bingham wrote:
>>>> On 12/10/18 11:58, Vladimir Zapolskiy wrote:
>> [snip]
>>
>>>> Essentially they are multi purpose buses - which do not yet have a home.
>>>> We have used media as a home because of our use case.
>>>>
>>>> The use case whether they transfer frames from a camera or to a display
>>>> are of course closely related, but ultimately covered by two separate
>>>> subsystems at the pixel level (DRM vs V4L, or other for other data)
>>>>
>>>> Perhaps as they are buses - on a level with USB or I2C (except they can
>>>> of course carry I2C or Serial as well as 'bi-directional video' etc ),
>>>> they are looking for their own subsystem.
>>>>
>>>> Except I don't think we don't want to add a new subsystem for just one
>>>> (or two) devices...
>>>
>>> I'm not sure a new subsystem is needed. As you've noted there's an overlap
>>> between drivers/media/ and drivers/gpu/drm/ in terms of supported
>>> hardware. We even have a devices supported by two drivers, one in drivers/
>>> media/ and one in drivers/gpu/drm/ (I'm thinking about the adv7511 in
>>> particular). This is a well known issue, and so far nothing has been done
>>> in mainline to try and solve it.
>>
>> I agree that there's an overlap between drivers/media/ and drivers/gpu/drm/,
>> formally a hypothetical (sic!) DS90Ux9xx video bridge cell driver should be
>> added into both subsystems also, and the actual driver of two should be
>> selected in runtime. I call such a driver 'hypothetical', because in fact I
>> don't have it, and I'm not so sure that its existence is justified, but
>> that's only because DS90Ux9xx video bridge functionality is _transparent_,
>> it does not have any controls literally, but it is a pure luck eventually.
> 
> I don't think that's entirely correct, there's at least the video bus width 
> (18-bit/24-bit) that needs to be selected. You currently do so through a 
> pinctrl property, but that's not right.

if you deal with a complex IC/IP which supports parallel video output routed
over multiplexed pins, you have to specify a pinmux configuration, it is
unavoidable (for reference see arch/arm/boot/dts/imx6qdl-sabrelite.dtsi and
&pinctrl_j15 pin group, why does pinctrl setting exist?), so the property
will remain as a pinmux/pinctrl property in one or another form independently
on a probable video bus width selection of a DS90Ux9xx video bridge cell.

In this particular case the pinmux/pinctrl driver shall be aware of
'ti,video-depth-18bit' property of 'parallel' pin function to resolve pin
resource conflicts with GPIO and audio bridging functions of IC, this is
a clear hardware pinmux (or pinctrl of "parallel" function) property.

Please don't neglect the complexity and necessity of pinmuxing and other
IC functions, if all provided functions of DS90Ux9xx ICs are put aside and
just video bridging is left, only then you justify the device as a media
device, but the IC and its configuration is simply more complex than
you describe it. And, as I've said before, the video bridging function is
extremely trivial and it has no real controls, but other functions have.

--
Best wishes,
Vladimir
