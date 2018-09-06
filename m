Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACA82075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYVy6Mkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACA82075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeIGBg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:36:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58983 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbeIGBg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:36:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DCE3521BF7;
        Thu,  6 Sep 2018 16:59:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Sep 2018 16:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=fDbBQKffKr3P1QQmgYrKiF7kp+CKI
        zQEmYcsIEsj2eE=; b=dYVy6MkpD2cND4fezfwxrm4usdMThe4X6JDIE6d1bDidZ
        8WHIrsbLuV6F63Bky0vKSlYSaapF2eM/z1kAFCNm6U8VTbv5kSP28kF7OGo5Rn/b
        PfgWyUmAEhfP71zt+YEDmlE+scVF7S4ropDvSpK6Dc+RilsIbi7iH6NI+C73ak2j
        vtCr2iFchX9APJjD6xRjWnQjQgLtEzn8DFEpse4DJuHj0lI0mnNfSNofPUfre4t0
        BFU8CXj4Q3tEJ+vw+h9Y6Cyc5Dwy+ZP++3vuvL3PMc3eA3tUjLoYv17GnsebUk5L
        an/I6SqnHR8m75oy9GXxqD6VdP6RSSKyLueauF21A==
X-ME-Proxy: <xmx:IpWRW4Nhxp_Lm2gTbxyOVjRzJd3p43mgD0d02Jg9GT-a8xHAt55Plg>
    <xmx:IpWRW62F2p3scUNzaFgX3UIqURPa4PTLKd062tqeToo3chJR7J9rrA>
    <xmx:IpWRW6w_tNR_nxKg3GaK_pbq9nKw5tB0-pFv5yxwzJBKfRADjwpmhQ>
    <xmx:IpWRW0qO9q8pLyvsnZ_07NTmwjBqWsRqMOB_gIPrs1Gqcy83IWF_ag>
    <xmx:IpWRW4XKdEPH3zjoBOYwlgzisU4BEukV6D-fv771Lt8-mWoBBeIjHA>
    <xmx:IpWRW5dDe-XRFJfAbrvNg4xhkb7uq4Rw0u4KnXHkbQ5m75dnLerW8g>
X-ME-Sender: <xms:IpWRWzu5VuI7bRd-cSTu58oZqGxTf22HNWYcLQfHybIC_Q6cIcquAg>
Received: from mail-itl (ip5b40bfaa.dynamic.kabel-deutschland.de [91.64.191.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 633301029A;
        Thu,  6 Sep 2018 16:59:13 -0400 (EDT)
Date:   Thu, 6 Sep 2018 22:59:09 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/balloon: add runtime control for scrubbing ballooned
 out pages
Message-ID: <20180906205909.GK1353@mail-itl>
References: <20180906153355.25363-1-marmarek@invisiblethingslab.com>
 <bf287a28-5e40-1ea2-a983-3d6a8e9a9869@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Content-Disposition: inline
In-Reply-To: <bf287a28-5e40-1ea2-a983-3d6a8e9a9869@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 04:14:50PM -0400, Boris Ostrovsky wrote:
> You can also use cmdline_find_option() in the balloon driver.

This looks to be x86 only (?!), which doesn't sound right in
drivers/xen/. I'll use core_param() for now...

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAluRlR0ACgkQ24/THMrX
1yww7wf/ZnwHnaM/MC9JRClrMN7zchfCYYQiaeU53sYzyH/l7HTU0sIrL/x43ZE1
vVRGH+Bb9rv/8JUaBGnAnQVVLIEuo1F9Pr53eVlawclnsgTKxOm1C0YBd5lnomCA
CxJCbBB2iEON4pSKQxoDZYi/X/iddawWqY2g49KcZ+1baP4PVDpXOsxq6rprYLQ3
4CrJpgxfG43V0rFrjNxNnogckJSOfZjGXnIyfwW/3tUgkOmLrzO/TLi+dhWJQuHS
jTyEEwGteZMDv53HTQZY8Ys+G9KKWkli2kPGbtnECnCuNhuuu19yo+EPT0YUpLUR
vuuY0Bv2g0g8/OTZ09DonYzszQYbKA==
=t/AJ
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
