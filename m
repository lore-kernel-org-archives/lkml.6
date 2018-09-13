Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F2FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258232146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="EJrt2maw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258232146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeINCzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:55:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38320 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeINCzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:55:08 -0400
Received: by mail-io1-f68.google.com with SMTP id y3-v6so4424932ioc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC4xCRBf+sqKJaI3IajyAgsIYn5dr5uvIXjrxS/MNtg=;
        b=EJrt2mawuW9zJlvzt5xdRxqky8DEB+JBFpMcWdyCDS4xjb81alTbs+JIbuWQC8IuKS
         ox/U1HqtI9+s7g243F7R10Fze89kt1Adc3UkHLzqWl5xht9A4D+FdrnbkoU/LIZnBm5Z
         2/N4dxr2Ny7i6F/yq3xPwyzvMSWSL9/nyqI8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC4xCRBf+sqKJaI3IajyAgsIYn5dr5uvIXjrxS/MNtg=;
        b=MkhTJy1BhiU1pYmh4HzVPvxeef/M9J4MzDzvZFeNrxeWC86CuiCpOyCbRrcu+pLvI7
         /QJQPaxiiXFMjM19IpigC6r3rdXeauIJuAv65uat3ae2mF0vTM8HD/T2kdHIzV6P+WY4
         ulobkXgF+Ei+MZ7cF0qt6r8i/rQv5tSZJzntodvyrxbzfE+L020MO60hJXknz6UvVbNM
         SLFa5UlHzKKhd3zrWaSCMsL/+WoEObe/jMddzoZHY+Utmbgv+YP6wWvfp3omwJAv8BCn
         GIyyYiAPQe3iXd2GRO+/W5NFRTy4DwihmzzEy+1VLW48wRcFS2LE4UjLaq9hdUWOAm8W
         eN0Q==
X-Gm-Message-State: APzg51AbBW8ilyq23U5dGQUm7qq99pWFumC5unGiSSEsn577ngDhkYhw
        64P6msBimW06TLNC5aakBOVCE1Jtswo1Ig0Lwq0K/g==
X-Google-Smtp-Source: ANB0VdZeOcvDBuDDmUV4/d/ADtLxtqTYJmw6IVxifBQHIhe9Q/PBSfgQCkb95VwlqL8lpUXrcJ/LWwLCSoSsdmcCyO0=
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr8385048ioe.66.1536875028000;
 Thu, 13 Sep 2018 14:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180913035145.28056-1-songqiang.1304521@gmail.com>
In-Reply-To: <20180913035145.28056-1-songqiang.1304521@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 13 Sep 2018 14:43:35 -0700
Message-ID: <CAJCx=gk3Md910hfD2ZiTRNj6mv1nf+r6p_0tYMu7uKiEp4ZvOw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: lidar-v2: replace i2c block access method
 with the one already implemented.
To:     songqiang1304521@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        songqiang.1304521@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:51 PM Song Qiang <songqiang1304521@gmail.com> wrote:
>
> This driver tries to access a block of data on a i2c bus and it tries
> to manually make a device command frame and a consecutively read frame,
> then uses i2c_transfer() to read data. But this has already been
> implemented in i2c_smbus_read_i2c_block_data().
> Sorry for not having this device by my hand, which is a little expansive
> for me, but I have another i2c device and tested with both i2c_transfer()
> and i2c_smbus_read_i2c_block_data() and they all ends the same.
> I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
> function is the same as i2c_smbus_read_block_data()? The original code
> is commented with something I'm not sure, but I think if it's a standard
> SMBus, it should be able to use in here.
> Hoping for someone to explain.
>

Yes actually there is a reason for this insanity!

It isn't actually SMBUS (note the lidar_smbus_xfer function below it)
and has a odd way to read registers via I2C.
Basically the I2C_M_STOP flags is the reason you can use the standard
i2c_smbus_read_i2c_block_data().

Page 6 in this datasheet
* http://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf

> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> ---
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c  | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 47af54f14756..ca880ba8e820 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -63,23 +63,7 @@ static const struct iio_chan_spec lidar_channels[] = {
>
>  static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
>  {
> -       struct i2c_client *client = data->client;
> -       struct i2c_msg msg[2];
> -       int ret;
> -
> -       msg[0].addr = client->addr;
> -       msg[0].flags = client->flags | I2C_M_STOP;
> -       msg[0].len = 1;
> -       msg[0].buf  = (char *) &reg;
> -
> -       msg[1].addr = client->addr;
> -       msg[1].flags = client->flags | I2C_M_RD;
> -       msg[1].len = len;
> -       msg[1].buf = (char *) val;
> -
> -       ret = i2c_transfer(client->adapter, msg, 2);
> -
> -       return (ret == 2) ? 0 : -EIO;
> +       return i2c_smbus_read_i2c_block_data(data->client, reg, len, val);
>  }
>
>  static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
> --
> 2.17.1
>
