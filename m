Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B500C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD77E24A5C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77E24A5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeFWAzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:55:51 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60784 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933753AbeFWAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:55:50 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fWWq9-0006Mz-3d; Fri, 22 Jun 2018 20:55:45 -0400
Message-ID: <1529715344.7898.214.camel@surriel.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 22 Jun 2018 20:55:44 -0400
In-Reply-To: <CALCETrX9PZEHs9bj476bj5qEb1aXtiH0K8G998t1+CbUuiaGmg@mail.gmail.com>
References: <20180620195652.27251-1-riel@surriel.com>
         <20180620195652.27251-8-riel@surriel.com>
         <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
         <1529682813.7898.195.camel@surriel.com>
         <CALCETrXJzhwXkEi5oC9XY58B8fYT26WhMT+KBt-8m2M+foQvsw@mail.gmail.com>
         <1529698739.7898.206.camel@surriel.com>
         <CALCETrX9PZEHs9bj476bj5qEb1aXtiH0K8G998t1+CbUuiaGmg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7UncSXbSFFRcWD/S54X1"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7UncSXbSFFRcWD/S54X1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 15:05 -0700, Andy Lutomirski wrote:

> I think the right solution if you want that last little bit of
> performance is to get rid of the code in intel_idle and to add it in
> the core idle code.  We have fancy scheduler code to estimate the
> idle
> time, and we should use it here IMO.

Good point.

However, I suspect we have some lower hanging
larger fruit to tackle first.

Every time we go into lazy TLB mode, we take
a refcount on the mm. Every time we leave lazy
TLB mode, we drop the refcount.

Every time we switch from the idle task to a
kernel thread, the kernel thread takes a
refcount, and the idle task drops it. Every
time we switch back, we do the same dance in
reverse.

I am working on a patch to grab the refcount
once, and hang onto it while a particular mm
is that CPU's lazy_mm.

We can release it when we switch to a task
with a different mm.

The patches we have so far get rid of a lot of
the pounding on mm_cpumask(mm).

That patch should help us also get rid of tasks
pounding on mm->count.

After that, the idle state thing is probably
of pretty small impact, though I suspect it will
still be worth tackling :)


As an aside, isn't the fancy CPU power management
stuff in the scheduler cpufreq, not cpuidle? The
cpuidle stuff in kernel/sched/idle.c looks like it
will just call down into the menu governor (and
maybe the ladder governor on some systems??)

--=20
All Rights Reversed.
--=-7UncSXbSFFRcWD/S54X1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlstmpAACgkQznnekoTE
3oPsDwf9EVZwLy81NwMzaGbUDfkhXeY90EF9Ol3ygh+aXm+9XNXvE7JRTqTVzMdf
GOMT8MahXXOMW1ANQ1gwjUG26uwA8Qd8EhV76FCq5kdGKtZF/49UC6EPx+j3QSWo
L9cqlOIqxIT+Nh6FuiXbzv8C/XKBlN+RZeYrmuTOY3ahiWMBY7U2I+tnXW3qiOs7
Fe0koY5Xecz/5++zQ1SUXXnJYwHODWQgKV+q7FOMF19v2iruaP5opwQMx9yNMtCl
JSCOpxJzhpVIuu4Hz1pP0W9dUFQdagb+BuK5CkMSkHgv2N3loTWum+4iDwHbt5p6
4gy5H7Gj+FzzLOAQc+rf2rHM1Ydeqw==
=V4Ja
-----END PGP SIGNATURE-----

--=-7UncSXbSFFRcWD/S54X1--

