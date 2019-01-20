Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1EFC676ED
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968A12087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="aI7HarUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfATPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 10:33:07 -0500
Received: from narfation.org ([79.140.41.39]:34374 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfATPdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 10:33:07 -0500
Received: from sven-edge.localnet (p200300C5974E31FD0000000000004065.dip0.t-ipconnect.de [IPv6:2003:c5:974e:31fd::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id D538311012E;
        Sun, 20 Jan 2019 16:33:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1547998384;
        bh=lZPFMe/5HXUsCryov7z0A+6Rpv0uxdtNA8LptfTIeFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI7HarUDPSLNO67T8Mv5NIYlYETL/w6gnbr83Nx98OGdgzb6d/vTcwpDwRhu7sRaS
         CLgHStRnY9ZgR2rpkBEQUmo+lLm/ArOn4sIPWjlX5fwZX7c1DDKVDzTN0mcH9o0Vav
         hwOI5pD1m8DPsza58k6LMzCeiRE8De6QFYC0KPOo=
From:   Sven Eckelmann <sven@narfation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [patch 2/2] scripts/spdxcheck.py: Handle special quotation mark comments
Date:   Sun, 20 Jan 2019 16:32:55 +0100
Message-ID: <3904432.cpar7GfAiZ@sven-edge>
In-Reply-To: <20190116104127.698565432@linutronix.de>
References: <20190116102651.489113812@linutronix.de> <20190116104127.698565432@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1720244.jrHZZGNX3P"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1720244.jrHZZGNX3P
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 16 January 2019 11.26.53 CET Thomas Gleixner wrote:
> The SuperH boot code files use a magic format for the SPDX identifier
> comment:
> 
>   LIST "SPDX-License-Identifier: .... "
> 
> The trailing quotation mark is not stripped before the token parser is
> invoked and causes the scan to fail. Handle it gracefully.
[...]

This patch introduces a false positive when checking files with an ANSI-C 
style /* SPDX-License-Identifier: .... */ comment line.

    $ ./scripts/checkpatch.pl -q -f include/linux/bug.h
    WARNING: 'SPDX-License-Identifier: GPL-2.0 */' is not supported in LICENSES/...
    #1: FILE: include/linux/bug.h:1:
    +/* SPDX-License-Identifier: GPL-2.0 */
    
    total: 0 errors, 1 warnings, 79 lines checked

checkpatch.pl is already stripping the "/* " prefix and only sends the 
remaining "SPDX-License-Identifier: GPL-2.0 */" via stdin to
scripts/spdxcheck.py. Thus the newly introduced check

> +                # Remove trailing comment closure
> +                if line.startswith('/*'):
> +                    expr = expr.rstrip('*/').strip()

doesn't match and thus the code doesn't remove the " */" at the end of the 
line.

Kind regards,
	Sven
--nextPart1720244.jrHZZGNX3P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxElKcACgkQXYcKB8Em
e0Yp4A//S9LSe/7QRX7rwb8+URrAa4NeSlLqK9xkIEu8l1qH5JgHUNBXbyx4vLEv
EG/IiMskFVwaExXSvgjrE5IMgKGfeDgd+7G+lYHmcMHrO6brDH5Onbc3t9XHe+8O
dmHa/WLZeYQuvt8iAOuzkGp8s1mUUnDPyN4HiC3ObU53PDCW0mfF9O9HPNEQikjX
avqzO+wyKyBD52h8UYzPVinVble2nbF6wkrxYpUURsZsNtpyiCFg3okKlfbqa+Mb
2gT8nqvNZ9cc8d9QVlg/theMfS5mTcQoBVPCw8ExQ0s7hwO4OjswXTLhh1Dpo6MY
GtEIs68qvQyYOPkfm2KWTeYc4okNBOfJKDprbUk7Kql6LUMhiwE8r2H/M5SNE61s
I8Y5n1oSi3MW3h0Ihqu25XyJ9pLmCgI+Mo7PC/kSeSGahMjnZiPlYXb0OwWl2Bjx
yZoRGkZk4RWAIcAPQkT6IQHi32HYzZUuHPqeIp/H2X0K6lAPMAjdDZV1LTxYP86d
XcmfiBCxBV8PoCmvxzxxK8K5LCXFcbMsPBzJPfFThQmUh7xLRB3XMC49cQTJetMt
0NhaIHgwG2maPRfxH5rDv2uRADDRvvS6bCTbIEb/GFELT+0sOWqUYpn6fNUPjx7y
XBDhZOKSMbQjGccBSExaR3g4rlgsROgh0el0C55tK3V4VAdsd+U=
=nnHA
-----END PGP SIGNATURE-----

--nextPart1720244.jrHZZGNX3P--



