Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222EFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611F2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeIQB0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIQB0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9306527DAEF
Received: by earth.universe (Postfix, from userid 1000)
        id 5640B3C0C49; Sun, 16 Sep 2018 13:28:50 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:28:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
Message-ID: <20180916112850.57ah4q3fmcvofd3a@earth.universe>
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
 <20180719054200.GB30024@minitux>
 <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
 <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6jaad763qpji7jq"
Content-Disposition: inline
In-Reply-To: <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r6jaad763qpji7jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

What's the status of this patch? It looks good to me, should it be
merged, did I miss a newer version?

-- Sebastian

On Fri, Jul 20, 2018 at 10:44:53AM -0700, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-07-18 23:59:20)
> >=20
> >=20
> > On 7/19/2018 11:12 AM, Bjorn Andersson wrote:
> > > On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:
> > >=20
> > >> commit '8c1b7dc9b: firmware: qcom: scm: Expose download-mode control'
> > >> added support for download-mode control using the scm firmware
> > >> driver for platforms which require a secure call to write the magic
> > >> cookie into the tcsr location.
> > >>
> > >> For platforms which *do not* need an scm call and where the kernel c=
an
> > >> write the cookie by a direct read/write, add similar support in the
> > >> msm-poweroff driver.
> > >> Similar to the scm driver, the msm-poweroff driver clears the cookie
> > >> during a clean reboot.
> > >>
> > >> Download mode using msm-poweroff driver can be enabled by including
> > >> msm-poweroff.download_mode=3D1 on the command line.
> > >>
> > >=20
> > > Should have thought about this when I wrote the scm code...
> > >=20
> > > I would prefer if we could find a way to consolidate the two
> > > implementations behind the same Kconfig and command line parameters.
> >=20
> > The only problem I saw with this was that *both* drivers would think
> > its enabled and try their own ways to enable it, and one of it would
> > always fail. We could fail silently, which would mean we will miss
> > cases when its a genuine failure but that should be fine?
>=20
> Should be fine if SCM fails silently. If TCSR is specified it better
> work because that doesn't really rely on anything besides writing into a
> memory location.
>=20
> >=20
> > >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > >> ---
> > >>   .../bindings/power/reset/msm-poweroff.txt          |  3 ++
> > >>   drivers/power/reset/Kconfig                        | 11 +++++++
> > >>   drivers/power/reset/msm-poweroff.c                 | 38 ++++++++++=
++++++++++++
> > >>   3 files changed, 52 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/power/reset/msm-power=
off.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> index ce44ad3..9dd489f 100644
> > >> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> @@ -8,6 +8,9 @@ settings.
> > >>   Required Properties:
> > >>   -compatible: "qcom,pshold"
> > >>   -reg: Specifies the physical address of the ps-hold register
> > >> +Optional Properties:
> > >> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of =
the
> > >> +             download mode control register
> > >>  =20
> > >>   Example:
> > >>  =20
> > >> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconf=
ig
> > >> index df58fc8..0c97e34 100644
> > >> --- a/drivers/power/reset/Kconfig
> > >> +++ b/drivers/power/reset/Kconfig
> > >> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
> > >>      help
> > >>        Power off and restart support for Qualcomm boards.
> > >>  =20
> > >> +config POWER_RESET_MSM_DOWNLOAD_MODE
> > >=20
> > > How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
> > > drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
> > > both drivers?
> >=20
> > yes, thats possible, but I am not sure how to make the command line
> > option common for both. One other option I thought was if we could hand=
le it
> > within the scm driver itself with an additional
> > binding to specify the non-secure download mode address.
> > something like qcom,dload-mode-ns?
>=20
> Is the SCM device and driver always going to be present though? It may
> be better to make a TCSR platform device driver on designs that would
> configure the cookie with direct read/writes from Linux to break the
> relationship with scm entirely. Then the different configurations could
> flow from the DTS file either describing scm that has scm call, a
> special scm_writel address for TCSR, or a specific TCSR node with the
> address of the download mode cookie that triggers a TCSR driver to probe
> and register a reboot handler.
>=20
>=20

--r6jaad763qpji7jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluePnIACgkQ2O7X88g7
+po7TBAAm/WBwxYU9CeIJnqV1/JGGY+raTEqbTihym+klH+//6Kq0XfIWHPy5Rwq
Kc2jzUz0528djeo4uDjbNK/2WVn573DYUqU2rZOxTqztua9Bym0OZxHRiw2bS78q
DRrXa8pEV9ng4FqwcHZrT8AbgP5hK7a92++N0mP6fIcYwfH2a5jSGhAb3u/Dl5Bd
CCV+k1uCZrMag7IHfoFnYCEy3XBPKcqQZSfe5U7DenjuIT8rHPdksmtWULsa/eIG
Avr+2kh3ypFnfV/n5sWo1gqhOPtBvIz8+aO+MSuNm8qNqUKPFmVy0NMjJcirroyq
DmvkAqCQwx3x7ww6k+PUN7f5FCCjpIliKk0o5rfcRTf2j7VRyGtf60VtSWn0x5HF
D0h9DJl9xTNwSPgZU/FlDf0zae/6PIST18Nn1aARpv8Dbodzlq5cNcpviaaHX5HR
qog3wdVlupa7Ml0i/4B+IOvbGVJ9OMHJ1ZvjmtxQg/ObsZ1EStMx0YYMt8eojfaK
/QN4rkjEd87u9CgIrhG9NdAewwWLtLQP1rfT/w0s8DBLbWLr6Et649aC2av+Qn2b
suN2UN86pFq7VT168jKUiFJwIjH29ACHDbuHSylHxidbLjYSUh1Ge/uoo2kwkDsp
zAdUMdrUCXJQUwUV9kyaj5N7JiIkVg3ZjJumyYe1d/J1AY9T0eM=
=cX7z
-----END PGP SIGNATURE-----

--r6jaad763qpji7jq--
