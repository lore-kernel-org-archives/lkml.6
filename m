Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E3C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0155F2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 07:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0155F2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeKCQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:13:34 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:28644 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeKCQNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:13:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7F3FB405F2;
        Sat,  3 Nov 2018 08:03:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 5iRs-YLNZsni; Sat,  3 Nov 2018 08:03:08 +0100 (CET)
Date:   Sat, 3 Nov 2018 18:02:53 +1100
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
Message-ID: <20181103070253.ajrqzs5xu2vf5stu@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o3pji34sj5yzq7vq"
Content-Disposition: inline
In-Reply-To: <20181102091658.1bc979a4@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o3pji34sj5yzq7vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Steven Rostedt <rostedt@goodmis.org> wrote:
> > As an aside, I just tested with the frame unwinder and it isn't thrown
> > off-course by kretprobe_trampoline (though obviously the stack is still
> > wrong). So I think we just need to hook into the ORC unwinder to get it
> > to continue skipping up the stack, as well as add the rewriting code for
> > the stack traces (for all unwinders I guess -- though ideally we should
>=20
> I agree that this is the right solution.
>=20
> > do this without having to add the same code to every architecture).
>=20
> True, and there's an art to consolidating the code between
> architectures.
>=20
> I'm currently looking at function graph and seeing if I can consolidate
> it too. And I'm also trying to get multiple uses to hook into its
> infrastructure. I think I finally figured out a way to do so.
>=20
> The reason it is difficult, is that you need to maintain state between
> the entry of a function and the exit for each task and callback that is
> registered. Hence, it's a 3x tuple (function stack, task, callbacks).
> And this must be maintained with preemption. A task may sleep for
> minutes, and the state needs to be retained.
>=20
> The only state that must be retained is the function stack with the
> task, because if that gets out of sync, the system crashes. But the
> callback state can be removed.
>=20
> Here's what is there now:
>=20
>  When something is registered with the function graph tracer, every
>  task gets a shadowed stack. A hook is added to fork to add shadow
>  stacks to new tasks. Once a shadow stack is added to a task, that
>  shadow stack is never removed until the task exits.
>=20
>  When the function is entered, the real return code is stored in the
>  shadow stack and the trampoline address is put in its place.
>=20
>  On return, the trampoline is called, and it will pop off the return
>  code from the shadow stack and return to that.

I was playing with a toy version of this using the existing kretprobe
architecture (by borrowing the shadow stack concept of storing the
stack_addr() -- though it's actually stored inside the existing
kretprobe_instance and thus doesn't need separate push-pop code).

The rewriting of kretprobe_trampoline in the stack unwinder *works* on
x86 now except for the regs handling (the current function is still
incorrectly shown as kretprobe_trampoline). This is actually a general
bug in ftrace as well, because (for instance) while the unwinder calls
into ftrace_graph_ret_addr() while walking up the stack this isn't used
to correct regs->ip in perf_callchain_kernel(). I think this is the
cause of the bug in ftrace-graph (if you switch to the "frame" unwinder
you might be able to see it more clearly) -- but when trying to fix it
I'm having trouble figuring out what retp should be (stack_addr(regs)
doesn't give the right result for some reason).

I will try to fix it up and attach it, but if you're already working on
a prototype the unifies all the users that works too. The patch I have
at the moment duplicates each of the key ftrace_graph_return_addr
invocations with a matching kretprobe_return_addr (though there's only
three of these).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--o3pji34sj5yzq7vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvdSB0ACgkQSnvnv3De
m58Z2hAAiP2I/PBiup+H7hbA8daKL7z2l5TXW3E6DYhpblBysAaAnmxc+je0Ukvm
Ma8QQRbQ1Z5ffu+HThgOFJ0LcuwkwRaVJY48wM9R2cCpUbDahcJ4tOqs/G5H3tX0
gD0A2GYW9h30y1/YeR5isHRqP6AA1yjNmoREvuIaCjQKjyClruUNX7qCAuIqkwR4
E9KbG8dlXiPW7zeQZD4fYDmgBpGv1S/Yn9ZwDz5i13bgPeQz9NyGHtAApFzSBiYv
nHZ5L//idGbQcUwekjNWL57QAcRpf53T3eC5I8G0lyM15EJhyOJo44OYJ9gb2LfI
fvRHnZAikto/F6et9Td7m7krvIYuq/RTePt/DQjsq/Q1wK5Gbf0vmn1lxP6PVBf2
c3+kZakkmvpv+LXpSHmCadYhZ0z+TqeFkXI5ts3DIG7TkYnuXgYQCAqIOqwe3YU5
FjZLf6MhZtz+5NskRzUFhMWj1UJM5zSw+QhWndZ3sLmQ2/Qo6b+8HP5CuhVLIL0H
RvdkqBMuPEMM6MkLK3wludxfbKOT9C0AGKV5/d25GzAdiueDfPy8xGiZXG/ddtg/
0ObEqnAdE/yqEowhQrcjvQkGlAlGHNrNfM2eH0hnP621Ab5sUIhpkQVqmv1N7ozs
xUeamYbI8BTp59hxefgf3UgdGc57ViyBNXiTGzWbFCQKH2PbX2s=
=TZjX
-----END PGP SIGNATURE-----

--o3pji34sj5yzq7vq--
