Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977E20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1977E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeKHRUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:20:47 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:43546 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeKHRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:20:47 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1517BA11DC;
        Thu,  8 Nov 2018 08:46:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 3ebsSXMH46ED; Thu,  8 Nov 2018 08:46:27 +0100 (CET)
Date:   Thu, 8 Nov 2018 18:46:12 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181108074612.ldy6rozdpsdps6bf@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
 <20181103070253.ajrqzs5xu2vf5stu@yavin>
 <20181104115913.74l4yzecisvtt2j5@yavin>
 <20181106171501.59ccabbc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbqkumg7gz6vi3h3"
Content-Disposition: inline
In-Reply-To: <20181106171501.59ccabbc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fbqkumg7gz6vi3h3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 4 Nov 2018 22:59:13 +1100
> Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> > The same issue is present in __save_stack_trace
> > (arch/x86/kernel/stacktrace.c). This is likely the only reason that --
> > as Steven said -- stacktraces wouldn't work with ftrace-graph (and thus
> > with the refactor both of you are discussing).
>=20
> By the way, I was playing with the the orc unwinder and stack traces
> from the function graph tracer return code, and got it working with the
> below patch. Caution, that patch also has a stack trace hardcoded in
> the return path of the function graph tracer, so you don't want to run
> function graph tracing without filtering.

Neat!

> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 169b3c44ee97..aaeca73218cc 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -242,13 +242,16 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *tr=
ace, unsigned long *ret,
>  	trace->calltime =3D current->ret_stack[index].calltime;
>  	trace->overrun =3D atomic_read(&current->trace_overrun);
>  	trace->depth =3D index;
> +
> +	trace_dump_stack(0);

Right, this works because save_stack is not being passed a pt_regs. But if
you pass a pt_regs (as happens with bpf_getstackid -- which is what
spawned this discussion) then the top-most entry of the stack will still
be a trampoline because there is no ftrace_graph_ret_addr call.

(I'm struggling with how to fix this -- I can't figure out what retp
should be if you have a pt_regs. ->sp doesn't appear to work -- it's off
by a few bytes.)

I will attach what I have at the moment to hopefully explain what the
issue I've found is (re-using the kretprobe architecture but with the
shadow-stack idea).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--fbqkumg7gz6vi3h3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvj6cQACgkQSnvnv3De
m58C0hAAvEHGmh6w7VmGXJDnLfSS/kpa71QhInmQkbSFBUXSzOnQrkkV1Vf0Yizf
t4tQNm1qlTCpcu00HUTSL55h5tePtQ20qk9RXk8EIWDIyndV2mVgVmovVQtb2DBY
0JWOH7hzy7Z1n3RJQOYCeduXyme1z9AsoVJtJ9+VTdV/oe/X1i9WyulgcdFwYoOB
eEFKvhwOlPdEcQ3xo5FxSVMX+R7OQUDAbHE+KkkAn4DaSxwUP6pcax0aFCbUmbVl
8aD9D3ct7ewz8WtigDbGbqXmGARflCNU7VQJXGac0odEmIwqj2HVRTq2GWxJwqsS
WNJA0MiUDyMAiC1FG8WZCutgg0X+daqGQU9fLoMjXjhgwQxX1sJQLBfyuVIwul+j
sCs1dQ0Q1gLuEDIbCNfyAaesZMc6RrMB/iyZgcPPTYpYr1SSl13wsLoGVLUHIvZS
+9MDwZ/qCbPSEMwWOKJEA0Rh/KfoUgyMtuka1rnxotUs3AlDtoX1U2S8kCeGU/Op
BrcTbbjSv9+iV/EMyONNivjeV/zkzq7KJv0gIHCG++0L4p0A4VCeQYG1Ls3e+v/9
oXUT5PZVl78IRCgK7frUx/azVi2GkmdyPUro2OxUZ4bqoDc7wwZQzBgW6udVdBNZ
UVas+6o2RTwV7Gk2YUGGAkaJdQVAUH506raaSs0aEan6JhEoSQI=
=uQf+
-----END PGP SIGNATURE-----

--fbqkumg7gz6vi3h3--
