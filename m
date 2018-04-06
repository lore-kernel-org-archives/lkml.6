Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523054279; cv=none;
        d=google.com; s=arc-20160816;
        b=RmA097OKWRR+lzOCK6cWQq/C8/IWnkmzDX+lqI2vzgppkh9cNWSXc76p3UW9AmRIcS
         4fW/6au6WbmR2wcdT9lZVuY9pScYDhZB7dfQ0aekX3UyCtLFr9SaOswmMiXaReggTsoj
         EQGigV3+Z9tSXOTXfONhrPp/sBig+FDLxn5XSP3NLKon6tJDEgZ4LosmVousT/gWz+pJ
         WN4OQI2agyKWeWgksDQbheesOcjdwaipSvt35fFJkR01KC4ikG1NM9uyL5eGGhLotdgN
         u4g3gYEDrMEQBiwMW6SUuR1pOYf7w5MtvMFW+dFJcAPe6zPtnGqjWWWsJQIZiRsEneX8
         RToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xFS/gR+mfukAcxSONWZ7LxHa0uGVw55tp6Phkz58LKs=;
        b=KynEzO+5aCOhQvdaNacI7EVQFcbRvRXWuaKQJEBzUEnRhhMEFF8gPOi6qvi3DprmkG
         yaF3VIM3YDVPAfkzRB6pMkmQbIhci7d5XzQvw6mHlaXjkQ1G+N9j0SMZlAK6Dyf8OYDR
         3aH3+iY8dRgBTgDL1Su1Oeh3ppMbUFNSFbJdK055XgRE+87Rp+bL40uSpxLt37UvrbNp
         clb5U1D/Gbb9OCb7vT6nLrNw9slpRAYdMTeCl3QgouX9ES7GIFjX+gaB3+1N6N0h5hoH
         4okjUhFrog//ZtqhhbZGf2JXj5f0DWbsOGbmL7mIabsilyWrBiKa/EpsI6hUUR04UXP7
         YDew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ji7p913R;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ji7p913R;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49CWRYsYkwr++gMRDou+4Za1CzlUIXZSDaMVGWn4BJE1lPHIF4186Bzp1BaXCuoDGjdu3WK9w==
Date: Fri, 6 Apr 2018 15:37:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	benjamin.tissoires@redhat.com, gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
Message-ID: <20180406223756.GD206175@dtor-ws>
References: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
 <a8d419ae-4047-77af-0a1c-683bf1370e6a@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d419ae-4047-77af-0a1c-683bf1370e6a@synaptics.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596643408771291983?=
X-GMAIL-MSGID: =?utf-8?q?1597038164758951384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 05:52:52PM -0700, Andrew Duggan wrote:
> 
> On 04/02/2018 07:03 AM, Christophe JAILLET wrote:
> > When extending the rmi_spi buffers, we must check that no out of memory
> > error occurs, otherwise we may access data above the currently allocated
> > memory.
> > 
> > Propagate the error code returned by 'rmi_spi_manage_pools()' instead.
> Yep, that definitely looks like an oversight on my part. Thanks for the fix.
> 
> Andrew
> 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

Applied, thank you.

> 
> > ---
> >   drivers/input/rmi4/rmi_spi.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
> > index 76edbf2c1bce..082defc329a8 100644
> > --- a/drivers/input/rmi4/rmi_spi.c
> > +++ b/drivers/input/rmi4/rmi_spi.c
> > @@ -147,8 +147,11 @@ static int rmi_spi_xfer(struct rmi_spi_xport *rmi_spi,
> >   	if (len > RMI_SPI_XFER_SIZE_LIMIT)
> >   		return -EINVAL;
> > -	if (rmi_spi->xfer_buf_size < len)
> > -		rmi_spi_manage_pools(rmi_spi, len);
> > +	if (rmi_spi->xfer_buf_size < len) {
> > +		ret = rmi_spi_manage_pools(rmi_spi, len);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >   	if (addr == 0)
> >   		/*
> 

-- 
Dmitry
