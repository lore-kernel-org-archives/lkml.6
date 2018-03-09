Date: Fri, 9 Mar 2018 09:19:21 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, linux@roeck-us.net,
	mathias.nyman@linux.intel.com, johan@kernel.org,
	felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
	peter.chen@nxp.com, drake@endlessm.com, joe@perches.com,
	Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2] usb: core: introduce per-port over-current counters
Message-ID: <20180309171921.GA30438@kroah.com>
References: <20180220115033.29496-1-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220115033.29496-1-dev@g0hl1n.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 12:50:33PM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> For some userspace applications information on the number of
> over-current conditions at specific USB hub ports is relevant.
> 
> In our case we have a series of USB hardware (using the cp210x driver)
> which communicates using a proprietary protocol. These devices sometimes
> trigger an over-current situation on some hubs. In case of such an
> over-current situation the USB devices offer an interface for reducing
> the max used power. As these conditions are quite rare and imply
> performance reductions of the device we don't want to reduce the max
> power always.
> 
> Therefore give user-space applications the possibility to react
> adequately by introducing an over_current_counter in the usb port struct
> which is exported via sysfs.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
> Tested on an i.MX6DL based board
> 
> Changes v2:
> 	- rename oc_count to over_current_count
> 	- add entry to Documentation/ABI
> 	- add detailled description to commit message
> ---
>  Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++++
>  drivers/usb/core/hub.c                  |  4 +++-
>  drivers/usb/core/hub.h                  |  1 +
>  drivers/usb/core/port.c                 | 10 ++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 0bd731cbb50c..27020293c85b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -189,6 +189,15 @@ Description:
>  		The file will read "hotplug", "wired" and "not used" if the
>  		information is available, and "unknown" otherwise.
>  
> +What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
> +Date:		February 2018
> +Contact:	Richard Leitner <richard.leitner@skidata.com>
> +Description:
> +		Most hubs are able to detect over-current situations on their
> +		ports and report them to the kernel. This attribute is to expose
> +		the number of over-current situation occurred on a specific port
> +		to user space. This file will contain an unsigned int.

"unsigned int" is very vague :)

How about "this is a 32bit value"?

And what happens when this wraps?  Is that allowed?

thanks,

greg k-h
