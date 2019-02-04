Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25258C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4320820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfBDJ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:27:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBDJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:27:28 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqaXE-00085l-Ao; Mon, 04 Feb 2019 10:27:24 +0100
Date:   Mon, 4 Feb 2019 10:27:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Vyukov <dvyukov@google.com>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: perf_event_open+clone = unkillable process
In-Reply-To: <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com> <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Dmitry Vyukov wrote:

> On Fri, Feb 1, 2019 at 5:48 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Hello,
> >
> > The following program creates an unkillable process that eats CPU.
> > /proc/pid/stack is empty, I am not sure what other info I can provide.
> >
> > Tested is on upstream commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a.
> > Config is attached.
> 
> Looking through other reproducers that create unkillable processes, I
> think I found a much simpler reproducer (below). It's single threaded
> and just setups SIGBUS handler and does timer_create+timer_settime to
> send repeated SIGBUS. The resulting process can't be killed with
> SIGKILL.
> +Thomas for timers.

+Oleg, Eric

That's odd. With some tracing I can see that SIGKILL is generated and
queued, but its not delivered by some weird reason. I'm traveling in the
next days, so I won't be able to do much about it. Will look later this
week.

Thanks,

	tglx
