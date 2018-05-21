Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEUTCe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:02:34 -0400
Received: from anholt.net ([50.246.234.109]:50466 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeEUTC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:02:29 -0400
From: Eric Anholt <eric@anholt.net>
To: Liviu Dudau <Liviu.Dudau@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH v8 2/3] drm: writeback: Add out-fences for writeback connectors
In-Reply-To: <20180518151743.29937-3-Liviu.Dudau@arm.com>
References: <20180518151743.29937-1-Liviu.Dudau@arm.com> <20180518151743.29937-3-Liviu.Dudau@arm.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 21 May 2018 12:02:25 -0700
Message-ID: <87a7ssu91a.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Liviu Dudau <Liviu.Dudau@arm.com> writes:

> From: Brian Starkey <brian.starkey@arm.com>
>
> Add the WRITEBACK_OUT_FENCE_PTR property to writeback connectors, to
> enable userspace to get a fence which will signal once the writeback is
> complete. It is not allowed to request an out-fence without a
> framebuffer attached to the connector.
>
> A timeline is added to drm_writeback_connector for use by the writeback
> out-fences.


> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index cf3a28676006a..6a7462c1821ad 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -49,6 +49,32 @@ struct drm_writeback_connector {
>  	 * drm_writeback_signal_completion()
>  	 */
>  	struct list_head job_queue;
> +
> +	/**
> +	 * @fence_context:
> +	 *
> +	 * timeline context used for fence operations.
> +	 */
> +	unsigned int fence_context;
> +	/**
> +	 * @fence_lock:
> +	 *
> +	 * spinlock to protect the fences in the fence_context.
> +	 */
> +	spinlock_t fence_lock;
> +	/**
> +	 * @fence_seqno:
> +	 *
> +	 * Seqno variable used as monotonic counter for the fences
> +	 * created on the connector's timeline.
> +	 */
> +	unsigned long fence_seqno;
> +	/**
> +	 * @timeline_name:
> +	 *
> +	 * The name of the connector's fence timeline.
> +	 */
> +	char timeline_name[32];
>  };
>=20=20
>  struct drm_writeback_job {
> @@ -59,12 +85,14 @@ struct drm_writeback_job {
>  	 * framebuffer reference to a workqueue.
>  	 */
>  	struct work_struct cleanup_work;
> +
>  	/**
>  	 * @list_entry:
>  	 *
>  	 * List item for the connector's @job_queue
>  	 */
>  	struct list_head list_entry;
> +
>  	/**
>  	 * @fb:
>  	 *

Move this hunk into patch 1?

Other than that, the series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

It's pretty clean and makes sense to me.  I only had some questions
about the job_queue, which seems superfluous if we aren't supporting
firing off a new writeback while an old one is outstanding (and maybe we
should throw an error in that case).  Still, I think this is ready to land.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsDF8EACgkQtdYpNtH8
nui3QBAAoUEW51kGUOOKfarNq8LMbKyqq5hDO7Qndhuy74lvD3W5plcoexdZ+671
O/OMjiqPRWU2fZzaQJoamc9JVGIX23A49LnWfLIiH6DXHi3im7olMW4atyXrK1g4
zyUhQQ5LyKsQbuUIMfMJSDTYWxkb37MbH8a0X19RKTHufZeJW52fLml8vvfcMShT
/4H3LmeBcz5EoOWo+hbuRMq8bbxJzwQ4O5BGAIof/0TaDz4UDGR4TsRbgbDaCTnl
hJmCba56RmvHNxYdbPnR0S9v1QW+oQiVKR1AGAnskKlF/mHKHPVQjwP+OuvOBgXP
cdrIA3W/IEBMYc+ngpBSX9829nDIuN/aElLUMXJxq5xiYyP0LOfdR7TPLyn1tkzO
RfSRHWFdDQ9t1/WmwIDz7XQePxyQ4OSdlAFvPy+xPfUgdATsz95Mt+N8au1uY3ug
jss/9umXB3zxblgwhqPHXs7V2BBds0H6XiW6eHQOCoMkGF6nHnQQNUtgl6jVL45j
92wNUlLnWjLb9jAEhLLJdc7wLv7kz5PtlhkbksYEJra5G1Sinx/ILUIPhmC0X9SR
HlEYn2v4DNWQTVafJgZzvxVpcNoJSFGLIcwe9+Yaav58dGAxrGn1Aqagh3aut1vn
rmhzCaWgtPdagPnbQEMYKvzquRd7NKQVgzlvL/1sIc53W8hcN+w=
=Kl6p
-----END PGP SIGNATURE-----
--=-=-=--
