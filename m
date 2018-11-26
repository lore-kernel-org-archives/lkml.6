Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4490C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701A52086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="TOT86e/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701A52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeKZXBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:01:39 -0500
Received: from se15t.web-hosting.com ([162.255.118.154]:49361 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeKZXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:01:39 -0500
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1gRFfj-000BBA-28; Mon, 26 Nov 2018 04:07:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mEnkEeWgKHYjtBVVm4l7+jjUdOazAbfE2iyra0nSoRw=; b=TOT86e/jD+heQNdVEgURqSm+Uz
        +nFTQA7HP0ZDn+ILFVZopDejUCK8CZJGI/yeL6BHIQVGC9y49fdG0Dkt7wpvLL6vavioGYCJ4zBeV
        2nBzJ+7TUwaeYafmoJ7l/409sZY2B3wLar9lH9nnOA4ouxCWuxbPEAIGUNBF0llRmlowz6mYfOIzA
        hc7NMy9h9+TP9yZTbQ3/c5wiuSxe3ifitoAVXljE0QJabLhIzDE0RUZ0swbyKr6msfpoDlhtKO1Qn
        j4GkVV9DwMzHtUakNaAIaMb582d8QovIfwkHrGyD1jwks++b92nhfS6zBTHe3XRQ8vnvVri1AEdIY
        qdpoG6hQ==;
Received: from [183.82.227.62] (port=32879 helo=[192.168.0.105])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1gRFfY-001Zte-Sj; Mon, 26 Nov 2018 07:07:22 -0500
Subject: Re: [linux-sunxi] Re: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix
 VBP size calculation
To:     jagan@amarulasolutions.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
 <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea>
 <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <55900bf3-efb5-5f78-5252-b3f6d4f775fb@openedev.com>
Date:   Mon, 26 Nov 2018 17:37:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.37)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ommB5J93wwZfPlX9xMyv/x602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9dX4ZHi2KTdPJq2sFwGM16/7aw6ZDL6gCpHGlnjxa51P/a3oTZXMlz+UdhwK7oslF8p
 YZCrUbRX+v1BemLUP5ofy4f7/zcujaKBXakzPtL+idMlhCno/QsYaTlhyywkGTJtwmMoRiiCREkR
 xBTI/GEx8L7GcfNO+2MU0i0gmK7/lEDuCjlf75Q9Rtb05lrEBezQu5IqYl3M6BKhcK235Vd6DKt6
 8F2sRgccYriU/DLjXixgNudg5J2xRadG5H9ZBwgPamQi6P+Rl9F3q79ckRlGskeNL6TYueRH+IWu
 LLTE8jogp0FBlJ1tKSTvnwFnRZfm25zyHssh4zPcVuzM95KdDMVwtpruRAyuSRbY6vFDEY4Jcr7S
 O3VRLkE/7O0yq2gDleyAktvWbJHRM4J5lnMVrM1/gc7qnRWrx/hylxAx84IADj35faHyXVw0gY4Y
 1ZNfKnJwEAK38IW87IvMifKiIBxtBdU36OKGv6ikQhc8lgXWdZotymwMXqSpDqBhARcoxaUGyuON
 pEZ872ApxSNIPvm1tInPrbCwvqKFfyvBcGLdl7ZS88uxu0+JJWtCTaGh+cI4p3wXhQZQoas8Bmts
 Pg5H5j74iEEeWjvWGg2Zl2HhAmneKgRPMOTYGqbywIMIPAHfDXo5xW6cGAivq2enL5/dgiNCqwqV
 U490dJhhxybdBl46WIbJqohzHTq1GhnScPYHjT1zhsZdS1mUEjJLB+uMsiYbiwuxTlLWMnK+Cf6a
 siBiWK7tobs44Qs1g1y4R4t7v7t8HZLu4AwN7qH1u82M9V3U9IwsARVMB0PlxVTsnyICMSMsOwk8
 ZxuIpP0LMnVymDsHpyB991Uek2RwQdJjEWciBYfIflGbJRs256f+PabO1c9AoU3hEig2PTTPeX7M
 0Tp7u/vAdy6WXRROxZOIKnvk05bMpffqASfBngjhEXCytybWl/QyRzoZpKp4CryuZxzNBmeuFO5F
 CJkOoJgF9fT/UgVaw1G/ZQf9+yGdFSnFkTk2Ros7h4eWdl60/LDee3sIUuip0qnpvZ77WYznhGil
 ijOYJ4pCQ72EeQQQ5Q4LqaSpB+9v+OsI70qLA/reX3wyssDKrOPEg805Ix7/C9VwqPH/5QpQnZ0B
 ArusUFxhRMOHZI4kpixxEjSfj9DzQ4yJ57bQ4IEbgr6yFlWAVFIKU5C2qApG3drYASJFC/49WOPB
 r5nlEUI4xGsnN02luYMWAqp2c1OG337yyPl2DgxJXM6S/XbZ38iLsusO+a9w4sXlyF+niApgflAp
 4PYFwVfuunBi7178En7Mo+EvY1E48TWDIpZ+s1g0vMeUyuL2YH7Z5Y5D2UrTehOen/ZFsjOaJktN
 iMczDxWA+mTKUBRotfvln7toE07t57dogL1ODQurFlaEeV2JluTv8Euz4kEu2pciqS/9AKkccBIk
 1Sag4dKiqCrF8eZZHnRAFIhjQ5cxckig+bTBVI2VqHLhlUVQoJMlVSK76rUjL9fZ3JA4FfMb2Aay
 w9Cxfk6hFjnW6aJKofUIq72cz/DrHxeXi5Ty1C+US2xZX9BGCVfStKCeCKaIwk8kkTKAf2rRpkje
 puFexoN0uBb1ukURhAMP8O4VT8dJ9MHsyJWjL5rTwkoH/iv9Fqlmggf/IoEknD0AWjr2RfGDWITJ
 zQ==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 9:55 PM, Jagan Teki wrote:
> On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>
>> On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
>>> On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
>>>>> The horizontal and vertical back porch calculation in BSP
>>>>> code is simply following the Linux drm comment diagram, in
>>>>> include/drm/drm_modes.h which is
>>>>>
>>>>> [hv]back porch = [hv]total - [hv]sync_end
>>>>>
>>>>> BSP code form BPI-M64-bsp is calculating vertical back porch as
>>>>> (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
>>>>>
>>>>> timmings->ver_sync_time= panel_info->lcd_vspw;
>>>>> timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
>>>>>
>>>>> vbp = panel->lcd_vbp;
>>>>> vspw = panel->lcd_vspw;
>>>>> dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
>>>>> dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
>>>>> =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
>>>>> =>  timmings->ver_back_porch
>>>>> =>  mode->vtotal - mode->end
>>>>>
>>>>> Which evatually same as mode->vtotal - mode->vsync_end so update the
>>>>> same in SUN6I_DSI_BASIC_SIZE0_VBP
>>>>>
>>>>> On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
>>>>> value.
>>>>>
>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>
>>>> I've tested your changes on my A33 board, and this commit will break
>>>> it.
>>>>
>>>> It creates vblank timeouts, and visual artifacts at the bottom of the
>>>> display.
>>>
>>> Strange, VBP is earlier gives front porch which is anyway wrong.
>>>
>>>>
>>>> Later commits seem to fix the issue, but will create some blanking on
>>>> the upper third of the display.
>>>>
>>>> Since the documentation is quite sparse, and a MIPI-DSI analyzer is
>>>> way too expensive, I'd really like to have at least what each of these
>>>> commits are actually fixing, and what symptoms each of these were
>>>> causing, and not just "the BSP does it".
>>>
>>> W/o this 2-lane panel is breaking, same vblank timeout and visual
>>> artifacts at the bottom of the panel. though the commits may reference
>>> BSP, I have at-least tested on 3 different panels for us to prove its
>>> working.
>>>
>>>> Having some datasheet for the panels you had working would help too.
>>>
>>> Unfortunately datasheet doesn't have any required information what we
>>> actually looking for.
>>
>> Not even the timings? How did you get that information then?
> 
> datasheet has timing values, but this changes need controller
> information about VBP register that I don't have. But again existing
> VBP is not back porch for real, it's front porch.
> 

I'm about to send next version by combining with burst mode changes in
one series. Do you have any further inputs on this. I didn't not see
any breakage with 4-lane devices, but has issue with 2-lane w/o this change.
