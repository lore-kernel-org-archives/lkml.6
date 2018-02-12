Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbeBLKxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:53:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933921AbeBLKxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:53:39 -0500
Date: Mon, 12 Feb 2018 11:53:36 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm0=?= =?UTF-8?B?w6lueWk=?=
        <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Message-ID: <20180212115336.4b828ab8@endymion>
In-Reply-To: <1514652658-6228-2-git-send-email-linux@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
        <1514652658-6228-2-git-send-email-linux@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sat, 30 Dec 2017 08:50:58 -0800, Guenter Roeck wrote:
> The piix4 i2c driver is extremely slow. Replacing msleep()
> with usleep_range() increases its speed substantially.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 78dd5951d6e7..52a8b1c5c110 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>  
>  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
>  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> -		msleep(2);
> +		usleep_range(2000, 2000);

Isn't this exactly the same? I'm fine using the same function for
consistency, just curious.

>  	else
> -		msleep(1);
> +		usleep_range(500, 1000);

Were you able to test this on older hardware? Unfortunately, the
specification errata of the original Intel PIIX4 is quite vague on the
amount of time you must wait before checking the Host Busy bit:

"Note that there may be moderate latency before the transaction begins
and the Host Busy bit gets set."

I guess we made it 1 ms at the time because it was the minimum we could
sleep anyway.

One option if you really care about the performance of the i2c-piix4
driver on recent hardware would be to lower the initial delay even more
for ATI and AMD chipsets. The errata was for Intel chipsets originally,
and while we know that at least some of the ServerWorks implementations
suffered from the same problem (worse actually) I don't think that
anybody ever bothered checking if it applied to more recent
implementations by other vendors.

For reference, at 93.75 kHz (the default SMBus frequency or the SB800),
an SMBus Quick transaction would be completed in 117 us, so I guess an
initial delay of 150 or 200 us would be optimum. And an SMBus Read Byte
transaction completes in 416 ms. I think this is the most popular SMBus
transaction, so ensuring that it is as fast as possible would make
sense.

And it might even work on older Intel chipsets, who knows. Plus I doubt
anyone is still using them anyway, so you have my approval to lower the
delays to whatever works for you.

As a comparison point, in the i2c-i801 driver we use:

	usleep_range(250, 500);

for both the initial sleep and the waiting loop.

>  
>  	while ((++timeout < MAX_TIMEOUT) &&
>  	       ((temp = inb_p(SMBHSTSTS)) & 0x01))
> -		msleep(1);
> +		usleep_range(200, 500);

Note that you are also drastically reducing the effective timeout value
here, because it is a counter and not an overall time. Beforehand, we
would wait for at least 501 ms for the transaction to complete. Now
this could be down to only 100 ms. That being said, if my math is
right, the longest supported transaction (Block Read) at the slowest
allowed SMBus clock speed (10 kHz) would be done in 33 ms, so we are
still good.

>  
>  	/* If the SMBus is still busy, we give up */
>  	if (timeout == MAX_TIMEOUT) {

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
