Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF0EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23602533E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23602533E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeGBNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:06:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39833 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeGBNGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:06:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 358475B02182A;
        Mon,  2 Jul 2018 21:06:04 +0800 (CST)
Received: from localhost (10.202.226.43) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 21:06:03 +0800
Date:   Mon, 2 Jul 2018 14:05:51 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum
 failed
Message-ID: <20180702140551.00006297@huawei.com>
In-Reply-To: <alpine.DEB.2.20.1807020843100.31768@fox.voss.local>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
        <a84243a1a15d11511061eeae2f09c0ad8154d093.1530268235.git.nikolaus.voss@loewensteinmedical.de>
        <20180630162803.3a2ad759@archlinux>
        <alpine.DEB.2.20.1807020843100.31768@fox.voss.local>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 08:53:00 +0200
Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:

> On Sat, 30 Jun 2018, Jonathan Cameron wrote:
> 
> > On Fri, 29 Jun 2018 10:10:10 +0200
> > Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:
> >  
> >> Currently, the driver bails out if not explicitly referred to in
> >> DT or ACPI tables. This prevents fallback mechanisms from coming
> >> into effect, e.g. I2C device ID table match via DT or ACPI
> >> PRP0001 HID. However DT/ACPI enum should take precedence over
> >> the fallback, so evaluate that first.
> >>
> >> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>  
> >
> > Is the change to probe_new actually related to the rest of the change?
> >
> > I can't immediately see why...  If not I would prefer that as a separate
> > change.  
> 
> Well, it is, because the id table pointer of the old probe() is not 
> used any more.
Hmm. Fair enough, kind of incidental cleanup rather than anything more.

J

> 
> >  
> >> ---
> >>  drivers/iio/accel/st_accel_i2c.c | 21 ++++++++++++---------
> >>  1 file changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> >> index 6bdec8c451e0..e360da407027 100644
> >> --- a/drivers/iio/accel/st_accel_i2c.c
> >> +++ b/drivers/iio/accel/st_accel_i2c.c
> >> @@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> >>
> >> -static int st_accel_i2c_probe(struct i2c_client *client,
> >> -						const struct i2c_device_id *id)
> >> +static int st_accel_i2c_probe(struct i2c_client *client)
> >>  {
> >>  	struct iio_dev *indio_dev;
> >>  	struct st_sensor_data *adata;
> >> @@ -156,14 +155,18 @@ static int st_accel_i2c_probe(struct i2c_client *client,
> >>  					 client->name, sizeof(client->name));
> >>  	} else if (ACPI_HANDLE(&client->dev)) {
> >>  		ret = st_sensors_match_acpi_device(&client->dev);
> >> -		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
> >> -			return -ENODEV;
> >> -
> >> -		strlcpy(client->name, st_accel_id_table[ret].name,
> >> +		if ((ret >= 0) && (ret < ST_ACCEL_MAX))
> >> +			strlcpy(client->name, st_accel_id_table[ret].name,
> >>  				sizeof(client->name));
> >> -	} else if (!id)
> >> -		return -ENODEV;
> >> +	}
> >>
> >> +	/*
> >> +	 * If OF and ACPI enumeration failed, there could still be platform
> >> +	 * information via fallback enumeration or explicit instantiation, so
> >> +	 * check if id table has been matched via client->name.
> >> +	 */
> >> +	if (!client->name)
> >> +		return -ENODEV;
> >>
> >>  	st_sensors_i2c_configure(indio_dev, client, adata);
> >>
> >> @@ -187,7 +190,7 @@ static struct i2c_driver st_accel_driver = {
> >>  		.of_match_table = of_match_ptr(st_accel_of_match),
> >>  		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
> >>  	},
> >> -	.probe = st_accel_i2c_probe,
> >> +	.probe_new = st_accel_i2c_probe,
> >>  	.remove = st_accel_i2c_remove,
> >>  	.id_table = st_accel_id_table,
> >>  };  
> >
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


