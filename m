Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F373ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018A9208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018A9208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeGPTFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:05:55 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36062 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:05:55 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ff8Mq-00036w-Gv; Mon, 16 Jul 2018 14:37:04 -0400
Message-ID: <1531766224.26425.5.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,switch_mm: skip atomic operations for init_mm
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Date:   Mon, 16 Jul 2018 14:37:04 -0400
In-Reply-To: <20180716010457.GA28744@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
         <20180710142833.26231-8-riel@surriel.com>
         <20180715230430.GD30102@gmail.com> <1531698583.26425.3.camel@surriel.com>
         <20180716010457.GA28744@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cK+L1gKqhjZttuNLeN5Q"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cK+L1gKqhjZttuNLeN5Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-16 at 03:04 +0200, Ingo Molnar wrote:
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > On Mon, 2018-07-16 at 01:04 +0200, Ingo Molnar wrote:
> > > * Rik van Riel <riel@surriel.com> wrote:
> > >=20
> > > > +		/*
> > > > +		 * Stop remote flushes for the previous mm.
> > > > +		 * Skip the idle task; we never send init_mm
> > > > TLB
> > > > flushing IPIs,
> > > > +		 * but the bitmap manipulation can cause cache
> > > > line contention.
> > > > +		 */
> > > > +		if (real_prev !=3D &init_mm) {
> > > > +			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
> > > > +						mm_cpumask(rea
> > > > l_pr
> > > > ev)));
> > > > +			cpumask_clear_cpu(cpu,
> > > > mm_cpumask(real_prev));
> > >=20
> > > BTW., could this optimization be (safely) extended to all (or
> > > most)
> > > !task->mm=20
> > > kernel threads?
> > >=20
> > > In particular softirq and threaded irq handlers could benefit
> > > greatly
> > > I suspect in=20
> > > certain networking intense workloads that happen to active them.
> >=20
> > Yes, it could.
> >=20
> > Are there kernel threads that use something other than
> > init_mm today?
>=20
> Yeah, I think that's the typical case - so at minimum the comment
> should be fixed:
>=20
>  > > > +	 * Skip the idle task; we never send init_mm TLB
> flushing IPIs,
>=20
> and it should say 'skip kernel threads', right?

I will send a v6 that improves this comment, and has
the S-o-b thing you suggested for patch 1/7.

I think that addresses all the comments people had on
this patch series.

--=20
All Rights Reversed.
--=-cK+L1gKqhjZttuNLeN5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltM5dAACgkQznnekoTE
3oNiaQf/aSMi4AkwWBwY0sNhn8IKpUhra8FgyY0K+7CWOSuryY57YkfT33itzRIt
TFzI9p3k0UKij+8gEp1uSxMkkHUIPicM35PdYSVrYo8SO0/omWyCy3K5ZdY3lpe9
RPJLiqWguyKAHQukx8sNBtax6mKhK42iW270DMWzrd0u5S+52xg9w0QMB2hjigM3
Vd0tKzRvDu1hotLWED5CHf48Y7Q9sd2XJOXQRP0zNlnsQ6T9ny083DMCGKQ+aEe2
y6YADQardWN2mcXgiamY+8NUxa6WGc/ZvYSMOAPWZXsxlZzT2ZMGq3s6Eu5TSWGC
/peFnrPytfwdgvrXqwzl4ZvaNQuIeg==
=aITW
-----END PGP SIGNATURE-----

--=-cK+L1gKqhjZttuNLeN5Q--

