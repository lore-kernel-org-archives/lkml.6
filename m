Date: Fri, 27 Apr 2018 09:22:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
Subject: Re: [PATCH v1 1/4] mhi_bus: core: Add support for MHI host interface
Message-ID: <20180427072211.GA6735@kroah.com>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524795811-21399-2-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 07:23:28PM -0700, Sujeev Dias wrote:
> MHI Host Interface is a communication protocol to be used by the host
> to control and communcate with modem over a high speed peripheral bus.
> This module will allow host to communicate with external devices that
> support MHI protocol.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>

No one else has ever reviewed this code before?  That's not good, please
at the very least, have someone else at your company go over it first.
I don't want to be the ones having to point out all of the "obvious"
issues :)

> ---
>  Documentation/00-INDEX                        |    2 +
>  Documentation/devicetree/bindings/bus/mhi.txt |  141 +++
>  Documentation/mhi.txt                         |  235 ++++
>  drivers/bus/Kconfig                           |   17 +
>  drivers/bus/Makefile                          |    1 +
>  drivers/bus/mhi/Makefile                      |    8 +
>  drivers/bus/mhi/core/Makefile                 |    1 +
>  drivers/bus/mhi/core/mhi_boot.c               |  593 ++++++++++
>  drivers/bus/mhi/core/mhi_dtr.c                |  177 +++
>  drivers/bus/mhi/core/mhi_init.c               | 1290 +++++++++++++++++++++
>  drivers/bus/mhi/core/mhi_internal.h           |  732 ++++++++++++
>  drivers/bus/mhi/core/mhi_main.c               | 1476 +++++++++++++++++++++++++
>  drivers/bus/mhi/core/mhi_pm.c                 | 1177 ++++++++++++++++++++
>  include/linux/mhi.h                           |  694 ++++++++++++
>  include/linux/mod_devicetable.h               |   11 +
>  15 files changed, 6555 insertions(+)

And a 6555 line patch is a bit hard to consume all at once.  Can't this
be split up into much more reviewable chunks?  Look at how some of the
other new bus subsystems got added to the tree recently.  They were
submitted in longer patch series, but smaller sized patches
individually.  That makes things much easier to review.

For example, there is no reason your debugfs stuff needs to be in this
initial patch.  That should be in a separate one, right?  Same for
firmware download.  Please take the time to break this up into logical
steps.

Like my son's math teacher keeps telling him, "show your work, not just
an answer at the bottom of the page".

Also, it is required by the DT maintainers to split that file alone up
into a separate patch to be even considered for merging.

One thing I can tell you right now that isn't acceptable:

> +#ifdef CONFIG_MHI_DEBUG

Don't have a separate config option for debugging.  No one will enable
it, which makes it pointless.   Everything has to be dynamic these days.

> +
> +#define MHI_VERB(fmt, ...) do { \
> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_VERBOSE) \
> +			pr_debug("[D][%s] " fmt, __func__, ##__VA_ARGS__);\
> +} while (0)
> +
> +#else
> +
> +#define MHI_VERB(fmt, ...)
> +
> +#endif
> +
> +#define MHI_LOG(fmt, ...) do {	\
> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_INFO) \
> +			pr_info("[I][%s] " fmt, __func__, ##__VA_ARGS__);\
> +} while (0)
> +
> +#define MHI_ERR(fmt, ...) do {	\
> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_ERROR) \
> +			pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
> +} while (0)
> +
> +#define MHI_CRITICAL(fmt, ...) do { \
> +		if (mhi_cntrl->klog_lvl <= MHI_MSG_LVL_CRITICAL) \
> +			pr_alert("[C][%s] " fmt, __func__, ##__VA_ARGS__); \
> +} while (0)
> +

And do not roll your own debugging/logging macros.  Use what is given to
you (dev_info(), dev_err(), dev_dbg()), they are there for a reason.  By
going around them, you circumvent the whole of the kernel logging
infrastructure and declare that your tiny bus is somehow more "special"
than it.

And I doubt you want to make such a statement :)

thanks,

greg k-h
