Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbeBMLLz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:11:55 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34700 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934226AbeBMLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:11:52 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Tue, 13 Feb 2018 11:11:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <patches@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 16/21] regulator: wm8994: Pass descriptor instead of GPIO
 number
Message-ID: <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-17-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180212131717.27193-17-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=747 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802130134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:17:12PM +0100, Linus Walleij wrote:
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up from the device tree node or the board file
> decriptor table for the regulator.
> 
> There is a single board file passing the GPIOs for LDO1 and LDO2
> through platform data, so augment this to pass descriptors
> associated with the i2c device as well.
> 
> Cc: patches@opensource.cirrus.com
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Lee: this patch is touching the MFD core driver for WM8994,
> but as with all other patches we just change the regulator
> parts. Would be nice if you could ACK it.
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 18 ++++++++++++++++--
>  drivers/mfd/wm8994-core.c                    |  9 ---------
>  drivers/regulator/wm8994-regulator.c         | 19 +++++++++++--------
>  include/linux/mfd/wm8994/pdata.h             |  3 ---
>  4 files changed, 27 insertions(+), 22 deletions(-)
> 
> +static struct gpiod_lookup_table wm8994_gpiod_table = {
> +	.dev_id = "i2c-wm8958", /* I2C device name */
> +	.table = {
> +		GPIO_LOOKUP("GPION", 6,
> +			    "wlf,ldo1ena", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("GPION", 4,
> +			    "wlf,ldo2ena", GPIO_ACTIVE_HIGH),
> +		{ },
>  	},
>  };
>  
> @@ -366,6 +379,7 @@ static int wlf_gf_module_probe(struct i2c_client *i2c,
>  					    rev == gf_mods[i].rev))
>  			break;
>  
> +	gpiod_add_lookup_table(&wm8994_gpiod_table);

Would it be nicer to add this as a new member of gf_mods and
register it inside the loop? Since eventually we will need tables
for wm5102, wm8994, wm2200, wm8996, wm5100 and wm0010.

Thanks,
Charles
