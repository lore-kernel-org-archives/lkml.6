Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC9C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1506D21730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1506D21730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeHOCAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:00:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732521AbeHOCAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4D3D40216E8;
        Tue, 14 Aug 2018 23:11:23 +0000 (UTC)
Received: from krava (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 243A8178BC;
        Tue, 14 Aug 2018 23:11:20 +0000 (UTC)
Date:   Wed, 15 Aug 2018 01:11:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, namhyung@kernel.org,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, alexander.kapshuk@gmail.com
Subject: Re: [PATCH 1/2] perf tools: Make check-headers.sh check based on
 kernel dir
Message-ID: <20180814231120.GB3180@krava>
References: <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111504.3568-1-jolsa@kernel.org>
 <87mutplnwk.fsf@concordia.ellerman.id.au>
 <20180814072726.GA13931@krava>
 <20180814180644.GA24338@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814180644.GA24338@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 23:11:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 14 Aug 2018 23:11:23 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 03:06:44PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 14, 2018 at 09:27:26AM +0200, Jiri Olsa escreveu:
> > On Tue, Aug 14, 2018 at 11:47:39AM +1000, Michael Ellerman wrote:
> > > Jiri Olsa <jolsa@kernel.org> writes:
> > > > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > > > index ea48aa6f8d19..9d466e853aec 100755
> > > > --- a/tools/perf/check-headers.sh
> > > > +++ b/tools/perf/check-headers.sh
> > > > @@ -88,6 +88,8 @@ check () {
> > > >  # differences.
> > > >  test -d ../../include || exit 0
> > > >  
> > > > +pushd ../.. > /dev/null
> > > > +
> > > >  # simple diff check
> > > >  for i in $HEADERS; do
> > > >    check $i -B
> > > 
> > > This breaks the build when sh is not bash:
> > > 
> > >   ./check-headers.sh: 91: ./check-headers.sh: pushd: not found
> > >   ./check-headers.sh: 107: ./check-headers.sh: popd: not found
> > >   Makefile.perf:205: recipe for target 'sub-make' failed
> > 
> > sry.. Arnaldo, would you change it for simple cd (attached below)
> > or should I send the fix?
> 
> Nah, I'm folding this in, to keep it bisectable.

any chance one of your docker tests could run build in sh/zsh? ;-)

thanks,
jirka
