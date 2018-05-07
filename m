Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeEGGj7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:39:59 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35672 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:39:57 -0400
X-Google-Smtp-Source: AB8JxZouAtD55ujHhRaH+jXMUJMvbZsMeEB+VDIOcgbml5/4sdumSI/1NyZkgX8lkffgUnjrdB3jrKOpbwDVfOz2Myc=
MIME-Version: 1.0
References: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com> <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
In-Reply-To: <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 07 May 2018 06:39:44 +0000
Message-ID: <CAGS+omATdiURdKFTZAeCW=7R0kB7z8vW-Wj05j_-RoJhAq=FHg@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
To: Akshu Agrawal <Akshu.Agrawal@amd.com>
Cc: Adam.Thomson.Opensource@diasemi.com, Alexander.Deucher@amd.com,
        Support.Opensource@diasemi.com, perex@perex.cz, tiwai@suse.com,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 6, 2018 at 10:50 PM Agrawal, Akshu <Akshu.Agrawal@amd.com>
wrote:



> On 5/4/2018 2:45 PM, Adam Thomson wrote:
> > On 03 May 2018 08:59, Akshu Agrawal wrote:
> >
> >> Non-dts based systems can use ACPI DSDT to pass on the mclk
> >> to da7219.
> >> This enables da7219 mclk to be linked to system clock.
> >> Enable/Disable of the mclk is already handled in the codec so
> >> platform drivers don't have to explicitly do handling of mclk.
> >>
> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> >> ---
> >> v2: Fixed kbuild error
> >> v3: Add corresponding clk_put for clk_get
> >>  include/sound/da7219.h    |  2 ++
> >>  sound/soc/codecs/da7219.c | 10 +++++++++-
> >>  2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
> >> index 1bfcb16..df7ddf4 100644
> >> --- a/include/sound/da7219.h
> >> +++ b/include/sound/da7219.h
> >> @@ -38,6 +38,8 @@ struct da7219_pdata {
> >>
> >>      const char *dai_clks_name;
> >>
> >> +    const char *mclk_name;
> >> +
> >>      /* Mic */
> >>      enum da7219_micbias_voltage micbias_lvl;
> >>      enum da7219_mic_amp_in_sel mic_amp_in_sel;
> >> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> >> index 980a6a8..ecd46fc 100644
> >> --- a/sound/soc/codecs/da7219.c
> >> +++ b/sound/soc/codecs/da7219.c
> >> @@ -1624,6 +1624,8 @@ static struct da7219_pdata
*da7219_fw_to_pdata(struct
> >> snd_soc_component *compone
> >>              dev_warn(dev, "Using default clk name: %s\n",
> >>                       pdata->dai_clks_name);
> >>
> >> +    device_property_read_string(dev, "dlg,mclk-name",
&pdata->mclk_name);
> >> +
> >
> > Personally am still not keen on this. To me the use of a
device_property_*
> > function suggests the same property resides in both DT and ACPI, but
here we're
> > only using this for the ACPI case. DT has no want or need for this. I
still feel
> > we should look at something more generic in the clock framework,
although I do
> > agree with Mark that this should be properly specced.
> >

> I am not an expert in field of ACPI, IMO forming a Spec and changing
> ACPI to have DT like clock framework is good to have but a bigger change
> which should be taken up later.

> The current code of handling of mclk in the driver is usable only by DT.
> The device_property (though ACPI specific) makes this code, a common
> code for DT and ACPI based devices.

> https://www.kernel.org/doc/Documentation/acpi/DSD-properties-rules.txt
> "....Still, for the sake of code re-use, it may make sense to provide as
> much of the configuration data as possible in the form of device
> properties and complement that with an ACPI-specific mechanism suitable
> for the use case at hand......"

This sounds like a pretty reasonable justification for addressing the issue
using DSD to me.
For what its worth, you can add:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>



> Thanks,
> Akshu
