Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeCZQsJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:48:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38343 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeCZQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:48:07 -0400
X-Google-Smtp-Source: AG47ELvLMk9GVIcSMfVqqpP1pdNgQF93ReYV65/TN8WtJIV6ZkoL+/xRVNTV/F+kfo0aRUa5auMXl52TX4IMxjy35HI=
MIME-Version: 1.0
In-Reply-To: <20171129121123.7zg63mjy7pufokg5@dell>
References: <20170927213527.31416-1-shawnn@chromium.org> <20171129121123.7zg63mjy7pufokg5@dell>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 26 Mar 2018 18:48:06 +0200
Message-ID: <CAFqH_51zqxXZeEXDSry9aBwwj4Z7SRzxfKw5Ffzh-2A1UQG2Pw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros ec: spi: Fix "in progress" error signaling
To: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Nematbakhsh <shawnn@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, jonathanh@nvidia.com,
        Brian Norris <briannorris@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2QGmFxq015714

Dear all,

Cc'ing some more chromium folks.

2017-11-29 13:11 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Wed, 27 Sep 2017, Shawn Nematbakhsh wrote:
>
>> For host commands that take a long time to process, cros ec can return
>> early by signaling a EC_RES_IN_PROGRESS result. The host must then poll
>> status with EC_CMD_GET_COMMS_STATUS until completion of the command.
>>
>> None of the above applies when data link errors are encountered. When
>> errors such as EC_SPI_PAST_END are encountered during command
>> transmission, it usually means the command was not received by the EC.
>> Treating such errors as if they were 'EC_RES_IN_PROGRESS' results is
>> almost always the wrong decision, and can result in host commands
>> silently being lost.
>>
>> Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Shawn Nematbakhsh <shawnn@chromium.org>
>> ---
>>  drivers/mfd/cros_ec_spi.c | 52 ++++++++++++++++++++++-------------------------
>>  1 file changed, 24 insertions(+), 28 deletions(-)
>
> Applied, thanks.
>

This patch is a bit old and is already applied but I would like to
discuss an issue that Tomeu found playing with kernelci and a Veyron
Jaq attached to our lab.

Seems that after this patch, the veyron jaq spits out lots of spi
tranfer error messages. See full log here [1]

 cros-ec-spi spi0.0: spi transfer failed: -121
 cros-ec-spi spi0.0: Command xfer error (err:-121)
 cros-ec-i2c-tunnel ff110000.spi:ec@0:i2c-tunnel: Error transferring
EC i2c message -121

The issue is random, not always happens, but when happens makes
cros-ec unusable. Reproduce the issue is easier if CONFIG_SMP is not
set.

What happens is that the master starts the transmission and the
cros-ec returns an spi error event (EC_SPI_RX_BAD_DATA  - data is
0xfb). The difference between after and before the patch is that now
the cros-ec does not recover, whereas without this patch after some
tries it succeeds (note that before the patch the affected code
returned -EAGAIN whereas now returns -EREMOTEIO)

I think that reverting this patch is NOT the solution, but I don't
have enough knowledge yet to understand why the cros-ec fails. I need
to look at the cros-ec firmware to understand better what is
happening, but meanwhile, thoughts? clues?

An important note is that I did not reproduce the issue on a Veyron
Minnie, even with CONFIG_SMP disabled.

[1] https://lava.collabora.co.uk/scheduler/job/1085493#L905

Best regards,
  Enric

> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
