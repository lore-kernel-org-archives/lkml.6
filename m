Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeEFQTw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 12:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeEFQTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 12:19:48 -0400
Date: Sun, 6 May 2018 17:19:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: Fix sensor reads after resume
Message-ID: <20180506171942.0a4802d7@archlinux>
In-Reply-To: <20180430042546.8801-1-shrirang.bagul@canonical.com>
References: <20180430042546.8801-1-shrirang.bagul@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 12:25:46 +0800
Shrirang Bagul <shrirang.bagul@canonical.com> wrote:

> CTRL1 register (ODR & BDU settings) gets reset after system comes back
> from suspend, causing subsequent reads from the sensor to fail.
> 
> This patch restores the CTRL1 register after resume.
> 
> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-fixes-for-4.14b
> 
> Since 4.17.rc1, this driver uses REGMAP; I'll send a separate patch to
> address this issue.
> 
> Cc: stable@vger.kernel.org
> Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
Looks like part of the problem was introduced in that patch, part well predated
it (BDU).

> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
As you way, this needs to be a bit different to take into account
the change to regmap.  We'll need to have that upstream before we look
at a back port.  One element inline surprises me and needs further
explanation.


> ---
>  drivers/iio/humidity/hts221_core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 32524a8dc66f..fed2da64fa3b 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -674,11 +674,15 @@ static int __maybe_unused hts221_resume(struct device *dev)
>  	struct hts221_hw *hw = iio_priv(iio_dev);
>  	int err = 0;
>  
> -	if (hw->enabled)
> -		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -					     HTS221_ENABLE_MASK, true);

Why drop the enable setting?  Seems that we want to do this 'as well',
if the device was previous enabled.

> +	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +				     HTS221_BDU_MASK, 1);
> +	if (err < 0)
> +		goto fail_err;
>  
> -	return err;
> +	err = hts221_update_odr(hw, hw->odr);
> +
> +fail_err:
> +	return err < 0 ? err : 0;
>  }
>  
>  const struct dev_pm_ops hts221_pm_ops = {
