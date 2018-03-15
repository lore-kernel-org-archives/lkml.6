Date: Thu, 15 Mar 2018 18:10:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/3] driver core: check notifier_call_chain return value
Message-ID: <20180315171059.GA10254@kroah.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227140926.22996-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:09:24PM +0100, Benjamin Gaignard wrote:
> When being notified that a driver is about to be bind a listener
> could return NOTIFY_BAD.
> Check the return to be sure that the driver could be bind.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/base/dd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index de6fd092bf2f..9275f2c0fed2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -304,9 +304,12 @@ static int driver_sysfs_add(struct device *dev)
>  {
>  	int ret;
>  
> -	if (dev->bus)
> -		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> -					     BUS_NOTIFY_BIND_DRIVER, dev);
> +	if (dev->bus) {
> +		if (blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> +						 BUS_NOTIFY_BIND_DRIVER, dev) ==
> +						 NOTIFY_BAD)
> +			return -EINVAL;

checkpatch does not complain about this?

And what is going to break when we enable this, as we have never checked
this before?

thanks,

greg k-h
