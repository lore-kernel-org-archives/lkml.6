Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E92EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1079520821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBCPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:21:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfBCPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:21:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0069A31487;
        Sun,  3 Feb 2019 15:21:21 +0000 (UTC)
Received: from krava (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0FDD5B680;
        Sun,  3 Feb 2019 15:21:14 +0000 (UTC)
Date:   Sun, 3 Feb 2019 16:21:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: perf_event_open+clone = unkillable process
Message-ID: <20190203152113.GA11794@krava>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
 <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
 <20190202183013.GA10522@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202183013.GA10522@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 03 Feb 2019 15:21:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 07:30:45PM +0100, Jiri Olsa wrote:
> On Fri, Feb 01, 2019 at 06:06:03PM +0100, Dmitry Vyukov wrote:
> > On Fri, Feb 1, 2019 at 5:48 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > Hello,
> > >
> > > The following program creates an unkillable process that eats CPU.
> > > /proc/pid/stack is empty, I am not sure what other info I can provide.
> > >
> > > Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
> > > Config is attached.
> > 
> > Looking through other reproducers that create unkillable processes, I
> > think I found a much simpler reproducer (below). It's single threaded
> > and just setups SIGBUS handler and does timer_create+timer_settime to
> > send repeated SIGBUS. The resulting process can't be killed with
> > SIGKILL.
> > +Thomas for timers.
> 
> nice, I managed to kill it by strace ;-)
> 
> [jolsa@krava perf]$ strace  -p 10725
> strace: Process 10725 attached
> --- stopped by SIGBUS ---
> --- stopped by SIGBUS ---
> --- stopped by SIGBUS ---
> --- stopped by SIGBUS ---
> +++ killed by SIGINT +++

fyi I can no longer reproduce the kill via strace.. not sure
what was different

jirka
