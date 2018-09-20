Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E32C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073EC2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x1/hRuwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073EC2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbeITXwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:52:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38256 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbeITXwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:52:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KHwqBU089809;
        Thu, 20 Sep 2018 18:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iknaWo/C9kRaiPoGpx7TdiD50gzYqmdiZTQEqjTAg+M=;
 b=x1/hRuwojH5aAQtI72mzrndfGrb5CTVr/i/miVel9oTyz8PK0E6NQYJd16ylnp2U29lK
 YhWVI+M2V/p8X5ih/6ohenJCKP8J6xhlKndef3ANsE29eRt0LDfZtRdYAAT0Gf1JBZ5A
 P90AJZUlA69/uwMcL1dgjHHs/sL42CjxxioJzQo+zpOw6Nx8+gnD3UR76s2fxuDlb0iR
 R3HK/CrpSQTdyjN6quQWdX5Rvda6yZGWUlMmEPEy15fyavkdjrCTZbbbeLzpfY0u+1H1
 gIwaYucsryA/hHlwcA+n5d3Gvwt1B5vzNBr9Q435rNnSq4VhP572dqlyndoJXJJ8jF7B ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mgtqrcd80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 18:06:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8KI5xwU029204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 18:06:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8KI5p6u024791;
        Thu, 20 Sep 2018 18:05:51 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 11:05:50 -0700
Date:   Thu, 20 Sep 2018 21:05:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devel@driverdev.osuosl.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
Message-ID: <20180920180529.hjc54yoqmvnpvvt7@mwanda>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
 <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
 <9860023.SlBYqtbjDV@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9860023.SlBYqtbjDV@z50>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=456
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:48:22PM +0200, Janusz Krzysztofik wrote:
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a53d17745d21..5bc3447949c9 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  			__set_bit(hwgpio, mask);
>  
>  			if (array_info)
> -				find_next_zero_bit(array_info->get_mask,
> +				i = find_next_zero_bit(array_info->get_mask,
>  						   array_size, i);

We could mark find_next_zero_bit() and friends as a __must_check
functions so we avoid this bug in the future.  I have a more complicated
idea how to detect these bugs in a generic way using Smatch but it will
take longer to implement.

regards,
dan carpenter

