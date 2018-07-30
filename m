Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A281C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC02720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeG3VMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:12:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50314 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbeG3VMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:12:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkDxg-0005BY-NM; Mon, 30 Jul 2018 15:36:08 -0400
Message-ID: <1532979368.28585.33.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon, 30 Jul 2018 15:36:08 -0400
In-Reply-To: <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
         <1532961011.28585.30.camel@surriel.com>
         <20180730162653.GM2494@hirez.programming.kicks-ass.net>
         <1532978146.28585.32.camel@surriel.com>
         <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TQJ0OGlnMeltqnHFvU/U"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TQJ0OGlnMeltqnHFvU/U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 12:30 -0700, Andy Lutomirski wrote:
> On Mon, Jul 30, 2018 at 12:15 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 30, 2018 at 10:30:11AM -0400, Rik van Riel wrote:
> > >=20
> > > > > What happened to the rework I did there? That not only
> > > > > avoided
> > > > > fiddling
> > > > > with active_mm, but also avoids grab/drop cycles for the
> > > > > other
> > > > > architectures when doing task->kthread->kthread->task things.
> > > >=20
> > > > I don't think I saw that. I only saw your email from
> > > > July 20th with this fragment of code, which does not
> > > > appear to avoid the grab/drop cycles, and still fiddles
> > > > with active_mm:
> > >=20
> > > Yeah, that's it. Note how it doesn't do a grab+drop for kernel-
> > > > kernel,
> > >=20
> > > where the current could would have.
> > >=20
> > > And also note that it only fiddles with active_mm if it does the
> > > grab+drop thing (the below should have s/ifdef/ifndef/ to make
> > > more
> > > sense maybe).
> >=20
> > I'll kick off a test with your variant. I don't think we
> > will see any performance difference on x86 (due to not
> > using a refcount at all any more), but unless Ingo is in
> > a hurry I guess there's no issue rewriting this part of
> > the patch series :)
> >=20
> > Do the other patches look ok to you and Andy?
> >=20
>=20
> The whole series other than the active_mm stuff looked okay to me.

Does the active_mm stuff look like a step in the right
direction with the bugfix, or would you prefer the code
to go in an entirely different direction?

If this looks like a step in the right direction, it
may make sense to make this step before the merge window
opens, and continue with more patches in this direction
later.

--=20
All Rights Reversed.
--=-TQJ0OGlnMeltqnHFvU/U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltfaKgACgkQznnekoTE
3oPtRggAuIs0YWwDPWVIsj60RvX4pIOazfD/ytxipbJlBH3ksLL1fRqX/+aUdFMB
pcFapRCwjY0W5TLBFIUeFBKumoTfvCiz0bwV0Gm8UiBqNptU/8ZzLSUMMRdCwCgK
Ybtf2nshq3leVtKfqnBPsTDZVZoN+aqbxWXJSLfEsJOqQwE9M/q50CAf9P4penG1
z4P2balb9uP96zazYwJgcYqVzDR4lFs1TYmn9VUYZLjOODwW0XB8hOD6PITfV9da
DT11vX7VOUiX94f6VbbS5OvT61rr1UORGzi/NJPBdQaQjP/XhETe/2TbUUL66H4D
hckch9sbrw5Oo6O3FoA7V/Jb5TK5RA==
=k4tB
-----END PGP SIGNATURE-----

--=-TQJ0OGlnMeltqnHFvU/U--

