Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AC9C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B94206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B94206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeKUBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:43232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbeKUBrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:47:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51BB1ACFB;
        Tue, 20 Nov 2018 15:17:31 +0000 (UTC)
Message-ID: <07a6b541f53a68b994f8ee6b1c864e096e1ff8cf.camel@suse.de>
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 20 Nov 2018 16:17:29 +0100
In-Reply-To: <1542725830.28362.12.camel@suse.com>
References: <20181120143438.18296-1-nsaenzjulienne@suse.de>
         <1542725830.28362.12.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Uth/gyW1o5TB7eTHmbf6"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uth/gyW1o5TB7eTHmbf6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Tue, 2018-11-20 at 15:57 +0100, Oliver Neukum wrote:
> On Di, 2018-11-20 at 15:34 +0100, Nicolas Saenz Julienne wrote:
> > The hub sends hot-plug events to the host trough it's interrupt
> > URB. The
> > driver takes care of completing the URB and re-submitting it.
> > Completion
> > errors are handled in the hub_event() work, yet submission errors
> > are
> > ignored, rendering the device unresponsive. All further events are
> > lost.
> >=20
>=20
> Hi,
>=20
> almost. There is no point in kicking of an error handling while aq
> reset is underway. You are checking only "quiescing" but not
> "in_reset".

Anytime "in_reset" is set "quiescing" is also set:

static int hub_pre_reset(struct usb_interface *intf)
{
	struct usb_hub *hub =3D usb_get_intfdata(intf);

	hub_quiesce(hub, HUB_PRE_RESET); //sets quiesce
	hub->in_reset =3D 1;
	hub_pm_barrier_for_all_ports(hub);
	return 0;
}

static int hub_post_reset(struct usb_interface *intf)
{
	struct usb_hub *hub =3D usb_get_intfdata(intf);

	hub->in_reset =3D 0;
	hub_pm_barrier_for_all_ports(hub);
	hub_activate(hub, HUB_POST_RESET); //clears quiesce
	return 0;
}

I should be OK isn't it?

Regards,
Nicolas

>=20
> 	Regards
> 		Oliver
>=20


--=-Uth/gyW1o5TB7eTHmbf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlv0JYkACgkQlfZmHno8
x/4Vkgf+M3cOBygpH6THEgKd7MV6B/8hSnlI38n8uaf2yY/uljlU/Z5HYh10f6Ms
q14xd5ugZLU+ONqhGwnPdnqNs1e0DaRQyeTarByvlV1VSzCkOMiPhpoArnm6Hxu2
+6HZ2M/z3csnd57lyFInsxzu9B9pqrNqduw8nA6dhX6/goR2aBTB7T12DCF7aLBs
TBA8QMy5Fkg/1ENPqsV6Tv/POI7ERo3MrSDihOO0LNlzoMHw9TgalQG9N6pJZ1xF
/shMBMK20yWQZYh8ilOOz2G+PhpzHDenccUuH84944W6SXdo6BAwgN99BMeZdwVI
+aa/mdt3FssPr8mMQU+gk9nd3uXfXw==
=LaPc
-----END PGP SIGNATURE-----

--=-Uth/gyW1o5TB7eTHmbf6--

