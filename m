Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524653939; cv=none;
        d=google.com; s=arc-20160816;
        b=YozhajbLUb2a9GFlIt6EgHKh+FVWP8f+VOCuJB+FSZsaYpk9kZTgNzP23hSPmP8q5p
         8zwTmE8Nc2WkhGwepT4GujWawS6d84/lrWAfFLamEUT7wttUvEtcpj/9KKch44oagGPo
         jx9C5NHSYH9aKzklrtsRaLfOriH6SZrmsTmVnK/u7WjA3BfdjgRJZs/K/ZhvCDfBPCzd
         9HPKWDjgZF+JaC/09ELqL/OiaH9un/T5QMo0VrNk5iB7c9J2+mp1W++r6QbbZ0w3cU+R
         FU1idMSQugjiSbZuYedL+7hstNwj52HPT4zw8Kmt843mbEdQ+M4y35UvthfuEaRo8t/9
         QauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=rrpdfXGAKDSlbODtRwIaql+fd/+pgBiHjgQRwIzn9Sg=;
        b=k5IHa4XO1/oEBed/UIjBpt9B5AwdMb9+Fd9ycpXnUUfGrVxzxHZOOMLG526SYYEZaQ
         f++K7ArQWJb+SikaPBIzJkHVixVAWOLG3EnCvgGcvlmce9cXYDyMc1TzvwJ9XHnE6aQG
         yWpecycqK2WOdq3nRcFHpvSGxyYjBZ0lXQRgKEQLU3CndLL4mbWpQjP+l5HUkOdfCQNu
         C84nJ1Kj4S7OYjUlI1SJfvaDhZMqQsSiZj0EeibmIvhxOL80YqrVhDJbBT/4GZZjkF3l
         awpVoVLvjlbxf9Pz23Oi6TfX8HKIUrQFrwqyTyrEe48D0cVddXw3oREAIA/iOoAN4fYt
         AW5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vJEYo+e3;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vJEYo+e3;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZr+8HAHXvVvsKx4wvOrOf2Igu+ugfTuO6BZe6qxiH4mCtYf+QntQLoIvFnfOm5Ki3iKlEMzeA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 12:58:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] gnss: add generic serial driver
Message-ID: <20180425105850.GQ4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-4-johan@kernel.org>
 <20180425085749.GC13295@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425085749.GC13295@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647063920484580?=
X-GMAIL-MSGID: =?utf-8?q?1598715529322084679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:57:49AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 24, 2018 at 06:34:54PM +0200, Johan Hovold wrote:
> > Add a generic serial GNSS driver (library) which provides a common
> > implementation for the gnss interface and power management (runtime and
> > system suspend). This allows GNSS drivers for specific chip to be
> > implemented by simply providing a set_power() callback to handle three
> > states: ACTIVE, STANDBY and OFF.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gnss/Kconfig  |   7 +
> >  drivers/gnss/Makefile |   3 +
> >  drivers/gnss/serial.c | 288 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/gnss/serial.h |  47 +++++++
> >  4 files changed, 345 insertions(+)
> >  create mode 100644 drivers/gnss/serial.c
> >  create mode 100644 drivers/gnss/serial.h
> > 
> > diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> > index 103fcc70992e..f8ee54f99a8d 100644
> > --- a/drivers/gnss/Kconfig
> > +++ b/drivers/gnss/Kconfig
> > @@ -9,3 +9,10 @@ menuconfig GNSS
> >  
> >  	  To compile this driver as a module, choose M here: the module will
> >  	  be called gnss.
> > +
> > +if GNSS
> > +
> > +config GNSS_SERIAL
> > +	tristate
> > +
> 
> Maybe a real help entry?  Or is this only selected from child drivers?
> I haven't gotten that far in the series, sorry...

Correct, it's only selected by child drivers.

Johan
