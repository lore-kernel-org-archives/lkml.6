Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbeBLWWt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41021 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:22:44 -0500
X-Google-Smtp-Source: AH8x226fXc+bgXWFTLHQkRH3fY3hwZL5IWYWVc72gZIV1vha7f3uiejObW4Da/k9guZL4LtQUzg4Sw==
Date: Mon, 12 Feb 2018 14:22:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Message-ID: <20180212222241.GA32060@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <1514652658-6228-2-git-send-email-linux@roeck-us.net>
 <20180212115336.4b828ab8@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212115336.4b828ab8@endymion>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Mon, Feb 12, 2018 at 11:53:36AM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 30 Dec 2017 08:50:58 -0800, Guenter Roeck wrote:
> > The piix4 i2c driver is extremely slow. Replacing msleep()
> > with usleep_range() increases its speed substantially.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/i2c/busses/i2c-piix4.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> > index 78dd5951d6e7..52a8b1c5c110 100644
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -467,13 +467,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
> >  
> >  	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
> >  	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
> > -		msleep(2);
> > +		usleep_range(2000, 2000);
> 
> Isn't this exactly the same? I'm fine using the same function for
> consistency, just curious.
> 
> >  	else
> > -		msleep(1);
> > +		usleep_range(500, 1000);
> 
> Were you able to test this on older hardware? Unfortunately, the
> specification errata of the original Intel PIIX4 is quite vague on the
> amount of time you must wait before checking the Host Busy bit:
> 
> "Note that there may be moderate latency before the transaction begins
> and the Host Busy bit gets set."
> 
> I guess we made it 1 ms at the time because it was the minimum we could
> sleep anyway.
> 
> One option if you really care about the performance of the i2c-piix4
> driver on recent hardware would be to lower the initial delay even more
> for ATI and AMD chipsets. The errata was for Intel chipsets originally,
> and while we know that at least some of the ServerWorks implementations
> suffered from the same problem (worse actually) I don't think that
> anybody ever bothered checking if it applied to more recent
> implementations by other vendors.
> 
> For reference, at 93.75 kHz (the default SMBus frequency or the SB800),
> an SMBus Quick transaction would be completed in 117 us, so I guess an
> initial delay of 150 or 200 us would be optimum. And an SMBus Read Byte
> transaction completes in 416 ms. I think this is the most popular SMBus
> transaction, so ensuring that it is as fast as possible would make
> sense.
> 
> And it might even work on older Intel chipsets, who knows. Plus I doubt
> anyone is still using them anyway, so you have my approval to lower the
> delays to whatever works for you.
> 
> As a comparison point, in the i2c-i801 driver we use:
> 
> 	usleep_range(250, 500);
> 
> for both the initial sleep and the waiting loop.
> 
A further test on Ryzen shows that bit 0 of SMBHSTSTS is set immediately,
ie with
	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
        busy = inb_p(SMBHSTSTS) & 0x01;
busy is always true. None of the datasheets I was able to find (sb700,
sb800, bolton) suggests that an initial delay is needed.

Another quick test with my Ryzen system, using usleep_range(100, 100),
shows the result of quick commands in the third loop iteration (ie
after 200 uS), and the result of a "read byte" operation in the 6th
loop iteration (ie after 500 uS). This is measured without initial delay.

Not sure what that means, if anything, for the driver. The biggest concern
is the "moderate latency" required by the Intel chips. Otherwise we could
just use the values from i2c-i801 for both initial and loop delay.

Guenter
