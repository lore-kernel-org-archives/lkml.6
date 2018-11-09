Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C132720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C132720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeKIRx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:53:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43751 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeKIRx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:53:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1215E80548; Fri,  9 Nov 2018 09:13:56 +0100 (CET)
Date:   Fri, 9 Nov 2018 09:13:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        rteysseyre@gmail.com,
        =?iso-8859-1?Q?Bj=F6rn?= Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20181109081358.GD12450@amd>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <CAMuHMdWTnwVeO0ihTSzaoQWPGw3HO8tiy+HARpwW9cCCXMAJPQ@mail.gmail.com>
 <CAMz4kuKZ5z-v_j5Fhu=QzwY-=U6SBy4uSWoT8G8U83Z2qBRLxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKZ5z-v_j5Fhu=QzwY-=U6SBy4uSWoT8G8U83Z2qBRLxA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-07 11:23:52, Baolin Wang wrote:
> Hi Geert,
>=20
> On 6 November 2018 at 23:57, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> > Hi Baolin,
> >
> > On Tue, Oct 2, 2018 at 6:39 PM Baolin Wang <baolin.wang@linaro.org> wro=
te:
> >> This patch adds one new led trigger that LED device can configure
> >> the software or hardware pattern and trigger it.
> >>
> >> Consumers can write 'pattern' file to enable the software pattern
> >> which alters the brightness for the specified duration with one
> >> software timer.
> >>
> >> Moreover consumers can write 'hw_pattern' file to enable the hardware
> >> pattern for some LED controllers which can autonomously control
> >> brightness over time, according to some preprogrammed hardware
> >> patterns.
> >>
> >> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >
> >> --- /dev/null
> >> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> >> @@ -0,0 +1,431 @@
> >
> >> +static void pattern_trig_timer_function(struct timer_list *t)
> >> +{
> >> +       struct pattern_trig_data *data =3D from_timer(data, t, timer);
> >> +
> >> +       mutex_lock(&data->lock);
> >
> > Timer functions run in interrupt context, hence if CONFIG_DEBUG_ATOMIC_=
SLEEP=3Dy:
> >
> > BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:254
> > in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/1
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted
> > 4.20.0-rc1-koelsch-00841-ga338c8181013c1a9 #171
> > Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> > [<c020f19c>] (unwind_backtrace) from [<c020aecc>] (show_stack+0x10/0x14)
> > [<c020aecc>] (show_stack) from [<c07affb8>] (dump_stack+0x7c/0x9c)
> > [<c07affb8>] (dump_stack) from [<c02417d4>] (___might_sleep+0xf4/0x158)
> > [<c02417d4>] (___might_sleep) from [<c07c92c4>] (mutex_lock+0x18/0x60)
> > [<c07c92c4>] (mutex_lock) from [<c067b28c>]
> > (pattern_trig_timer_function+0x1c/0x11c)
> > [<c067b28c>] (pattern_trig_timer_function) from [<c027f6fc>]
> > (call_timer_fn+0x1c/0x90)
> > [<c027f6fc>] (call_timer_fn) from [<c027f944>] (expire_timers+0x94/0xa4)
> > [<c027f944>] (expire_timers) from [<c027fc98>] (run_timer_softirq+0x108=
/0x15c)
> > [<c027fc98>] (run_timer_softirq) from [<c02021cc>] (__do_softirq+0x1d4/=
0x258)
> > [<c02021cc>] (__do_softirq) from [<c0224d24>] (irq_exit+0x64/0xc4)
> > [<c0224d24>] (irq_exit) from [<c0268dd0>] (__handle_domain_irq+0x80/0xb=
4)
> > [<c0268dd0>] (__handle_domain_irq) from [<c045e1b0>] (gic_handle_irq+0x=
58/0x90)
> > [<c045e1b0>] (gic_handle_irq) from [<c02019f8>] (__irq_svc+0x58/0x74)
> > Exception stack(0xeb483f60 to 0xeb483fa8)
> > 3f60: 00000000 00000000 eb9afaa0 c0217e80 00000000 ffffe000 00000000 c0=
e06408
> > 3f80: 00000002 c0e0647c c0c6a5f0 00000000 c0e04900 eb483fb0 c0207ea8 c0=
207e98
> > 3fa0: 60020013 ffffffff
> > [<c02019f8>] (__irq_svc) from [<c0207e98>] (arch_cpu_idle+0x1c/0x38)
> > [<c0207e98>] (arch_cpu_idle) from [<c0247ca8>] (do_idle+0x138/0x268)
> > [<c0247ca8>] (do_idle) from [<c0248050>] (cpu_startup_entry+0x18/0x1c)
> > [<c0248050>] (cpu_startup_entry) from [<402022ec>] (0x402022ec)
> >
> > Either this should use a spinlock instead of a mutex, or the timer
> > function should kick a workqueue to do the real work.
> >
>=20
> Ah, sorry I missed this. Good catch.
>=20
> After more thinking, the easy fix is that I think we can remove the
> mutex lock in pattern_trig_timer_function(). Since the mutex lock is
> used to protect the pattern trigger data, but before changing new
> pattern trigger data (pattern values or repeat value) by users, we
> always cancel the timer firstly to clear previous patterns'
> performance. That means there is no race in
> pattern_trig_timer_function(), so we can drop the mutex lock in
> pattern_trig_timer_function() to avoid this issue.
>=20
> I will send one patch to fix this issue. Thanks.

That's kind of interesting, but yes, it should work.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvlQcYACgkQMOfwapXb+vIgTQCfdl40iS1czNt8D9OJf/A32jfF
8noAniM9zrGGCOlj8d3NvB4D0UnBXzqb
=mQQf
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
