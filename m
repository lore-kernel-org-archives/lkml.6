Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7266BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3918B223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3918B223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeKLU3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:44550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeKLU3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69FFEB033;
        Mon, 12 Nov 2018 10:36:40 +0000 (UTC)
Date:   Mon, 12 Nov 2018 21:38:22 +1100
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
Message-ID: <20181112103822.ktd4fx7o4cqpfk4q@mikami>
References: <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
 <20181103070253.ajrqzs5xu2vf5stu@yavin>
 <20181104115913.74l4yzecisvtt2j5@yavin>
 <20181106171501.59ccabbc@gandalf.local.home>
 <20181108074612.ldy6rozdpsdps6bf@yavin>
 <20181108080448.rggfn4zawi3por23@yavin>
 <20181109161551.6b96bd7d932c71432ac65e83@kernel.org>
 <20181109150629.wpedwxsgbftkl3ab@mikami>
 <20181111003137.c9df7a077d983cde57c06ee8@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7k6zcwip3nr62atq"
Content-Disposition: inline
In-Reply-To: <20181111003137.c9df7a077d983cde57c06ee8@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7k6zcwip3nr62atq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-11, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > +		addr =3D kretprobe_ret_addr(current, addr, stack_addr(regs));
> > >=20
> > > But since kretprobe will be an event, which can kick the stackdump.
> > > BTW, from kretprobe, regs->ip should always be the trampoline handler=
,=20
> > > see arch/x86/kernel/kprobes/core.c:772 :-)
> > > So it must be fixed always.
> >=20
> > Right, but kretprobe_ret_addr() is returning the *original* return
> > address (and we need to do an (addr =3D=3D kretprobe_trampoline)). The
> > real problem is that stack_addr(regs) isn't the same as it is during
> > kretprobe setup (but kretprobe_ret_addr() works everywhere else).
>=20
> I think stack_addr(regs) should be same when this is called from kretprobe
> handler context. Otherwise, yes, it is not same, but in that case, regs->=
ip
> is not kretprobe_trampoline too.

I figured it out.

It should be (regs->sp - 1) (just like it is inside the relevant
unwinder function for ORC). I now have a prototype which works under the
frame unwinder[*] -- however under ORC you can only see the top-most
function (the unwinder doesn't see the other function calls). I'm
playing with ORC hints with kretprobe_trampoline to try to improve
things but it's still a bit screwy.


[*]: However, I've noticed that the stack traces between the two traces
	 no longer match. On kprobe you get function_name+1, but on
	 kretprobe you get function_caller+foo. Obviously it's working but
	 the return address results in slightly different stack traces. This
	 means that stack trace aggregation between kprobe and kretprobe
	 won't work anymore -- at least not like it did in my original
	 patch. So I'm really not sure where to go from here.

I can send around another patchset to illustrate the problem if you like
(as well as show how the current unwinding code works).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--7k6zcwip3nr62atq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvpWBsACgkQnhiqJn3b
jbSy7A/+IEFpapcvq94nrWh9OjRuEOAjfNmAk1UzkaA7UdzuGQeqZXNI7My55evY
52fDICDJTrwUz1dJwgjqz7DBgmDUnTSVzt5/5Ypc43Z2xrYVZ0ivffA+P2y5aW6t
kXeQUhh52mMHtOsLucR/lu8OuYzZvJ8XqmOH2n93OXyX5B26KcKb7av4NT9hn4Vv
67YgTPScGt/zxk5mPTbV8lsnqU0rMWsCPZLTlXspFzwNHsPQfGcZ9avqj6h6HU7m
E3bxhCANzy2Wl9TbgKW0Mq7z5nbEyNSF26hpQh0dsFulHlN++lxpeZgBjtCvGgdX
mnLVjWtE47z2fgGRpgERa4eemZXRNLMcLbcOQwBDSuIT3bh9izXu97gQaqeVtY2C
PtnG1MG6dVmo1SzsNnmu3YZc41CGofmyc2wdssBtFnqY1rKZI73zPTgSgfNEK2V2
FqCjI4HNfYzns/pcrE7XiRUUrZnkdfEi1NmO9xRrpRP1SzZdgryCZWO5x1QMZdW0
ceN9JK6sh5ZHN64qoGXgsC51gwdPXgNrtZkEzuPA9nLeiZWi2GJEiMejN3ocMTvu
miqStmedFrJrYWbgLtK/J1ypJesnOURvU38H/OKwcQf4HkDxde115mw3AP4Wq2CT
EkJ4ataA2lfyA6IwOtprtlePn7GJl/iCD0whahftumKTWDshz7Y=
=OSID
-----END PGP SIGNATURE-----

--7k6zcwip3nr62atq--
