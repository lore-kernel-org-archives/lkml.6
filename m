Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3619320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3619320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLMAjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:39:42 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:59818 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:39:41 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7959E72CC6C;
        Thu, 13 Dec 2018 03:39:38 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 52EFD95D299; Thu, 13 Dec 2018 03:39:38 +0300 (MSK)
Date:   Thu, 13 Dec 2018 03:39:38 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181213003938.GD24195@altlinux.org>
References: <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, Dec 10, 2018 at 11:18:18AM +0100, Peter Zijlstra wrote:
> On Sat, Dec 08, 2018 at 12:38:05PM -0500, Steven Rostedt wrote:
> > On Sat, 8 Dec 2018 11:44:23 +0100, Peter Zijlstra wrote:
>=20
> > > > Why do we care about lost events? Because strace records *all* even=
ts,
> > > > as that's what it does and that's what it always has done. It would=
 be
> > > > a break in functionality (a regression) if it were to start losing
> > > > events. I use strace to see everything that an application is doing=
=2E =20
> > >=20
> > > So make a new tool; break the expectation of all events. See if there=
's
> > > anybody that really cares.
> >=20
> > Basically you are saying, break strace and see if anyone notices?
>=20
> Nah, give it a new name. Clearly mark this is a new tool.
>=20
> > > > When we discussed this at plumbers, Oracle people came to me and sa=
id
> > > > how awesome it would be to run strace against their database access=
es.
> > > > The problem today is that strace causes such a large overhead that =
it
> > > > isn't feasible to trace any high speed applications, especially if
> > > > there are time restraints involved. =20
> > >=20
> > > So have them run that perf thing acme pointed to.
> > >=20
> > > So far nobody's made a good argument for why we cannot have LOST even=
ts.
> >=20
> > If you don't see the use case, I'm not sure anyone can convince you.
> > Again, I like the fact that when I do a strace of an application I know
> > that all system calls that the application I'm tracing is recorded. I
> > don't need to worry about what happened in the "lost events" space.
>=20
> You're the one pushing for this crap without _any_ justification. Why
> are you getting upset if I ask for some?
>=20
> If people care so much, it shouldn't be hard to write up a coherent
> story on this, so far all I seem to get is: because it's always been
> like that.
>=20
> Which really isn't much of an argument.

As you rightly pointed out, strace users are expecting that no events are
lost because it's always been like that, and it would require some efforts
to imagine what kind of things are going to break if this is no longer the
case.

Last FOSDEM I attended a talk [1] by Philippe Ombredanne, he was speaking
about a strace-based tool called TraceCode that constructs build graphs
that are used to find out "exactly which files were built, by what and how
they were transformed in multiple steps from sources to your final binaries=
".

Imagine you told Philippe that strace now works faster but it's no longer
reliable because some events may be lost, and he would have to repeat
builds under strace again and again until he is lucky.  I can imagine his
reaction to this piece of news, and I certainly wouldn't like to be the
messenger.

btw, I didn't ask for the implementation to be ugly.
You don't have to introduce polling into the kernel if you don't want to,
userspace is perfectly capable of invoking wait4(2) in a loop.
Just block the tracee, notify the tracer, and let it pick up the pieces.

[1] https://archive.fosdem.org/2018/schedule/event/debugging_tools_stracing=
_build/


--=20
ldv

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcEapKAAoJEAVFT+BVnCUIGMQP/078NhxXNLpbMS/DEVDJ4Yun
cQb0lCE5SEcPpQ0u6Zd5oP8wrKSCBd1Yp0uG/HFTTioTQKRpcUZ0lmshVGKAZJ49
kkCZQ2y4DxIOLzhilXeOkFmCBGJ5y5dNfSGETIynI228oO/BkaEO9itQNqHaNzdz
YD7lqeTStTJO5zPFFjXSObNw+cmW+akYg07k75Y5xBPXAFCMUP4MzvSCQc0U6h12
G7ycg3ImCEB00b5OajI3mlHq6ZJsIH/d02m+GcunalS/f/Oe1VnqiHwa9Jb2fk+v
p+UT63aPCABBImraRl2L1irkGYNVZuehfcDE6ZfuB3WtJXcX/Xrd6cHYR5gNswy7
dr545sHaLiqu4OGsdObgx2NsEgzBKEiaECO92ywHUeY+ql1VJoJoKX5Qt5iI+1hw
9YIyuQoNt2jT+vCA6Zp8FErdIqrf4ehy25YmGOAQZ951ys5qZiYzBQikZy3NPkyC
2Mu1x0BnY8+BTcSGy/Bv9EgPXhOk1LdykuurbfnYAFHPlraVRq/nSpid2cqk0FZ+
Skn9gk6OXY9F0uEey5Ckr2foOTbXNV8/yaR04OzmPliSP8UXhLbbXJVA6Of/8MHA
Cell6w71+T5fd65qawPPF9KBTfv3Ise+ym6pZDf9rDEVZ/YTjjGVDTJui9Ql2vgu
uFb3R7TCrIrKXFhJIOc3
=CGBN
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
