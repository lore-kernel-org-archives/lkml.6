Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeETCKQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:10:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38349 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeETCKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:10:13 -0400
X-Google-Smtp-Source: AB8JxZrvtspi//BWcoNfgkgusCXC3G1PeZdJqUsBXPa5cWMw86eNDpK3uLYwfuggZYCcjSAI/Tmi7OmRVBNQY5Bk8zg=
MIME-Version: 1.0
In-Reply-To: <CAGRGNgWumzhiiwJenOXRuRN0i-_2uY=YR5L+9m70HW2ibF=C7w@mail.gmail.com>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-11-jernej.skrabec@siol.net> <CAGRGNgWumzhiiwJenOXRuRN0i-_2uY=YR5L+9m70HW2ibF=C7w@mail.gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 20 May 2018 12:09:52 +1000
Message-ID: <CAGRGNgXbKGhnern4=_W9W5dKM54H5B1dnAD7up-23rUAMWWCSw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 10/15] drm/sun4i: Add support for R40 TV TCONs
To: jernej.skrabec@siol.net
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Sun, May 20, 2018 at 11:57 AM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Jernej,
>
> On Sun, May 20, 2018 at 4:31 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>> R40 display pipeline has a lot of possible configurations. HDMI can be
>> connected to 2 different TCONs (out of 4) and mixers can be connected to
>> any TCON. All this must be configured in TCON TOP.
>>
>> Along with definition of TCON capabilities also add mux callback, which
>> can configure this complex pipeline.
>>
>> For now, only TCON TV is supported.
>>
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 39 ++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index e0c562ce1c22..81b9551e4f78 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -1274,6 +1274,31 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
>>         return 0;
>>  }
>>
>> +static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
>> +                                    const struct drm_encoder *encoder,
>> +                                    int index)
>> +{
>> +       if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS)
>> +               sun8i_tcon_top_set_hdmi_src(tcon->tcon_top, index);
>> +
>> +       sun8i_tcon_top_de_config(tcon->tcon_top, tcon->id,
>> +                                tcon_type_tv, index);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sun8i_r40_tcon_tv_set_mux_0(struct sun4i_tcon *tcon,
>> +                                      const struct drm_encoder *encoder)
>> +{
>> +       return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 0);
>> +}
>> +
>> +static int sun8i_r40_tcon_tv_set_mux_1(struct sun4i_tcon *tcon,
>> +                                      const struct drm_encoder *encoder)
>> +{
>> +       return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 1);
>> +}
>
> Are TCON-TOPs going to be a common thing in new SoCs from Allwinner?
> If so, maybe we should add an index to the TCON quirks and have a
> common TCON-TOP set_mux function.

Actually, that only moves it up a level. Should it be a devicetree property?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
