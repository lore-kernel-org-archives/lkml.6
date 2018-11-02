Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E9EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99BA2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99BA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKBQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:06:01 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:50852 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeKBQGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:06:00 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9F72B4B39A;
        Fri,  2 Nov 2018 07:59:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id N6g6TMfkTEix; Fri,  2 Nov 2018 07:59:47 +0100 (CET)
Date:   Fri, 2 Nov 2018 17:59:32 +1100
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
Message-ID: <20181102065932.bdt4pubbrkvql4mp@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
 <20181101083551.3805-2-cyphar@cyphar.com>
 <20181101204720.6ed3fe37@vmware.local.home>
 <20181102050509.tw3dhvj5urudvtjl@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kv2w2345ipyd7tq"
Content-Disposition: inline
In-Reply-To: <20181102050509.tw3dhvj5urudvtjl@yavin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kv2w2345ipyd7tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-11-02, Aleksa Sarai <cyphar@cyphar.com> wrote:
> For kretprobes I think it would be fairly easy to reconstruct what
> landed you into a kretprobe_trampoline by walking the set of
> kretprobe_instances (since all new ones are added to the head, you can
> get the real return address in-order).
>=20
> But I still have to figure out what is actually stopping the
> save_stack_trace() unwinder that isn't stopping the show_stacks()
> unwinder (though the show_stacks() code is more ... liberal with the
> degree of certainty it has about the unwind).

As an aside, I just tested with the frame unwinder and it isn't thrown
off-course by kretprobe_trampoline (though obviously the stack is still
wrong). So I think we just need to hook into the ORC unwinder to get it
to continue skipping up the stack, as well as add the rewriting code for
the stack traces (for all unwinders I guess -- though ideally we should
do this without having to add the same code to every architecture).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3kv2w2345ipyd7tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvb9dEACgkQSnvnv3De
m58HVQ/9GjCMyDH7P29NqoKKhHNNyeyu64COmyciYvp58xSTJH+37yiVdMsL5evE
FgRwPYWxVY0pFe8i8yfxeaiFsWN4KJDelldTKY5o2yD91tuD/g1s8zWqri8UOVYW
0+sdchSV15VcAwt21fnoFkGTFIYYJ6DtKI6mG3bxdVeNF/A7tPgZQ7mYJKlNWWKS
jioKf6i/AkojePH5LVofA+6wwvGQe/pyV1mHIx17AN71P9fAvn5tEW6I8e97W0my
FArFkLbYhpkk3p2rOxOKFLPqaxyQQ8lyCpSRnI/kGIYBHP7sUrplddVO9gHpLo9i
8OOj4/AyEzcK8Af9FweN8e57j/bUeEjR8Sdth8MH4ie6EC/N7129lWoCloUF3erJ
XBrDtGog68p6r+L/s2k8AId8/eUnnjIaK/hoGw1NtPN6HBDunm899ufEnn8ADXJI
hbKqMGhyUvItay/V8iZgufNfcJ8ZfaidkfvHLvRGz9lrjA27jR0OWwSjmPnvyA8i
inNkW6rdLVO5EVjg5LolS2YKOXBTya/6ViCnA39HV+8b4oagTblJJBkw4sVoyaKQ
IEbBAx9x3OFPK4Cnw1IG5wtoFp9RMCBO+XdKOkO3cKmlXSuD8D24HIzRWJD6M0ni
8iz59eUZrbB42sgen64CzJvPROtxQvdB1tvrsZ6vn/NeSsWfBs4=
=+Zfh
-----END PGP SIGNATURE-----

--3kv2w2345ipyd7tq--
