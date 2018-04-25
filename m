Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524659004; cv=none;
        d=google.com; s=arc-20160816;
        b=y1nxjh/3vl6oRWgdtciCH1TII6caZwU+HmIJ0pPDyS3JuQaNXXiJLzQnfgBObt32+r
         2mlMAt7WzBQB+htCXjK0ruqs0K7ji+NDiNkfnDXwgfbB727FU85BanGYI6rCjlPIO8kf
         3rlbIIhDFc96+RBz+fI5yCIfrCSXA0E8Uil5w0kjCT6dWWUBnERnEG8YTXFVanbHT5JD
         dQV4IF392syp+Qb0bl/pAEqFX8zg0L9GVNfkEL0JjqE6xJVsDK/pCmkgTdHcheLnaMnx
         G4L9l5elMSr7eT8eckZJkQnl9S3lqcsI9LpzQUPy+Uk8ESayL8Eh6gHoN/d/lD80w/Mq
         9vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=0ysj9hHxVgpLfRa8J/18kF7+d5TSzpOhYGgrSmwERy8=;
        b=lGQKhHAkbIZX0IRCjAF94qom+8FbDgHZ3ZzdZMuDBnQeQh87BuENgvafiwXXrAKi/e
         uEUhUun0adO0lX/q+j9Gy6UznW9UzehwU8Vy8VMOgWCZBsAmWWGwNSl5C3B4f8egqyxY
         rsORjJnfbudAd2D+uhI/kDXaSEf3IOs/Yf72MQCBwDV/iISk0uTTaj6tFTm6tuKWOIp/
         CRW3m9Y4xdOHshY4ex2IoWKT758GGwADCesGupBR8sW+ISJoa26yh672oYGIEXRZbEdg
         RkTmbxN/ORTSnMQLQ0wulwPsdBU7LK0s73ts5RgxcuqBvCtdQ+Bg7ZnY8CvArQJNsEGf
         cIGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JlB7lYhm;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JlB7lYhm;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4/421FHtopvmWWy/Y1vg460MpJA7ueOdv/8jaPsJ/2UoTA8ftglAHMzQhKDN5RlYiRtYVteyw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 14:23:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] gnss: add GNSS receiver subsystem
Message-ID: <20180425122315.GS4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-2-johan@kernel.org>
 <20180425085649.GB13295@kroah.com>
 <20180425105645.GP4615@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425105645.GP4615@localhost>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062102212642?=
X-GMAIL-MSGID: =?utf-8?q?1598720840685369169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:56:45PM +0200, Johan Hovold wrote:
> On Wed, Apr 25, 2018 at 10:56:49AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 24, 2018 at 06:34:52PM +0200, Johan Hovold wrote:

> > > +static int gnss_open(struct inode *inode, struct file *file)
> > > +{
> > > +	struct gnss_device *gdev;
> > > +	int ret = 0;
> > > +
> > > +	gdev = container_of(inode->i_cdev, struct gnss_device, cdev);
> > > +
> > > +	get_device(&gdev->dev);
> > > +
> > > +	nonseekable_open(inode, file);
> > > +	file->private_data = gdev;
> > > +
> > > +	down_write(&gdev->rwsem);
> > 
> > Just curious, why a rwsem?  They can be slower than a normal semaphore,
> > is this really a contentious lock?
> 
> I use the rwsem to deal with hotplugging; the underlying device can go
> away at any time and the core makes sure that no further calls into the
> corresponding driver is made once all currently executing callbacks
> return.

I just did find one access to the gnss ops which was unsafe however; the
existence check for a write_raw callback in write() needs to be replaced
by a device flag.

Thanks,
Johan
