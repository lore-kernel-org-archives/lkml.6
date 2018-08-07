Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97136C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56442208D6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56442208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbeHGLDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:03:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbeHGLDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:03:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DA987C809;
        Tue,  7 Aug 2018 08:50:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68C28215670D;
        Tue,  7 Aug 2018 08:50:11 +0000 (UTC)
Date:   Tue, 7 Aug 2018 10:50:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf ordered_events: fix crash in free_dup_event()
Message-ID: <20180807085010.GC7716@krava>
References: <1533605015-19514-1-git-send-email-eranian@google.com>
 <20180807072029.GA7716@krava>
 <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 08:50:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 08:50:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 01:16:22AM -0700, Stephane Eranian wrote:
> On Tue, Aug 7, 2018 at 12:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> > > Depending on memory allocations, it was possible to get a SEGFAULT in
> > > free_dup_event() because the event pointer was bogus:
> > >
> > > perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7
> >
> > is there any reproducer?
> >
> The cmdline is simple:
> $ perf record -e cycles:pp -o - -a sleep 1 | perf inject -b -i - >/dev/null
> I was using v4.13 for my tests and it may be sensitive to compiler.
> Was using LLVM.

I can't make it fail even when I compile with clang 'make CC=clang'

  [jolsa@krava perf]$ clang --version
  clang version 6.0.1 (tags/RELEASE_601/final)

I'm on v4.17, but I dont think kernel version is related to this issue

> 
> It may be a compiler related issue. You do not allocate the whole struct.
> If the compiler was to do a memcpy() behind your back, you'd be in
> troubles.
> 
> Adding extra padding before *event was also avoiding the problem.
> struct ordered_event {
>         u64                     timestamp;
>         u64                     file_offset;
>         char                   pad[32];   <----- extra padding for debugging
>         union perf_event        *event;
>         struct list_head        list;
> };

might be some issue in the struct ordered_event allocation,
which is little convoluted 

jirka
