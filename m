Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B88C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EDE208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zxjBTx/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EDE208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbeHFUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:14:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733004AbeHFUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZWCFOg3kUl0vTxpPVawGXZoL5hQ2FdrX7BAQ+cF56M0=; b=zxjBTx/oIE/qFTxYIuWb7mRN0
        QylzjU23wBJ5syKQL0k13ku3Uot1CJhl1rLpL3gy9Nj84PkUDVTZ4KroNstL/SFJPJcjrgM4z+QM4
        XicGBJ32tnXO10CSWKeySJ/H18t+oq905aJkOepowSG8urtVGNb2NxJGXV1jplg1aDnqYColAGvNM
        v7XGnIMyvKUfXTqxYP6H9RpBdrMLGjrhM+bmT3J5T/upruic5bBdl66p5WILpvxqD/DEfRecZHcwb
        jGVoQHSkoXgdRIuPNFkEEBpYjo7mKvTV6kX8Pd9tw8z3tSJACVzBYvKyc3+99LXiimkxM7PJwM2X5
        Qpke8dmsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmjrm-0002xk-R8; Mon, 06 Aug 2018 18:04:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D87B12058A21E; Mon,  6 Aug 2018 20:04:23 +0200 (CEST)
Date:   Mon, 6 Aug 2018 20:04:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fubo Chen <fubo.chen@gmail.com>
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180806180423.GC2476@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net>
 <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:54:23AM -0700, Fubo Chen wrote:
> On Mon, Aug 6, 2018 at 8:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 06, 2018 at 08:35:07AM -0700, Fubo Chen wrote:
> > > On Thu, Jul 19, 2018 at 2:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > --- a/include/uapi/linux/perf_event.h
> > > > +++ b/include/uapi/linux/perf_event.h
> > > > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> > > >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> > > >
> > > >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > > > +
> > > > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1UL << 63,
> > > >  };
> > >
> > > The above change makes sparse unhappy :-( Sparse reports the following
> > > complaint about __PERF_SAMPLE_CALLCHAIN_EARLY:
> >
> > I thought I changed that to 1ULL before commit.
> 
> The sparse complaint was reported for code with the "1ULL << 63".

Ah ok.. and I think I see what you mean. The C standard says that enums
shall be 'int'. However C++ standard says any integer type that fits the
largest value.

I suppose GCC uses the C++ definition and I suspect many other compilers
will too.
