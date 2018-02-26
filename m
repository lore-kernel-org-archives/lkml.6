Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1519655555; cv=none;
        d=google.com; s=arc-20160816;
        b=VPvGPpdl+5aGMeUoVQflQhMDF6mpIsoZ6yC6bvajU0l0+Fhx7euHSh1z+JPRTKjEAm
         nGPzfeFyPV9cQaVyYjdS/6mYeflu18bmrkh4NNunxNDypzvMIDxGnEprn4mrxf6pcSx9
         gqez6jKFiyN01JhPdS+bT+Xo2JVnGcGZM/brIIcgXgILFazQ5kWmsmpZn7vvh8puB64z
         41mu1I0DDONS7RQIQdKspBD4aA+MwHrkvMrhhU/4YkwhMlOSWcn/i6dBVixK6E7yzJ2K
         byDwiGQLWOYIhw7EFpbflTzgKWS8RxOMofXjAa9lIMmRZjqWMQeZTJXpBpib66LswDOD
         WVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DPdt8/ZrYwx9y/rtcqlJZjTTCt42nlLPYgQfb3Y06O0=;
        b=UCLCj4pIgNao/T4t2voKZpFUCiEUWtyVF4548WatWhOiPWzTyugguJaWvUnayhLi5J
         htVun5mzzrYDhIxmYlpe/MECTaEK7KOJgoZlaYYTNENxV/ZmjZdQNk+aFJaCcEDVg10J
         0f30TszrJKaZs4Fb8T4XQ49b8rfHwvfP15wTbcamItjIUpee8J4/gpZdv91SBw70g+lw
         UfutJqJGxLJdDVogrDmC+hF2j7Geefw0h1RjyKUrbllnrCwoqW6Xq7G/aHiiiyQzeRHg
         CZKADkyAes5R5OkyABvKiMtnOKEvXkhIJJ7+Fhlvf4TWEjGgmMH/ZzU8bEvO19qq6zlf
         /V3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=RQTQBhOP;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=RQTQBhOP;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELtRF0wJ59WSM0yJin9ETtw6AmTvUosn/jWWwMtOtd237Rk7KFUrEnQdRQliJ9GlD8SmhNQHd95rWHnEP7NTMIo=
MIME-Version: 1.0
In-Reply-To: <20180226152620.6740b458@endymion>
References: <20180226102000.1b76640e@endymion> <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
 <20180226152620.6740b458@endymion>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 26 Feb 2018 15:32:35 +0100
Message-ID: <CAMRc=McpCp5BQ61B6Gwd2OcuJq_aeT2fqwFRPF7xum-gn4yRXQ@mail.gmail.com>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454680453951468?=
X-GMAIL-MSGID: =?utf-8?q?1593474344359858461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-26 15:26 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> Hi Bartosz,
>
> On Mon, 26 Feb 2018 14:40:42 +0100, Bartosz Golaszewski wrote:
>> 2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
>> > The EEPROMs which hold the SPD data on DDR4 memory modules are no
>> > longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
>> > which use only 1 I2C address for data access. You need to switch
>> > between the lower page and the upper page of data by sending commands
>> > on the SMBus.
>> >
>> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> > ---
>> >  drivers/misc/eeprom/Kconfig  |   11 +
>> >  drivers/misc/eeprom/Makefile |    1
>> >  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 293 insertions(+)
>>
>> is there any reason not to use regmap as is done currently in at24? It
>> would spare you a lot of code.
>
> No specific reason, just the fact that I never used regmap before so
> the idea did not occur to me. I can give it a try, but my driver is
> already pretty simple so I'm curious if there's really anything to win.
> Let's see.
>

You wouldn't need to check i2c functionalities and could simplify the
read functions.

> Is there any documentation available on how to convert an existing
> driver to use regmap?
>

Take a look at the series from Heiner[1].

> --
> Jean Delvare
> SUSE L3 Support

I'm also seeing that you exported the sysfs eeprom attribute by hand.
I think you should register the driver as nvmem provider and set the
compat flag in nvmem config instead.

Thanks,
Bart

[1] http://patchwork.ozlabs.org/project/linux-i2c/list/?series=15614&state=*
