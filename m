Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE80C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B90208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B90208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKJApv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:45:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:58982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728190AbeKJApv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:45:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 088A4AC11;
        Fri,  9 Nov 2018 15:04:50 +0000 (UTC)
Date:   Sat, 10 Nov 2018 02:06:29 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
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
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181109150629.wpedwxsgbftkl3ab@mikami>
References: <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
 <20181103070253.ajrqzs5xu2vf5stu@yavin>
 <20181104115913.74l4yzecisvtt2j5@yavin>
 <20181106171501.59ccabbc@gandalf.local.home>
 <20181108074612.ldy6rozdpsdps6bf@yavin>
 <20181108080448.rggfn4zawi3por23@yavin>
 <20181109161551.6b96bd7d932c71432ac65e83@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dlusgdlwys367xnp"
Content-Disposition: inline
In-Reply-To: <20181109161551.6b96bd7d932c71432ac65e83@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlusgdlwys367xnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-09, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrac=
e.h
> > index ee696efec99f..c4dfafd43e11 100644
> > --- a/arch/x86/include/asm/ptrace.h
> > +++ b/arch/x86/include/asm/ptrace.h
> > @@ -172,6 +172,7 @@ static inline unsigned long kernel_stack_pointer(st=
ruct pt_regs *regs)
> >  	return regs->sp;
> >  }
> >  #endif
> > +#define stack_addr(regs) ((unsigned long *) kernel_stack_pointer(regs))
>=20
> No, you should use kernel_stack_pointer(regs) itself instead of stack_add=
r().
>=20
> >=20
> >  #define GET_IP(regs) ((regs)->ip)
> >  #define GET_FP(regs) ((regs)->bp)
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/c=
ore.c
> > index b0d1e81c96bb..eb4da885020c 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -69,8 +69,6 @@
> >  DEFINE_PER_CPU(struct kprobe *, current_kprobe) =3D NULL;
> >  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> > =20
> > -#define stack_addr(regs) ((unsigned long *)kernel_stack_pointer(regs))
>=20
> I don't like keeping this meaningless macro... this should be replaced wi=
th generic
> kernel_stack_pointer() macro.

Sure. This patch was just an example -- I can remove stack_addr() all
over.

> > -	if (regs)
> > -		save_stack_address(trace, regs->ip, nosched);
> > +	if (regs) {
> > +		/* XXX: Currently broken -- stack_addr(regs) doesn't match entry. */
> > +		addr =3D regs->ip;
>=20
> Since this part is for storing regs->ip as a top of call-stack, this
> seems correct code. Stack unwind will be done next block.

This comment was referring to the usage of stack_addr(). stack_addr()
doesn't give you the right result (it isn't the address of the return
address -- it's slightly wrong). This is the main issue I was having --
am I doing something wrong here?

> > +		//addr =3D ftrace_graph_ret_addr(current, &state.graph_idx, addr, st=
ack_addr(regs));
>=20
> so func graph return trampoline address will be shown only when unwinding=
 stack entries.
> I mean func-graph tracer is not used as an event, so it never kicks stack=
dump.

Just to make sure I understand what you're saying -- func-graph trace
will never actually call __ftrace_stack_trace? Because if it does, then
this code will be necessary (and then I'm a bit confused why the
unwinder has func-graph trace code -- if stack traces are never taken
under func-graph then the code in the unwinder is not necessary)

My reason for commenting this out is because at this point "state" isn't
initialised and thus .graph_idx would not be correctly handled during
unwind (and it's the same reason I commented it out later).

> > +		addr =3D kretprobe_ret_addr(current, addr, stack_addr(regs));
>=20
> But since kretprobe will be an event, which can kick the stackdump.
> BTW, from kretprobe, regs->ip should always be the trampoline handler,=20
> see arch/x86/kernel/kprobes/core.c:772 :-)
> So it must be fixed always.

Right, but kretprobe_ret_addr() is returning the *original* return
address (and we need to do an (addr =3D=3D kretprobe_trampoline)). The
real problem is that stack_addr(regs) isn't the same as it is during
kretprobe setup (but kretprobe_ret_addr() works everywhere else).

> > @@ -1856,6 +1870,41 @@ static int pre_handler_kretprobe(struct kprobe *=
p, struct pt_regs *regs)
> >  }
> >  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> > =20
> > +unsigned long kretprobe_ret_addr(struct task_struct *tsk, unsigned lon=
g ret,
> > +				 unsigned long *retp)
> > +{
> > +	struct kretprobe_instance *ri;
> > +	unsigned long flags =3D 0;
> > +	struct hlist_head *head;
> > +	bool need_lock;
> > +
> > +	if (likely(ret !=3D (unsigned long) &kretprobe_trampoline))
> > +		return ret;
> > +
> > +	need_lock =3D !kretprobe_hash_is_locked(tsk);
> > +	if (WARN_ON(need_lock))
> > +		kretprobe_hash_lock(tsk, &head, &flags);
> > +	else
> > +		head =3D kretprobe_inst_table_head(tsk);
>=20
> This may not work unless this is called from the kretprobe handler contex=
t,
> since if we are out of kretprobe handler context, another CPU can lock the
> hash table and it can be detected by kretprobe_hash_is_locked();.

Yeah, I noticed this as well when writing it (but needed a quick impl
that I could test). I will fix this, thanks!

By is_kretprobe_handler_context() I imagine you are referring to
checking is_kretprobe(current_kprobe())?

> So, we should check we are in the kretprobe handler context if tsk =3D=3D=
 current,
> if not, we definately can lock the hash lock without any warning. This can
> be something like;
>=20
> if (is_kretprobe_handler_context()) {
>   // kretprobe_hash_lock(current =3D=3D tsk) has been locked by caller =
=20
>   if (tsk !=3D current && kretprobe_hash(tsk) !=3D kretprobe_hash(current=
))
>     // the hash of tsk and current can be same.
>     need_lock =3D true;
> } else
>   // we should take a lock for tsk.
>   need_lock =3D true;

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--dlusgdlwys367xnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvlonIACgkQnhiqJn3b
jbSbFQ//SnJ9X96iLygU7suh6KaaaKt6o/NfaDYXPcWMVlPxkktF7hRIVeWllsf3
hfq9/jqfsd84rFUM4hYQPkWfMS5J3kkjjDMpTe+q1Qn7blVxRNg2BqxcfU7dvIxH
QRzMjhxNkqHuvbKRS9+j6JxmH0cvW7rrkA8hzLNGDKGMzE4SHBqJaDc7IO7Y4qyF
Jg53Hm4wIIcZ52bl46eHCsp9enHT3Tb8BOR7bVu/isO2xkYBfh8AHE6lKU2fDSm1
X9NbUcY7Gl9Vfc/317iAZsu6EyDtkj38YxKk/+8b7VFr3m5DiV/1DuXws/WvWhdG
uP8KjrGHaaqaunJuRVcltoBVyc3b/A5aZaXHNV+9BbOmCud9hMEzPrhKkoxx9pa/
qteMUntR5huO6LDnmdhdJMHPqCp1+hVpITKhsxS1bDbNb1XFrdqKLvJxds3pUMjo
dlpCTpfixkUTSghqMsHIpGm5KZvDDHbbpgCIGQtjvnxMz5IapODidznY9++otN2K
ybxkGDeq8e7JU0BSEvWhnP3ty0Cv/q6dJO5KmVXLGFXC3Tcvo6rQajeW9zRk/qYu
ANvpQbc5C/a1XYXmRfyERKEgMMwysLR48oyoxPY2kSzXo/khBLgR0uR84hKblRNh
g0h9MGH0mE94AMPA3Z7RqMBxmYwmlfKOYRBqTyP9TnGlCQ4ubeo=
=JgGw
-----END PGP SIGNATURE-----

--dlusgdlwys367xnp--
