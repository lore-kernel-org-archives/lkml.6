Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA222184E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBDU2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfBDU2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:28:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69DA0C057F34;
        Mon,  4 Feb 2019 20:28:22 +0000 (UTC)
Received: from krava (ovpn-204-43.brq.redhat.com [10.40.204.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7FC445D9CA;
        Mon,  4 Feb 2019 20:28:19 +0000 (UTC)
Date:   Mon, 4 Feb 2019 21:28:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190204202818.GC4794@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava>
 <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org>
 <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 04 Feb 2019 20:28:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:05:38PM -0800, Stephane Eranian wrote:

SNIP

> > > > > >
> > > > > > [jolsa@krava perf]$ ll result_1/
> > > > > > total 348
> > > > > > -rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
> > > > > > -rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
> > > > > > -rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
> > > > > > -rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
> > > > > > -rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
> > > > > > -rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
> > > > > > -rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
> > > > > > -rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
> > > > > > -rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header
> > > > >
> > > > > Awesome. What do you think about having it like this:
> > > > >
> > > > >   $ perf record --output result_1.data ... - writes data to a file
> > > > >
> > > > >   $ perf record --dir result_1 ... - or even
> > > > >   $ perf record --output_dir result_1 ... - writes data into a directory
> > > > >
> > > > > IMHO, this interface is simpler for a user.
> > > >
> > > > yep, seems more convenient.. I'll add it
> > > >
> > > But what happens if you do: perf record -o foo --output_dir foo.d?
> >
> > Should fail, i.e. either you use single-file or directory output, I
> > think.
> >
> Agreed

ok, will do that

thanks,
jirka
