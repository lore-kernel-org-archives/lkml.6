Date: Tue, 1 May 2018 15:08:03 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Grant Likely <grant.likely@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	boot-architecture@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180501220803.GB31900@kroah.com>
References: <20180501213114.20183-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501213114.20183-1-robh@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 04:31:14PM -0500, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
> 
> Unfortunately, this change breaks with modules as we have no way of
> knowing when modules are done loading. One possibility is to make this
> opt in or out based on compatible strings rather than at a subsystem level.
> Ideally this information could be extracted automatically somehow. OTOH,
> maybe the lists are pretty small. There's only a handful of subsystems
> that can be optional, and then only so many drivers in those that can be
> modules (at least for pinctrl, many drivers are built-in only).
> 
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch came out of a discussion on the ARM boot-architecture 
> list[1] about DT forwards and backwards compatibility issues. There are 
> issues with newer DTs breaking on older, stable kernels. Some of these 
> are difficult to solve, but cases of optional devices not having 
> kernel support should be solvable.
> 
> I tested this on a RPi3 B with the pinctrl driver forced off. With this 
> change, the MMC/SD and UART drivers can function without the pinctrl 
> driver.
> 
> Rob
> 
> [1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
> 
>  drivers/base/dd.c            | 16 ++++++++++++++++
>  drivers/pinctrl/devicetree.c |  2 +-
>  include/linux/device.h       |  2 ++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index c9f54089429b..5848808b9d7a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -226,6 +226,15 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +
> +int driver_deferred_probe_optional(void)
> +{
> +	if (initcalls_done)
> +		return -ENODEV;
> +
> +	return -EPROBE_DEFER;
> +}

The name is ackward for this function, but I can't think of anything
better at the moment, sorry.  However, the overall idea for this is
sane, no objection from me at all for this change.

thanks,

greg k-h
