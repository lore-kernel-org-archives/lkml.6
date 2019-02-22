Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D62075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="h4Av5GWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfBVO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:28:43 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:34363 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBVO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550845720;
        s=strato-dkim-0002; d=aepfle.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=U1HZ5hqsM7AaTAXIE+Qz1wTiIY/Ai6ETOm9gqRYmKB0=;
        b=h4Av5GWjETVu/C9/Zk+NPD5/JcfBhpfWdkiLj28QrPt9IEihasn4KSAwCX5k5+dsux
        Syx+RGlP2c7yQjje6S72zoKW+XL9LS47UY85zy3f1X+cAOJqQToX3PQHc2v1VA4sraBs
        tlucp+iZKwLtpNyTNYcYKsd76XK+1nByhJvoM=
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAgc09FajRctxF8avNjL8BIaOzrboMVGNhg5iLfM="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
        by smtp.strato.de (RZmta 44.12 AUTH)
        with ESMTPSA id R08017v1MESekTC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 22 Feb 2019 15:28:40 +0100 (CET)
Date:   Fri, 22 Feb 2019 15:28:36 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: recalibrating x86 TSC during suspend/resume
Message-ID: <20190222142836.GA14744@aepfle.de>
References: <20190222105302.GA26398@aepfle.de>
 <alpine.DEB.2.21.1902221212190.1777@nanos.tec.linutronix.de>
 <036fab04-0c1b-134d-a170-399b2dc6ab5f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <036fab04-0c1b-134d-a170-399b2dc6ab5f@redhat.com>
User-Agent: Mutt/1.11.3 (20190207T234809.c483d3c3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, Paolo Bonzini wrote:

> On 22/02/19 12:44, Thomas Gleixner wrote:
> >> The specific usecase I have is a workload within VMs that makes heavy
> >> use of TSC. The kernel is booted with 'clocksource=3Dtsc highres=3Doff=
 nohz=3Doff'
> >> because only this clocksource gives enough granularity. The default
> >> paravirtualized clock will return the same values via
> >> clock_gettime(CLOCK_MONOTONIC) if the timespan between two calls is too
> >> short. This does not happen with 'clocksource=3Dtsc'.
>=20
> This shouldn't happen.  clock_gettime(CLOCK_MONOTONIC) should be
> monotonic increasing.  Do you have a testcase?

Two years ago I tweaked sysbench to track the execution time of the
'memory' test:

https://github.com/olafhering/sysbench
https://github.com/olafhering/sysbench/blame/pv/src/tests/memory/sb_memory.c

The checks in diff_timespec() triggered with clocksource=3Dxen, but I can
not reproduce it right now with 5.0 and 4.4 based kernels. I have no
data how KVM behaves. In the end the hypervisor was tweaked to tolerate
a certain jitter in expected TSC speed before emulation kicks in. Up to
~1MHz would be ok to stay within the 500PPM limit that ntpd can handle.

But now there is that "island" issue that needs to be resolved in one
way or another.

Olaf

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXHAHEAAKCRBdQqD6ppg2
fnzCAKCxHIeYXFSa14XpUTZpfglkb21WywCg7EFBbRgWebESoVVMPmQkLBshGRQ=
=JtGU
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
