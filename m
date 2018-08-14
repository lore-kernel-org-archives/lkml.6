Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B1FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F81C2157F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="haEI2Hks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F81C2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeHNUzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeHNUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:55:06 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554D62157F;
        Tue, 14 Aug 2018 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534270007;
        bh=ZDChWXNDEmknlaibdZkHzRVKasqzPge9+K9pSk/QJHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haEI2HkslfC7VTPF4akCD+5GlZKor0qTPv2Q3GIgcfAr4rtEyECCt+MQZU0b85v6h
         gDULXBgsXEfLyWrbgVW9NIasT0K6D7KOxanrnSc+TStgR5bAv6HCQ7xVsdkD72zU0y
         Rcf3nGrG3DKs87s/9hLNhdpZYQSXOib5nQgxuURc=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 778F0140A1C; Tue, 14 Aug 2018 15:06:44 -0300 (-03)
Date:   Tue, 14 Aug 2018 15:06:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, namhyung@kernel.org,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: Re: [PATCH 1/2] perf tools: Make check-headers.sh check based on
 kernel dir
Message-ID: <20180814180644.GA24338@kernel.org>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111504.3568-1-jolsa@kernel.org>
 <87mutplnwk.fsf@concordia.ellerman.id.au>
 <20180814072726.GA13931@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814072726.GA13931@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 14, 2018 at 09:27:26AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 14, 2018 at 11:47:39AM +1000, Michael Ellerman wrote:
> > Jiri Olsa <jolsa@kernel.org> writes:
> > > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > > index ea48aa6f8d19..9d466e853aec 100755
> > > --- a/tools/perf/check-headers.sh
> > > +++ b/tools/perf/check-headers.sh
> > > @@ -88,6 +88,8 @@ check () {
> > >  # differences.
> > >  test -d ../../include || exit 0
> > >  
> > > +pushd ../.. > /dev/null
> > > +
> > >  # simple diff check
> > >  for i in $HEADERS; do
> > >    check $i -B
> > 
> > This breaks the build when sh is not bash:
> > 
> >   ./check-headers.sh: 91: ./check-headers.sh: pushd: not found
> >   ./check-headers.sh: 107: ./check-headers.sh: popd: not found
> >   Makefile.perf:205: recipe for target 'sub-make' failed
> 
> sry.. Arnaldo, would you change it for simple cd (attached below)
> or should I send the fix?

Nah, I'm folding this in, to keep it bisectable.
 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 80bf84803677..466540ee8ea7 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -88,7 +88,7 @@ check () {
>  # differences.
>  test -d ../../include || exit 0
>  
> -pushd ../.. > /dev/null
> +cd ../..
>  
>  # simple diff check
>  for i in $HEADERS; do
> @@ -104,4 +104,4 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
>  # diff non-symmetric files
>  check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
>  
> -popd > /dev/null
> +cd tools/perf
