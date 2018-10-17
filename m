Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62582150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62582150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJQT1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:27:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59060 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:27:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 408888078B; Wed, 17 Oct 2018 13:32:26 +0200 (CEST)
Date:   Wed, 17 Oct 2018 13:32:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     vbabka@suse.cz, hpa@zytor.com, torvalds@linux-foundation.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: Re: l1tf: Kernel suggests I throw away third of my memory. I'd
 rather not
Message-ID: <20181017113226.GA5176@amd>
References: <20181017105610.GA4260@amd>
 <20181017111544.GO18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20181017111544.GO18839@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > 6a012288 suggests I throw away 1GB on RAM. On 3GB system.. that is not
> > going to be pleasant.
> >=20
> > l1tf.html says:
> >=20
> > # The Linux kernel contains a mitigation for this attack vector, PTE
> > # inversion, which is permanently enabled and has no performance
> > # impact.
> >=20
> > I don't believe it has "no" performance impact, but I guess it is lost
> > in the noise.
>=20
> Please prove otherwise. I would be more than surprised if inverting pfn
> part of the pte is noticeable. But I can be wrong of course.

I'm not saying its noticeable. I'm saying that inversion takes few
clock cycles (including a branch?) and that neither caches nor RAM is
free.

"no noticeable performance impact" I'd agree with :).

> > #  The kernel ensures that the address bits of PTEs, which are
> > # not marked present, never point to cacheable physical memory space.
> >=20
> > # A system with an up to date kernel is protected against attacks from
> > # malicious user space applications.
> >=20
> > These are not true.
> >=20
> > cat /sys/devices/system/cpu/vulnerabilities/l1tf
> > Vulnerable
> > uname -a
> > Linux amd 4.19.0-rc8-next-20181017autobisect1539371050 #189 SMP Wed
> > Oct 17 12:04:23 CEST 2018 i686 GNU/Linux
>=20
> This is a result of you having memory above MAX_PFN/2 right?

Yes.

> > Now question is... can we do better? Kernel stores information about
> > swapped-out pages there, right? That sounds like a cool hack, but
> > maybe it is time to get rid of that hack?
>=20
> Patches are welcome.

Cooperation will be needed if you want to see patches. As
in... answering the questions above.

> > As a workaround, can I simply do swapoff -a to be safe for now?
>=20
> Well, that depends. Do you care about PROT_NONE attacks as well? If not
> then no-swap would help you. But even then no-swap is rather theoretical
> attack on a physical host unless you allow an arbitrary swapout to a
> malicious user (e.g. allow a user controlled memcg hard limit that would
> cause excessive local swapouts).

PROT_NONE attack.. aha, so kernel stores not only information about
swapped-out pages but also about file-backed pages that are currently
not present? Hmm. That makes it more complex :-(.=20

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvHHcoACgkQMOfwapXb+vLNUgCfWbqpoSLWonc6V6Gr674SjNTX
7fcAoLzFGJgOme3A4yIyCTGv3LRFW2kl
=T8qo
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
