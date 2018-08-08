Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A17C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70429216E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFH6Fsds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70429216E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeHHSNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeHHSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:13:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77D5216E6;
        Wed,  8 Aug 2018 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533743611;
        bh=LYF3Ue+eK0o+u9T04YM57Lc2zy2d/B4GWEn+SbLWFnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFH6FsdsbxsRNwJHIFzl3o+h5f61Bouncr8e/fbAC0LWzRH4/oBgdlQpwwPFEOQRy
         vBB29TPz6Qt8idbR66XMnRhr6PAdK/bF5WupC5GGEmNlzzrKe0kqjoY+tfnsGc8y4v
         oyzH3GZoD1TAqy0e6SSogGIDWDLBRg2FWjlrL8FU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7C8E8140A1C; Wed,  8 Aug 2018 12:53:28 -0300 (-03)
Date:   Wed, 8 Aug 2018 12:53:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180808155328.GA9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 08:39:58AM +0200, Thomas-Mich Richter escreveu:
> On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> > Thomas Richter <tmricht@linux.ibm.com> writes:
> >> Add support for s390 auxiliary trace support.
> >> Use 'perf record -e rbd000' to create the perf.data file.
> >> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> >> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> > ...
> >>
> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> >> ---
> >>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
> >>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
> >>  2 files changed, 314 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> > 
> > 
> > I'm seeing a build break on ppc64le which seems to be caused by this
> > commit (I haven't bisected):
> > 
> >   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
> >   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> >     return *((unsigned long long *) &te->timestamp[te->t]);
> >     ^
> > 
> > 
> > And on powerpc big endian:
> >   In file included from util/cpumap.h:10:0,
> >                    from util/s390-cpumsf.c:150:
> >   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
> >   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
> >      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
> >             ^
> > 
> > cheers
> > 
> 
> Can you please try this patch. Thanks a lot

Ok, this was making the build fail as well on some containers here:

   1    37.95 alpine:3.4                    : gcc (Alpine 5.3.0) 5.3.0

  CC       /tmp/build/perf/util/s390-cpumsf.o
  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
util/s390-cpumsf.c: In function 'trailer_timestamp':
util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *((unsigned long long *) &te->timestamp[te->t]);
  ^

   2    48.46 alpine:3.5                    : gcc (Alpine 6.2.1) 6.2.1 20160822
  CC       /tmp/build/perf/util/parse-branch-options.o
util/s390-cpumsf.c: In function 'trailer_timestamp':
util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *((unsigned long long *) &te->timestamp[te->t]);
  ^~~~~~
  CC       /tmp/build/perf/util/dump-insn.o

---------

I stopped at this point when this report/patch resurfaced in my mind, so
I came back and folded this fix into the cset introducing the problem
since it hasn't gone Ingo's way, so that we can keep this bisectable
when upstream.

Thanks guys!

- Arnaldo
