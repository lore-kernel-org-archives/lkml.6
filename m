Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BCC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D321771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCCaTsEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6D321771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeHHSTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeHHSTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:19:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB422175F;
        Wed,  8 Aug 2018 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533743964;
        bh=0LuWXGTABGg22FDNPKdH6Z4uOTiRLuTuBJagpEerZus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCCaTsEJ4Cglq4CwTy+MGWiWd2QIbwgpt8dDkSOTIGU7q8/YbgJbsTfeQgRnHeMuy
         RfrBkgof/f4I32QqhEfCMrxXhN3gqrPBkoj+ZURbrHbtW2IOOoEkvq1IlkYo6meWwc
         RuPzRxB/6yNKfwBoirUALvDzlqVPV3yhtX0m2D50=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 55424140A1C; Wed,  8 Aug 2018 12:59:21 -0300 (-03)
Date:   Wed, 8 Aug 2018 12:59:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180808155921.GB9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180808155328.GA9543@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 12:53:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 08, 2018 at 08:39:58AM +0200, Thomas-Mich Richter escreveu:
> > On 08/08/2018 05:37 AM, mpe@ellerman.id.au wrote:
> > > Thomas Richter <tmricht@linux.ibm.com> writes:
> > >> Add support for s390 auxiliary trace support.
> > >> Use 'perf record -e rbd000' to create the perf.data file.
> > >> The event also has the symbolic name SF_CYCLES_BASIC_DIAG,
> > >> using 'perf record -e SF_CYCLES_BASIC_DIAG' is equivalent.
> > > ...
> > >>
> > >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > >> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> > >> ---
> > >>  tools/perf/util/s390-cpumsf-kernel.h |  71 ++++++++
> > >>  tools/perf/util/s390-cpumsf.c        | 244 ++++++++++++++++++++++++++-
> > >>  2 files changed, 314 insertions(+), 1 deletion(-)
> > >>  create mode 100644 tools/perf/util/s390-cpumsf-kernel.h
> > > 
> > > 
> > > I'm seeing a build break on ppc64le which seems to be caused by this
> > > commit (I haven't bisected):
> > > 
> > >   util/s390-cpumsf.c: In function ‘trailer_timestamp’:
> > >   util/s390-cpumsf.c:222:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
> > >     return *((unsigned long long *) &te->timestamp[te->t]);
> > >     ^
> > > 
> > > 
> > > And on powerpc big endian:
> > >   In file included from util/cpumap.h:10:0,
> > >                    from util/s390-cpumsf.c:150:
> > >   util/s390-cpumsf.c: In function ‘s390_cpumsf_basic_show’:
> > >   util/s390-cpumsf.c:187:10: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Werror=format=]
> > >      pr_err("Invalid AUX trace basic entry [%#08lx]\n", pos);
> > >             ^
> > > 
> > > cheers
> > > 
> > 
> > Can you please try this patch. Thanks a lot
> 
> Ok, this was making the build fail as well on some containers here:

Ok, failed in another container:

  11 centos:6                      : gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)

  CC       /tmp/build/perf/tests/sample-parsing.o
cc1: warnings being treated as errors
In file included from util/s390-cpumsf.c:161:
util/s390-cpumsf-kernel.h:16: error: packed attribute is unnecessary for 'def'
util/s390-cpumsf-kernel.h:25: error: packed attribute is unnecessary for 'CL'
util/s390-cpumsf-kernel.h:28: error: packed attribute is unnecessary for 'ia'
util/s390-cpumsf-kernel.h:29: error: packed attribute is unnecessary for 'gpp'
util/s390-cpumsf-kernel.h:30: error: packed attribute is unnecessary for 'hpp'
util/s390-cpumsf-kernel.h:34: error: packed attribute is unnecessary for 'def'
mv: cannot stat `/tmp/build/perf/util/.s390-cpumsf.o.tmp': No such file or directory
make[4]: *** [/tmp/build/perf/util/s390-cpumsf.o] Error 1


For reference, this is the current output of the tests so far, that I'll
let running while I try to figure out this case:

[root@seventh ~]# time dm
   1    37.95 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2    48.46 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3    43.18 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4    46.87 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5    85.35 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   6    36.86 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   7    41.37 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   8    30.61 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9    27.69 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10    26.45 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  11    20.70 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  12    39.16 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  13    34.18 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  14    37.12 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  15: debian:9

