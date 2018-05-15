Date: Tue, 15 May 2018 17:13:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] driver-core: return EINVAL error instead of
 BUG_ON()
Message-ID: <20180515151302.GA23930@kroah.com>
References: <20180504132357.31771-1-flo@geekplace.eu>
 <20180515135114.31939-2-flo@geekplace.eu>
 <20180515151035.GB23553@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515151035.GB23553@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 05:10:35PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 15, 2018 at 03:51:12PM +0200, Florian Schmaus wrote:
> > I triggerd the BUG_ON() in driver_register() when booting a domU Xen
> > domain. Since there was no contextual information logged, I needed to
> > attach kgdb to determine the culprit (the wmi-bmof driver in my
> > case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do
> > not register a driver with bus_type not registered").
> > 
> > Instead of running into a BUG_ON() we print an error message
> > identifying the, likely faulty, driver but continue booting.
> > 
> > Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> > ---
> > 
> > Notes:
> >     - return EINVAL (instead of EBUSY)
> >     - follow common pattern when quoting commits in commit messages
> > 
> >  drivers/base/driver.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> > index ba912558a510..afd5b08b7677 100644
> > --- a/drivers/base/driver.c
> > +++ b/drivers/base/driver.c
> > @@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
> >  	int ret;
> >  	struct device_driver *other;
> >  
> > -	BUG_ON(!drv->bus->p);
> > +	if (!drv->bus->p) {
> > +		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
> > +			   drv->name);
> 
> checkpatch.pl should have said to use pr_err(), right?  :)
> 
> Also, why not print out the driver name as well?

Sorry, I meant the bus name.
