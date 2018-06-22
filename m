Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70ED23F28
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70ED23F28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934139AbeFVPxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:53:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60022 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeFVPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:53:36 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWONR-0000BI-F7; Fri, 22 Jun 2018 11:53:33 -0400
Message-ID: <1529682813.7898.195.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 22 Jun 2018 11:53:33 -0400
In-Reply-To: <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-8-riel@surriel.com>
         <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tudc6USxxjCRJIcBNgW5"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tudc6USxxjCRJIcBNgW5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 08:36 -0700, Andy Lutomirski wrote:
> On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > Do not call leave_mm when going into a cstate. Now that mprotect
> > and
> > madvise no longer send IPIs for TLB shootdowns to idle CPUs, there
> > is
> > no real reason to disable lazy TLB mode in idle states.
> >=20
> > This seems to help performance on Broadwell systems. Haswell
> > performance
> > numbers are inconclusive.
>=20
> I'm skeptical.  The code you're removing is more about power
> consumption than about performance.  If a task migrates from one cpu
> to another, runs for awhile, and exits, we don't want to IPI the old
> CPU if the old CPU is deeply asleep.  The logic you're removing is a
> bit awkwardly written, but the intent is to only do the leave_mm() in
> deep sleep.  We should arguably change the condition to check the
> expected sleep duration instead of the microarchitectural properties
> of the target state, though.

That is fair.

A quick hack could be to just remove the tlb flush
from C3 state (which gets called a lot), but keep
it for C6 state and deeper (which get called more
when a CPU is really idle).

--=20
All Rights Reversed.
--=-tudc6USxxjCRJIcBNgW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstG30ACgkQznnekoTE
3oO1wAf/YnmqSDlt05IIPfqecf6atTJQt0VbPyS40Q4az/lkKUrLfQyuoXR1zc6B
0VhFU+XyC5FpO+HcAlG2hkd94ZCz5g4pqDaUc0j3S2SGdhamUtS/gIBc7qIi0NOv
FVbfhZo3MNWcrH/nIILvixZJn2lRMusfZqf8syz8p4NFZ+7yK+ROWNZV0OqEdHwy
uvwXYl8xe80kn91XJUEFlc17xVlDRi3kYzTeZGc3AoLN368h/y0mjSmeYDC8Saod
5vYxEEFk0HyU/3A9f4QopNcuRnZcPvf2M2/1JtHm5PTqzzrvffe2036LUUlDjtkG
gfYYUZt0G2nLaDySpRnCqFW5Qa8iWg==
=NbHL
-----END PGP SIGNATURE-----

--=-tudc6USxxjCRJIcBNgW5--

