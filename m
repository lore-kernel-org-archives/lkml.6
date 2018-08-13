Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24AB21798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntxq0Tz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24AB21798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHMVmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeHMVmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:42:21 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10E7215A5;
        Mon, 13 Aug 2018 18:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534186732;
        bh=LU6sth4Gn1VmM72851mWGjiUsLAZ4FokH1PPSe8dnRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntxq0Tz3T964I0Tner8JlWIh3c4IONG8wcoRltiqFhsjMClsyYpzbZ6+dxGeGp81K
         0iEQ4ijuq25Fa9kKwSa1AQuNWSbtKxCKxo8QdWgbyAH1cgZuRwFnoAX5ybWUQo3FIR
         Qn4LeaK/i53TFUcTtEYtuBaSBIMwhHZ7Qj7hiFMY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3576D140A1C; Mon, 13 Aug 2018 15:58:50 -0300 (-03)
Date:   Mon, 13 Aug 2018 15:58:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, David Ahern <dsahern@gmail.com>,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Fix check-headers.sh AND list path of
 execution
Message-ID: <20180813185850.GC4499@kernel.org>
References: <20180723070145.GB7523@krava>
 <20180811083915.17471-1-alexander.kapshuk@gmail.com>
 <20180813111631.GA718@krava>
 <CAJ1xhMUfQ9GDEXgL-+R_vs1aoidbwj5LRsyb9K32MMUnR23whQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1xhMUfQ9GDEXgL-+R_vs1aoidbwj5LRsyb9K32MMUnR23whQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 13, 2018 at 02:19:10PM +0300, Alexander Kapshuk escreveu:
> On Mon, Aug 13, 2018 at 2:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Sat, Aug 11, 2018 at 11:39:15AM +0300, Alexander Kapshuk wrote:
> > > The '||' path of execution in the 'test' block of the check_2() function
> > > may also be taken if file2 does not exist, in which case the warning
> > > message about the ABI headers being different would still be printed
> > > where it should not be.  See below.
> > >
> > > % file1=file1; file2=file2
> > > % cmd="echo diff $file1 $file2"
> > > % test -f $file2 &&
> > > eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
> > > differs from latest version at '$file2'" >&2
> > > Warning: Kernel ABI header at 'tools/file1' differs from latest
> > > version at 'file2'
> > >
> > > The proposed patch converts the code following the '&&' operator into a
> > > compound list to be executed in the current process environment only if
> > > file2 does exist. Should the files being compared differ, a diff command
> > > to compare the files concerned is printed on standard output. E.g.
> > >
> > > diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> > >
> > > Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> >
> > I posted follow up patches based on this one
> > as a reply on this patch
> >
> > for this one:
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > thanks,
> > jirka
> 
> Noted.
> Thanks.

Thanks, applied the three patches to acme/perf/core.

- Arnaldo
