Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDSNtJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:49:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbeDSNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:49:07 -0400
Date: Thu, 19 Apr 2018 15:49:02 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alexander Popov <alex.popov@linux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, sil2review@lists.osadl.org,
        Dmitry Vyukov <dvyukov@google.com>, syzkaller@googlegroups.com
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Message-ID: <20180419134902.6l5jsf4wpqfiaskj@pengutronix.de>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:29:22PM +0300, Alexander Popov wrote:
> i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
> returns ZERO_SIZE_PTR if i2c_msg.len is zero.
> 
> Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
> of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
> case of zero len.
> 
> Let's check the len against zero before dereferencing buf pointer.
> 
> This issue was triggered by syzkaller.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  drivers/i2c/i2c-dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 036a03f..5790bc8 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -280,6 +280,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
>  		 */
>  		if (msgs[i].flags & I2C_M_RECV_LEN) {
>  			if (!(msgs[i].flags & I2C_M_RD) ||
> +			    !msgs[i].len ||

I'd prefer

			msgs[i].len > 0

here instead of

			!msgs[i].len

because I can parse that more easily. Semantically the patch is fine and
can have my

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

>  			    msgs[i].buf[0] < 1 ||
>  			    msgs[i].len < msgs[i].buf[0] +
>  					     I2C_SMBUS_BLOCK_MAX) {

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
