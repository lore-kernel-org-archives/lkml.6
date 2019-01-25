Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3EE2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAYRzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:55:43 -0500
Received: from anholt.net ([50.246.234.109]:42046 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfAYRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:55:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3F70D10A2AAF;
        Fri, 25 Jan 2019 09:55:42 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7U6N0DRL8bbt; Fri, 25 Jan 2019 09:55:40 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 78EE710A0E8E;
        Fri, 25 Jan 2019 09:55:40 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 01A7E2FE3A6F; Fri, 25 Jan 2019 09:55:39 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization when completing commit
In-Reply-To: <0d136757267f4457527838065a5bf60fd6781835.camel@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com> <20190108145056.2276-2-paul.kocialkowski@bootlin.com> <87d0onussr.fsf@anholt.net> <0d136757267f4457527838065a5bf60fd6781835.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 25 Jan 2019 09:55:39 -0800
Message-ID: <87k1isvcys.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> On Wed, 2019-01-23 at 10:34 -0800, Eric Anholt wrote:
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>>=20
>> > During an atomic commit, the HVS is configured with a display list
>> > for the channel matching the associated CRTC. The Pixel Valve (CRTC)
>> > and encoder are also configured for the new setup at that time.
>> > While the Pixel Valve and encoder are reconfigured synchronously, the
>> > HVS is only reconfigured after the display list address (DISPLIST) has
>> > been updated to the current display list address (DISPLACTX), which is
>> > the responsibility of the hardware.
>> >=20
>> > The time frame during which the HVS is still running on its previous
>> > configuration but the CRTC and encoder have been reconfigured already
>> > can lead to a number of synchronization issues. They will eventually
>> > cause errors reported on the FIFOs, such as underruns.
>> >=20
>> > With underrun detection enabled (from Boris Brezillon's series), this
>> > leads to unreliable underrun detection with random false positives.
>> >=20
>> > To ensure a coherent state, wait for each enabled channel of the HVS
>> > to synchronize its current display list address. This fixes the issue
>> > of random underrun reporting on commits.
>> >=20
>> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> > ---
>> >  drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
>> >  drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
>> >  drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
>> >  drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
>> >  4 files changed, 22 insertions(+)
>> >=20
>> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_d=
rv.h
>> > index c24b078f0593..955f157f5ad0 100644
>> > --- a/drivers/gpu/drm/vc4/vc4_drv.h
>> > +++ b/drivers/gpu/drm/vc4/vc4_drv.h
>> > @@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
>> >  extern struct platform_driver vc4_hvs_driver;
>> >  void vc4_hvs_dump_state(struct drm_device *dev);
>> >  int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
>> > +void vc4_hvs_sync_dlist(struct drm_device *dev);
>> >=20=20
>> >  /* vc4_kms.c */
>> >  int vc4_kms_load(struct drm_device *dev);
>> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_h=
vs.c
>> > index 5d8c749c9749..1ba60b8e0c2d 100644
>> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
>> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
>> > @@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc=
4_hvs *hvs,
>> >  	return 0;
>> >  }
>> >=20=20
>> > +void vc4_hvs_sync_dlist(struct drm_device *dev)
>> > +{
>> > +	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>> > +	unsigned int i;
>> > +	int ret;
>> > +
>> > +	for (i =3D 0; i < SCALER_CHANNELS_COUNT; i++) {
>> > +		if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
>> > +			continue;
>> > +
>> > +		ret =3D wait_for(HVS_READ(SCALER_DISPLACTX(i)) =3D=3D
>> > +			       HVS_READ(SCALER_DISPLISTX(i)), 1000);
>> > +		WARN(ret, "Timeout waiting for channel %d display list sync\n",
>> > +		     i);
>> > +	}
>> > +}
>> > +
>> >  static int vc4_hvs_bind(struct device *dev, struct device *master, vo=
id *data)
>> >  {
>> >  	struct platform_device *pdev =3D to_platform_device(dev);
>> > diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_k=
ms.c
>> > index 0490edb192a1..2d66a2b57a91 100644
>> > --- a/drivers/gpu/drm/vc4/vc4_kms.c
>> > +++ b/drivers/gpu/drm/vc4/vc4_kms.c
>> > @@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state=
 *state)
>> >=20=20
>> >  	drm_atomic_helper_commit_hw_done(state);
>> >=20=20
>> > +	vc4_hvs_sync_dlist(dev);
>> > +
>> >  	drm_atomic_helper_wait_for_flip_done(dev, state);
>>=20
>> wait_for_flip_done should already be waiting for DISPLACTX to match our
>> crtc's display list, though, right (see vc4_crtc_handle_page_flip())?
>> This seems like a no-op to me.
>
> Right, at this stage it's pretty much a no-op. It does make a
> difference when bringing-in vc4_hvs_unmask_underrun, because this
> vc4_hvs_sync_dlist call comes before it.
>
> When the display lists are not yet synchronized (and differ), an
> underrun occurs so it will be reported although it's not related to the
> new display list configuration. Waiting for the display lists to sync
> before unmasking the interrupt prevents that.
>
> I think waiting for the page flip to unmask the underrun interrupt
> would be too late because the HVS should have finished processing the
> new dlist by then (but maybe I'm mistaken about that), so we would miss
> the underrun indication.

For load tracking I'm mainly concerned about making sure that we don't
have long-standing underruns -- if the first frame after a modeset is a
little wonky, you probably won't notice it.

Getting a clean modeset sequence would be really nice to have,
just... don't block on that.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxLTZsACgkQtdYpNtH8
nuicQQ//YmWlLLiza+wJ0yYUT46tUaGrkzjVwdvhQKhxmuc0cSRUQ9wUqtN+jjCS
abOB9ZMa1ZTKdFmRaGfmVx6+OWjMXG/sA29BmrbWXfQpBNgt3g7ij9LRDqqMXqmP
XVnJb6UYB4yiEpHYb+Af7RKaOoSBdXETOozTN3+7bgfHw2VEtDAjETEpXDSYy4ah
QAKEjD31Agh/GyoJT7if/XSW3mp9bO/TzkHN4t+4ZaLV6zi8m5gNnDwxTSRt/4sX
+GerFWdL/hT2lN57QAdbk7osWJ2xA60hLfjv+EhCD3+DJjbgb9+3JHfzrVroxd0M
O7ygR+5hj3NjRxFuraLIKOE/5c1izBXWOtM5U4XB+iU7ln0F80/N4Vm/4NCZXOx/
fQsMtDNBxrwjVd/DSY/WQg6ZT0fJEHLIwVAs2ogGPoZ6iFZBODbH/fcEhmxqcrAL
wRxijjXZI/Z8IGvTUy5N19I2b6OJAqxNSbo1Vbfe8qzo2zfNzyxwryllrQo5I0Zp
nDOVCf/uMlMQ8TZuV2yEw9tz58s/EQhOZ3/IKv80tsqTXiIGUgoMEzw/n1yewG8Z
9Sd8oYBBphAKpnulA4Cv/Xhg9QVCNkxLLxOD2+qN2KbbzuL3+eSXDRzstLYffuAl
oggTBGG7MnzZfJf83+i8z/VUO4lvuJB9U7dg+UhzMvqJWwYtrMM=
=NwCF
-----END PGP SIGNATURE-----
--=-=-=--
