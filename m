Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B26C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F1220878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F1220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKUKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:35:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:21684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeKUKfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:35:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="asc'?scan'208";a="87476039"
Received: from hsismaet-mobl.amr.corp.intel.com ([10.254.47.201])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2018 16:03:19 -0800
Message-ID: <95340aa60ea9a19a5c216e5863a368f05dbfeebd.camel@intel.com>
Subject: Re: [PATCH net-next] e100: Fix passing zero to 'PTR_ERR' warning in
 e100_load_ucode_wait
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Date:   Tue, 20 Nov 2018 16:03:18 -0800
In-Reply-To: <20181119124819.15860-1-yuehaibing@huawei.com>
References: <20181119124819.15860-1-yuehaibing@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-swPMXqxaQYbFeXqr8aqX"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-swPMXqxaQYbFeXqr8aqX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-19 at 20:48 +0800, YueHaibing wrote:
> Fix a static code checker warning:
> drivers/net/ethernet/intel/e100.c:1349
>  e100_load_ucode_wait() warn: passing zero to 'PTR_ERR'
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks fine, I am just concerned of the regression testing needed on
hardware that is almost 20 years old now.  The availability of the hardware
for testing is also a concern.

> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 7c4b554..736115b 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -1345,8 +1345,8 @@ static inline int e100_load_ucode_wait(struct nic
> *nic)
> =20
>  	fw =3D e100_request_firmware(nic);
>  	/* If it's NULL, then no ucode is required */
> -	if (!fw || IS_ERR(fw))
> -		return PTR_ERR(fw);
> +	if (IS_ERR_OR_NULL(fw))
> +		return PTR_ERR_OR_ZERO(fw);
> =20
>  	if ((err =3D e100_exec_cb(nic, (void *)fw, e100_setup_ucode)))
>  		netif_err(nic, probe, nic->netdev,


--=-swPMXqxaQYbFeXqr8aqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlv0oMcACgkQ5W/vlVpL
7c53jg/+IpV9nKJj11Q61TYAO0YFR8tGCy5DZcLzL09iXoIOVd4CM7Qjy9t6B5sY
7pt/dxfbSMESY2fNLuJogms8z5r73+OMV9h+SqYM+XChNgaoVm0uQI+yY3VCI3KE
FAzig6iSknwI+9/xjGCpkt2nsNz5nggNigE03tVjDqe5AOLVTNyaDc+gD+zwuY+Q
XaxSzI0cNeTG482zYk4B0nPXSFnYVyhSsAO5nu2DnJd1b52cE8nydjIsJvlDfSrs
TUbphLOuWwrw7Fa7nF8Ihv0RXQk0xwynv1mfG+4tchovRBwJzMHe856A0aP0WNJk
TF51zQh4y0dbq2twyR0bd8Jwuiz7Of7N1DvdvjQSuF7kfylFVZgpzs2moqOBUZsj
mAPa1733eG2WK8pX9q+NJWgYpp+XkFzy4HiKOawaSNFbNvBqMo8nQxicSwitBQ2+
NNu0WHWWP90cCx8xa5HDH9RSffoTWMa3S6kAaPDQPR9ji2F3+vuy/9Fgoqxxzq2t
3cMWhkwxzqDaRzpdlqqZomVqgReHllhqP797opcxDFd2IvD5tDWetmZplz2q2LvC
E/be2Ly8HeRuh87x5HQXlRuXsCKP9AcYkaPjHzNxlsBfo/2RUGA3aXITA8cCoVQ6
uETNT+2mVedS8NMoTh0w9ABRUbg4ywiTKHHzHB5b0SrD94J4WRI=
=xXR/
-----END PGP SIGNATURE-----

--=-swPMXqxaQYbFeXqr8aqX--

