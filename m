Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9DFC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE37B20685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE37B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeKDVOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:14:17 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:20968 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeKDVOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:14:17 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D930B40555;
        Sun,  4 Nov 2018 12:59:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id NdV5wkatz1zb; Sun,  4 Nov 2018 12:59:28 +0100 (CET)
Date:   Sun, 4 Nov 2018 22:59:13 +1100
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
Message-ID: <20181104115913.74l4yzecisvtt2j5@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
 <20181102065932.bdt4pubbrkvql4mp@yavin>
 <20181102091658.1bc979a4@gandalf.local.home>
 <20181103070253.ajrqzs5xu2vf5stu@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2yaciluwfpe2adhl"
Content-Disposition: inline
In-Reply-To: <20181103070253.ajrqzs5xu2vf5stu@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2yaciluwfpe2adhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-03, Aleksa Sarai <cyphar@cyphar.com> wrote:
> This is actually a general bug in ftrace as well, because (for
> instance) while the unwinder calls into ftrace_graph_ret_addr() while
> walking up the stack this isn't used to correct regs->ip in
> perf_callchain_kernel(). I think this is the cause of the bug in
> ftrace-graph (if you switch to the "frame" unwinder you might be able
> to see it more clearly) -- but when trying to fix it I'm having
> trouble figuring out what retp should be (stack_addr(regs) doesn't
> give the right result for some reason).

@Steven, @Masami: Can you verify whether this is an actual bug? The
snippet is like (arch/x86/events/core.c):

  void
  perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_r=
egs *regs)
  {
    /* ... */
	if (perf_callchain_store(entry, regs->ip))
		return;
	/* rest of unwind code */
  }

And it seems to me that there's an ftrace_graph_ret_addr missing here
(though I was having trouble figuring out what the right retp would be
in this context -- both stack_addr(regs) and &regs->sp appear to be
wrong when I was trying to get this to work with kretprobes -- while my
patch worked with all other kretprobe_trampoline cases in the unwinder).

The same issue is present in __save_stack_trace
(arch/x86/kernel/stacktrace.c). This is likely the only reason that --
as Steven said -- stacktraces wouldn't work with ftrace-graph (and thus
with the refactor both of you are discussing).

Thanks.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2yaciluwfpe2adhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlve3w4ACgkQSnvnv3De
m58I4g/8CFItPEhmf9/ruSZ+czcVr2kRsDAJsGofWkgUuGd3HTou7U2/r0xvZeDF
1XgpwSWDxwkTrEumRZOQDaCjLwIrXqOBi8l12pEiTPC7V4hkxkzeUZpoh5UzgO7O
Tr9T/aW/5Tdqu93PJgX0ky2ECc6n4SJB8F2GDBZkVrRQoemFf3ulWWYWvUnrNk8y
8vxNrx4WoGYle32T9kTPwgQhReB86vyMSUZW3SjT1mLkIkqIf01hWHRefX8E66Ot
DFQB7OG6ep4mQsbKuekWJ0DtCUY4u7T98EmhtFq6bQ53L5BmTmKSiiE0z6HF+iJB
N1sGnkVyHIRNgjGxbchR8uxdJCpLg+MWM9rxpkMc4JWtQkTSoCRHXKnHMfYWOhN5
N4+xijxq4lCfJwXShKJNeFFOwM66rwls3KVEzUKcojn5H+UXxmR84SyWrhFHYnB0
5FSmJzvQcypLyuJuinxOt0EBXbQ6uDW5pgsFfWRcbfEu72VSXOZi+1AaAaYlBv3C
zV//7hYQhzwd0FZoBinr2ukKqmQcy1w+2oUVeHckWU3NsXS0V02pSqna85Hzv6ce
m82UwtpLUPcRtH53M7nmdwy4nOcAyPuuxGsscMfi0p+Fwc2i6R10Npr2wZ7/3zi8
Hbkss2B5r+YHW2YMiQGSUnfnB93LjnafPasol5iLWJFldcSdvl4=
=AUFA
-----END PGP SIGNATURE-----

--2yaciluwfpe2adhl--
