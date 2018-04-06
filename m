Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeDFPIb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:08:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52217 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751726AbeDFPI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:08:27 -0400
Date: Fri, 6 Apr 2018 16:08:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/8] counter: 104-quad-8: Documentation: Add Generic
 Counter sysfs documentation
Message-ID: <20180406160813.00007982@huawei.com>
In-Reply-To: <20180402194136.GA11724@sophia>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <c821777fbc8399583f49fe4058ca75a9b7d4581b.1520614431.git.vilhelm.gray@gmail.com>
        <20180324172140.382659e2@archlinux>
        <20180402194136.GA11724@sophia>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018 15:41:47 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sat, Mar 24, 2018 at 05:21:40PM +0000, Jonathan Cameron wrote:
> >On Fri,  9 Mar 2018 13:43:19 -0500
> >William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >  
> >> This patch adds standard documentation for the Generic Counter interface
> >> userspace sysfs attributes of the 104-QUAD-8 driver.
> >> 
> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> >A few minor comments inline...
> >Some of this seems generic and common enough you should just put it in the
> >main docs straight away rather that waiting for more devices to use it.
> >
> >Jonathan  
> 
> That sounds reasonable so I'll move some of these into the main Generic
> Counter sysfs documentation file.
> 
> Some comments inline follow.
> 
> William Breathitt Gray
> 
> >  
> >> ---
> >>  .../ABI/testing/sysfs-bus-counter-104-quad-8       | 115 +++++++++++++++++++++
> >>  MAINTAINERS                                        |   1 +
> >>  2 files changed, 116 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> >> 
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> >> new file mode 100644
> >> index 000000000000..4269b438185a
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> >> @@ -0,0 +1,115 @@
> >> +What:		/sys/bus/counter/devices/counterX/countY_count_mode
> >> +KernelVersion:	4.17
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Count mode for channel Y. The preset value for channel Y is used
> >> +		by the count mode where required. The following count modes are
> >> +		available:
> >> +
> >> +		Normal:
> >> +			Counting is continuous in either direction.
> >> +
> >> +		Range Limit:
> >> +			An upper or lower limit is set, mimicking limit switches
> >> +			in the mechanical counterpart. The upper limit is set to
> >> +			the preset value, while the lower limit is set to 0. The
> >> +			counter freezes at count = preset when counting up, and
> >> +			at count = 0 when counting down. At either of these
> >> +			limits, the counting is resumed only when the count
> >> +			direction is reversed.
> >> +
> >> +		Non-recycle:
> >> +			Counter is disabled whenever a 24-bit count overflow or
> >> +			underflow takes place. The counter is re-enabled when a
> >> +			new count value is loaded to the counter via a preset
> >> +			operation or write to raw.
> >> +
> >> +		Modulo-N:
> >> +			A count boundary is set between 0 and the preset value.
> >> +			The counter is reset to 0 at count = preset when
> >> +			counting up, while the counter is set to the preset
> >> +			value at count = 0 when counting down; the counter does
> >> +			not freeze at the bundary points, but counts
> >> +			continuously throughout.  
> >
> >This worries me a little in that you will end up with all sorts of subtle
> >variations around these concepts and hence end up with an impossible to
> >generalize userspace interface...  
> 
> There is a potention for a deal of variations due to the diverse range
> of counter devices out there -- in particular, I worry about the
> confusion of similar functionality using slightly different names (e.g.
> "Normal" may be named "Continuous" in another driver) and vice versa.
> Perhaps I should standardize these count modes in the main Generic
> Counter sysfs documentation file.
I would definitely standardize these.  Any new type can then be added.
At least for devices that do the same thing we'll have the same naming!

> 
> A difficulty with standardizing these count modes is how to handle
> description cases such as "Non-recycle" mode whose limit range is that
> of the count register size (24-bit). This limit range would be different
> in a device of a different count register size; for example, the LS7366R
> is a 32-bit version of this counter device with the same interface, but
> which has a 32-bit limit in "Non-recycle" mode. However, this may not be
> such a problem since the datasheet for these devices does use a more
> generic description of this mode which I can utilize: "counter disabled
> with carry or borrow, re-enabled with reset or load."

Describe the range as a separate attribute?

> 
> The count_mode attribute is core enough to Generic Counter paradigm that
> I expect it to appear in many Counter drivers, so I'll move this to the
> main Generic Counter sysfs documentation file for better standardization
> of its modes.
> 

Great

> >  
> >> +
> >> +What:		/sys/bus/counter/devices/counterX/countY_count_mode_available
> >> +What:		/sys/bus/counter/devices/counterX/countY_noise_error_available
> >> +KernelVersion:	4.17
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Discrete set of available values for the respective Count Y
> >> +		configuration are listed in this file.
> >> +
> >> +What:		/sys/bus/counter/devices/counterX/countY_direction
> >> +KernelVersion:	4.17
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Read-only attribute that indicates the count direction of
> >> +		Count Y. Two count directions are available: Forward and
> >> +		Backward.  
> >Is this telling us which way it is currently counting?  I would imagine
> >it's generic inversion control, but this description doesn't make that clear.  
> 
> The nature of quadrature encoding allows direction of movement to be
> determined -- in terms of count data this direction represents whether
> the count value is increasing or decreasing. For the 104-QUAD-8 device,
> this "direction" is a read-only value provided by the hardware
> evaluation of the A and B input lines.

Ah fair enough.  I would add a bit more text to give that quadrature
example (I'd forgotten about that and was thinking of completely
differently).

> 
> However, I can imagine some simple counter devices permitting write
> operations to configure a direction as a form of inversion control for
> the counter. This attribute is generic enough to include in the main
> Generic Counter sysfs documentation file, so I'll move it there and add
> a more detailed explanation of its read and write functionality.

I would be careful about having the same attribute for those two use
cases as they aren't really comparable.

> 
> >  
> >> +
> >> +What:		/sys/bus/counter/devices/counterX/countY_enable
> >> +KernelVersion:	4.17
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Whether channel Y inputs A and B are enabled. Valid attribute
> >> +		values are boolean.  
> >Why would you disable them?  I'm unclear on what userspace would do with this.  
> 
> Truthfully, I haven't found much use for this functionality in my
> applications, but several devices provide it so I have exposed it here.
> I believe the intention is to allow users to pause a counter temporarily
> (i.e. by ignoring changes on the A and B inputs) and then pick up where
> they left off.
> 
> I think a possible real life use case would look like this: a conveyor
> system tracks total movement, reaches the end of a production run and
> pauses the counter, rehomes the conveyor belt, then restarts the counter
> and continues counting where it left off.
> 
> This count enable functionality is generic enough that I can also move
> it to the main Generic Counter sysfs documentation file, but I'll give
> it a more generic description without referencing the A and B input
> lines.
> 
That's a good enough explanation.  I'd add the conveyor example to the
docs so people don't wonder what sort of thing it is for in future!

> >  

...
