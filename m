Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525762915; cv=none;
        d=google.com; s=arc-20160816;
        b=UYxThLzoN/bJ5JSFdKEAww+rJdll6+7jT29rxSjtQhCRWOaWbH3+rUoFZVreAp4/r+
         ZNH77EJkC+KBXAXkXTnM7dgbsFAFKIszyQ2frQ99HA5avV5geB0HZrs7bvkm5xzlhZXb
         GoTXLewm6rvs18s64qGUJrSOpVKmjfjnQDZ1wywcUQisRgjOh7vAMOJQqFoZpS7P5tmL
         Y6OHhpkVUpFfyMtEQD1c+W1w8FudbTOJpNEAa3ykb2/qU0aHDI58Q4BKNFvGh6ZIVjdR
         HVu0E5w3a5D4mNxA6txZa6Mxkl2Qsk4P8jVyavYb6dHS2S0H+d8NuehSi1u/tekYWFU8
         Kdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=bJt3phMwrsYIcJVwRbjY2LWJVfYJ1hQBoPXk6u9hvYU=;
        b=1HG8U3gwzaQ9MCD8B0pSDl25a3NLnEIpbe4qJ5fimg3HEtqHwtKFG3MKg6zZAQBoSn
         8grFljMsY2A05HqzEFO1KQXm8h+CRlUn4iE71ktBjM5IM+anHjAIPiu6C+CUVPuKtMdn
         tBd/8bnm+IP6lXzen9aQMxwz2s2yATODRUGbI995vFrG/rJYjqaRxOa7MqRuZeBMEFps
         FDhM6DaAqRZdjvVirfGahNlpB6aLivmszyckZatsQLNyGvQlwG/u3+DI92e6w7aPZPET
         JJMa7Y2X8kP975hXNqd0nlh+Imr8be2DlVtI5chOFTksDDs8ylUdhNwLLfk7SNYBJ6P+
         v9Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G+Xl1BuH;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G+Xl1BuH;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqk2wUqy7MthEmek4CMzkV4859/n+wlV6Z/rnF6A7bR/ERHB9by07iSziWeZnKDQk81AcP/3w==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 8 May 2018 09:01:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180508070153.GX2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180507102056.GU2285@localhost>
 <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599878374329366978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:06:44PM +0200, Marcel Holtmann wrote:

> >> I have one concern, though. While providing raw data by
> >> default is fine generally, it is a problem with device
> >> auto-discovery. I think there should be some IOCTL from
> >> the start, that can be used to inform userspace about
> >> the raw protocol being used (i.e. "NMEA"). I fear, that
> >> userspace may start to just assume raw = NMEA without
> >> having this (especially since all initial drivers provide
> >> NMEA).
> > 
> > One problem I see here would be that the driver does not necessarily
> > know either what protocol is currently being used. Some devices have
> > boot-pins which can be used to configure the initial protocol used (and
> > this could perhaps be reflected in DT), but this can often later be
> > changed (by user space) and even be made persistent using battery-backed
> > ram or eeproms.
> > 
> > Also note that at least u-blox devices supports having more than one
> > protocol active on the same port...
> 
> as long as userspace can determine that it is GNSS hardware and what
> hardware it is, then you deal with the rest in userspace.

Yeah, I think that will do for now.

Thanks,
Johan
