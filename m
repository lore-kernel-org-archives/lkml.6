Date: Sat, 24 Mar 2018 10:04:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.16 2/3] drivers: change struct
 device_driver::coredump() return type to void
Message-ID: <20180324090446.GA863@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-3-git-send-email-aspriel@gmail.com>
 <20180323165543.GA21833@kroah.com>
 <CAJ65rDy1UjJ7tEu4f3m8BwnA1qai1iRU3yWfU4qvEE9uLrr5pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ65rDy1UjJ7tEu4f3m8BwnA1qai1iRU3yWfU4qvEE9uLrr5pg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 09:50:05AM +0100, Arend van Spriel wrote:
> On Fri, Mar 23, 2018 at 5:55 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Mar 15, 2018 at 10:55:24AM +0100, Arend van Spriel wrote:
> >> Upon submitting a patch for mwifiex [1] it was discussed whether this
> >> callback function could fail. To keep things simple there is no need
> >> for the error code so the driver can do the task synchronous or not
> >> without worries. Currently the device driver core already ignores the
> >> return value so changing it to void.
> >>
> >> [1] https://patchwork.kernel.org/patch/10231933/
> >>
> >> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> >> ---
> >>  include/linux/device.h | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index b093405..f08c25b 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -256,6 +256,9 @@ enum probe_type {
> >>   *           automatically.
> >>   * @pm:              Power management operations of the device which matched
> >>   *           this driver.
> >> + * @coredump:        Called when sysfs entry is written to. The device driver
> >> + *           is expected to call the dev_coredump API resulting in a
> >> + *           uevent.
> >>   * @p:               Driver core's private data, no one other than the driver
> >>   *           core can touch this.
> >>   *
> >> @@ -287,7 +290,7 @@ struct device_driver {
> >>       const struct attribute_group **groups;
> >>
> >>       const struct dev_pm_ops *pm;
> >> -     int (*coredump) (struct device *dev);
> >> +     void (*coredump) (struct device *dev);
> >
> > Isn't this going to cause build warnings now?  Are there no users of
> > this callback function yet?
> 
> Hi Greg,
> 
> I submitted driver patches for the 4.17 kernel and from that
> discussion we concluded it would be good to change to void return
> type. So those driver patches were dropped. The caller of the callback
> in drivers/base/dd.c does not use the return value so from that side
> there is no issue. So my motivation for asking to consider this for
> 4.16 is so I can resubmit the driver patches for 4.17 if there is
> still time before the merge window.

It's too late for 4.16 for this, and I would queue it up in my tree now
but I don't want to cause any build warnings in linux-next from it.  So
how about I submit something like this right after 4.17-rc1 is out,
where the function signature is changed _and_ all definitions of that
function are changed at the same time to keep everything sane at once?

Can you send me such a patch right before -rc1 is out base on Linus's
tree?  That should give everyone enough time to get the things merged,
right?

Or is there no in-flight patches to use this yet, and I can queue it up
now for -rc1 as no build warnings will happen?

thanks,

greg k-h
