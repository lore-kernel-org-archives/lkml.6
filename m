Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933585AbeBVSCo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:02:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55191 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeBVSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:02:42 -0500
X-Google-Smtp-Source: AH8x22494Dhxf9SMtRxXH8IgkpBE6quEw4BrYGqJ4i3F/gaPQqZ2/cO5d9ARf3aSnUcDOMaCUTk235OeBsgOdsbFvYY=
MIME-Version: 1.0
In-Reply-To: <1043d995-1448-3c0c-8052-8c31d18343d1@caviumnetworks.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com> <1043d995-1448-3c0c-8052-8c31d18343d1@caviumnetworks.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Thu, 22 Feb 2018 11:02:38 -0700
Message-ID: <CALdTtnv12uzaVQLzEMOgPdN6wqo=UAdm+_nhDhcf5Jr2zY=4hA@mail.gmail.com>
Subject: Re: [PATCH 1/4] i2c: xlp9xx: return ENXIO on slave address NACK
To: George Cherian <gcherian@caviumnetworks.com>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        wsa@the-dreams.de, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 7:28 AM, George Cherian
<gcherian@caviumnetworks.com> wrote:
> Gentle Ping on this series.

I've been using these on a few Cavium Sabre boards, which previously
had an unusable system interface (/dev/ipmi) due to timeouts or just
enumerations failures. So, fwiw:

Tested-by: dann frazier <dann.frazier@canonical.com>

 -dann

> On 01/18/2018 11:09 AM, George Cherian wrote:
>>
>> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>>
>> Fix the driver violation of the common practice to return
>> ENXIO error on a slave address NACK.
>>
>> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/i2c/busses/i2c-xlp9xx.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c
>> b/drivers/i2c/busses/i2c-xlp9xx.c
>> index b970bf8..6d78cdc 100644
>> --- a/drivers/i2c/busses/i2c-xlp9xx.c
>> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
>> @@ -324,7 +324,8 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev
>> *priv, struct i2c_msg *msg,
>>                 dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
>>                 if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
>>                         xlp9xx_i2c_init(priv);
>> -               return -EIO;
>> +               return (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) ?
>> +                       -ENXIO : -EIO;
>>         }
>>         if (timeleft == 0) {
>>
>
> Regards
> -George
