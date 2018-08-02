Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF19C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A013021534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A013021534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeHBSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:50:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:27890 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbeHBSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:50:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 09:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="asc'?scan'208";a="250576918"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2018 09:58:31 -0700
Message-ID: <6a0523e73e5a9a2fe23caeb9a65e505e788d6012.camel@intel.com>
Subject: Re: [E1000-devel] [PATCH] igb: CPU0 latency and updating statistics
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
Cc:     "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Date:   Thu, 02 Aug 2018 09:58:31 -0700
In-Reply-To: <1533108587.16601.56.camel@atviedlbe741.rss.d3s.at.thales>
References: <1533108587.16601.56.camel@atviedlbe741.rss.d3s.at.thales>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jZxZmlWW/J710wkyfVoh"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jZxZmlWW/J710wkyfVoh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-01 at 07:29 +0000, JABLONSKY Jan wrote:
> The Watchdog workqueue in igb driver is scheduled every 2s for each=20
> network interface. That includes updating a statistics protected by=20
> spinlock. Function igb_update_stats in this case will be protected=20
> against preemption. According to number of a statistics registers=20
> (cca 60), processing this function might cause additional cpu load
>  on CPU0.
>=20
> In case of statistics spinlock may be replaced with mutex, which=20
> reduce latency on CPU0.
>=20
>=20
> # Measurements
> Measurements were performed on Intel Atom E3950 (Quad-Core),=20
> E3930 (Dual-Core)
>=20
> # Cyclictest
> High latency is always on CPU0 which might be in range=20
> from 70us to 140us (sometimes higher)
>=20
>=20
> # cyclictest -l1000000 -Smp90 -i200 -q
>=20
> # E3930
> # default
> T: 0 ( 1745) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 72
> T: 1 ( 1746) P:90 I:700 C: 285737 Min: 3 Act: 4 Avg: 3 Max: 13
>=20
> # with patch
> T: 0 (  932) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 22
> T: 1 (  933) P:90 I:700 C: 285736 Min: 2 Act: 3 Avg: 3 Max: 12
>=20
>=20
> # E3950
> # default
> T: 0 ( 1103) P:90 I:200 C:1000000 Min: 2 Act: 2 Avg: 2 Max: 89
> T: 1 ( 1104) P:90 I:700 C: 285738 Min: 2 Act: 4 Avg: 2 Max: 9
> T: 2 ( 1105) P:90 I:1200 C: 166678 Min: 2 Act: 5 Avg: 3 Max: 22
> T: 3 ( 1106) P:90 I:1700 C: 117653 Min: 2 Act: 6 Avg: 2 Max: 13
>=20
> # with patch
> T: 0 (  879) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 26
> T: 1 (  880) P:90 I:700 C: 285729 Min: 3 Act: 4 Avg: 3 Max: 22
> T: 2 (  881) P:90 I:1200 C: 166672 Min: 3 Act: 7 Avg: 3 Max: 24
> T: 3 (  882) P:90 I:1700 C: 117649 Min: 3 Act: 7 Avg: 3 Max: 8
>=20
>=20
> Additionally I think updating statistics and watchdog task should=20
> be implemented in 2 separated ways
>=20
> Patch is created against a linux-4.4
>=20
> Reviewed also by: Bernhard Kaindl  <bernhard.kaindl@thalesgroup.com>
>=20
> Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c    | 14 +++++++-------
>  3 files changed, 10 insertions(+), 10 deletions(-)

NACK, as is.  This patch is malformed, as well as does not apply to the
current net-next tree.

Since the jist of this change is to wrap statistical updates with mutex
lock versus spin locks, I will put together a patch agains the latest
net-next tree for your review Jan.

--=-jZxZmlWW/J710wkyfVoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAltjODcACgkQ5W/vlVpL
7c7G4w//cD+lFsjX+DTHNbExHlbXos73a7qe49gKAXINPZRwPlrpu24JNw906scP
Ijsh77fArmtsj7pRd3HR8Vmz6jJ4DmyBUmQE/PO0uvX5K1Bi9ojQwWJsa+AmpNip
WYhM8hytQ+EWE8zcxc+x318XzylJwdVHomVj6lDLBzgDdMr8cD46eNKsfYYZ41ZI
AbK1oxw8hv4wleStgfavs90hWltpYKdVdRVcCYfFH+xDNf/exYYjxs0dQi/q9S63
1b/yFcfcFNyjwJyZduMJ97yvHhJEm9ucD/dEG+inyCoozvy2+osOePfsYvI+y3jQ
m45CdT41uDPU1gXIhsaeEeHuRcTa6U2oL02gaqwJRc3LduEJC7JXO7uBE3x3nEYi
lXzYC2IoqNUBYmvpwsQ9fvrWCR1wCyoMQoxzk7fagPLPpPEdtOT51uLX1vd1ax/X
MiOUu+jbccDxTbHDwsKeN10jh6aTa3Dg34Rcqwk+ZlQYRywEs9hYJJpd4Aplqdxd
YUkqE15aoDFxmBWmqxv5G8lwMLeiTaBBephGWgIvpauVcPgIcfsNu4Ze/cIPjULD
xwN0hcyDKXb8e0hV39Mked7VI4nzQiaD8y6UoAivwr6aTCOgASs1FCUhzaxQzv6i
EdpUh7mkpymg0yLtYEkjYkMPFUrn3y3T5fEo0GAiA7RdfkDAb/8=
=8/iX
-----END PGP SIGNATURE-----

--=-jZxZmlWW/J710wkyfVoh--

