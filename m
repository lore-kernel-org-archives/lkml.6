Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeDPMZU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:25:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41163 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752648AbeDPMZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:25:18 -0400
Subject: Re: [PATCH v2 1/5] ALSA: xen-front: Introduce Xen para-virtualized
 sound frontend driver
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-2-andr2000@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <c473b7b3-6125-7f2f-d3c2-bff58dc61d48@suse.com>
Date: Mon, 16 Apr 2018 14:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416062453.24743-2-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Introduce skeleton of the para-virtualized Xen sound
> frontend driver.
> 
> Initial handling for Xen bus states: implement
> Xen bus state machine for the frontend driver according to
> the state diagram and recovery flow from sound para-virtualized
> protocol: xen/interface/io/sndif.h.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Only one minor nit (see below). With that addressed (or fixed when
committing):

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

> ---
>  sound/Kconfig             |   2 +
>  sound/Makefile            |   2 +-
>  sound/xen/Kconfig         |  10 +++
>  sound/xen/Makefile        |   5 ++
>  sound/xen/xen_snd_front.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++
>  sound/xen/xen_snd_front.h |  18 +++++
>  6 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 sound/xen/Kconfig
>  create mode 100644 sound/xen/Makefile
>  create mode 100644 sound/xen/xen_snd_front.c
>  create mode 100644 sound/xen/xen_snd_front.h
> 
> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
> new file mode 100644
> index 000000000000..f406a8f52c51
> --- /dev/null
> +++ b/sound/xen/xen_snd_front.c
> @@ -0,0 +1,196 @@
> +static void sndback_changed(struct xenbus_device *xb_dev,
> +			    enum xenbus_state backend_state)
> +{
> +	struct xen_snd_front_info *front_info = dev_get_drvdata(&xb_dev->dev);
> +	int ret;
> +
> +	dev_dbg(&xb_dev->dev, "Backend state is %s, front is %s\n",
> +		xenbus_strstate(backend_state),
> +		xenbus_strstate(xb_dev->state));
> +
> +	switch (backend_state) {
> +	case XenbusStateReconfiguring:
> +		/* fall through */
> +	case XenbusStateReconfigured:
> +		/* fall through */
> +	case XenbusStateInitialised:
> +		/* fall through */
> +		break;
> +
> +	case XenbusStateInitialising:
> +		/* recovering after backend unexpected closure */
> +		sndback_disconnect(front_info);
> +		break;
> +
> +	case XenbusStateInitWait:
> +		/* recovering after backend unexpected closure */
> +		sndback_disconnect(front_info);
> +
> +		ret = sndback_initwait(front_info);
> +		if (ret < 0)
> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
> +		else
> +			xenbus_switch_state(xb_dev, XenbusStateInitialised);
> +		break;
> +
> +	case XenbusStateConnected:
> +		if (xb_dev->state != XenbusStateInitialised)
> +			break;
> +
> +		ret = sndback_connect(front_info);
> +		if (ret < 0)
> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
> +		else
> +			xenbus_switch_state(xb_dev, XenbusStateConnected);
> +		break;
> +
> +	case XenbusStateClosing:
> +		/*
> +		 * in this state backend starts freeing resources,
> +		 * so let it go into closed state first, so we can also
> +		 * remove ours
> +		 */

Please start the sentence with a capital letter and end it with a
full stop.


Juergen
