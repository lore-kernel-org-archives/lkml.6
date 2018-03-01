Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966620AbeCAJEU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:04:20 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35745 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965281AbeCAJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:04:12 -0500
X-Google-Smtp-Source: AG47ELv8MFNYdz9KYRJEA41XpHYpWRX47Zr2AWWnt4AJmSsSwyXMpN2hjWcsZh4tStk0ODHTfVCaSqZwX/c9r5W/NpM=
MIME-Version: 1.0
In-Reply-To: <20180301084315.0811f712@dell-desktop.home>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
 <20180227212433.2189-2-mylene.josserand@bootlin.com> <20180227225140.6f9902b8@windsurf.lan>
 <20180301084315.0811f712@dell-desktop.home>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 1 Mar 2018 10:04:11 +0100
Message-ID: <CAOf5uw=9aydTjTQbWJrZW4fFudcS9cp9=c4RhowyLyoWG97Q1A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v1 1/4] ASoC: codecs: pcm179x: Add PCM1789 id
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        alexandre.belloni@bootlin.com, LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2194Pp5010281

Hi

On Thu, Mar 1, 2018 at 8:43 AM, Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
> Hello,
>
> Thank you for the review.
>
> On Tue, 27 Feb 2018 22:51:40 +0100
> Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:
>
>> Hello,
>>
>> On Tue, 27 Feb 2018 22:24:30 +0100, Mylène Josserand wrote:
>> > To prepare the support for the PCM1789, add a new compatible
>> > and use the i2c_id to handle, later, the differences between
>> > these two DACs even if they are pretty similar.
>> >
>> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
>> > ---
>> >  Documentation/devicetree/bindings/sound/pcm179x.txt | 2 +-
>>
>> The DT binding change should be in a separate patch.
>>
>> >  sound/soc/codecs/pcm179x-i2c.c                      | 6 ++++--
>> >  sound/soc/codecs/pcm179x.c                          | 3 ++-
>> >  sound/soc/codecs/pcm179x.h                          | 8 +++++++-
>>
>> And this should be together with the PCM1789 support patch. Otherwise
>> your series is not bisectable: if we apply only PATCH 1/4, the driver
>> supports the new compatible string, but it doesn't have the actual code
>> to handle PCM1789. Am I missing something here ?
>
> No, you are right, I will merge it with patch 02.
>

Can you please include me in next series?

I have several hardware running on pcm179x family

Michael

>>
>> > -   return pcm179x_common_init(&client->dev, regmap);
>> > +   return pcm179x_common_init(&client->dev, regmap, id->driver_data);
>>
>> This can be done in a preparation patch.
>>
>> >  }
>> >
>> >  static const struct of_device_id pcm179x_of_match[] = {
>> >     { .compatible = "ti,pcm1792a", },
>> > +   { .compatible = "ti,pcm1789", },
>> >     { }
>> >  };
>> >  MODULE_DEVICE_TABLE(of, pcm179x_of_match);
>> >
>> >  static const struct i2c_device_id pcm179x_i2c_ids[] = {
>> > -   { "pcm179x", 0 },
>> > +   { "pcm179x", PCM179X },
>>
>> And also this addition.
>>
>> > +   { "pcm1789", PCM1789 },
>> >     { }
>> >  };
>> >  MODULE_DEVICE_TABLE(i2c, pcm179x_i2c_ids);
>> > diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
>> > index 4b311c06f97d..81cbf09319f6 100644
>> > --- a/sound/soc/codecs/pcm179x.c
>> > +++ b/sound/soc/codecs/pcm179x.c
>> > @@ -218,7 +218,8 @@ static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
>> >     .non_legacy_dai_naming  = 1,
>> >  };
>> >
>> > -int pcm179x_common_init(struct device *dev, struct regmap *regmap)
>> > +int pcm179x_common_init(struct device *dev, struct regmap *regmap,
>> > +                   enum pcm17xx_type type)
>>
>> And this done.
>>
>> >  {
>> >     struct pcm179x_private *pcm179x;
>> >
>> > diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
>> > index cf8681c9a373..8c08689e3b8b 100644
>> > --- a/sound/soc/codecs/pcm179x.h
>> > +++ b/sound/soc/codecs/pcm179x.h
>> > @@ -17,11 +17,17 @@
>> >  #ifndef __PCM179X_H__
>> >  #define __PCM179X_H__
>> >
>> > +enum pcm17xx_type {
>> > +   PCM179X,
>>
>> And this one.
>>
>> > +   PCM1789,
>> > +};
>> > +
>> >  #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
>> >                       SNDRV_PCM_FMTBIT_S16_LE)
>> >
>> >  extern const struct regmap_config pcm179x_regmap_config;
>> >
>> > -int pcm179x_common_init(struct device *dev, struct regmap *regmap);
>> > +int pcm179x_common_init(struct device *dev, struct regmap *regmap,
>> > +                   enum pcm17xx_type type);
>>
>> And this one. Just as a "preparation patch" to support multiple codecs
>> in the existing pcm179x.c driver.
>>
>> Thanks!
>>
>> Thomas
>
> Thanks,
>
> Mylène
>
> --
> Mylène Josserand, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
