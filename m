Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11665C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FF92064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FF92064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJ3MLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:11:52 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34908 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeJ3MLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:11:51 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 70605A103F;
        Tue, 30 Oct 2018 04:20:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id h5TYESYlst3T; Tue, 30 Oct 2018 04:20:07 +0100 (CET)
Date:   Tue, 30 Oct 2018 14:19:53 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-ID: <20181030031953.5petvkbt45adewdt@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
 <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="unl4yk5o34rxufjm"
Content-Disposition: inline
In-Reply-To: <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unl4yk5o34rxufjm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-30, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > Historically, kretprobe has always produced unusable stack traces
> > (kretprobe_trampoline is the only entry in most cases, because of the
> > funky stack pointer overwriting). This has caused quite a few annoyances
> > when using tracing to debug problems[1] -- since return values are only
> > available with kretprobes but stack traces were only usable for kprobes,
> > users had to probe both and then manually associate them.
>=20
> Yes, this unfortunately still happens. I once tried to fix it by
> replacing current "kretprobe instance" with graph-tracer's per-thread
> return stack. (https://lkml.org/lkml/2017/8/21/553)

I played with graph-tracer a while ago and it didn't appear to have
associated return values? Is this hidden somewhere or did I just miss
it?

> I still believe that direction is the best solution to solve this kind
> of issues, otherwise, we have to have 2 different stack fixups for
> kretprobe and ftrace graph tracer. (I will have a talk with Steve at
> plumbers next month)

I'm definitely :+1: on removing the duplication of the stack fixups, my
first instinct was to try to refactor all of the stack_trace code so
that we didn't have multiple arch-specific "get the stack trace" paths
(and so we could generically add current_kretprobe_instance() to one
codepath). But after looking into it, I was convinced this would be more
than a little ugly to do.

> > With the advent of bpf_trace, users would have been able to do this
> > association in bpf, but this was less than ideal (because
> > bpf_get_stackid would still produce rubbish and programs that didn't
> > know better would get silly results). The main usecase for stack traces
> > (at least with bpf_trace) is for DTrace-style aggregation on stack
> > traces (both entry and exit). Therefore we cannot simply correct the
> > stack trace on exit -- we must stash away the stack trace and return the
> > entry stack trace when it is requested.
> >=20
> > In theory, patches like commit 76094a2cf46e ("ftrace: distinguish
> > kretprobe'd functions in trace logs") are no longer necessary *for
> > tracing* because now all kretprobe traces should produce sane stack
> > traces. However it's not clear whether removing them completely is
> > reasonable.
>=20
> Then, let's try to revert it :)

Sure. :P

> BTW, could you also add a test case for ftrace too?
> also, I have some comments below.

Yup, will do.

> > +#define KRETPROBE_TRACE_SIZE 1024
> > +struct kretprobe_trace {
> > +	int nr_entries;
> > +	unsigned long entries[KRETPROBE_TRACE_SIZE];
> > +};
>=20
> Hmm, do we really need all entries? It takes 8KB for each instances.
> Note that the number of instances can be big if the system core number
> is larger.

Yeah, you're right this is too large for a default.

But the problem is that we need it to be large enough for any of the
tracers to be happy -- otherwise we'd have to dynamically allocate it
and I had a feeling this would be seen as a Bad Idea=E2=84=A2 in the kprobe
paths.

  * ftrace uses PAGE_SIZE/sizeof(u64) =3D=3D 512 (on x86_64).
  * perf_events (and thus BPF) uses 127 as the default but can be
    configured via sysctl -- and thus can be unbounded.
  * show_stack(...) doesn't appear to have a limit, but I might just be
    misreading the x86-specific code.

As mentioned above, the lack of consensus on a single structure for
storing stack traces also means that there is a lack of consensus on
what the largest reasonable stack is.

But maybe just doing 127 would be "reasonable"?

(Athough, dynamically allocating would allow us to just use 'struct
stack_trace' directly without needing to embed a different structure.)

> > +	hlist_for_each_entry_safe(iter, next, head, hlist) {
>=20
> Why would you use "_safe" variant here? if you don't modify the hlist,
> you don't need to use it.

Yup, my mistake.

> > +void kretprobe_save_stack_trace(struct kretprobe_instance *ri,
> > +				struct stack_trace *trace)
> > +{
> > +	int i;
> > +	struct kretprobe_trace *krt =3D &ri->entry;
> > +
> > +	for (i =3D trace->skip; i < krt->nr_entries; i++) {
> > +		if (trace->nr_entries >=3D trace->max_entries)
> > +			break;
> > +		trace->entries[trace->nr_entries++] =3D krt->entries[i];
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(kretprobe_save_stack_trace);
> > +
> > +void kretprobe_perf_callchain_kernel(struct kretprobe_instance *ri,
> > +				     struct perf_callchain_entry_ctx *ctx)
> > +{
> > +	int i;
> > +	struct kretprobe_trace *krt =3D &ri->entry;
> > +
> > +	for (i =3D 0; i < krt->nr_entries; i++) {
> > +		if (krt->entries[i] =3D=3D ULONG_MAX)
> > +			break;
> > +		perf_callchain_store(ctx, (u64) krt->entries[i]);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(kretprobe_perf_callchain_kernel);
>=20
>=20
> Why do we need to export these functions?

That's a good question -- I must've just banged out the EXPORT
statements without thinking. I'll remove them in v2.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--unl4yk5o34rxufjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvXzdUACgkQSnvnv3De
m58ZeA//XvVrDhEbPziCxnA/9X2okNsPPon9p/R1APZHR3Zz6aukGUsmqJaR1KYn
Dt6AKJ1MtHdyHBG+5PsXU915z3mJihTX8Mknl+kdD4QDe++jmW0u6uUMDsdTsicv
UuPsaeOZPOC0Kj15izjmpQMryM032wOV4j57GR0ViPmYHaeO8PaeXFTliLNd1UXM
hi+ysXLmQYk2Vmxbba4rXAtRd4cUzvyCiSgwAv8rD1c9GzgE7U78KJ7hJgLKTbUA
mnVp7ip720eyzZsWpPM6BaO+LASAO59VN/++QNMSjolqKBYDIyybyctXf4DQmdmH
OGVw+9VYJ58LHt2fxtOYpgJt1PCD1hrx/8Yxkri2MmWOJ0K1dKqMN3AEwVLYzzRI
3q4kxOU4QfIKhg54yH1YoQNwunH63obzAxVyVOCenAbSOTPhLnM4QPdFifJ+7fTY
iF1n5y2WaFtbhMypu/Av/IV2xAN13oCLRhRZdE4/CdQyf4axjfNEzHkHI0a0eK5w
02PYNCg/Hhi9dmX1WI2eKgwb0jvIdnoYlzDIeEB7l55YiRxSvbM/YKUrns7EWLLK
i1JC4sbdKaU1GvpDiA1BQer5M3hGgz9mC8/bfGSFAyP8geFc+44y+ZvC2KC/jDzY
wdZ+2MCY3oV4wzCI8K3ndhXjOBdnH/4RMDP9NQs7u9PafJHssYI=
=vJhx
-----END PGP SIGNATURE-----

--unl4yk5o34rxufjm--
