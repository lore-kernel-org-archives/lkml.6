Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A533DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740DF214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740DF214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeIRUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:08:38 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41556 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeIRUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:08:38 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g2H6K-0001dD-OW; Tue, 18 Sep 2018 10:35:40 -0400
Message-ID: <bf7db07c6e8bb5600262612cd55f37668ed495e5.camel@surriel.com>
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
From:   Rik van Riel <riel@surriel.com>
To:     "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Tue, 18 Sep 2018 10:35:39 -0400
In-Reply-To: <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
         <20180914111251.GC24106@hirez.programming.kicks-ass.net>
         <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
         <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
         <20180917094844.GR24124@hirez.programming.kicks-ass.net>
         <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+NPxZ2Y1B5mNYuNsf2uj"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+NPxZ2Y1B5mNYuNsf2uj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-09-18 at 15:22 +0200, Jan H. Sch=C3=B6nherr wrote:
> On 09/17/2018 11:48 AM, Peter Zijlstra wrote:
> > On Sat, Sep 15, 2018 at 10:48:20AM +0200, Jan H. Sch=C3=B6nherr wrote:
> >=20
> > >=20
> > > CFS bandwidth control would also need to change significantly as
> > > we would now
> > > have to dequeue/enqueue nested cgroups below a
> > > throttled/unthrottled hierarchy.
> > > Unless *those* task groups don't participate in this flattening.
> >=20
> > Right, so the whole bandwidth thing becomes a pain; the simplest
> > solution is to detect the throttle at task-pick time, dequeue and
> > try
> > again. But that is indeed quite horrible.
> >=20
> > I'm not quite sure how this will play out.
> >=20
> > Anyway, if we pull off this flattening feat, then you can no longer
> > use
> > the hierarchy for this co-scheduling stuff.
>=20
> Yeah. I might be a bit biased towards keeping or at least not fully
> throwing away
> the nesting of CFS runqueues. ;)

I do not have a strong bias either way. However, I=20
would like the overhead of the cpu controller to be
so low that we can actually use it :)

Task priorities in a flat runqueue are relatively
straightforward, with vruntime scaling just like
done for nice levels, but I have to admit that
throttled groups provide a challenge.

Dequeueing throttled tasks is pretty straightforward,
but requeueing them afterwards when they are no
longer throttled could present a real challenge
in some situations.

> However, the only efficient way that I can currently think of, is a
> hybrid model
> between the "full nesting" that is currently there, and the "no
> nesting" you were
> describing above.
>=20
> It would flatten all task groups that do not actively contribute some
> function,
> which would be all task groups purely for accounting purposes and
> those for
> *unthrottled* CFS hierarchies (and those for coscheduling that
> contain exactly
> one SE in a runqueue). The nesting would still be kept for
> *throttled* hierarchies
> (and the coscheduling stuff). (And if you wouldn't have mentioned a
> way to get
> rid of nesting completely, I would have kept a single level of
> nesting for
> accounting purposes as well.)
>=20
> This would allow us to lazily dequeue SEs that have run out of
> bandwidth when
> we encounter them, and already enqueue them in the nested task group
> (whose SE
> is not enqueued at the moment). That way, it's still a O(1) operation
> to re-enable
> all tasks, once runtime is available again. And O(1) to throttle a
> repeat offender.

I suspect most systems will have a number of runnable
tasks no larger than the number of CPUs most of the
time.

That makes "re-enable all the tasks" often equivalent
to "re-enable one task".

Can we handle the re-enabling (or waking up!) of one
task almost as fast as we can without the cpu controller?

--=20
All Rights Reversed.

--=-+NPxZ2Y1B5mNYuNsf2uj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluhDTsACgkQznnekoTE
3oP9UwgAufSl9MI+BwVFF2CVVDpB1vTf5en5CrkqN/e0MoA/tfsoDMjgD5NMuy9F
orMIVzJHTcgmfJ9YJm8CMmVslQ8D7ZMWmei/UOd6ZT7Mv0FSDTJMCK/6ELe7ZLyT
Knj521o03ylNsC0H5DdgdCNDYYM/LWZpy9ZNoqg9lYcStgA14eeb3AIE8C7lQ7AI
hrSZ6F/tb9OvGveRXw8pQ7e7ZGMmL/Hn/UUp9nNSxiiQyil1tSdsMP9Gg23UaPI0
QktgDDlRusjIqCPqBAEZ5wgD4TF0NLeeRyYITQIRJs2/B7B4lLSdjc27bJbUZjEa
HXGF+QlKRB9oWVRs7V0lMxQqFAQhXw==
=WsYD
-----END PGP SIGNATURE-----

--=-+NPxZ2Y1B5mNYuNsf2uj--

