Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC042C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712C32081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712C32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeKBOLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 10:11:25 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:8428 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKBOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 10:11:25 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 03941A1107;
        Fri,  2 Nov 2018 06:05:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 5888h3bBCDBv; Fri,  2 Nov 2018 06:05:24 +0100 (CET)
Date:   Fri, 2 Nov 2018 16:05:09 +1100
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
Message-ID: <20181102050509.tw3dhvj5urudvtjl@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gjrsgidzixwxeap"
Content-Disposition: inline
In-Reply-To: <20181101204720.6ed3fe37@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6gjrsgidzixwxeap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-01, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu,  1 Nov 2018 19:35:50 +1100
> Aleksa Sarai <cyphar@cyphar.com> wrote:
> > @@ -1834,6 +1853,11 @@ static int pre_handler_kretprobe(struct kprobe *=
p, struct pt_regs *regs)
> >  		ri->rp =3D rp;
> >  		ri->task =3D current;
> > =20
> > +		trace.entries =3D &ri->entry.entries[0];
> > +		trace.max_entries =3D KRETPROBE_TRACE_SIZE;
> > +		save_stack_trace_regs(regs, &trace);
> > +		ri->entry.nr_entries =3D trace.nr_entries;
> > +
>=20
> So basically your saving a copy of the stack trace for each probe, for
> something that may not ever be used?
>=20
> This adds quite a lot of overhead for something not used often.
>=20
> I think the real answer is to fix kretprobes (and I just checked, the
> return call of function graph tracer stack trace doesn't go past the
> return_to_handler function either. It's just that a stack trace was
> never done on the return side).
>=20
> The more I look at this patch, the less I like it.

That's more than fair.

There's also an issue that Masami noted -- nested kretprobes don't give
you the full stack trace with this solution since the stack was already
overwritten. I think that the only real option is to fix the unwinder to
work in a kretprobe context -- which is what I'm looking at now.

Unfortunately, I'm having a lot of trouble understanding how the current
ftrace hooking works -- ORC has a couple of ftrace hooks that seem
reasonable on the surface but I don't understand (for instance) how
HAVE_FUNCTION_GRAPH_RET_ADDR_PTR *actually* works. Though your comment
appears to indicate that it doesn't work for stack traces?

For kretprobes I think it would be fairly easy to reconstruct what
landed you into a kretprobe_trampoline by walking the set of
kretprobe_instances (since all new ones are added to the head, you can
get the real return address in-order).

But I still have to figure out what is actually stopping the
save_stack_trace() unwinder that isn't stopping the show_stacks()
unwinder (though the show_stacks() code is more ... liberal with the
degree of certainty it has about the unwind).

Am I barking up the wrong tree?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6gjrsgidzixwxeap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvb2wIACgkQSnvnv3De
m5+l3A/9G/bIFwCfq09RMkpdTMo9ODJiwOqb+JS0KFwOpNNoapaT9gDPymIMbJzu
F7kjiIfbtzWlodDjIBqU2hMLMvFrSrKK38kEyOFXYpVd5hvqX+U7CEV7LM3a+Gt8
eRxUqbWQDochrJVOVyNGJYdB0yGlHFlJYisYejQKKlr18p1h5xM7zWgbhxzbM3I4
LewMrs1i5PuVgAfux5xscHJ9kkFP2bhQsC9LDeFNVTGaCmL4+ebSEBdAz2y678eh
rO+Pv/URk/wqL6jbSNb5LJguYP892mK7Ezsmhw4k+6IfwrWavlLvok8WRr5GKLqU
jF3C4H/1VJsBwSx/sCgw9WCWNvKrwGjyAQDmlGJmbLpK9PyO4mh4VtYFpDQAYbVi
YfxgtP6IFTguzDY1gLD2ruzfHcKkhqVnR2VitqtsUZY4amRIdJbNnj7+tS/87Opk
cO4x8cLgh+fbNKN/CVEa18+2HC+710lKlApjKmOs+s8LH/kZJ3VtuheT9b14RXPE
0P/BjM4T5kixY2VaxTUdmxgQmcq02O9fMrWIAuJPLjVpT7smGVcOmWbseGWf4kmU
mz+qcvlWIJFA91O5xfK2kNOUwtMha8+Z8WsjYWfk4P6vHuGwn/zyXyIhFJ7kpOXJ
7VK0+zZnfqszf9Mf4RwZDCt8PcQPJ1m9r4tbVavf8wKFSdGceAk=
=ipcF
-----END PGP SIGNATURE-----

--6gjrsgidzixwxeap--
