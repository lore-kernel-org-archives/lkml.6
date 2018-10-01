Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="a9Utp/Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070B2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeJAOcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:32:55 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:42189 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:32:54 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1g6t3z-0008xL-CD; Mon, 01 Oct 2018 00:56:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XjKNJAEuJji7FPXIPBoIFfAWIk9R9jHw4nsWP191dm4=; b=a9Utp/IlfjIVsOXvX2ERTJoZS0
        A06tuysEantiOc3OaT/xaP20kHjuxln//ixo5VmFeifSSsTBypappIBgVOWjdU0GOeiqbnrKPZfrU
        u2c03be7iAh7KqnBx9sP4L+AVMJp6iPtJdKtgnwPs3q+ZC9EubjXGfOY3iRJobg5S7d9z8VwO/8lm
        xiDhUXqEuyexzKDXI+wWgmShr+kGoXirt+GQPBLN4G9Tp5U8Aywbqk+zCBGc+G4YFxwObQ1S1FTUm
        fJ5R3umPlGiMNW2hX0kpfqwHJVrXnOOfpNugQ6ucKdhVqGh8iuAEWRJtAttCoA0cWD6c2uQTFB6uK
        8d9Sw54g==;
Received: from [223.237.19.35] (port=11597 helo=[192.168.43.180])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1g6t3r-000c9t-UX; Mon, 01 Oct 2018 03:56:13 -0400
Subject: Re: [linux-sunxi] Re: [PATCH 08/12] drm/sun4i: sun6i_mipi_dsi:
 Refactor vertical video start delay
To:     maxime.ripard@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>
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
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-9-jagan@amarulasolutions.com>
 <20180927171451.7iqt2nt2log5qojf@flea>
 <CAMty3ZDxpLwVDsgVMjX+6+uz89sQ1aZaXHHZ+-5aogrA4MHmqw@mail.gmail.com>
 <20180929152758.g3goxwjud2ym5rft@flea>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <c6933daf-c445-ade4-a31b-f311ddae7256@openedev.com>
Date:   Mon, 1 Oct 2018 13:25:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929152758.g3goxwjud2ym5rft@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gc54RqAsCCzbBBTf7uoKD9602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7zDil9nzpwm+X/neb6NqWhvt8C9mOBdONdnsxgsk1D2p81t61bzOH+dRuda
 OCHhfvkbONHJki/bT3w/adEN9DqaPbFM3vei53Yyp3v779HcSLG62plOzR5DsoLGZCSqoE3JNAYC
 28t8cR5ITCXTcZqmvaqpXrmasHx4eiR7j6vX9B9laqTmco/p+9en7IdA6p9E/g67cwxyIR8VmA5e
 WtNvnSJzSMipXLKj208wF0l+/LRpsq1uynJlGc1wGBNxKAasUDAM310p3PNWWaIaSygi7PgEVsGe
 cFro/0JGrOyRSaDNUgpG8fAJ7Lg21L451C+Y73wey0WZIByhkSafuhnLcy3brt7kvrJyGkSOIbze
 Phts3vFtUDOwEYF9reFkRh1Z2XmZE6Ulo3Sg6/fHCWNx01dKq9doQCQL/RyDC8HpXAynucv4rnju
 YPOfZh8jslwg7QT+iN5/VyfWKR5edUF17qyCLW5GY4F23J7eq8SL0BtM8UT3jCT30WOGa77ANY69
 cBNhkoiRE9GgA7DbpeRaXeO0Hg/cLwycMnvIieVWIs4dJKDqjPjhvPjqAjKg6VeiSiHqKnOM6HUc
 1C6txUOgA50Rgoi231VkAC4d/u07DCMMQ72GN0COt/Z36GxUDe1/x2bFJS+Hj6rj4u8HaEmUMY84
 DYH6Unxm8wYeyz752/Quc8Wou4TIK4Bcb6TQCr94GXpVQ2KwGtu81JXrQcgqRYMJqVDlz3D3q3rG
 z4wpqXduuWzX2YNPcyspnKOz/GpVtBEI/lNmY9JL/ej0hsKuKmLtSOgDyocRXs5/Dj5QrbiOquAw
 kPRjlgIoLaXIRRdYY1xob1S/a4Rw9BKeg+GlaQRG0qurVqDgRPCOBb4ws+nK6Hdu5ythdss+87CL
 YnNBoGfS0DhK3BfvFNI4fRpBbmGFHU0Fd1FYwiLqVhSu3v+nCpyCSdscG09FH1xvLyyjtb2gYbxM
 T6+Iy9pOFZK275ou5bBvQX3uElphnHsYcHZLfQ+dkTJQ3t6fkiyQeQV6EipRzMVZ5LqwTx7Vvn9S
 VCuiP+10HNhHuWYhdKNkJvfZdFJiZZPY9MnZD1O5yq0pWWScINzg4dgw5iDGlYGqO34MHW3kQw7M
 VMW91WDF0AVkTNBL3fc2BdqUkv1aMlvUsuiVMUz2osEFaYRxsB6RP1WtefrqFnxOMi6sKMFKy5Lq
 LFUIM7si3XKl+gouHE7VOEtHO7BXRk+kb0Ie3l6uI43eRHGnZHBV/yCqCu6qSDJ/f45lS5rBa1fG
 Ecf8+4nW/e7KbhESZjhzfQs2xAJQnSUfEaFbXfx3YmWV3Eu1dd5T48p+m8Gi9mpWQ6cJTOhMhoTy
 AjQts04eAyoaGqs2BxWyJ5iZ/mYkQw5Sva7E5XuqpjkxjsxX7/OU+X56MDbCOXzqrgeRjh9HHXX0
 2BXFZ0oSYx0xwIlnSxHDnJq+tjf1ariSumYaswHs71h51UM9FqN9xH7aeMYHGsZ/4QaVkaMLBQ2N
 o2eCxS3UTYtuZQ==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 September 2018 08:57 PM, Maxime Ripard wrote:
> On Thu, Sep 27, 2018 at 11:03:19PM +0530, Jagan Teki wrote:
>> On Thu, Sep 27, 2018 at 10:44 PM Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>>
>>> On Thu, Sep 27, 2018 at 05:18:46PM +0530, Jagan Teki wrote:
>>>> Accordingly to BPI-M64-bsp DE DSI code Video start delay
>>>> can be computed by subtracting total vertical timing with
>>>> front porch timing and with adding 1 delay line for TCON.
>>>
>>> This is what the current code is doing as well.
>>
>> The current code
>> return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>>
>> (mode->vsync_end - mode->vdisplay) = front porch + sync
>>
>> but I'm updating here only front porch.
>>
>>>
>>>> This patch simply add the start_delay logic from BPI-M64-bsp,
>>>> w/o this new computation, the DSI on A64 encounter vblank time out.
>>>>
>>>> [CRTC:36:crtc-0] vblank wait timed out
>>>>
>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> ---
>>>>   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> index 9918fdb990ff..217db74c6dc3 100644
>>>> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
>>>> @@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
>>>>   static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>>>>                                           struct drm_display_mode *mode)
>>>>   {
>>>> -     return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
>>>> +     u32 vfp = mode->vsync_start - mode->vdisplay;
>>
>> let me explain this.
>>
>> Actual code from Allwinner
>> u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
>>
>> So,
>>
>> => (panel->lcd_vt - panel->lcd_y) - (panel->lcd_vbp)
>> => (front porch + sync + back porch) - (back porch + sync)
> 
> Unless Allwinner is doing something fishy, in which case that should
> be mentionned, the back porch doesn't contain the sync pulse.

As per as I understand panel->lcd_vbp is not back porch timings value 
which i used by drm. It is BSP DTS property value and actual back porch 
is calculated as "panel->lcd_vbp - panel->sync"

timmings->ver_sync_time= panel_info->lcd_vspw;
timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;

