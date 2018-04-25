Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524653814; cv=none;
        d=google.com; s=arc-20160816;
        b=v1gJ1XpS/zH7Lss/kzKvp9+fP30Koq/XERTuKZquz+hvXBwd6RLbgozfpfztgD75Re
         w5vyXo7+JPJ/qkes4QmBeKmxxkEXvOCEtvljPNxGIpZEDCJMRAb2xdIpD73CZsmJ3dEh
         QyBlFGYMhPwI8pOyxpS50CQp81/sa/wOw7dA8EqaD1iPKK05wxHymzaf8qgTUpEuH09A
         clStvISCL/yq8V1pGGlVL3RnSXbSpOerQXrcI7nn0b5btyNPxJebHE/o/fapaWG3sE/h
         ZStHMjar8stDiPjqDBNu+tLEeIktiIXno3qUPezpxeXFtqe7qMNDSPZ+sAryCRW7LbPM
         HD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=zlCddK7os+6KSxbIfngmcdQmuahIiBlJFp/sOxTScXs=;
        b=qv7yFNTJIAgDOfANxGXwLfjxr7G/5cyOFTFXxkIHlaVJSCSOkhO/LAcxHKL0N/UYsP
         caP96K52aAqaxn+vWjlfKaVVcgo1tb/11PTLmnpQzOS3XKDIxbpPJwgga9JVq+x6Zh8h
         s+7TDkHBn7y3kae38osf9npNrn8IB1wXFciRV8nve0Fape4D44ZWL0BB8A8D9b37wAPv
         eIRf4o/1GXTkzgE+oVayeI1KIBzuXsLNFz5gssh2JzpVTf9BE3CyNvsXGpG1LEkXeBH6
         T7rdcvKOH4w1rQSbbPT9tlAd3botu3c2fcoq2LLJnjIMJ1kEOiujADA0+RcZOl6lo9+w
         RKlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CTix02Uq;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CTix02Uq;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZp332rTexwbO5WPTGw4RhW5WNcsALAIDCqTvEKqWio9SliP/Zw0BText/1QxY7tEczHmoerYw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 12:56:45 +0200
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
Message-ID: <20180425105645.GP4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-2-johan@kernel.org>
 <20180425085649.GB13295@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425085649.GB13295@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062102212642?=
X-GMAIL-MSGID: =?utf-8?q?1598715398870688241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:56:49AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 24, 2018 at 06:34:52PM +0200, Johan Hovold wrote:
> > +#define GNSS_MINORS	16
> 
> Why only 16?  Just have to start somewhere?

Yeah, a mostly arbitrarily picked number. I figured only developers
would have an interest in having even that many GNSS receivers in one
system. But it can be raised, now or later.

> > +static int gnss_open(struct inode *inode, struct file *file)
> > +{
> > +	struct gnss_device *gdev;
> > +	int ret = 0;
> > +
> > +	gdev = container_of(inode->i_cdev, struct gnss_device, cdev);
> > +
> > +	get_device(&gdev->dev);
> > +
> > +	nonseekable_open(inode, file);
> > +	file->private_data = gdev;
> > +
> > +	down_write(&gdev->rwsem);
> 
> Just curious, why a rwsem?  They can be slower than a normal semaphore,
> is this really a contentious lock?

I use the rwsem to deal with hotplugging; the underlying device can go
away at any time and the core makes sure that no further calls into the
corresponding driver is made once all currently executing callbacks
return.

> > +	if (gdev->disconnected) {
> > +		ret = -ENODEV;
> > +		goto unlock;
> > +	}
> > +
> > +	if (gdev->count++ == 0) {
> > +		ret = gdev->ops->open(gdev);
> > +		if (ret)
> > +			gdev->count--;
> 
> Why do we care about the opens here?  Do you only want the "child
> driver" to have open called once, like a tty driver?  Does it matter?

Exactly, core deals with the open counts so that the individual gnss
drivers need not. Serdev, for example, blows up if you try to open the
same device twice.

> Again, just curious.
> 
> > +	}
> > +unlock:
> > +	up_write(&gdev->rwsem);
> > +
> > +	if (ret)
> > +		goto err_put_device;
> > +
> > +	return 0;
> > +
> > +err_put_device:
> > +	put_device(&gdev->dev);
> > +
> > +	return ret;
> 
> Those last 9 lines can be rewritten as just:
> 
> 	if (!ret)
> 		put_device(&gdev->dev);
> 
> 	return ret;

Yeah, I usually prefer having an explicit return 0 in the success path
and clearly separate the error paths even if it adds few extra lines.
This case could become an exception though.

> > +static ssize_t gnss_write(struct file *file, const char __user *buf,
> > +		size_t count, loff_t *pos)
> > +{
> > +	struct gnss_device *gdev = file->private_data;
> > +	size_t written = 0;
> > +	int ret;
> > +
> > +	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, count);
> 
> Nit, some of these initial dev_dbg() calls might be able to be removed,
> as ftrace should handle the tracing code now, right?

Right. The were probably mostly useful to me during development, and can
be added back later if it turns out they have any further value.

> > +static const struct file_operations gnss_fops = {
> > +	.owner		= THIS_MODULE,
> > +	.open		= gnss_open,
> > +	.release	= gnss_release,
> > +	.read		= gnss_read,
> > +	.write		= gnss_write,
> > +	.poll		= gnss_poll,
> > +	.llseek		= no_llseek,
> > +};

> > +struct gnss_device *gnss_allocate_device(struct device *parent)
> > +{
> > +	struct gnss_device *gdev;
> > +	struct device *dev;
> > +	int id;
> > +	int ret;
> > +
> > +	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
> > +	if (!gdev)
> > +		return NULL;
> > +
> > +	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
> > +	if (id < 0) {
> > +		kfree(gdev);
> > +		return ERR_PTR(id);
> > +	}
> > +
> > +	gdev->id = id;
> > +
> > +	dev = &gdev->dev;
> > +	device_initialize(dev);
> > +	dev->devt = gnss_first + id;
> > +	dev->class = gnss_class;
> > +	dev->parent = parent;
> > +	dev->release = gnss_device_release;
> > +	dev_set_drvdata(dev, gdev);
> > +	dev_set_name(dev, "gnss%d", id);
> > +
> > +	init_rwsem(&gdev->rwsem);
> > +	mutex_init(&gdev->read_mutex);
> > +	mutex_init(&gdev->write_mutex);
> > +	init_waitqueue_head(&gdev->read_queue);
> > +
> > +	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
> > +	if (ret)
> > +		goto err_put_device;
> > +
> > +	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);
> > +	if (!gdev->write_buf)
> > +		goto err_put_device;
> > +
> > +	cdev_init(&gdev->cdev, &gnss_fops);
> > +	gdev->cdev.owner = THIS_MODULE;
> 
> This protects this module from being unloaded, but how do you pass on
> the module reference counts to the "child" gnss driver?  Am I just
> missing that logic here somewhere?

Due to the hotplug support mentioned above, I do not need to pin the
"child" gnss driver modules. Their devices can go away at any time, be
it due to hotplugging, driver unbind through sysfs, or module unload.

> Anyway, minor things, this looks really clean, nice job.

Thanks again!

Johan
