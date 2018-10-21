Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A1ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4619920838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4619920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJURo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:44:56 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:22674 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeJURo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:44:56 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 8CEEC4B7D7;
        Sun, 21 Oct 2018 11:31:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id AS-ZKBlWutd6; Sun, 21 Oct 2018 11:31:10 +0200 (CEST)
Date:   Sun, 21 Oct 2018 20:31:06 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>
Cc:     linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net,
        cyphar@cyphar.com
Subject: [RFC] Merging ftrace_stack, perf_callchain, oprofile->backtrace and
 stack_trace
Message-ID: <20181021093106.mhjpb2rnx6kstjki@ryuk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jpe3xsjujl3wfigt"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jpe3xsjujl3wfigt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm currently working on a patchset to make kretprobes produce
reasonable stack traces[1], and it appears this is a generic problem
across the entire kernel -- you can see the same kretprobe_trampoline()
issue when using ftrace just as much as bpf_trace.

However, in working on this patch, I've noticed that there appear to be
several different implementations of "get the stack trace from this
pt_regs" which all appear quite similar. Namely:

  * struct ftrace_stack;
  * struct perf_callchain_entry; [**]
  * struct stack_trace;

  * oprofile_operations->backtrace [This is not related to the kretprobe
	problem, very tangential, but since it's usage is not very
	complicated -- logging to dmesg -- it wouldn't be too bad to
	refactor this one too].

Would there be a strong objection to me trying to merge together these
so that they all use 'struct stack_trace', and no longer have
arch-specific code that is doing (what appears to be) the same unwind
code? Or is this something that was intentionally avoided because there
are some differences that I'm not seeing?

The reason I ask is because the kretprobes patch would require saving
the stacktrace during pre_handler_kretprobe() -- and so in order for all
of the tracing subsystems to take advantage of it they'd need to be able
to use that saved stack trace.

The only other option I can see would be to implement some sort of
translation from 'struct stack_trace' to the others. This wouldn't be
too bad, but I imagine it would be uglier than refactoring them all to
use the same struct.

[**] perf_callchain_entry has the concept of "marking" a context in the
     stack trace. But I wonder whether this is something that we could
	 do with 'struct stack_trace' -- after all it's just magic ->ip
	 values. *But* then the question is what is the purpose of
	 sysctl_perf_event_max_contexts_per_stack? It limits the number of
	 contexts, but isn't that already implicitly limited by the number
	 of stack entries? We could also implement this with 'struct
	 stack_trace' but it would require wrapping 'struct stack_trace' to
	 make it efficient.

[1]: https://github.com/iovisor/bpftrace/issues/101

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jpe3xsjujl3wfigt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlvMR1YACgkQnhiqJn3b
jbTGTA//YKz045vrFlJghTCdYFA5JvJNv5JjbAXgMIC5KnVNmj7XeSJgrmZLXNfB
PWRHQw+u+ylN+2d0lcKCL8XgC8g0TjNt7XUio9UPpBE3OuHghY/BFHehqhct0eNW
/FtmVJyFoN20deCwmy3USVJQMdmPGF6j1QramNsVPVOIXMz/Nl1rl4clAYl9bIpb
hpcmzgDzSuaiOJiIaP9sOQCoI7Mz3tQ0BJ7ElBFpIL33OUCPygqkiG0w4C6h5RQX
kXzvBYk8QDGiYPi6b86p+0SgpQJuNyrxMc545duHlIZnb2eGA59PknMbBWu0Lljx
cP/xLhD+wIuufHU1+nmtXu5DmJg8EJ81mrTzDfTFoFX6nZRuHGNwcb9b0L+3nSZp
+6CjzxDaukWJACgiSq25bBCVVUvshBL0ZGuqKRgIW4OmJO0ND4TgfY5RPoCNLOBm
Ko2JPif9L0XveNuxXARXfd5R2hOxGXsH5ZzA/pV6p/BfEfPbJ51FrFwZSC7915jK
u2lS9Ym/3ZLjNvE4VBpE0Ni0w19aQh4zNkeYv6Mp12JIHN0HVDwgfmW5jS/xqWU7
RtFr3Cnsl0/lnYmKQIwHqnL4rNT+B1HswAubxhP0iJxlOV4z+uD5mQ4WKrCqnERR
xnC5CXPWcruqF+GY0CDWAUwEj0Sn06EYxa/qqXYYp1szP5UsasA=
=+/wd
-----END PGP SIGNATURE-----

--jpe3xsjujl3wfigt--
