Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD628C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8187F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="xDDkWFvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8187F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=narfation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeK3S5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:57:55 -0500
Received: from narfation.org ([79.140.41.39]:48204 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3S5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:57:54 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2018 13:57:53 EST
Received: from bentobox.localnet (unknown [92.117.99.95])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 931D81100D8;
        Fri, 30 Nov 2018 08:41:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1543563699;
        bh=WdDazkSFA1AZHwC+jWd2Oj0Gfmrki60u7iMe+J1W1v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDDkWFvKI7M+YtYJyjL9vnel0JtBWFdvY62/Ip3EcbOQJM5XLKx0+tuPsFG2J9XeR
         HFD5ZvnpipxHObB5D9DzEV7vRBNzmCNHeGrnCW0R/7p0ImZ2OIBvyaFPBoFwQo2TjN
         /83ShLyhyorSg6uffTz/Cx+4vr2MJxOj2A1O9ncU=
From:   Sven Eckelmann <sven@narfation.org>
To:     b.a.t.m.a.n@lists.open-mesh.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, mareklindner@neomailbox.ch,
        sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net,
        netdev@vger.kernel.org, zhong.weidong@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix null pointer dereference in batadv_gw_election
Date:   Fri, 30 Nov 2018 08:41:35 +0100
Message-ID: <2508553.amZRsud9Hk@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
References: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3029363.zrB592PKAl"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3029363.zrB592PKAl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 30 November 2018 15:00:02 CET Wen Yang wrote:
> This patch fixes a possible null pointer dereference in
> batadv_gw_election, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./net/batman-adv/gateway_client.c:289:15-24: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:290:15-29: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:291:15-29: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:292:15-27: ERROR: next_gw is NULL but dereferenced.
> ./net/batman-adv/gateway_client.c:293:15-27: ERROR: next_gw is NULL but dereferenced.

This patch is seems to be nonsensical. next_gw cannot be NULL at this point 
(let us call this location in the code "4."). Let us go through the code

    // 1. when both are NULL then it would jump out of the the function.
	if (curr_gw == next_gw)
		goto out;

    [...]

    if (curr_gw && !next_gw) {
        [...]
        // 2. this handles the only valid case when next_gw is NULL
    }  else if (!curr_gw && next_gw) {
        // 3. here we know that next_gw is not NULL and curr_gw is NULL
        // we can therefore infer that 
        [...]
    } else {
        // 4. here you try to add an ugly patch to handle a non-existing 
        // next_gw == NULL case
        [...]
    }

Let us go through all possible combinations:

        curr_gw  next_gw
    I   0        0
    II  x        0
    III 0        y
    IV  x        y

For I:   we would leave the function even at 1. and never reach 4.
For II:  would be handled by 2. and thus never reach 4.
For III: would be handled by 3. and thus never reach 4.
For IV:  This can be handled by 1. (when x == y). Or otherwise it would be
         handled by 4. but is not the next_gw == NULL case.

Please correct me (in case I missed something) but it looks to me that this 
patch should be rejected.

Kind regards,
	Sven
--nextPart3029363.zrB592PKAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwA6a8ACgkQXYcKB8Em
e0ZMiw//abzOV72YH6n3yUp00BPlx2pZmZgzxrAV09jzFebl+HskKMBYN/PL4opu
xqu9Rimo5787LRBOT2gsTok3Xo0gfNUa43DsHxP1+XHByRKTHIbDLlOia3kmIE8w
5XZ4CO/RW5c0Oix9HTz2Shjuc/w4HjYJDiqZaVP19lhFv2Y+hx+ybT+CLdU7dm5S
n9SFY/QSWVEYpGR4SKM4BtS7UW1ph+yntja61JkC4lwh2VnQIblzy5OHzLHmmdB+
iQ7FAI6pvUjcXbOSoowM6Z9Xxty3m9ZppEvEZ5DllpVpO+mWV02Lcln+ePxY/NVI
lOlxJBg5+9uuWtmvOVdygKp+51MgrGYNgvoYZJfbf/AOpamNgB78t81EOt4tMquV
VRij3jgE4vxB2Ee0Lk3MP3SVd2ECH2HbHkfv+UulBEAXmeMbqkZjRnDQWfkWzMd2
dIbNzKIvH13quxu3WgzoNQHco5pmdFT+FXpX57mYybvTUlweCUCubZo1MyvO5kM3
GrU/7EGpzKWORi13v+I+LUDOqprXZ9d8c6xqHNmucHlsdE22r6sqG/1rfjPnjGUw
MFzGgH+mq1LOZz6eNQIp7o4CUxYv2719EAhKBOCZE0+EQw3W2eoq/4SBvJB+j9im
bBkSbec80kUU6SxophKOJZDb/En5pxx9i45g3N7UwYZvnCzzudE=
=aQHz
-----END PGP SIGNATURE-----

--nextPart3029363.zrB592PKAl--

