Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BD120663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BD120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeJVXpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:45:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:40016 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeJVXpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:45:21 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 799ACA11BA;
        Mon, 22 Oct 2018 17:26:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 64oQSpoWh24N; Mon, 22 Oct 2018 17:26:16 +0200 (CEST)
Date:   Tue, 23 Oct 2018 02:26:12 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [RFC] Merging ftrace_stack, perf_callchain, oprofile->backtrace
 and stack_trace
Message-ID: <20181022152612.ex5hkipgm5uzjrt5@ryuk>
References: <20181021093106.mhjpb2rnx6kstjki@ryuk>
 <20181021201358.GF4931@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7kf34kg5qgdazn6"
Content-Disposition: inline
In-Reply-To: <20181021201358.GF4931@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7kf34kg5qgdazn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-21, Peter Zijlstra <peterz@infradead.org> wrote:
> > Hi all,
> >=20
> > I'm currently working on a patchset to make kretprobes produce
> > reasonable stack traces[1], and it appears this is a generic problem
> > across the entire kernel -- you can see the same kretprobe_trampoline()
> > issue when using ftrace just as much as bpf_trace.
> >=20
> > However, in working on this patch, I've noticed that there appear to be
> > several different implementations of "get the stack trace from this
> > pt_regs" which all appear quite similar. Namely:
> >=20
> >   * struct ftrace_stack;
> >   * struct perf_callchain_entry; [**]
> >   * struct stack_trace;
>=20
> the perf thing also does userspace stack, where the others do not afaik.

Ah right, I forgot about that. Though I wonder whether there would be a
strong argument against extending 'struct stack_trace' to contain the
ustack so we could use it then.

> And for the kernel part it already uses the regular kernel unwinder.
> I'm not sure what you're proposing.

They do use the kernel unwinder, but they are both implemented
per-architecture and use different structures to store and represent the
stack trace (even though at the end of the day they are just an array of
longs).

oprofile for instance (appears to) reimplement the following code
per-architecture:

  struct stack_trace trace;
  save_stack_trace(&trace);
  print_stack_trace(&trace, 0);

The same applies for perf_callchain_entry which is all implemented
per-architecture even though get_perf_callchain_kernel() could just
re-use save_stack_trace_regs().

But after looking at this a bit more, I think I'll write a patch which
does this the "silly" way and then I'll see whether maintainers prefer
it to be refactored.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--w7kf34kg5qgdazn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvN7BMACgkQnhiqJn3b
jbSM7g//QbG1AvVQCwBpkR4KFSyFIN80VeTSTmbSgRm0zJutZmEL2Swd2RIMi5i1
f/Ymd3SDbE3T91MLFNum1zb6rMB0sPNkbZez87WUI9ow8KIn8Q1Kb61Pp30sjJMG
7grfIV93cG3pNhY9Cuq10AnOUvEgIIxmqOMlx+5qJppGcrvSAZ4HsB+cgHh8kgp1
WNJe0PcfpUxFqetT2qdJESyPwTROdxG6mBXfM46LpYthbW0DNCU5XXaUzx3IPNAa
wax+8ll1+UAdrpWTXmdKyN9RgYQFVwm9M9vwVfFNK7Wf7yJQXgAjqJDRXW0EuYAa
G3fhKg9DkYsbnESxoG/XM6XWkTTIGj1qXSC49ieOhzv5Bi4JxIW2+PUjSddG5iBB
QB9bJx32bWK5CScSUVb8SV9ZFxUX9N0LcOSRRAR6r4d3h9cLUythi2XcnRYPiUea
vYb46751qiiqZjBTX+cTia/vUACevoFhIb5xEtKlHaCE4SlBhialOH2tmTOfpcgr
faJe4SRliSA0mR8JK6H9/wBFuV3BsS24FaNepjvB3DW3PCzvxCNUNSI8bpJ9I5fY
WgMqfp3BNJYg9sz8jpEIzgHDl9q2bxkat67j3qvr2smSgz22FM26LT/kBr40tvrQ
HU9fGTu53y7uR+FyR81ZuWniTrONZ7ErkG2D+tYMXPDknodpOqQ=
=YvRk
-----END PGP SIGNATURE-----

--w7kf34kg5qgdazn6--
