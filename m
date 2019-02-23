Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FE6206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550891915;
	bh=4XrV26I2j7NRsIeTHlxt8hkaz8zOcisXA3Av8EbDBpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QDJqRyF4/Zc7XSsVBkJmt2VuyDOyfQkht56UtcwsTLYHVFdRSllUG93xZBHLhlrKL
	 2zxDDJsNRWeMfJ3PGal1Iwhb/JlilrGheK0YAdc6tFmmpHkifcz4zrQn5nm8V3PY10
	 qPedcsXJzTIqqFQiwqjJY2nZTBZCCWh2nppLc2+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfBWDSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:18:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55963 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWDSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:18:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so3595644wme.5;
        Fri, 22 Feb 2019 19:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFO+7+oa0wvRqUr3GH29+Yi0Dkk9WdcGMAMbDKLC1jA=;
        b=sVcPLJqsphxrdRPgWqQWrlwLCrLKuS1uYn8X2DkyTHSuiqw/E6yoUED5MTZ5IPGU9i
         pUskZNLCcFMAMEBhzzbRWBhUIeHrt3Bc9lCrDcJdXnPfT7cbU3x7BIgcyrFcrD1IGgs+
         lWlLrdVqJemFxRdx73g7WZYDtG6Iz3IZbquJBy1yCG97ObjjmEC6quzZIEqKjfYyDQjQ
         M/MBBjOSU7Dwy4RzoOr6hKhsGZ0owsPBT0IOnIUVqTDw55a9Gf2/h/a7izu+7fkiwVCa
         CnvyMiVn6LRyuy5CDQ90PGEpbb4tRKhNUz0CByhgmae4b5b61UrYAfgXB7ME3CqTu4pX
         QRnQ==
X-Gm-Message-State: AHQUAubyWIbVTMrwvIouvCK9oqIEEXz2eGw1WhBGfMG+gWAq2TBcHtRi
        BJ23Y30NYj1X5QTPWb48ESHA3hI1WVIUjCiEx9E=
X-Google-Smtp-Source: AHgI3IZV2RpQBdF3n1TjIcWS256+j2op+4P+nd2fv4SVYZrYmReYKPeKYCFA3/Dlvwgu4/zQ7iH/5nvrtk0NGxec7/g=
X-Received: by 2002:a7b:c752:: with SMTP id w18mr4408299wmk.97.1550891909929;
 Fri, 22 Feb 2019 19:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190221123909.GG10990@krava> <20190221135320.io7egcwajehfrdd5@studium.uni-erlangen.de>
 <20190221162858.GA3940@krava>
In-Reply-To: <20190221162858.GA3940@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 23 Feb 2019 12:18:18 +0900
Message-ID: <CAM9d7cjPcBEE3dsC6vDy3AtxEjc6bW-f=KGt5nB5rJWFr_whYw@mail.gmail.com>
Subject: Re: [PATCH] perf hist: fix memory leak if histogram entry is reused
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 22, 2019 at 1:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Feb 21, 2019 at 02:53:20PM +0100, Jonas Rabenstein wrote:
> > On Thu, Feb 21, 2019 at 01:39:09PM +0100, Jiri Olsa wrote:
> > > On Thu, Feb 21, 2019 at 01:23:06PM +0100, Jonas Rabenstein wrote:
> > > > In __hists__add_entry the srcline of the addr_location is duplicated
> > > > for the hist_entry. If hists__findnew_entry returns an already existing
> > > > hist_entry the srcline has to be freed again as no further reference to
> > > > that duplicated srcline would exists anymore.
> > > >
> > > > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > > > ---
> > > >  tools/perf/util/hist.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > index 8aad8330e392..25b8dbdbbe87 100644
> > > > --- a/tools/perf/util/hist.c
> > > > +++ b/tools/perf/util/hist.c
> > > > @@ -623,6 +623,9 @@ __hists__add_entry(struct hists *hists,
> > > >           .ops = ops,
> > > >   }, *he = hists__findnew_entry(hists, &entry, al, sample_self);
> > > >
> > > > + if (he && he->srcline != entry.srcline)
> > > > +         free(entry.srcline);
> > > > +
> > > >   if (!hists->has_callchains && he && he->callchain_size != 0)
> > > >           hists->has_callchains = true;
> > > >   return he;
> > >
> > > nice, do we have similar issue in here?
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 216388003dea..e65e6822c848 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -966,7 +966,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
> > >                     .map = al->map,
> > >                     .sym = al->sym,
> > >             },
> > > -           .srcline = al->srcline ? strdup(al->srcline) : NULL,
> > > +           .srcline = al->srcline,
> > While this shouldn't leak the memory, we may end up with an al->srcline
> > to get free afterwards while still having a reference on it within the
> > hist_entry... Also I could not find where/how the hist_entry is freed up
> > so we may get an double free if both of al and he clean the srcline.
> > Of course, with your solution we could spare the useless strdup/free if
> > we find an hist_entry (which should be the typical case for hotspots..).
> > Taking a deeper look thus should be beneficial - but I do not have the
> > time for that right now because I'm still working on the inline-symbol
> > integration which is more important for me...
>
> ok, I'll check it

I think we can defer calling strdup() to hist_entry__init().

Thanks,
Namhyung
