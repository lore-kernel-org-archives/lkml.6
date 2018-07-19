Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1777ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482920693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGSBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:46:38 -0400
Received: from tuna.sandelman.ca ([209.87.249.19]:57096 "EHLO
        tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGSBqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:46:38 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 21:46:37 EDT
Received: from sandelman.ca (obiwan.sandelman.ca [IPv6:2607:f0b0:f:2::247])
        by tuna.sandelman.ca (Postfix) with ESMTP id 33E702008C;
        Wed, 18 Jul 2018 21:14:27 -0400 (EDT)
Received: by sandelman.ca (Postfix, from userid 179)
        id 6C9E01A76; Wed, 18 Jul 2018 20:54:03 -0400 (EDT)
Received: from sandelman.ca (localhost [127.0.0.1])
        by sandelman.ca (Postfix) with ESMTP id 6A5041A54;
        Wed, 18 Jul 2018 20:54:03 -0400 (EDT)
From:   Michael Richardson <mcr@sandelman.ca>
To:     dsahern@kernel.org
cc:     netdev@vger.kernel.org, nikita.leshchenko@oracle.com,
        roopa@cumulusnetworks.com, stephen@networkplumber.org,
        idosch@mellanox.com, jiri@mellanox.com, saeedm@mellanox.com,
        alex.aring@gmail.com, linux-wpan@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
X-Mailer: MH-E 8.6; nmh 1.7+dev; GNU Emacs 24.5.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Date:   Wed, 18 Jul 2018 20:54:03 -0400
Message-ID: <15730.1531961643@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

>>>>> David Ahern <dsahern@gmail.com> writes:
dsahern@kernel.org wrote:
    > Nikita Leshenko reported that neighbor entries in one namespace can
    > evict neighbor entries in another. The problem is that the neighbor
    > tables have entries across all namespaces without separate accounting
    > and with global limits on when to scan for entries to evict.

    > Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
    > namespace and making the accounting and threshold limits per namespace.

This is a good improvement, thank you.
We absolutely need to keep a DOS against a single netns from causing
evictions in another netns.

Within a namespace there may be neighbours entries that are more
sure/valid/useful than others.  I would like an API to be able to
mark them explicitely, but that could come leter.

In particular, in the 802.15.4 case, NE that arrive via encrypted
channels should be preferred over entries that arrive over unencrypted
channels.  This is needed for IETF 6tisch secure join work, for instance.

I believe that we could use network namespaces to implement though.

I had not considered that before, and I think that it will work, but
there might be something subtle that I've missed.  (Alex?)
It appears that one can tune the amount of space on a per-namespace basis:

+	nd_tbl->gc_thresh1	= 128;
+	nd_tbl->gc_thresh2	= 512;
+	nd_tbl->gc_thresh3	= 1024;

> Remove open use of arp_tbl and nd_tbl in favor of the new
> ipv{4,6}_neigh_table helpers. Since the existence of the IPv6 table
> is managed by the core networking, the IS_ENABLED checks for IPv6
> can be removed in favor of "is the table non-NULL".

What's the advantage of changing this check? (I am ignorant)


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBW0/hJ4CLcPvd0N1lAQIyJQf/bfxvt2k0AgkFh2XrPvTiZ0pdXdicbhHE
XDv5Fgft/iTBcvuDXH0ocIzPQGqyx46RbXBpH+ExJ/9YX3UHkaHQM19aDHZirOWj
WS7Wxhxzcb5Tum/HfaD8vBF9n0qqGrRvDidn8b+UR4E8dnrhb4NRk0XVOUPnYx+J
1dHMTOaPz1ubs/h3U48GpiMn8IdXeqTsQ569zYmM5G3SSMl9bTfCu4GDmcVoFXlZ
U+h5GXZm3COzqMl7UHiAGEcC++7OizvDv/R0dk2rE3jnUACSgk8tkN+t/ymSUfFg
C/VCZuwVUnZoSx5faWHd4OEdW10J5Z6Karuu4m7h0PM4tEYPNZHMGA==
=Tc0V
-----END PGP SIGNATURE-----
--=-=-=--
