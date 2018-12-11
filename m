Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60807C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D802086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="Zo443ti4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D802086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeLKRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:39:25 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:43206 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:39:25 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id DC458B00963
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:39:23 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:references:to:from:from:subject:subject; s=dkim; t=
        1544549962; x=1545413963; bh=fjo4i1DXGIr7W88H73aZkWxddgCaSKM0ee3
        8UzJxH6w=; b=Zo443ti4MIfRDuBovUc3QH/Mdqyx0HRCCx4Ez/1cqKe3YPrtiX0
        RyjjynqYqfUzR+iN+aGlmLv1Q3RMhqml0Ov0Gq5JoG+7RG2P2RJ+o/FQl8JnsJPc
        GhTZBSywg1qfUcPLtB1nNHpUqBTtCcAaywPthpZ2ZqKP3t2PUjUpP5+0=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id btjgzi5pk0Lp for <linux-kernel@vger.kernel.org>;
        Tue, 11 Dec 2018 18:39:22 +0100 (CET)
Received: from [192.168.2.69] (88-149-228-83.v4.ngi.it [88.149.228.83])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 6ECEFB0071D;
        Tue, 11 Dec 2018 18:39:22 +0100 (CET)
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Jonathan Liu <net147@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
 <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
Message-ID: <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
Date:   Tue, 11 Dec 2018 18:39:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to ask you,

Il 11/12/2018 18:20, Giulio Benetti ha scritto:
> Hi Jonathan,
> 
> Il 11/12/2018 11:49, Jonathan Liu ha scritto:
>> Hi Giulio,
>>
>> On Thu, 6 Dec 2018 at 22:00, Giulio Benetti
>> <giulio.benetti@micronovasrl.com> wrote:
>>>
>>> Hi Jonathan,
>>>
>>> Il 06/12/2018 08:29, Jonathan Liu ha scritto:
>>>> Hi Giulio,
>>>>
>>>> On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
>>>> <giulio.benetti@micronovasrl.com> wrote:
>>>>>
>>>>> Differently from other Lcd signals, HSYNC and VSYNC signals
>>>>> result inverted if their bits are cleared to 0.
>>>>>
>>>>> Invert their settings of IO_POL register.
>>>>>
>>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>> ---
>>>>>    drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c 
>>>>> b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>> index 3c15cf2..aaf911a 100644
>>>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct 
>>>>> sun4i_tcon *tcon,
>>>>>                        SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>>>>>
>>>>>           /* Setup the polarity of the various signals */
>>>>> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
>>>>> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>>>>>                   val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>>>>>
>>>>> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
>>>>> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>>>>                   val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>>>>>
>>>>>           regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>>>>
>>>> I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
>>>> LCD touchscreen (Innolux AT070TN92) connected to Olimex
>>>> A20-OLinuXino-MICRO that the image does not display correctly after
>>>> this change.
>>>> The image is shifted to the right.
>>>>
>>>> Reverting the change results in the image being displayed correctly on
>>>> the screen.
>>>>
>>>> I have in the device tree a "panel" node with compatible =
>>>> "innolux,at070tn92" which uses the timings in
>>>> drivers/gpu/drm/panel/panel-simple.c.
>>>>
>>>> Any ideas?
>>
>>>
>>> Checking Display Datasheet:
>>> https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf 
>>>
>>>
>>> Page 13 section 3.3.2 you can see it needs active low VS and HS.
>>>
>>> You can refer to this Thread and check scope captures about VS and HS
>>> versus TCON0_IOPOL register:
>>> https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html 
>>>
>>>
>>> There should be something that wrongly sets one of these or both:
>>> mode->flags |= DRM_MODE_FLAG_PHSYNC;
>>> and/or
>>> mode->flags |= DRM_MODE_FLAG_PVSYNC;
>>>
>>> Checked in panel-simple.c but it's not there.
>>
>> flags is 0 because it is not assigned in the struct definition for the 
>> panel.
> 
> I don't think it is 0, because otherwise IO_POL_REG wouldn't be set to 
> 0x03000000 but to 0.
> What is checked is exactly mode->flags, so the problem seems to be 
> upstream.
> 
> This is my doubt, it seems mode->flags is not initialized or overriden 
> at a certain point, this is why I want to debug it with Jtag tomorrow.
> 
>> Before this change, TCON0_IO_POL_REG would be 0x03000000 (both bits
>> set to 1) and image displays correctly > After this change, 
>> TCON0_IO_POL_REG is 0x00000000 (both bits set to 0)
>> and image doesn't display correctly.
>>
>> Checked using "devmem2 0x01c0c088" on A20-OLinuXino-MICRO Rev J.
> 
> 0x03000000 as I've triple checked with scope means Positive H/Vsync,
> and 0x00000000 Negative H/VSync.
> 
> Please check on the Thread I've pointed you above where there are all 
> the links to the scope captures.
> 
> Are you completely sure you're using the correct panel?
> This is because if with 0x03000000 it works correctly, it means that 
> you're using Positive VS and HS but on datasheet on Figure 3.2 it shows 
> that they must be negative.
> 
> Do you have any chance to measure those signals with a scope?
> 
> Tomorrow, while debugging, I'll re-check H/Vsync signals again.
> 
> Kind regards

Can you precisely point me the sources of:
- u-boot
- kernel
- dts

you're using?

Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
