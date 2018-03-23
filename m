Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeCWMsy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:48:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36918 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752009AbeCWMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:48:53 -0400
Date: Fri, 23 Mar 2018 12:48:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/11] staging: iio: ad7746: Add remove()
Message-ID: <20180323134837.00002ab0@huawei.com>
In-Reply-To: <1521642539-4845-8-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1521642539-4845-8-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 11:28:55 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This allows the driver to be probed and removed as a module.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 815573c..8abba71 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -768,6 +768,15 @@ static int ad7746_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int ad7746_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
Remove is not required to allow a driver to be removed..
It's required to clean up anything that needs cleaning up
when the remove happens.

If all you have is the device unregister then it should be
possible to use.
devm_iio_device_register and rely on managed cleanup to
automatically call the unregister code for you.

Hence there would be no need to have a remove function.

Jonathan
> +
> +	return 0;
> +}
> +
>  static const struct i2c_device_id ad7746_id[] = {
>  	{ "ad7745", 7745 },
>  	{ "ad7746", 7746 },
> @@ -792,6 +801,7 @@ static struct i2c_driver ad7746_driver = {
>  		.of_match_table = of_match_ptr(ad7746_of_match),
>  	},
>  	.probe = ad7746_probe,
> +	.remove = ad7746_remove,
>  	.id_table = ad7746_id,
>  };
>  module_i2c_driver(ad7746_driver);
