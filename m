Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA2FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013982083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013982083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeINUFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:05:13 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46142 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeINUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:05:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so13009492oie.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R0zCWy766RE54hRWnFEO/UDDG5FecCafh6znM9o0wwg=;
        b=U6UhhtAY4JU3gZIzc01t3eC7rt0MRfZcacxbXRJIGtAnc1HxdICQgvYP5rwookXt/c
         zVBNvj4oI3tYn9CtH4ZKFDT7BFFymMROmeq9NTuD7I8dwK7uBhafcCwB3ZlHQ4AkTDHi
         EANjoqKlh4MildRlagtflPb3mtLtSul2r0HLCGCY1hP7W9jgR+2XP8WOOq17PSz9nP/3
         JDeNR7pA+AOzDFqLtvY/nxZu21hcDHzKJWuIrWE5mXfHeHtFRUZRVPplanaRimRORUhc
         /qFg3rDNnQ69RR4+r1x0CsGu4V1vH4o0bnqmqczGfWizJCT35pEy2Ykp6Tl9i/L5xutI
         QKjg==
X-Gm-Message-State: APzg51D806sss1Y5l7o8m2PvVM+f3or1GKb+QtiNJ5eIWThCe2jF0FWC
        opMvIrICBEU8fxavOMyYa8pcYQr1UmiEehaKnDT4Xw==
X-Google-Smtp-Source: ANB0Vdb2etZ70KFLeKlLzv08Mfq1EVxPgCZ5ff0E0M3ybXSASzsJdJnepNi9nqI1PH0Uu+fJ8ClcpHz6TVsQRRfkvCE=
X-Received: by 2002:aca:cf44:: with SMTP id f65-v6mr10279079oig.356.1536936620996;
 Fri, 14 Sep 2018 07:50:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:554b:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 07:50:20
 -0700 (PDT)
In-Reply-To: <CAE4VaGBeTy-du_tThkr3w-r2KbYW8m+sRcpDPn9sYeENUy_x4g@mail.gmail.com>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com> <20180907131923.GB24106@hirez.programming.kicks-ass.net>
 <20180907134420.GD3995@linux.vnet.ibm.com> <20180907135235.GE24106@hirez.programming.kicks-ass.net>
 <CAE4VaGBeTy-du_tThkr3w-r2KbYW8m+sRcpDPn9sYeENUy_x4g@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 14 Sep 2018 16:50:20 +0200
Message-ID: <CAE4VaGDoxOQEhPYtVzEkNdrnFQ=Lnjj2is71ZYUBn_csUreoNA@mail.gmail.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Jakub Ra??ek" <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Srikar,

> I have bounced the 5 patches to you, (one of the 6 has not been applied by
> Peter) so I have skipped that.
> They can also be fetched from
> http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com

I'm sorry for the delay, we have finally the results for the above
kernel. The performance results look good compared to 4.19 vanilla and
are about the same as Mel's sched-numa-fast-crossnode-v1r12 patch set
for 4.18:

Compared to kernel-4.19.0-0.rc1.1

  * Improvement upto 20% for SPECjbb2005, SPECjvm2008 benchmarks
  * Improvement upto 50% for stream benchmark
  * Improvement upto 100% for the NAS benchmark (sp_C subtest, 8
threads on 4 NUMA system with 4x E5-4610 v2 @ 2.30GHz, 64 cores in
total)

When I compare it against Mel's patchset
(git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
sched-numa-fast-crossnode-v1r12)

  * Mel's kernel is about 15% faster for stream benchmarks
  * The other benchmarks show very similar results with both kernels

Mel's patchset eliminates NUMA migration rate limits, this is
presumbly the reason for the good stream results.

Do you have any update when the current patchset could be merged into
the upstream kernel?

Thanks a lot!
Jirka

On Sun, Sep 9, 2018 at 4:03 PM, Jirka Hladky <jhladky@redhat.com> wrote:
>
> Hi Peter and Srikar,
>
> thanks a lot for the information and for the patches to test!
>
> > I have bounced the 5 patches to you, (one of the 6 has not been applied by
> > Peter) so I have skipped that.
> > They can also be fetched from
> > http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com
>
> We have started the benchmarks, I will report the results on Monday.
>
> > I generally run specjbb2005 (single and multi instance).
> We also run a single and multi-instance specjbb2005 test.
>
> > I have tried running NAS but I couldn't set it up properly.
> We run the OMP variant and we control the number of threads with the
> OMP_NUM_THREADS env variable. The setup is quite simple:
>
> cd NPB_sources/config/
> mv suite_x86_64.def suite.def
> cd ..
> make suite
>
> FYI - starting from 4.17 kernel there is a significant performance
> drop compared to 4.16 kernel. Mel has come up with a
> sched-numa-fast-crossnode-v1r12 patch series
> git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git which we have
> tested extensively and with it, the benchmarks results are back at
> 4.16 level. As I understand it, Mel's patch series depends on your
> patch series and can be only merged when your patches are completed.
>
> Thanks!
> Jirka
>
>
> On Fri, Sep 7, 2018 at 3:52 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Sep 07, 2018 at 07:14:20PM +0530, Srikar Dronamraju wrote:
> > > * Peter Zijlstra <peterz@infradead.org> [2018-09-07 15:19:23]:
> > >
> > > > On Fri, Sep 07, 2018 at 06:26:49PM +0530, Srikar Dronamraju wrote:
> > > >
> > > > > Can you please pick
> > > > >
> > > > >
> > > > > 1. 69bb3230297e881c797bbc4b3dbf73514078bc9d sched/numa: Stop multiple tasks
> > > > > from moving to the cpu at the same time
> > > > > 2. dc62cfdac5e5b7a61cd8a2bd4190e80b9bb408fc sched/numa: Avoid task migration
> > > > > for small numa improvement
> > > > > 3. 76e18a67cdd9e3609716c8a074c03168734736f9 sched/numa: Pass destination cpu as
> > > > > a parameter to migrate_task_rq
> > > > > 4.  489c19b440ebdbabffe530b9a41389d0a8b315d9 sched/numa: Reset scan rate
> > > > > whenever task moves across nodes
> > > > > 5.  b7e9ae1ae3825f35cd0f38f1f0c8e91ea145bc30 sched/numa: Limit the
> > > > > conditions where scan period is reset
> > > > >
> > > > > from https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched
> > > >
> > > > That is not a stable tree; the whole thing is re-generated from my quilt
> > > > set every time I feel like it.
> > > >
> > > > It is likely those commit ids will no longer exist in a few hours.
> > > >
> > >
> > > Okay, I will forward the relevant mails to Jirka.
> >
> > Or he can click on that link and find new IDs :-)
