Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B09F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B09F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbeKOABN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:01:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:46656 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbeKOABN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:01:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 05:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,232,1539673200"; 
   d="asc'?scan'208";a="108005314"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2018 05:57:48 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        v.anuragkumar@gmail.com, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capable endpoints
In-Reply-To: <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Wed, 14 Nov 2018 15:57:44 +0200
Message-ID: <87k1lfiwx3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> When bulk streams are enabled for an endpoint, there can
> be a condition where the gadget controller waits for the
> host to issue prime transaction and the host controller
> waits for the gadget to issue ERDY. This condition could
> create a deadlock. To avoid such potential deadlocks, a
> timer is started after queuing any request for the stream
> capable endpoint in usb_ep_queue(). The gadget driver is
> expected to stop the timer if a valid stream event is found.
> If no stream event is found, the timer expires after the
> STREAM_TIMEOUT_MS value and a callback function registered
> by gadget driver to endpoint ops->stream_timeout API would be
> called, so that the gadget driver can handle this situation.
> This kind of behaviour is observed in dwc3 controller and
> expected to be generic issue with other controllers supporting
> bulk streams also.
>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  Changes in v6:
> 	1. This patch is newly added in this series to add timer into udc/core.c
> ---
>  drivers/usb/gadget/udc/core.c | 71 +++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/usb/gadget.h    | 12 ++++++++
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index af88b48..41cc23b 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -52,6 +52,24 @@ static int udc_bind_to_driver(struct usb_udc *udc,
>  /* ---------------------------------------------------------------------=
---- */
>=20=20
>  /**
> + * usb_ep_stream_timeout - callback function for endpoint stream timeout=
 timer
> + * @arg: pointer to struct timer_list
> + *
> + * This function gets called only when bulk streams are enabled in the e=
ndpoint
> + * and only after ep->stream_timeout_timer has expired. The timer gets e=
xpired
> + * only when the gadget controller failed to find a valid stream event f=
or this
> + * endpoint. On timer expiry, this function calls the endpoint-specific =
timeout
> + * handler registered to endpoint ops->stream_timeout API.
> + */
> +static void usb_ep_stream_timeout(struct timer_list *arg)
> +{
> +	struct usb_ep *ep =3D from_timer(ep, arg, stream_timeout_timer);
> +
> +	if (ep->stream_capable && ep->ops->stream_timeout)

why is the timer only for stream endpoints? What if we want to run this
on non-stream capable eps?

> +		ep->ops->stream_timeout(ep);

you don't ned an extra operation here, ep_dequeue should be enough.

> @@ -102,6 +132,10 @@ int usb_ep_enable(struct usb_ep *ep)
>  	if (ret)
>  		goto out;
>=20=20
> +	if (ep->stream_capable)
> +		timer_setup(&ep->stream_timeout_timer,
> +			    usb_ep_stream_timeout, 0);

the timer should be per-request, not per-endpoint. Otherwise in case of
multiple requests being queued, you can't give them different timeouts

> @@ -269,6 +321,13 @@ int usb_ep_queue(struct usb_ep *ep,
>=20=20
>  	ret =3D ep->ops->queue(ep, req, gfp_flags);
>=20=20
> +	if (ep->stream_capable) {
> +		ep->stream_timeout_timer.expires =3D jiffies +
> +				msecs_to_jiffies(STREAM_TIMEOUT_MS);

timeout value should be passed by the gadget driver. Add a new
usb_ep_queue_timeout() that takes the new argument. Rename the current
usb_ep_queue() to static int __usb_ep_queue() with an extra argument for
timeout and introduce usb_ep_queue() without the argument, calling
__usb_ep_queue() passing timeout as 0.

> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index e5cd84a..2ebaef0 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -144,6 +144,7 @@ struct usb_ep_ops {
>=20=20
>  	int (*fifo_status) (struct usb_ep *ep);
>  	void (*fifo_flush) (struct usb_ep *ep);
> +	void (*stream_timeout) (struct usb_ep *ep);

why?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvsKdgACgkQzL64meEa
mQalAQ/9EEqb4x4ZVovOafpFs7dKEojviFtYs7DcqBHeEwlQyO0C1tK9pDJ2balL
boEwWvNC3sxVnZE3D+S7rdPspYrt3yP8KfXHNWuOyfQXQzrg4CCXSymSzUKjl9Z9
IX7zA+ok1BIiPNwLKr5JIS2kRoaepMG9IgUb0fQTV42qUkRbzvrrgAPEPumqhgwn
O+7kH0LZ5DPi2Dc0tckBvG9PQ0MiedO6ye7uCXoXPi+tNMKqy36bezH27/hcckBQ
ENo54ABHViy4k0fp1+8nLtGLb7vEGULmrvdna7e+9mkaliFTvzb7bL0G2zLaoHQn
09ywSN14ExtlE1plkdTQsQvCWR0YKCTAtZhZvYJY3G/OQM1FBsrSx+/FXoGOfM7B
YRwb93ZbDI+dVmx/4wEcBhHmBAySi7ibZcsj9ODxdzdcgoRClLHe7sJcfMl4UcV7
Yr8PVrK6z33lXTcyQLyI6Z9sBA7khZ5Vwm72GhqGuC3HbugQLPq5Aq4RpDholvUv
Wdb0biYbgj22b5YoweCq7lY20MDiIGI9f+iXhFluC7A4E84UwGDA0qLhrz6uF7fx
K8N+Ex9Kn9oQvce2jnKBYL1AaATc/u1MwH6otAGQfA9Kg1fPcnOT/Vhwg4ahIr3b
S0WRX2VlM6lTyT+ItzTFMHqx/iXNH2+/hnSiq8jR0qD6G7aaVQ8=
=sVay
-----END PGP SIGNATURE-----
--=-=-=--
