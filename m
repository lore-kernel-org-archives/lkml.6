Date: Sun, 29 Apr 2018 15:35:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] gnss: add GNSS receiver subsystem
Message-ID: <20180429133511.GA28913@kroah.com>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-2-johan@kernel.org>
 <20180425085649.GB13295@kroah.com>
 <20180425105645.GP4615@localhost>
 <20180425122315.GS4615@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425122315.GS4615@localhost>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 02:23:15PM +0200, Johan Hovold wrote:
> On Wed, Apr 25, 2018 at 12:56:45PM +0200, Johan Hovold wrote:
> > On Wed, Apr 25, 2018 at 10:56:49AM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 24, 2018 at 06:34:52PM +0200, Johan Hovold wrote:
> 
> > > > +static int gnss_open(struct inode *inode, struct file *file)
> > > > +{
> > > > +	struct gnss_device *gdev;
> > > > +	int ret = 0;
> > > > +
> > > > +	gdev = container_of(inode->i_cdev, struct gnss_device, cdev);
> > > > +
> > > > +	get_device(&gdev->dev);
> > > > +
> > > > +	nonseekable_open(inode, file);
> > > > +	file->private_data = gdev;
> > > > +
> > > > +	down_write(&gdev->rwsem);
> > > 
> > > Just curious, why a rwsem?  They can be slower than a normal semaphore,
> > > is this really a contentious lock?
> > 
> > I use the rwsem to deal with hotplugging; the underlying device can go
> > away at any time and the core makes sure that no further calls into the
> > corresponding driver is made once all currently executing callbacks
> > return.
> 
> I just did find one access to the gnss ops which was unsafe however; the
> existence check for a write_raw callback in write() needs to be replaced
> by a device flag.

Ok, in looking at this closer, it makes more sense to me, and my worries
are not true, you are handling this properly, sorry for the noise.

I'll wait for the next resend of this series to review it again and
consider merging it.

thanks,

greg k-h
