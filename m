Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeDJH4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:56:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38338 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbeDJH4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:56:22 -0400
Date: Tue, 10 Apr 2018 09:56:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>
Cc: Taiyi Wu <taiyity.wu@moxa.com>,
        Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] rtc: tps65910: add bounds checking
Message-ID: <20180410075610.GA24625@piout.net>
References: <20180410072417.7078-1-sz.lin@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180410072417.7078-1-sz.lin@moxa.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/04/2018 15:24:17+0800, SZ Lin (林上智) wrote:
> Since tm->tm_year is the offset relative to 1900, it needs to check for
> positive value to avoid overflow in YEARS_REG register.
> 
> The system will hang at the following stage on the next boot when overflow
> has occurred.
> 
> [    2.221192] systemd[1]: Time has been changed
> 
> This patch fixes the above hanging issue by adding bounds checking.
> 

Did you test linux-next, this should not happen anymore after
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=b3a5ac42ab18b7d1a8f2f072ca0ee76a3b754a43

> Signed-off-by: Taiyi Wu <taiyity.wu@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> ---
>  drivers/rtc/rtc-tps65910.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
> index d0244d7979fc..6be9f7bb0f1b 100644
> --- a/drivers/rtc/rtc-tps65910.c
> +++ b/drivers/rtc/rtc-tps65910.c
> @@ -105,6 +105,12 @@ static int tps65910_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	struct tps65910 *tps = dev_get_drvdata(dev->parent);
>  	int ret;
>  
> +	if ((tm->tm_year - 100) < 0) {
> +		dev_err(dev, "the requested year %d is unsupported\n",
> +			1900 + tm->tm_year);
> +		return -EINVAL;
> +	}
> +
>  	rtc_data[0] = bin2bcd(tm->tm_sec);
>  	rtc_data[1] = bin2bcd(tm->tm_min);
>  	rtc_data[2] = bin2bcd(tm->tm_hour);
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
