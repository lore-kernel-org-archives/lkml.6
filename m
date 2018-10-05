Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE5A2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cr.yp.to
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeJEWKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:10:43 -0400
Received: from salsa.cs.uic.edu ([131.193.32.108]:52722 "HELO salsa.cs.uic.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728118AbeJEWKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:10:42 -0400
Received: (qmail 24324 invoked by uid 1010); 5 Oct 2018 15:04:55 -0000
Received: from unknown (unknown)
  by unknown with QMTP; 5 Oct 2018 15:04:55 -0000
Received: (qmail 17007 invoked by uid 1000); 5 Oct 2018 15:05:38 -0000
Date:   5 Oct 2018 15:05:38 -0000
Message-ID: <20181005150538.17006.qmail@cr.yp.to>
Mail-Followup-To: Jason@zx2c4.com,
  ard.biesheuvel@linaro.org,
  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,
  linux-crypto@vger.kernel.org,
  davem@davemloft.net,
  gregkh@linuxfoundation.org,
  sneves@dei.uc.pt,
  luto@kernel.org,
  jeanphilippe.aumasson@gmail.com,
  linux@armlinux.org.uk,
  linux-arm-kernel@lists.infradead.org,
  peter@cryptojedi.org
Automatic-Legal-Notices: See https://cr.yp.to/mailcopyright.html.
From:   "D. J. Bernstein" <djb@cr.yp.to>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Peter Schwabe <peter@cryptojedi.org>
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
 <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For the in-order ARM Cortex-A8 (the target for this code), adjacent
multiply-add instructions forward summands quickly. A simple in-order
dot-product computation has no latency problems, while interleaving
computations, as suggested in this thread, creates problems. Also, on
this microarchitecture, occasional ARM instructions run in parallel with
NEON, so trying to manually eliminate ARM instructions through global
pointer tracking wouldn't gain speed; it would simply create unnecessary
code-maintenance problems.

See https://cr.yp.to/papers.html#neoncrypto for analysis of the
performance of---and remaining bottlenecks in---this code. Further
speedups should be possible on this microarchitecture, but, for anyone
interested in this, I recommend focusing on building a cycle-accurate
simulator (e.g., fixing inaccuracies in the Sobole simulator) first.

Of course, there are other ARM microarchitectures, and there are many
cases where different microarchitectures prefer different optimizations.
The kernel already has boot-time benchmarks for different optimizations
for raid6, and should do the same for crypto code, so that implementors
can focus on each microarchitecture separately rather than living in the
barbaric world of having to choose which CPUs to favor.

---Dan

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbt33CAAoJELDADU47DlRZPQwP/RX2uAhuaumOVvp9njd8n0zY
92cmL/mUx10TUsw/u76ryVjvdDkRd/8BAOtNQ5dYqLReiNcMqCX7keWe7F9myXWO
/LsobUdU28F4Q2iP0a7TwZIzKyxwQzHUnHsAl0tydsWoX0Nb2bs8gbpkf4AJ4BWr
41WDxiynGZezl7FUcXA0RgdxDMdFZxYXSw6wRDUscFs7MfOaDO9nvhNYRWVn+lNZ
DDnTCO3YPLc2qe5uPcH/CVOj+CIBVOd9uzO7ggmBqNfBWyYzKebu4xyY1bg8GXJa
Xj4y0ob+plAf427Svz5X2br4t2Lwg4VSrQ1kU3qXfCY46D1DJKraeKbLeiKijB6N
5vpxl1nKBvMyIQHr6dE/Q7qOvasYZuvKd+A/xv2wUwQxkdTI2u1tz+Oa2BkS2zyR
Oukto1kIYcfq8BlWxCIItjholBY5opfCA3tT1QdghBWILZwMN9IVGyb4kkCdxdcX
Py/DkEY2Cen90LNO5UT+3g4g/D/ALTwAvATg3U1JKgJfti6zQKLxUMQcmEiV4qky
aFcR1mpPoxwttoNd4s9zA1WFWBl6dCQjMhqhOvM3rBwByJyum0SQFqyx+F9P5Cpv
LM5V4MMVng8rGcF/E99FeVSPcdLAa8TjYfFqTfbe/hhFLJcvQ1PtdHeP8oSMvhqM
1IA4fIdgtto2qD3k37Kr
=AM3C
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
