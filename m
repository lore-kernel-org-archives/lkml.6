Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966962AbeCALEd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:04:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44025 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966703AbeCALEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:04:06 -0500
Date: Thu, 1 Mar 2018 12:04:04 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: piix4: Use usleep_range()
Message-ID: <20180301120404.42f10064@endymion>
In-Reply-To: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 12:46:52 -0800, Guenter Roeck wrote:
> The piix4 i2c driver is extremely slow. Replacing msleep()
> with usleep_range() increases its speed substantially.
> Use sleep ranges similar to those used in the i2c-801 driver
> to keep things simple.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Changed timeout values for usleep_range()
>     2000/2000 -> 2000/2100
>     500/1000 -> 250/500
>     200/500 -> 250/500
> 
>  drivers/i2c/busses/i2c-piix4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 462948e2c535..4c1f6aaec0fc 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -462,13 +462,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>  
>  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
>  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> -		msleep(2);
> +		usleep_range(2000, 2100);
>  	else
> -		msleep(1);
> +		usleep_range(250, 500);
>  
>  	while ((++timeout < MAX_TIMEOUT) &&
>  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
> -		msleep(1);
> +		usleep_range(250, 500);
>  
>  	/* If the SMBus is still busy, we give up */
>  	if (timeout == MAX_TIMEOUT) {

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
