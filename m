Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F213E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeLKMgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:36:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbeLKMgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:36:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8DD0ACDE;
        Tue, 11 Dec 2018 12:36:20 +0000 (UTC)
Message-ID: <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tara Null <tn@fastmail.net>, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 13:36:19 +0100
In-Reply-To: <20181210211231.4084251-1-arnd@arndb.de>
References: <20181210211231.4084251-1-arnd@arndb.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iz9Vcq7U4bBc0EImhqak"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iz9Vcq7U4bBc0EImhqak
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd, thanks for the patch!

On Mon, 2018-12-10 at 22:11 +0100, Arnd Bergmann wrote:
> I had started the removal of semaphores in this driver without
> knowing
> that Nicolas Saenz Julienne also worked on this. In case of the
> "remote
> event" infrastructure, my solution seemed significantly better, so
> I'm
> proposing this as a change on top.
>=20
> The problem with using either semaphores or completions here is that
> it's an overly complex way of waking up a thread, and it looks like
> the
> 'count' of the semaphore can easily get out of sync, even though I
> found
> it hard to come up with a specific example.
>=20
> Changing it to a 'wait_queue_head_t' instead of a completion
> simplifies
> this by letting us wait directly on the 'event->fired' variable that
> is
> set by the videocore.
>=20
> Another simplification is passing the wait queue directly into the
> helper
> functions instead of going through the fragile logic of recording the
> offset inside of a structure as part of a shared memory variable.
> This
> also avoids one uncached memory read and should be faster.
>=20
> Note that I'm changing it back to 'killable' after the previous patch
> changed 'killable' to 'interruptible', apparently based on a
> misunderstanding
> of the subtle down_interruptible() macro override in
> vchiq_killable.h.
>=20
> Fixes: f27e47bc6b8b ("staging: vchiq: use completions instead of
> semaphores")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../interface/vchiq_arm/vchiq_core.c          | 63 +++++++--------
> ----
>  .../interface/vchiq_arm/vchiq_core.h          | 12 ++--
>  2 files changed, 30 insertions(+), 45 deletions(-)
>=20
> diff --git
> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 482b5daf6c0c..eda3004a0c6a 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -417,26 +417,23 @@ vchiq_set_conn_state(VCHIQ_STATE_T *state,
> VCHIQ_CONNSTATE_T newstate)
>  }
> =20
>  static inline void
> -remote_event_create(REMOTE_EVENT_T *event)
> +remote_event_create(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
>  {
>  	event->armed =3D 0;
>  	/* Don't clear the 'fired' flag because it may already have
> been set
>  	** by the other side. */
> +	init_waitqueue_head(wq);
>  }
> =20
>  static inline int
> -remote_event_wait(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
> +remote_event_wait(wait_queue_head_t *wq, REMOTE_EVENT_T *event)
>  {
>  	if (!event->fired) {
>  		event->armed =3D 1;
>  		dsb(sy);
> -		if (!event->fired) {
> -			if (wait_for_completion_interruptible(
> -					(struct completion *)
> -					((char *)state + event-
> >event))) {
> -				event->armed =3D 0;
> -				return 0;
> -			}
> +		if (wait_event_killable(*wq, event->fired)) {
> +			event->armed =3D 0;
> +			return 0;
>  		}
>  		event->armed =3D 0;
>  		wmb();
> @@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state,
> REMOTE_EVENT_T *event)
>  }
> =20
>  static inline void
> -remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T
> *event)
> +remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T
> *event)
>  {
>  	event->armed =3D 0;
> -	complete((struct completion *)((char *)state + event->event));
> +	wake_up_all(wq);

Shouldn't this just be "wake_up(wq)"?=20

Regards,
Nicolas


--=-iz9Vcq7U4bBc0EImhqak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwPr0MACgkQlfZmHno8
x/5oGwgAgaXU/Me8ZmcYNWBmoAq7sMybiCrgz8vqDxU0LnX5mFXJ2VuuzPcxTTR9
7gaT+/ekslPnGGyzUy//WZXqYjQv3cI9uiaAt85rTU/Jqv1cbsGBY9ayjMJVEYId
ZNOpU4oXwQezFsy8Sx5BAeyrzthyLkMPKVwd9bTbqok6KjI/iVURJwHnXeXCm4Dl
CHhOciwWiJOvnbsAyJlgGqL/W2K0aSG9dDiZx+xypKy/z0xA7FpidLnETqPKZMTV
YLuiKL44bUmra6iSJd91PqCXLKUBsSeDwLDo9pONjvZ/fKvizIAG33yrYshRRv+3
ja6Fh6TAPvOsFii9eD50Y+8jkUkU1g==
=UpGO
-----END PGP SIGNATURE-----

--=-iz9Vcq7U4bBc0EImhqak--

