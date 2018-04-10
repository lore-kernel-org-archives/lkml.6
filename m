Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523341337; cv=none;
        d=google.com; s=arc-20160816;
        b=piYjO919CSgxJZHUkRLqtSEaIH9NHqSCX+YAqM3aoPwgLRDi7/R6JyznrlgQpHESHx
         gL5mZzXCRu39OyT9VWZIbZ05DKThpH34nwIAWu2iq9DID1duvZT6SVOr/A4fsdOB5ewo
         /b1XJbXnAbO2JHJ52VmJtY7IXpHDXheARM4NYcqUpsPGYUMZrTNit/EwCl5dRJn8CMX3
         r9XEJn58M1Ubi+TWsetvt2+wvNqmOVfP2g8XyVfxwP8Q9NLefjv9sZrwwOS5l1hiQOdY
         VuRsIikB/n48F9GZyVe2NwWzL7SzGiiNxsYF/Cf6QdwOSDgZc6noVJFtRlPEpxOFahNz
         8uPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=0kCfHoVVqJJTp5LFvZRbZ7+RzIoz5GpRGRK5aL3U4Ik=;
        b=cBCya9aUwgquGLRkslTCs0pUEXt2mplq0lDTJFWJskjghau6rqjPTrxHkVBAKS5GaG
         WAGsE2YYT/eBbr8P8iYwQ1/GEudyVOBH+ok9BhZ+WQ/20oHHSGnxFg28WJf45FWq/PdF
         pbX+cwmTZR4/uT8t9iOH7zhLcAT5tfFzvATVeKfhOFeZRbVIjg7DirUdHgX602eqKzG3
         fMmMMRTTGCV1SpD+KmnavYLurLrumqjmxnp3y/Q8I1aoxyPcH7whQhgR3am8zWocGApi
         NZ/f1ixke/rqYKUybrOGkhK0WP/9cM40NwETb6wKL83B0MrA0iF/HPZvAjPIkWH/72hc
         WofQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RH7R7p3n;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RH7R7p3n;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4++WRnxQofZjw/tmEgLiXcSyc/G7M+HtuJFKc3mHK/Yps1gqtsLwHfkSDIIT6Z1jJ+Yu1KUPw==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 10 Apr 2018 15:22:11 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] zram: introduce zram memory tracking
Message-ID: <20180410062211.GB38000@rodete-desktop-imager.corp.google.com>
References: <20180409055435.135695-1-minchan@kernel.org>
 <20180409055435.135695-5-minchan@kernel.org>
 <20180410000305.GA6942@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180410000305.GA6942@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597246846962715384?=
X-GMAIL-MSGID: =?utf-8?q?1597339166389189201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 09:03:05AM +0900, Sergey Senozhatsky wrote:
> Hi Minchan,
> 
> On (04/09/18 14:54), Minchan Kim wrote:
> > +static long long ns2usecs(u64 nsec)
> > +{
> > +	nsec += 500;
> > +	do_div(nsec, 1000);
> > +	return nsec;
> > +}
> 
> Sorry, I don't quite understand "nsec += 500".

Round-off

> 
> > +static ssize_t read_block_state(struct file *file, char __user *buf,
> > +				size_t count, loff_t *ppos)
> > +{
> [..]
> > +
> > +	up_read(&zram->init_lock);
> > +	copy_to_user(buf, kbuf, written);
> 
> drivers/block/zram/zram_drv.c: In function ‘read_block_state’:
> drivers/block/zram/zram_drv.c:701:2: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result [-Wunused-result]
>   copy_to_user(buf, kbuf, written);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Good catch.

> 
> [..]
> > @@ -61,7 +61,9 @@ struct zram_table_entry {
> >  		unsigned long element;
> >  	};
> >  	unsigned long value;
> > +#ifdef	CONFIG_ZRAM_MEMORY_TRACKING
> 
> A silly nitpick, but since you are going to resend this one, could you
> remove TAB between ifdef and CONFIG_ZRAM_MEMORY_TRACKING?

Sure.
