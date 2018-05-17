Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AB8JxZr478wBJ7wNjx/xNnXaoiz3gPX48BWZiRLVPo1CiTN4ncA3H//SBp0nCrme9R4ODE10nu0W
ARC-Seal: i=1; a=rsa-sha256; t=1526567452; cv=none;
        d=google.com; s=arc-20160816;
        b=yLlna0iTZDHC6w4P4s9Fept/NsF0cOcApeJ1q+VDACuydn5WTaGZ5tqDIJ3SpvunoR
         /Pl+5wHEOXQvwiWe12a5MPkB4Dn3Myzxz0v4uCnyERWLzEkM3ale9KeM2ZUijGnK/w4a
         9qKeZk4nQJcdxqHDw8LWOpl8NpnlJN9ztZUTjKpdStJu1onC5RIF7QTtA5FQSdvD01IH
         hnDcIbiNNkngeIAYNWqVVHO/jnvdVyLKAU75MzhiXBvfIJPEoPkXaP2ae07fAsC8fX0I
         ukJ6HowXr1imTnT2cbTy5fjveyMWLT3y1hy/c5dtpjs0cja0kmT0xVCDSChVuTvJOGcL
         DGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=BxrKrkwiT6TRWc4SmGF1B4BueldZSVHtPBmvHlc+JX0=;
        b=KDyzQzBRwB8fLOOhPJeV3V+3frHKdVeUSo5yENhZhSN+FX+GX1CRuAEiQxH+AP/YcI
         uo/y8+g1sjE/wR9xWk/Cl22ZtgkoRSHSMGMeiN7CVgthPsf/IGBS033dc4GfIRLmPu+r
         +fIQpUDtNLIu0un14ulSrUeidIviH6+jnUabW3DYrL97j2BKrkIg7wiE3eDKHP9IFOiI
         cwyfegNW3MSHYei/G+QakqdYv2E4N81Iha4cqqjC0ue0WPWntO72vMz4Hqq+QLoOc+Q9
         nKye88Dg2cTKKwAQeW8XZEB9AmZOiz5m/HvRcIIZhZJiA/5jESvOKozQ7se1/sRmXKhy
         /9KA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cpy4s+0g;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cpy4s+0g;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 15:30:47 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] MIPS: Move ehb() to barrier.h
Message-ID: <20180517143046.GA24704@jamesdev>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <1515148270-9391-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1515148270-9391-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588748166594079924?=
X-GMAIL-MSGID: =?utf-8?q?1600721993513954226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jan 05, 2018 at 10:31:05AM +0000, Matt Redfearn wrote:
> The current location of ehb() in mipsmtregs.h does not make sense, since
> it is not strictly related to multi-threading, and may be used in code
> which does not include mipsmtregs.h

>  arch/mips/include/asm/barrier.h    | 13 +++++++++++++
>  arch/mips/include/asm/mipsmtregs.h |  8 --------

But ehb isn't really a memory barrier like the other barriers in
barrier.h, its an execution hazard barrier, as used when available by
the hazard macros in hazards.h, and in fact there is already an _ehb()
there.

I suspect the intention was that most MIPS arch code using ehb would do
so using the appropriate hazard abstractions, which would do the right
number of NOPs on hardware without the EHB instruction. Code that is
specific to certain arch revisions (like the MIPS MT code and MIPS KVM)
can get away with using _ehb/ehb, but should use the abstractions where
they exist to make intentions clear.

None of the specific hazards in hazards.h really match the case in patch
2, I suppose you could have a new sync_mfc0_hazard() macro, but its so
specific and EHB should be guaranteed to exist there, so perhaps _ehb()
should just be used instead of ehb() there? (with a comment to describe
what operations are being protected from what hazards).

Cheers
James

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWv2SFQAKCRA1zuSGKxAj
8g1NAQDbRoahEifuu6/yUogKV60Ye0OY1HPN5uhoF/Sps8q+6AD8DQ8sqzB6icvF
yii4y7HzTo+e6WZ7o9i1Z1pm2g8YqgA=
=6e5S
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
