Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeCGXBk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:01:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56928 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754500AbeCGXBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:01:38 -0500
Date: Thu, 8 Mar 2018 00:01:36 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: remove VLA usage
Message-ID: <20180307230136.GB20370@piout.net>
References: <20180307201133.GA5860@embeddedgus>
 <20180307212506.GO3035@piout.net>
 <3e8e1515-0f0e-73d4-72eb-3a2a2fbf04e9@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8e1515-0f0e-73d4-72eb-3a2a2fbf04e9@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 at 16:39:51 -0600, Gustavo A. R. Silva wrote:
> Hi Alexandre,
> 
> On 03/07/2018 03:25 PM, Alexandre Belloni wrote:
> > On 07/03/2018 at 14:11:33 -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wvla, remove VLA and replace it
> > > with a fixed-length array instead.
> > > 
> > You should probably explain what VLA is and why this is important to do.
> 
> Sure. I can elaborate a little bit more.
> 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   drivers/rtc/rtc-bq32k.c  | 2 +-
> > >   drivers/rtc/rtc-mcp795.c | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
> > > index e8698e9..e4b234a 100644
> > > --- a/drivers/rtc/rtc-bq32k.c
> > > +++ b/drivers/rtc/rtc-bq32k.c
> > > @@ -74,7 +74,7 @@ static int bq32k_read(struct device *dev, void *data, uint8_t off, uint8_t len)
> > >   static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
> > >   {
> > >   	struct i2c_client *client = to_i2c_client(dev);
> > > -	uint8_t buffer[len + 1];
> > > +	uint8_t buffer[256];
> > You chose to change len to 255, probably because this is a uint8_t but
> 
> Correct.
> 
> > this is way too much for this rtc, it only has 10 consecutive registers.
> 
> In that case probably the best solution is to add the following line to the
> module:
> 
> #define MAX_LEN 10
> 
> and update the rest of the code as follows:
> 
> uint8_t buffer[MAX_LEN + 1];
> 

Seems better, yes.

> 
> > >   	buffer[0] = off;
> > >   	memcpy(&buffer[1], data, len);
> > > diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> > > index 79e24ea..00e11c1 100644
> > > --- a/drivers/rtc/rtc-mcp795.c
> > > +++ b/drivers/rtc/rtc-mcp795.c
> > > @@ -82,7 +82,7 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
> > >   {
> > >   	struct spi_device *spi = to_spi_device(dev);
> > >   	int ret;
> > > -	u8 tx[2 + count];
> > > +	u8 tx[257];
> 
> For this particular case it seems to me that the following works just fine:
> 
> #define MAX_COUNT 7
> 
> u8 tx[MAX_COUNT + 2];
> 
> What do you think?
> 

Nope, that RTC has a section of 255 bytes that could be read at once so
257 is the correct value.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
