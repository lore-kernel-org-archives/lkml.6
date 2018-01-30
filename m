Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeA3TFi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:05:38 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:40100 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeA3TFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:05:36 -0500
X-Google-Smtp-Source: AH8x22511RkzBXZTwPMtd/6JT6Rq5noGSyslCHJdY8f2+LELx8erk3yyFtiT++twkAoc1i+7MUMWc/rtr+ijtrIrCM8=
MIME-Version: 1.0
In-Reply-To: <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com> <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 21:05:35 +0200
Message-ID: <CAHp75VfmH5aNPzBLvm-GrQ-49uyJNNwdjbte3uh_kmaC91bz6A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Steven Presser <steve@pressers.name>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 8:34 PM, Steven Presser <steve@pressers.name> wrote:
> Andy,
>
> I apologize for the long response, but there's several issues to address
> here.

NP, it it a good explanation why. That's what commit message missed apparently.

> First, I believe the "bmc150" in the subject line is in some way a misnomer.
> You'd have to ask Jeremy for more details on what he intended it to refer
> to.  However, I believe the device in question is actually the bma250[1],
> which does not have a magnetometer component.  I'm unfortunately away from
> my notes, but I can check later if you need me to verify the exact chip.

Please do, I would really be on the safe side here.

> Second, we're seeing a difference between what's in the data sheet and
> what's exposed in the wild via ACPI.  I own the laptop that started the
> process of building this patch and I did the original ACPI-tables
> investigation.
>
> The device in question (BOSC0200) appears in the Lenovo Yoga 11e (and
> possibly other laptops - this happens to be the one I own). These laptops
> have a 360-degree hinge between the screen and the keyboard, letting them
> convert into tablets, if the user desires. The 11e implements this
> mode-switching by placing an accelerometer in each of the screen and
> keyboard, then doing math with the resulting vectors to figure out the angle
> between the two.

This makes a lot of sense.

>  For whatever reason, Lenovo chose to expose these two
> (physically separate) accelerometers via a single ACPI device which presents
> two i2c devices at sequential addresses.


> As part of my original investigation of the Yoga 11e, I wrote a
> proof-of-concept of pulling accelerometer data from the two devices exposed
> under the BOSC0200 ID and using that to calculate the position of the screen
> relative to the keyboard.  So based on my empirical experience, I can tell
> you the BOSC0200 device ID can expose two accelerometers at sequential
> addresses in the wild.
>
> I don't understand why Lenovo has reused the BOSC0200 ACPI device ID for a
> device that is fundamentally different from the base device. The ID doesn't
> belong to them and we're (apparently) now stuck in this situation where this
> ACPI device ID could represent two different device layouts.

Bad, bad Lenovo. (DMI strings might help here)

> Finally - Andy, I apologize if I came across as challenging you in my
> initial mail.  I was trying to strike a balance between brevity/respecting
> your time and asking a question.  Evidently I struck the wrong balance and
> should have given you more background on why I was doubting what you saw.
> This is my fault and you have my sincerest apologies for any offense I have
> caused.

No need, the root cause is lack of description in the commit message.

Nevertheless, the approach chosen I don't like. It looks like an ugly hack.

What we can do here is:
- do not contaminate core part with I2C/SPI/etc
- do not create another driver via board_info, we already in *the same* driver,
so, the better approach here AFAICS is to add DMI quirk into i2c-core-acpi



> Steve
>
> [1]
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA250E-DS004-06.pdf

-- 
With Best Regards,
Andy Shevchenko
