Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D34C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F6521A12
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY4IzHSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F6521A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeHHS3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHS3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:29:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B5121771;
        Wed,  8 Aug 2018 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533744527;
        bh=Ux1VrLtclywdQnoTK6jDIv8XNjq1ycKrh9ieqgHeX18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mY4IzHSrbnr8X0S8SYnylILGGcfuu9s9SPhS7aq3GLGtUno+k5oMf3j5WHySoVAiS
         Pw39FNY0c7QdaRke9RXWYCpyOV9V1ndGoBsAgnUde0RqAj0hapHYbJbv566uNgemTV
         x9h5sdoGwPW+VucoEBdLk+btnF8BMoLwcSj1T3h0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C2A29140A1C; Wed,  8 Aug 2018 13:08:43 -0300 (-03)
Date:   Wed, 8 Aug 2018 13:08:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180808160843.GC9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180808155921.GB9543@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 12:59:21PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 08, 2018 at 12:53:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Aug 08, 2018 at 08:39:58AM +0200, Thomas-Mich Richter escreveu:
> > > On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> > > > Thomas Richter <tmricht@linux.ibm.com> writes:
> > > >> Add support for s390 auxiliary trace support.
> > > >> Use 'perf record -e rbd000' to create the perf.data file.
> > > >> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> > > >> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> > > > ...
> > > >>
> > > >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > > >> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> > > >> ---
> > > >>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
> > > >>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
> > > >>  2 files changed, 314 insertions(+), 1 deletion(-)
> > > >>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> > > > 
> > > > 
> > > > I'm seeing a build break on ppc64le which seems to be caused by this
> > > > commit (I haven't bisected):
> > > > 
> > > >   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
> > > >   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> > > >     return *((unsigned long long *) &te->timestamp[te->t]);
> > > >     ^
> > > > 
> > > > 
> > > > And on powerpc big endian:
> > > >   In file included from util/cpumap.h:10:0,
> > > >                    from util/s390-cpumsf.c:150:
> > > >   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
> > > >   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
> > > >      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
> > > >             ^
> > > > 
> > > > cheers
> > > > 
> > > 
> > > Can you please try this patch. Thanks a lot
> > 
> > Ok, this was making the build fail as well on some containers here:
> 
> Ok, failed in another container:
> 
>   11 centos:6                      : gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
> 
>   CC       /tmp/build/perf/tests/sample-parsing.o
> cc1: warnings being treated as errors
> In file included from util/s390-cpumsf.c:161:
> util/s390-cpumsf-kernel.h:16: error: packed attribute is unnecessary for 'def'
> util/s390-cpumsf-kernel.h:25: error: packed attribute is unnecessary for 'CL'
> util/s390-cpumsf-kernel.h:28: error: packed attribute is unnecessary for 'ia'
> util/s390-cpumsf-kernel.h:29: error: packed attribute is unnecessary for 'gpp'
> util/s390-cpumsf-kernel.h:30: error: packed attribute is unnecessary for 'hpp'
> util/s390-cpumsf-kernel.h:34: error: packed attribute is unnecessary for 'def'
> mv: cannot stat `/tmp/build/perf/util/.s390-cpumsf.o.tmp': No such file or directory
> make[4]: *** [/tmp/build/perf/util/s390-cpumsf.o] Error 1

So, this is how it shows using that __packed you have:

[acme@seventh perf]$ pahole -C hws_basic_entry ~/bin/perf
struct hws_basic_entry {
	unsigned int               def:16;               /*     0:16  4 */
	unsigned int               R:4;                  /*     0:12  4 */
	unsigned int               U:4;                  /*     0: 8  4 */
	unsigned int               z:2;                  /*     0: 6  4 */
	unsigned int               T:1;                  /*     0: 5  4 */
	unsigned int               W:1;                  /*     0: 4  4 */
	unsigned int               P:1;                  /*     0: 3  4 */
	unsigned int               AS:2;                 /*     0: 1  4 */
	unsigned int               I:1;                  /*     0: 0  4 */
	unsigned int               CL:2;                 /*     4:30  4 */
	unsigned int               prim_asn:16;          /*     4: 0  4 */

	/* XXX 14 bits hole, try to pack */

	long long unsigned int     ia;                   /*     8     8 */
	long long unsigned int     gpp;                  /*    16     8 */
	long long unsigned int     hpp;                  /*    24     8 */

	/* size: 32, cachelines: 1, members: 14 */
	/* bit holes: 1, sum bit holes: 14 bits */
	/* last cacheline: 32 bytes */
};
[acme@seventh perf]$

And:

[acme@seventh perf]$ pahole -C hws_diag_entry ~/bin/perf
struct hws_diag_entry {
	unsigned int               def:16;               /*     0:16  4 */
	unsigned int               R:15;                 /*     0: 1  4 */
	unsigned int               I:1;                  /*     0: 0  4 */
	u8                         data[0];              /*     4     0 */

	/* size: 4, cachelines: 1, members: 4 */
	/* last cacheline: 4 bytes */
};
[acme@seventh perf]$ 

Now, if we apply this patch:

[acme@seventh perf]$ pahole -C hws_basic_entry ~/bin/perf
struct hws_basic_entry {
	unsigned int               def:16;               /*     0:16  4 */
	unsigned int               R:4;                  /*     0:12  4 */
	unsigned int               U:4;                  /*     0: 8  4 */
	unsigned int               z:2;                  /*     0: 6  4 */
	unsigned int               T:1;                  /*     0: 5  4 */
	unsigned int               W:1;                  /*     0: 4  4 */
	unsigned int               P:1;                  /*     0: 3  4 */
	unsigned int               AS:2;                 /*     0: 1  4 */
	unsigned int               I:1;                  /*     0: 0  4 */
	unsigned int               CL:2;                 /*     4:30  4 */
	unsigned int               prim_asn:16;          /*     4: 0  4 */

	/* XXX 14 bits hole, try to pack */

	long long unsigned int     ia;                   /*     8     8 */
	long long unsigned int     gpp;                  /*    16     8 */
	long long unsigned int     hpp;                  /*    24     8 */

	/* size: 32, cachelines: 1, members: 14 */
	/* bit holes: 1, sum bit holes: 14 bits */
	/* last cacheline: 32 bytes */
};
[acme@seventh perf]$ 

See, no need for packing, that old gcc version is right, and the other
struct:

[acme@seventh perf]$ pahole -C hws_diag_entry ~/bin/perf
struct hws_diag_entry {
	unsigned int               def:16;               /*     0:16  4 */
	unsigned int               R:15;                 /*     0: 1  4 */
	unsigned int               I:1;                  /*     0: 0  4 */
	u8                         data[0];              /*     4     0 */

	/* size: 4, cachelines: 1, members: 4 */
	/* last cacheline: 4 bytes */
};
[acme@seventh perf]$

No need for __packed.

I'm removing that to avoid having this failling in compilers that have
such a warning, since we default to Werror.

Holler if there is something I'missing :-)

- Arnaldo
