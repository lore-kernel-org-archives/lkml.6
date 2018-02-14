Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030967AbeBNOoX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:44:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:35040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030839AbeBNOoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:44:19 -0500
Date: Wed, 14 Feb 2018 15:44:16 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm0=?= =?UTF-8?B?w6lueWk=?=
        <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: piix4: Use usleep_range()
Message-ID: <20180214154416.5113038d@endymion>
In-Reply-To: <20180212222241.GA32060@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
        <1514652658-6228-2-git-send-email-linux@roeck-us.net>
        <20180212115336.4b828ab8@endymion>
        <20180212222241.GA32060@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 14:22:41 -0800, Guenter Roeck wrote:
> On Mon, Feb 12, 2018 at 11:53:36AM +0100, Jean Delvare wrote:
> > Were you able to test this on older hardware? Unfortunately, the
> > specification errata of the original Intel PIIX4 is quite vague on the
> > amount of time you must wait before checking the Host Busy bit:
> > 
> > "Note that there may be moderate latency before the transaction begins
> > and the Host Busy bit gets set."
> > 
> > I guess we made it 1 ms at the time because it was the minimum we could
> > sleep anyway.
> > 
> > One option if you really care about the performance of the i2c-piix4
> > driver on recent hardware would be to lower the initial delay even more
> > for ATI and AMD chipsets. The errata was for Intel chipsets originally,
> > and while we know that at least some of the ServerWorks implementations
> > suffered from the same problem (worse actually) I don't think that
> > anybody ever bothered checking if it applied to more recent
> > implementations by other vendors.
> > 
> > For reference, at 93.75 kHz (the default SMBus frequency or the SB800),
> > an SMBus Quick transaction would be completed in 117 us, so I guess an
> > initial delay of 150 or 200 us would be optimum. And an SMBus Read Byte
> > transaction completes in 416 ms. I think this is the most popular SMBus
> > transaction, so ensuring that it is as fast as possible would make
> > sense.
> > 
> > And it might even work on older Intel chipsets, who knows. Plus I doubt
> > anyone is still using them anyway, so you have my approval to lower the
> > delays to whatever works for you.
> > 
> > As a comparison point, in the i2c-i801 driver we use:
> > 
> > 	usleep_range(250, 500);
> > 
> > for both the initial sleep and the waiting loop.
>
> A further test on Ryzen shows that bit 0 of SMBHSTSTS is set immediately,
> ie with
> 	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
>         busy = inb_p(SMBHSTSTS) & 0x01;
> busy is always true. None of the datasheets I was able to find (sb700,
> sb800, bolton) suggests that an initial delay is needed.

It it good that today's hardware is better than Intel's original
hardware, but on the other hand, it makes little sense to start polling
before the command has a chance of being completed. So I don't think
that skipping the initial delay would help with performance.

> Another quick test with my Ryzen system, using usleep_range(100, 100),
> shows the result of quick commands in the third loop iteration (ie
> after 200 uS), and the result of a "read byte" operation in the 6th
> loop iteration (ie after 500 uS). This is measured without initial delay.

Your numbers are in line with my theoretical estimates above.

> Not sure what that means, if anything, for the driver. The biggest concern
> is the "moderate latency" required by the Intel chips. Otherwise we could
> just use the values from i2c-i801 for both initial and loop delay.

I think I would not bother too much about that older hardware which
probably nobody uses anymore (we are talking about late 90s
motherboards here, I'm rather conservative and sentimental with my
hardware and even me no longer have these.) It makes more sense to make
the driver as efficient as possible for current hardware.

>From your numbers above, an initial sleep of 200 us followed by 200 us
in-loop delays would seem reasonable to me. With some upper margin to
let the scheduler reduce the CPU awakening, as suggested by Joe
somewhere else in this thread.

If you want to push it one step further, you could estimate how long
the transaction is expected to take (based on the SMBus clock frequency
and the number of bytes in the transaction) and set the initial delay
to match that. That would allow to shorten the cycle time in the
polling loop (as you know you won't cycle at all in most cases) and
limit the useless calls to usleep_range() and the polls which can't
succeed.

Whether you want to spend time on this is up to you, of course.

-- 
Jean Delvare
SUSE L3 Support
