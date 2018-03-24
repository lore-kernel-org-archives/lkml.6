Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeCXRVr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbeCXRVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:21:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DF421770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:21:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/8] counter: 104-quad-8: Documentation: Add Generic
 Counter sysfs documentation
Message-ID: <20180324172140.382659e2@archlinux>
In-Reply-To: <c821777fbc8399583f49fe4058ca75a9b7d4581b.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <c821777fbc8399583f49fe4058ca75a9b7d4581b.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:43:19 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the Generic Counter interface
> userspace sysfs attributes of the 104-QUAD-8 driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
A few minor comments inline...
Some of this seems generic and common enough you should just put it in the
main docs straight away rather that waiting for more devices to use it.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8       | 115 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> new file mode 100644
> index 000000000000..4269b438185a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -0,0 +1,115 @@
> +What:		/sys/bus/counter/devices/counterX/countY_count_mode
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count mode for channel Y. The preset value for channel Y is used
> +		by the count mode where required. The following count modes are
> +		available:
> +
> +		Normal:
> +			Counting is continuous in either direction.
> +
> +		Range Limit:
> +			An upper or lower limit is set, mimicking limit switches
> +			in the mechanical counterpart. The upper limit is set to
> +			the preset value, while the lower limit is set to 0. The
> +			counter freezes at count = preset when counting up, and
> +			at count = 0 when counting down. At either of these
> +			limits, the counting is resumed only when the count
> +			direction is reversed.
> +
> +		Non-recycle:
> +			Counter is disabled whenever a 24-bit count overflow or
> +			underflow takes place. The counter is re-enabled when a
> +			new count value is loaded to the counter via a preset
> +			operation or write to raw.
> +
> +		Modulo-N:
> +			A count boundary is set between 0 and the preset value.
> +			The counter is reset to 0 at count = preset when
> +			counting up, while the counter is set to the preset
> +			value at count = 0 when counting down; the counter does
> +			not freeze at the bundary points, but counts
> +			continuously throughout.

This worries me a little in that you will end up with all sorts of subtle
variations around these concepts and hence end up with an impossible to
generalize userspace interface...

> +
> +What:		/sys/bus/counter/devices/counterX/countY_count_mode_available
> +What:		/sys/bus/counter/devices/counterX/countY_noise_error_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_direction
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the count direction of
> +		Count Y. Two count directions are available: Forward and
> +		Backward.
Is this telling us which way it is currently counting?  I would imagine
it's generic inversion control, but this description doesn't make that clear.

> +
> +What:		/sys/bus/counter/devices/counterX/countY_enable
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether channel Y inputs A and B are enabled. Valid attribute
> +		values are boolean.
Why would you disable them?  I'm unclear on what userspace would do with this.

> +
> +What:		/sys/bus/counter/devices/counterX/countY_noise_error
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates whether excessive noise is
> +		present at the channel Y count inputs in quadrature clock mode;
> +		irrelevant in non-quadrature (Pulse-Direction) clock mode.
If you are going to report errors like this I would suggest trying to have
a generic form that is easy for userspace to match.  
countY_error_noise would allow easy presentation of all errors of the
form
countY_error_<error type> as a list based on <error type>

> +
> +What:		/sys/bus/counter/devices/counterX/countY_preset
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If the counter device supports preset registers, the preset
> +		count for channel Y is provided by this attribute.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_preset_enable
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether to set channel Y counter with channel Y preset value
> +		when channel Y index input is active, or continuously count.
> +		Valid attribute values are boolean.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY_index_polarity
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Active level of channel Y-16 index input; irrelevant in
> +		non-synchronous load mode.
This seems like a generic control that should be in the main docs?
don't use Y-16 to identify the channel.  Use "the associated channel to signal Y".

> +
> +What:		/sys/bus/counter/devices/counterX/signalY_index_polarity_available
> +What:		/sys/bus/counter/devices/counterX/signalY_synchronous_mode_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Signal Y
> +		configuration are listed in this file.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY_synchronous_mode
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configure channel Y-16 counter for non-synchronous or
> +		synchronous load mode. Synchronous load mode cannot be selected
> +		in non-quadrature (Pulse-Direction) clock mode.
> +
> +		Non-synchronous:
> +			A logic low level is the active level at this index
> +			input. The index function (as enabled via preset_enable)
> +			is performed directly on the active level of the index
> +			input.
> +
> +		Synchronous:
> +			Intended for interfacing with encoder Index output in
> +			quadrature clock mode. The active level is configured
> +			via index_polarity. The index function (as enabled via
> +			preset_enable) is performed synchronously with the
> +			quadrature clock on the active level of the index input.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index febe27a9962e..8134050d175a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>  F:	drivers/counter/104-quad-8.c
>  
