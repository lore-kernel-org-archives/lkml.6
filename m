Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933709AbeCMQ3G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:29:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52835 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933615AbeCMQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:29:05 -0400
Date: Tue, 13 Mar 2018 17:28:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefano Manni <stefano.manni@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mcp795: remove VLA usage
Message-ID: <20180313162850.GK3795@piout.net>
References: <20180312231338.3756-1-stefano.manni@gmail.com>
 <20180312233102.GE3795@piout.net>
 <CANn9nbhM7LaqKg5pbVMYygAANFhWu3N77BUD6QTaVRngOhz3fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn9nbhM7LaqKg5pbVMYygAANFhWu3N77BUD6QTaVRngOhz3fg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2018 at 09:29:33 +0100, Stefano Manni wrote:
> Hi,
> 
> 2018-03-13 0:31 GMT+01:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> > Hi,
> >
> > On 13/03/2018 at 00:13:38 +0100, Stefano Manni wrote:
> >> In preparation to enabling -Wvla, remove VLAs and replace them with
> >> fixed-length arrays instead.
> >>
> >> rtc-mcp795.c uses a variable-length array declaration to contain
> >> the command to write the rtcc; this can be replaced by a fixed-
> >> size array of length 2 (instruction, address) + 32 (data out),
> >> assuming a maximum data length of 32 bytes before wrap up.
> >>
> >> This was prompted by https://lkml.org/lkml/2018/3/7/621
> >>
> >> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
> >> ---
> >>  drivers/rtc/rtc-mcp795.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> >> index 77f21331ae21..a5f504e2364c 100644
> >> --- a/drivers/rtc/rtc-mcp795.c
> >> +++ b/drivers/rtc/rtc-mcp795.c
> >> @@ -61,6 +61,9 @@
> >>
> >>  #define SEC_PER_DAY          (24 * 60 * 60)
> >>
> >> +/* Maximum length for data out in write operation to RTCC */
> >> +#define MCP795_MAX_DATAOUT_LEN       32
> >> +
> >
> > This is wrong, see https://marc.info/?l=linux-kernel&m=152046370320811&w=2
> >
> > Also, https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=74ce1a932504da166cfbccf5567aa3751b6aa599
> >
> 
> You sure that the right value to use is 255 + 2? mcp795_rtcc_write() just writes
> into the RTCC that contains only 32 registers (table 4-1 of
> datasheet). I assumed
> 32 as the maximum length of data to write before wrapping up (start
> from reg 0x0).
> Probably 32 is just a wrong assumption but why did you choose 255?
> 

It is not so wrong but the plan is to be able to support reading/writing
the EEPROM later but I agree it will need to be changed anyway.

> Another thing: don't we need also to check count against the array length?
> 
> if (count > MCP795_MAX_DATAOUT_LEN)
>     return -EINVAL;

u8 count will never be greater than 255.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
