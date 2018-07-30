Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC77E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7892F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7892F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG3QFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:05:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49762 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeG3QFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:05:45 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fk9Bb-0000vJ-Ts; Mon, 30 Jul 2018 10:30:11 -0400
Message-ID: <1532961011.28585.30.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon, 30 Jul 2018 10:30:11 -0400
In-Reply-To: <20180730095502.GG2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PiyL3ua32SMIGUwm91Kh"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PiyL3ua32SMIGUwm91Kh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 11:55 +0200, Peter Zijlstra wrote:
> On Sun, Jul 29, 2018 at 03:54:52PM -0400, Rik van Riel wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index c45de46fdf10..11724c9e88b0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2691,7 +2691,7 @@ static struct rq *finish_task_switch(struct
> > task_struct *prev)
> >  	 */
> >  	if (mm) {
> >  		membarrier_mm_sync_core_before_usermode(mm);
> > -		mmdrop(mm);
> > +		drop_lazy_mm(mm);
> >  	}
> >  	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
> >  		if (prev->sched_class->task_dead)
> > @@ -2805,7 +2805,7 @@ context_switch(struct rq *rq, struct
> > task_struct *prev,
> >  	 */
> >  	if (!mm) {
> >  		next->active_mm =3D oldmm;
> > -		mmgrab(oldmm);
> > +		grab_lazy_mm(oldmm);
> >  		enter_lazy_tlb(oldmm, next);
> >  	} else
> >  		switch_mm_irqs_off(oldmm, mm, next);
>=20
> What happened to the rework I did there? That not only avoided
> fiddling
> with active_mm, but also avoids grab/drop cycles for the other
> architectures when doing task->kthread->kthread->task things.

I don't think I saw that. I only saw your email from
July 20th with this fragment of code, which does not
appear to avoid the grab/drop cycles, and still fiddles
with active_mm:

Date: Fri, 20 Jul 2018 11:32:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720093239.GO2494@hirez.programming.kicks-ass.net>

+       /*
+        * kernel -> kernel   lazy + transfer active
+        *   user -> kernel   lazy + mmgrab() active
+        *
+        * kernel ->   user   switch + mmdrop() active
+        *   user ->   user   switch
+        */
+       if (!next->mm) {                                // to kernel
+               enter_lazy_tlb(prev->active_mm, next);
+
+#ifdef ARCH_NO_ACTIVE_MM
+               next->active_mm =3D prev->active_mm;
+               if (prev->mm)                           // from user
+                       mmgrab(prev->active_mm);
+#endif
+       } else {                                        // to user
+               switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
+#ifdef ARCH_NO_ACTIVE_MM
+               if (!prev->mm) {                        // from kernel
+                       /* will mmdrop() in finish_task_switch(). */
+                       rq->prev_mm =3D prev->active_mm;
+                       prev->active_mm =3D NULL;
+               }
+#endif

What email should I look for to find the thing you
referenced above?

> I agree with Andy that if you avoid the refcount fiddling, then you
> should also not muck with active_mm.
>=20
> That is, if you keep active_mm for now (which seems a reasonable
> first
> step) then at least ensure you keep ->mm =3D=3D ->active_mm at all times.

There do not seem to be a lot of places left in
arch/x86/ that reference active_mm. I guess the
next patch series should excise those? :)

--=20
All Rights Reversed.
--=-PiyL3ua32SMIGUwm91Kh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltfIPMACgkQznnekoTE
3oPx2QgAk7+QJQCkB3QiIOH6urIp0jk0HSIo8Lt+W7Gb9dKIaL3B0rJMYBavozwS
0jtUEn9gprCUYbG8XaDV10gVGLec7tbdV8bOLDWTEE9pG0JG1oOXtRuSkZTHnMGf
RKs2l0ABMCxXQjhMQxAmpHcHc+/bImt/E47pLAymuNBsl/odW1yvBgKiXKxLEzIF
rDE2tnbkx8cYhAjI+tzQC7EnzJ5Mo2CBt0FW/hlwQV6czRl+Dt/9crYuMO8FQa91
mJTWk7VVhFPyHnNYI+pNOtIcBwjyHCzFcMb/kWi87W4SP5QMYLKvACCUrg/TOvpM
QELBfJarZCaLkk/waLfg4JOwvTtYCQ==
=fMqg
-----END PGP SIGNATURE-----

--=-PiyL3ua32SMIGUwm91Kh--

