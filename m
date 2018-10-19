Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2FBECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5208120658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5208120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJSXwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:52:02 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45674 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeJSXwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:52:02 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gDWxl-0002d4-8j; Fri, 19 Oct 2018 11:45:21 -0400
Message-ID: <e34f720326a03ac07e3156abf77f0f6c22ce4289.camel@surriel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
From:   Rik van Riel <riel@surriel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Date:   Fri, 19 Oct 2018 11:45:19 -0400
In-Reply-To: <20181019153316.GB15416@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
         <20181017020933.GC24723@lerouge>
         <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
         <824154aacf8a5cbff57b4df6cb072b7d6e277f34.camel@surriel.com>
         <20181019153316.GB15416@lerouge>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-uSESSwnIuGk5sIfO7vRh"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uSESSwnIuGk5sIfO7vRh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-10-19 at 17:33 +0200, Frederic Weisbecker wrote:
> On Fri, Oct 19, 2018 at 11:16:49AM -0400, Rik van Riel wrote:
> > On Fri, 2018-10-19 at 13:40 +0200, Jan H. Sch=C3=B6nherr wrote:
> > >=20
> > > Now, it would be possible to "invent" relocatable cpusets to
> > > address
> > > that
> > > issue ("I want affinity restricted to a core, I don't care
> > > which"),
> > > but
> > > then, the current way how cpuset affinity is enforced doesn't
> > > scale
> > > for
> > > making use of it from within the balancer. (The upcoming load
> > > balancing
> > > portion of the coscheduler currently uses a file similar to
> > > cpu.scheduled
> > > to restrict affinity to a load-balancer-controlled subset of the
> > > system.)
> >=20
> > Oh boy, so the coscheduler is going to get its
> > own load balancer?
> >=20
> > At that point, why bother integrating the
> > coscheduler into CFS, instead of making it its
> > own scheduling class?
> >=20
> > CFS is already complicated enough that it borders
> > on unmaintainable. I would really prefer to have
> > the coscheduler code separate from CFS, unless
> > there is a really compelling reason to do otherwise.
>=20
> I guess he wants to reuse as much as possible from the CFS features
> and
> code present or to come (nice, fairness, load balancing, power aware,
> NUMA aware, etc...).

I wonder if things like nice levels, fairness,
and balancing could be broken out into code
that could be reused from both CFS and a new
co-scheduler scheduling class.

A bunch of the cgroup code is already broken
out, but maybe some more could be broken out
and shared, too?

> OTOH you're right, the thing has specific enough requirements to
> consider a new sched policy.=20

Some bits of functionality come to mind:
- track groups of tasks that should be co-scheduled
  (eg all the VCPUs of a virtual machine)
- track the subsets of those groups that are runnable
  (eg. the currently runnable VCPUs of a virtual machine)
- figure out time slots and CPU assignments to efficiently
  use CPU time for the co-scheduled tasks
  (while leaving some configurable(?) amount of CPU time=20
  available for other tasks)
- configuring some lower-level code on each affected CPU
  to "run task A in slot X", etc

This really does not seem like something that could be
shoehorned into CFS without making it unmaintainable.

Furthermore, it also seems like the thing that you could
never really get into a highly efficient state as long
as it is weighed down by the rest of CFS.

--=20
All Rights Reversed.

--=-uSESSwnIuGk5sIfO7vRh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlvJ/BAACgkQznnekoTE
3oMnBAf/XZ5FYRjXCcBLBqR5xipXq7leCGGOhPlJFF+dSRW9CrrAa599/sTrA80A
HP5KYBKOrsllzCYSI+93xEL/i5u+SbMh73dE3UtaHDFIsohPKpPk23hs+vZpRPll
hI6RJu7Qo6U2csA0JEYgx6pNDRHDYGhnTCdQqSH4kIt9OeW8NGBJnf8rtWemKyf0
cg/vKR3okqnHFGpuhOXm/s94PZrsmMAYm3Qe8vN5bJvIBSzLKn5nglY2QYGm3juh
KatSsPQj4P3WUIbyjWZBtFbVf/vEH932943Yg67rM6E1oUBDLe+GKWxLSQaAfcAH
goyThKZyR2kGEi26lFLy1qsh10Y76g==
=Qg3O
-----END PGP SIGNATURE-----

--=-uSESSwnIuGk5sIfO7vRh--

